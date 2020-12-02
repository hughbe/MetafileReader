//
//  META_ELLIPSE.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.3 META_ELLIPSE Record
/// The META_ELLIPSE Record draws an ellipse. The center of the ellipse is the center of the specified bounding rectangle. The ellipse is outlined
/// by using the pen and is filled by using the brush; these are defined in the playback device context.
public struct META_ELLIPSE {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let bottomRect: Int16
    public let rightRect: Int16
    public let topRect: Int16
    public let leftRect: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 7 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ELLIPSE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ELLIPSE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// BottomRect (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the lower-right corner of the
        /// bounding rectangle.
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
