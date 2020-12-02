//
//  ENCAPSULATED_POSTSCRIPT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.6.11 ENCAPSULATED_POSTSCRIPT Record
/// The ENCAPSULATED_POSTSCRIPT Record sends arbitrary PostScript data directly to a printer driver.
/// See section 2.3.6 for the specification of other Escape Record Types.
public struct ENCAPSULATED_POSTSCRIPT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let escapeFunction: MetafileEscapes
    public let byteCount: UInt16
    public let size: UInt32
    public let version: UInt32
    public let points: [PointL]
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 21 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ESCAPE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ESCAPE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// EscapeFunction (2 bytes): A 16-bit unsigned integer that defines the escape function. The value MUST be 0x1014
        /// (ENCAPSULATED_POSTSCRIPT) from the MetafileEscapes Enumeration (section 2.1.1.17) table.
        self.escapeFunction = try MetafileEscapes(dataStream: &dataStream)
        guard self.escapeFunction == .ENCAPSULATED_POSTSCRIPT else {
            throw MetafileReadError.corrupted
        }
        
        /// ByteCount (2 bytes): A 16-bit unsigned integer that specifies the size, in bytes, of the record data that follows. This value
        /// SHOULD be greater than or equal to the value of the Size field.<65>
        self.byteCount = try dataStream.read(endianess: .littleEndian)
        
        /// Size (4 bytes): A 32-bit unsigned integer that specifies the total size, in bytes, of the Size, Version, Points, and Data fields.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.size >= 28 else {
            throw MetafileReadError.corrupted
        }
        
        /// Version (4 bytes): A 32-bit unsigned integer that defines the PostScript language level.
        self.version = try dataStream.read(endianess: .littleEndian)
        
        /// Points (24 bytes): An array of three PointL Objects (section 2.2.2.15) that define the output parallelogram in 28.4 FIX
        /// device coordinates.
        self.points = [
            try PointL(dataStream: &dataStream),
            try PointL(dataStream: &dataStream),
            try PointL(dataStream: &dataStream)
        ]
        
        /// Data (variable): The PostScript data.
        let dataCount = Int(min(UInt32(self.byteCount), self.size - 28))
        self.data = try dataStream.readBytes(count: dataCount)
        
        // <65> Section 2.3.6.11: Any bytes that exceed the ByteCount field are ignored by the client.
        while (dataStream.position - startPosition) / 2  < self.recordSize {
            let _: UInt16 = try dataStream.read(endianess: .littleEndian)
        }
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
