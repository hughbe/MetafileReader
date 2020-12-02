//
//  PointL.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.15 PointL Object
/// The PointL Object defines the coordinates of a point
public struct PointL {
    public let x: Int32
    public let y: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// x (4 bytes): A 32-bit signed integer that defines the horizontal (x) coordinate of the point.
        self.x = try dataStream.read(endianess: .littleEndian)
        
        /// y (4 bytes): A 32-bit signed integer that defines the vertical (y) coordinate of the point.
        self.y = try dataStream.read(endianess: .littleEndian)
    }
}
