//
//  META_EXCLUDECLIPRECT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.2 META_EXCLUDECLIPRECT Record
/// The META_EXCLUDECLIPRECT Record sets the clipping region in the playback device context to the existing clipping region
/// minus the specified rectangle.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_EXCLUDECLIPRECT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let bottom: Int16
    public let right: Int16
    public let top: Int16
    public let left: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 7 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_EXCLUDECLIPRECT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_EXCLUDECLIPRECT.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// Bottom (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the lower-right corner of the
        /// rectangle.
        self.bottom = try dataStream.read(endianess: .littleEndian)
        
        /// Right (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical units, of the lowerright corner of the
        /// rectangle.
        self.right = try dataStream.read(endianess: .littleEndian)
        
        /// Top (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the upper-left corner of the
        /// rectangle.
        self.top = try dataStream.read(endianess: .littleEndian)
        
        /// Left (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical units, of the upper-left corner of the
        /// rectangle.
        self.left = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
