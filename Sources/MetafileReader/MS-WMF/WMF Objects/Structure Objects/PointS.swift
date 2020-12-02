//
//  PointS.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.16 PointS Object
/// The PointS Object defines the x- and y-coordinates of a point.
public struct PointS {
    public let x: Int16
    public let y: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// x (2 bytes): A 16-bit signed integer that defines the horizontal (x) coordinate of the point.
        self.x = try dataStream.read(endianess: .littleEndian)
        
        /// y (2 bytes): A 16-bit signed integer that defines the vertical (y) coordinate of the point.
        self.y = try dataStream.read(endianess: .littleEndian)
    }
}
