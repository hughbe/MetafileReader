//
//  META_SETTEXTJUSTIFICATION.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.27 META_SETTEXTJUSTIFICATION Record
/// The META_SETTEXTJUSTIFICATION Record defines the amount of space to add to break characters in a string of justified text.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETTEXTJUSTIFICATION {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let breakCount: UInt16
    public let breakExtra: UInt16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 5 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETTEXTJUSTIFICATION.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETTEXTJUSTIFICATION.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// BreakCount (2 bytes): A 16-bit unsigned integer that specifies the number of space characters in the line.
        self.breakCount = try dataStream.read(endianess: .littleEndian)
        
        /// BreakExtra (2 bytes): A 16-bit unsigned integer that specifies the total extra space, in logical units, to be added to the
        /// line of text. If the current mapping mode is not MM_TEXT, the value identified by the BreakExtra member is transformed
        /// and rounded to the nearest pixel. For details about setting the mapping mode, see META_SETMAPMODE Record (section 2.3.5.17).
        self.breakExtra = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
