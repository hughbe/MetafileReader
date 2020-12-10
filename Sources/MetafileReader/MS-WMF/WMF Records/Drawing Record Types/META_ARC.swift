//
//  META_ARC.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.1 META_ARC Record
/// The META_ARC Record draws an elliptical arc.
public struct META_ARC {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let yEndArc: Int16
    public let xEndArc: Int16
    public let yStartArc: Int16
    public let xStartArc: Int16
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
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ARC.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ARC.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// YEndArc (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the ending point of the radial
        /// line defining the ending point of the arc.
        self.yEndArc = try dataStream.read(endianess: .littleEndian)
        
        /// XEndArc (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical units, of the ending point of the radial
        /// line defining the ending point of the arc.
        self.xEndArc = try dataStream.read(endianess: .littleEndian)
        
        /// YStartArc (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the ending point of the radial
        /// line defining the starting point of the arc.
        self.yStartArc = try dataStream.read(endianess: .littleEndian)
        
        /// XStartArc (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical units, of the ending point of the radial
        /// line defining the starting point of the arc.
        self.xStartArc = try dataStream.read(endianess: .littleEndian)
        
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
            throw WmfReadError.corrupted
        }
    }
}
