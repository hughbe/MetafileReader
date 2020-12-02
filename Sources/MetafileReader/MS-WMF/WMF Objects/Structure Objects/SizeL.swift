//
//  SizeL.swift
//  
//
//  Created by Hugh Bellamy on 01/12/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.22 SizeL Object
/// The SizeL Object defines the x- and y-extents of a rectangle.
public struct SizeL {
    public let cx: UInt32
    public let cy: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// cx (4 bytes): A 32-bit unsigned integer that defines the x-coordinate of the point.
        self.cx = try dataStream.read(endianess: .littleEndian)
        
        /// cy (4 bytes): A 32-bit unsigned integer that defines the y-coordinate of the point
        self.cy = try dataStream.read(endianess: .littleEndian)
    }
}
