//
//  RectL.swift
//
//
//  Created by Hugh Bellamy on 01/12/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.19 RectL Object
/// The RectL Object defines a rectangle.
/// A rectangle defined with a RectL Object is filled up to— but not including—the right column and bottom row of pixels.
public struct RectL {
    public let left: Int32
    public let top: Int32
    public let right: Int32
    public let bottom: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// Left (4 bytes): A 32-bit signed integer that defines the x coordinate, in logical coordinates, of the upper-left corner of the
        /// rectangle.
        self.left = try dataStream.read(endianess: .littleEndian)
        
        /// Top (4 bytes): A 32-bit signed integer that defines the y coordinate, in logical coordinates, of the upper-left corner of the
        /// rectangle.
        self.top = try dataStream.read(endianess: .littleEndian)
        
        /// Right (4 bytes): A 32-bit signed integer that defines the x coordinate, in logical coordinates, of the lower-right corner of
        /// the rectangle.
        self.right = try dataStream.read(endianess: .littleEndian)
        
        /// Bottom (4 bytes): A 32-bit signed integer that defines y coordinate, in logical coordinates, of the lower-right corner of
        /// the rectangle.
        self.bottom = try dataStream.read(endianess: .littleEndian)
    }
}
