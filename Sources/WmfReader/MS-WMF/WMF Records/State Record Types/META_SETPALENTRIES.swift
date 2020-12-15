//
//  META_SETPALENTRIES.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.19 META_SETPALENTRIES Record
/// The META_SETPALENTRIES Record defines RGB color values in a range of entries in the logical palette that is defined in the
/// playback device context.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETPALENTRIES {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let palette: Palette
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 5 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETPALENTRIES.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETPALENTRIES.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// Palette (variable): A Palette Object (section 2.2.1.3), which defines the palette information.
        /// The META_SETPALENTRIES modifies the logical palette that is currently selected in the playback device context. A
        /// META_SELECTPALETTE Record (section 2.3.4.11) MUST have been used to specify that logical palette in the form of a
        /// Palette Object prior to the occurrence of the META_SETPALENTRIES in the metafile. A Palette object is one of the
        /// graphics objects that is maintained in the playback device context during playback of the metafile. See Graphics Objects
        /// (section 1.3.2) for more information.
        self.palette = try Palette(dataStream: &dataStream)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
