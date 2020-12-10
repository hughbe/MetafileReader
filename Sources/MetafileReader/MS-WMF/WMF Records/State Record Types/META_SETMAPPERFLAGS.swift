//
//  META_SETMAPPERFLAGS.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.18 META_SETMAPPERFLAGS Record
/// The META_SETMAPPERFLAGS Record defines the algorithm that the font mapper uses when it maps logical fonts to physical fonts.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETMAPPERFLAGS {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let mapperValues: UInt32
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 5 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETMAPPERFLAGS.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETMAPPERFLAGS.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// MapperValues (4 bytes): A 32-bit unsigned integer that defines whether the font mapper attempts to match a font aspect
        /// ratio to the current device aspect ratio. If bit zero is set, the mapper selects only matching fonts.
        self.mapperValues = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
