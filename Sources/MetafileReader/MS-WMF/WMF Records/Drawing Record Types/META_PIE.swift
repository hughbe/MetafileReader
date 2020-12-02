//
//  META_PIE.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.13 META_PIE Record
/// The META_PIE Record draws a pie-shaped wedge bounded by the intersection of an ellipse and two radials. The pie is outlined by
/// using the pen and filled by using the brush that are defined in the playback device context.
public struct META_PIE {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let yRadial2: Int16
    public let xRadial2: Int16
    public let yRadial1: Int16
    public let xRadial1: Int16
    public let bottomRect: Int16
    public let rightRect: Int16
    public let topRect: Int16
    public let leftRect: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 11 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_PIE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_PIE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// YRadial2 (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical coordinates, of the endpoint of the
        /// second radial.
        self.yRadial2 = try dataStream.read(endianess: .littleEndian)
        
        /// XRadial2 (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical coordinates, of the endpoint of the
        /// second radial.
        self.xRadial2 = try dataStream.read(endianess: .littleEndian)
        
        /// YRadial1 (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical coordinates, of the endpoint of the
        /// first radial.
        self.yRadial1 = try dataStream.read(endianess: .littleEndian)
        
        /// XRadial1 (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical coordinates, of the endpoint of the
        /// first radial.
        self.xRadial1 = try dataStream.read(endianess: .littleEndian)
        
        /// BottomRect (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the lower-right corner of
        /// the bounding rectangle.
        self.bottomRect = try dataStream.read(endianess: .littleEndian)
        
        /// RightRect (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical units, of the lower-right corner of the
        /// bounding rectangle.
        self.rightRect = try dataStream.read(endianess: .littleEndian)
        
        /// TopRect (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the upper-left corner of the
        /// bounding rectangle.
        self.topRect = try dataStream.read(endianess: .littleEndian)
        
        /// LeftRect (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical units, of the upper-left corner of the
        /// bounding rectangle.
        self.leftRect = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
