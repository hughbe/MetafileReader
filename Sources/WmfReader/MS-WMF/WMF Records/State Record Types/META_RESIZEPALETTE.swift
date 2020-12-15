//
//  META_RESIZEPALETTE.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.9 META_RESIZEPALETTE Record
/// The META_RESIZEPALETTE Record redefines the size of the logical palette that is defined in the playback device context.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_RESIZEPALETTE {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let numberOfEntries: UInt16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 4 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_RESIZEPALETTE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_RESIZEPALETTE.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// NumberOfEntries (2 bytes): A 16-bit unsigned integer that defines the number of entries in the logical palette.
        self.numberOfEntries = try dataStream.read(endianess: .littleEndian)

        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
