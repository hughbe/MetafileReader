//
//  META_SETVIEWPORTEXT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.28 META_SETVIEWPORTEXT Record
/// The META_SETVIEWPORTEXT Record sets the horizontal and vertical extents of the viewport in the playback device context.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETVIEWPORTEXT {
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
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETVIEWPORTEXT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETVIEWPORTEXT.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// Y (2 bytes): A 16-bit signed integer that defines the vertical extent of the viewport in device units.
        self.y = try dataStream.read(endianess: .littleEndian)
        
        /// X (2 bytes): A 16-bit signed integer that defines the horizontal extent of the viewport in device units.
        self.x = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
