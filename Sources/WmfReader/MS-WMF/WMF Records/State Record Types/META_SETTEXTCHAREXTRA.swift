//
//  META_SETTEXTCHAREXTRA.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.25 META_SETTEXTCHAREXTRA Record
/// The META_SETTEXTCHAREXTRA Record defines inter-character spacing for text justification in the playback device context. Spacing
/// is added to the white space between each character, including break characters, when a line of justified text is output.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETTEXTCHAREXTRA {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let charExtra: UInt16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 4 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETTEXTCHAREXTRA.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETTEXTCHAREXTRA.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// CharExtra (2 bytes): A 16-bit unsigned integer that defines the amount of extra space, in logical units, to be added to
        /// each character. If the current mapping mode is not MM_TEXT, this value is transformed and rounded to the nearest pixel.
        /// For details about setting the mapping mode, see META_SETMAPMODE Record (section 2.3.5.17).
        self.charExtra = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
