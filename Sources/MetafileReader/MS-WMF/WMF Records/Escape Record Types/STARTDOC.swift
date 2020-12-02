//
//  STARTDOC.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.6.44 STARTDOC Record
/// The STARTDOC Record informs the printer driver that a new print job is starting.
/// See section 2.3.6 for the specification of other Escape Record Types.
public struct STARTDOC {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let escapeFunction: MetafileEscapes
    public let byteCount: UInt16
    public let docName: String
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 5 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ESCAPE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ESCAPE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// EscapeFunction (2 bytes): A 16-bit unsigned integer that defines the escape function. The value MUST be 0x000A
        /// (STARTDOC) from the MetafileEscapes Enumeration (section 2.1.1.17) table.
        self.escapeFunction = try MetafileEscapes(dataStream: &dataStream)
        guard self.escapeFunction == .STARTDOC else {
            throw MetafileReadError.corrupted
        }
        
        /// ByteCount (2 bytes): A 16-bit unsigned integer that specifies the size, in bytes, of the DocName field.
        /// This size MUST be less than 260.
        self.byteCount = try dataStream.read(endianess: .littleEndian)
        guard self.byteCount < 260 else {
            throw MetafileReadError.corrupted
        }
        guard self.recordSize == 5 + self.byteCount / 2 else {
            throw MetafileReadError.corrupted
        }
        
        /// DocName (variable): A string of ByteCount 8-bit characters that contains the name of the document.
        self.docName = try dataStream.readString(count: Int(self.byteCount), encoding: .ascii)!
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
