//
//  META_OFFSETCLIPRGN.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.5 META_OFFSETCLIPRGN Record
/// The META_OFFSETCLIPRGN Record moves the clipping region in the playback device context by the specified offsets.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_OFFSETCLIPRGN {
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
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_OFFSETCLIPRGN.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_OFFSETCLIPRGN.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// YOffset (2 bytes): A 16-bit signed integer that defines the number of logical units to move up or down.
        self.yOffset = try dataStream.read(endianess: .littleEndian)
        
        /// XOffset (2 bytes): A 16-bit signed integer that defines the number of logical units to move left or right.
        self.xOffset = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
