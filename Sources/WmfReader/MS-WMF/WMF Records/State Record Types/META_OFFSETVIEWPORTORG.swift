//
//  META_OFFSETVIEWPORTORG.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.6 META_OFFSETVIEWPORTORG Record
/// The META_OFFSETVIEWPORTORG Record moves the viewport origin in the playback device context by specified horizontal and vertical offsets.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_OFFSETVIEWPORTORG {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let yOffset: Int16
    public let xOffset: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 5 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_OFFSETVIEWPORTORG.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_OFFSETVIEWPORTORG.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// YOffset (2 bytes): A 16-bit signed integer that defines the vertical offset, in device units.
        self.yOffset = try dataStream.read(endianess: .littleEndian)
        
        /// XOffset (2 bytes): A 16-bit signed integer that defines the horizontal offset, in device units.
        self.xOffset = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
