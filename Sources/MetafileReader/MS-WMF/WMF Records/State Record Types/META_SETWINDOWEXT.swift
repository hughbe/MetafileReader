//
//  META_SETWINDOWEXT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.30 META_SETWINDOWEXT Record
/// The META_SETWINDOWEXT Record defines the horizontal and vertical extents of the output window in the playback device context.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETWINDOWEXT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let y: Int16
    public let x: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 5 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETWINDOWEXT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETWINDOWEXT.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// Y (2 bytes): A 16-bit signed integer that defines the vertical extent of the window in logical units.
        self.y = try dataStream.read(endianess: .littleEndian)
        
        /// X (2 bytes): A 16-bit signed integer that defines the horizontal extent of the window in logical units.
        self.x = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
