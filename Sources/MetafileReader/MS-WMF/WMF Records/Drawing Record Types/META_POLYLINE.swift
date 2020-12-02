//
//  META_POLYLINE.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.14 META_POLYLINE Record
/// The META_POLYLINE Record draws a series of line segments by connecting the points in the specified array.
public struct META_POLYLINE {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let numberOfPoints: UInt16
    public let aPoints: [PointS]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 4 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_POLYLINE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_POLYLINE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// NumberOfPoints (2 bytes): A 16-bit signed integer that defines the number of points in the array.
        self.numberOfPoints = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 4 + 2 * self.numberOfPoints else {
            throw MetafileReadError.corrupted
        }
        
        /// aPoints (variable): A NumberOfPoints array of 32-bit PointS Objects (section 2.2.2.16), in logical units.
        var aPoints: [PointS] = []
        aPoints.reserveCapacity(Int(self.numberOfPoints))
        for _ in 0..<self.numberOfPoints {
            aPoints.append(try PointS(dataStream: &dataStream))
        }
        
        self.aPoints = aPoints
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
