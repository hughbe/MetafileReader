//
//  META_CREATEPALETTE.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.4.3 META_CREATEPALETTE Record
/// The META_CREATEPALETTE Record creates a Palette Object (section 2.2.1.3).
/// See section 2.3.4 for the specification of other Object Records.
public struct META_CREATEPALETTE {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let palette: Palette
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        let recordSize: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard recordSize >= 5 else {
            throw MetafileReadError.corrupted
        }
        
        self.recordSize = recordSize
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_CREATEPALETTE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_CREATEPALETTE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// Palette (variable): Palette Object data that defines the palette to create. The Start field in the Palette Object MUST be set
        /// to 0x0300.
        self.palette = try Palette(dataStream: &dataStream)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
