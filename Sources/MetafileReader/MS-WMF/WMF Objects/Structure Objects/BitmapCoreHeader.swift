//
//  BitmapCoreHeader.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.2 BitmapCoreHeader Object
/// The BitmapCoreHeader Object contains information about the dimensions and color format of a device-independent bitmap (DIB).<43>
public struct BitmapCoreHeader {
    public let headerSize: UInt32
    public let width: UInt16
    public let height: UInt16
    public let planes: UInt16
    public let bitCount: BitCount
    
    public init(dataStream: inout DataStream) throws {
        /// HeaderSize (4 bytes): A 32-bit unsigned integer that defines the size of this object, in bytes.
        self.headerSize = try dataStream.read(endianess: .littleEndian)
        
        /// Width (2 bytes): A 16-bit unsigned integer that defines the width of the DIB, in pixels.
        self.width = try dataStream.read(endianess: .littleEndian)
        
        /// Height (2 bytes): A 16-bit unsigned integer that defines the height of the DIB, in pixels.
        self.height = try dataStream.read(endianess: .littleEndian)
        
        /// Planes (2 bytes): A 16-bit unsigned integer that defines the number of planes for the target device. This value MUST be 0x0001.
        self.planes = try dataStream.read(endianess: .littleEndian)
        guard self.planes == 0x0001 else {
            throw WmfReadError.corrupted
        }
        
        /// BitCount (2 bytes): A 16-bit unsigned integer that defines the format of each pixel, and the maximum number of colors in the DIB.
        /// This value MUST be in the BitCount Enumeration (section 2.1.1.3).
        /// A DIB is specified by a DeviceIndependentBitmap Object (section 2.2.2.9).
        guard let bitCount = BitCount(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw WmfReadError.corrupted
        }
        
        self.bitCount = bitCount
    }
}
