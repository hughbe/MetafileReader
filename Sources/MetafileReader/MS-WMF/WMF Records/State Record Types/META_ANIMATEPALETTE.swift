//
//  META_ANIMATEPALETTE.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.1 META_ANIMATEPALETTE Record
/// The META_ANIMATEPALETTE Record redefines entries in the logical palette that is defined in the playback device context with the
/// specified Palette Object (section 2.2.1.3).
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_ANIMATEPALETTE {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let palette: Palette
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 5 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ANIMATEPALETTE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ANIMATEPALETTE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// Palette (variable): A variable-sized Palette Object that specifies a logical palette. The logical palette that is specified by the
        /// Palette Object in this record is the source of the palette changes, and the logical palette that is currently selected into the
        /// playback device context is the destination. Entries in the destination palette with the PC_RESERVED PaletteEntryFlag
        /// Enumeration (section 2.1.1.22) set SHOULD be modified by this record, and entries with that flag clear SHOULD NOT
        /// be modified. If none of the entries in the destination palette have the PC_RESERVED flag set, then this record SHOULD
        /// have no effect.
        self.palette = try Palette(dataStream: &dataStream)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
