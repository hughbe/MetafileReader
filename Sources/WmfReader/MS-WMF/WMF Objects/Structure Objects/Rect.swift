//
//  Rect.swift
//  
//
//  Created by Hugh Bellamy on 01/12/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.18 Rect Object
/// The Rect Object defines a rectangle.
public struct Rect {
    public let left: Int16
    public let top: Int16
    public let right: Int16
    public let bottom: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// Left (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical coordinates, of the upper-left corner of the rectangle
        self.left = try dataStream.read(endianess: .littleEndian)
        
        /// Top (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical coordinates, of the upper-left corner of the rectangle.
        self.top = try dataStream.read(endianess: .littleEndian)
        
        /// Right (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical coordinates, of the lower-right corner of the rectangle.
        self.right = try dataStream.read(endianess: .littleEndian)
        
        /// Bottom (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical coordinates, of the lower-right corner of the rectangle.
        self.bottom = try dataStream.read(endianess: .littleEndian)
    }
}
