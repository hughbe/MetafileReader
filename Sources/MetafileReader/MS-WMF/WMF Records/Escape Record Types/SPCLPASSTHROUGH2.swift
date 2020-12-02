//
//  POSTSCRIPT_PASSTHROUGH.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.6.43 SPCLPASSTHROUGH2 Record
/// The SPCLPASSTHROUGH2 Record enables documents to include private procedures and other resources to send to the printer
/// driver.
/// See section 2.3.6 for the specification of other Escape Record Types.
public struct SPCLPASSTHROUGH2 {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let escapeFunction: MetafileEscapes
    public let byteCount: UInt16
    public let reserved: UInt32
    public let size: UInt16
    public let rawData: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 8 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ESCAPE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ESCAPE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// EscapeFunction (2 bytes): A 16-bit unsigned integer that defines the escape function. The value MUST be 0x11D8
        /// (SPCLPASSTHROUGH2) from the MetafileEscapes Enumeration (section 2.1.1.17) table.
        self.escapeFunction = try MetafileEscapes(dataStream: &dataStream)
        guard self.escapeFunction == .SPCLPASSTHROUGH2 else {
            throw MetafileReadError.corrupted
        }
        
        /// ByteCount (2 bytes): A 16-bit unsigned integer that specifies the size, in bytes, of the Data field.
        self.byteCount = try dataStream.read(endianess: .littleEndian)
        guard self.byteCount >= 6 else {
            throw MetafileReadError.corrupted
        }
        guard self.recordSize == 8 + self.byteCount / 2 else {
            throw MetafileReadError.corrupted
        }
        
        /// Reserved (4 bytes): A 32-bit unsigned integer that is not used and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        /// Size (2 bytes): A 16-bit unsigned integer that specifies the size, in bytes, of the RawData field.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 8 + self.size / 2 else {
            throw MetafileReadError.corrupted
        }
        
        /// RawData (variable): The Size-length byte array of unprocessed private data to send to the printer driver.
        self.rawData = try dataStream.readBytes(count: Int(self.size))
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
