//
//  Bitmap16.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.1 Bitmap16 Object
/// The Bitmap16 Object specifies information about the dimensions and color format of a bitmap.
public struct Bitmap16 {
    public let type: Int16
    public let width: Int16
    public let height: Int16
    public let widthBytes: Int16
    public let planes: UInt8
    public let bitsPixel: UInt8
    public let bits: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// Type (2 bytes): A 16-bit signed integer that defines the bitmap type.
        self.type = try dataStream.read(endianess: .littleEndian)
        
        /// Width (2 bytes): A 16-bit signed integer that defines the width of the bitmap in pixels.
        self.width = try dataStream.read(endianess: .littleEndian)
        
        /// Height (2 bytes): A 16-bit signed integer that defines the height of the bitmap in scan lines.
        self.height = try dataStream.read(endianess: .littleEndian)
        
        /// WidthBytes (2 bytes): A 16-bit signed integer that defines the number of bytes per scan line.
        self.widthBytes = try dataStream.read(endianess: .littleEndian)
        
        /// Planes (1 byte): An 8-bit unsigned integer that defines the number of color planes in the bitmap. The value of this field MUST be 0x01.
        self.planes = try dataStream.read()
        guard self.planes == 0x01 else {
            throw WmfReadError.corrupted
        }
        
        /// BitsPixel (1 byte): An 8-bit unsigned integer that defines the number of adjacent color bits on each plane.
        self.bitsPixel = try dataStream.read()

        // Four byte-align
        let excessBytes = (dataStream.position - startPosition) % 4
        if excessBytes > 0 {
            let remainingCount = 4 - excessBytes
            guard dataStream.position + remainingCount <= dataStream.count else {
                throw WmfReadError.corrupted
            }
            
            dataStream.position += remainingCount
        }
        
        /// Bits (variable): A variable length array of bytes that defines the bitmap pixel data. The length of this field in bytes can be computed
        /// as follows. (((Width * BitsPixel + 15) >> 4) << 1) * Height
        let count = (((Int(self.width) * Int(self.bitsPixel) + 15) >> 4) << 1) * Int(self.height)
        self.bits = try dataStream.readBytes(count: count)
    }
}
