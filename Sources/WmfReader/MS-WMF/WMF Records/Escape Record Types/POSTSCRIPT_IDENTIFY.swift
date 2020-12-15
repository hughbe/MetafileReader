//
//  POSTSCRIPT_IDENTIFY.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.6.31 POSTSCRIPT_IDENTIFY Record
/// The POSTSCRIPT_IDENTIFY Record sets the printer driver to either PostScript-centric or GDIcentric mode.
/// See section 2.3.6 for the specification of other Escape Record Types.
public struct POSTSCRIPT_IDENTIFY {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let escapeFunction: MetafileEscapes
    public let byteCount: UInt16
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 5 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ESCAPE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ESCAPE.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// EscapeFunction (2 bytes): A 16-bit unsigned integer that defines the escape function. The value MUST be 0x1005
        /// (POSTSCRIPT_IDENTIFY) from the MetafileEscapes Enumeration (section 2.1.1.17) table.
        self.escapeFunction = try MetafileEscapes(dataStream: &dataStream)
        guard self.escapeFunction == .POSTSCRIPT_IDENTIFY else {
            throw WmfReadError.corrupted
        }
        
        /// ByteCount (2 bytes): A 16-bit unsigned integer that specifies the size, in bytes, of the Data field.
        self.byteCount = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 5 + self.byteCount / 2 else {
            throw WmfReadError.corrupted
        }
        
        /// Data (variable): An array of bytes of size ByteCount.
        self.data = try dataStream.readBytes(count: Int(self.byteCount))
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
