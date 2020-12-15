//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.3 BitmapInfoHeader Object
/// The BitmapInfoHeader Object contains information about the dimensions and color format of a device-independent bitmap (DIB).
public struct BitmapInfoHeader {
    public let headerSize: UInt32
    public let width: Int32
    public let height: Int32
    public let planes: UInt16
    public let bitCount: BitCount
    public let compression: Compression
    public let imageSize: UInt32
    public let xPelsPerMeter: Int32
    public let yPelsPerMeter: Int32
    public let colorUsed: UInt32
    public let colorImportant: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// HeaderSize (4 bytes): A 32-bit unsigned integer that defines the size of this object, in bytes.
        self.headerSize = try dataStream.read(endianess: .littleEndian)
        
        /// Width (4 bytes): A 32-bit signed integer that defines the width of the DIB, in pixels. This value MUST be positive.
        /// This field SHOULD specify the width of the decompressed image file, if the Compression value specifies JPEG or PNG format.<44>
        self.width = try dataStream.read(endianess: .littleEndian)
        guard self.width > 0 else {
            throw WmfReadError.corrupted
        }
        
        /// Height (4 bytes): A 32-bit signed integer that defines the height of the DIB, in pixels. This value MUST NOT be zero.
        /// Value Meaning
        /// 0x00000000 < value If this value is positive, the DIB is a bottom-up bitmap, and its origin is
        /// the lower-left corner.
        /// This field SHOULD specify the height of the decompressed image file, if the Compression value
        /// specifies JPEG or PNG format.
        /// value < 0x00000000 If this value is negative, the DIB is a top-down bitmap, and its origin is
        /// the upper-left corner. Top-down bitmaps do not support compression.
        self.height = try dataStream.read(endianess: .littleEndian)
        guard self.height != 0x00000000 else {
            throw WmfReadError.corrupted
        }
        
        /// Planes (2 bytes): A 16-bit unsigned integer that defines the number of planes for the target device. This value MUST be 0x0001.
        self.planes = try dataStream.read(endianess: .littleEndian)
        guard self.planes == 0x0001 else {
            throw WmfReadError.corrupted
        }
        
        /// BitCount (2 bytes): A 16-bit unsigned integer that defines the number of bits that define each pixel and the maximum number of
        /// colors in the DIB. This value MUST be in the BitCount Enumeration (section 2.1.1.3).
        guard let bitCount = BitCount(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw WmfReadError.corrupted
        }
        
        self.bitCount = bitCount
        
        /// Compression (4 bytes): A 32-bit unsigned integer that defines the compression mode of the DIB. This value MUST be in the
        /// Compression Enumeration (section 2.1.1.7). This value MUST NOT specify a compressed format if the DIB is a top-down bitmap,
        /// as indicated by the Height value.
        guard let compression = Compression(rawValue: UInt16(try dataStream.read(endianess: .littleEndian) as UInt32)) else {
            throw WmfReadError.corrupted
        }
        
        self.compression = compression
        
        /// ImageSize (4 bytes): A 32-bit unsigned integer that defines the size, in bytes, of the image. If the Compression value is BI_RGB,
        /// this value SHOULD be zero and MUST be ignored.<45> If the Compression value is BI_JPEG or BI_PNG, this value MUST specify
        /// the size of the JPEG or PNG image buffer, respectively.
        self.imageSize = try dataStream.read(endianess: .littleEndian)
        
        /// XPelsPerMeter (4 bytes): A 32-bit signed integer that defines the horizontal resolution, in pixelsper-meter, of the target device for the
        /// DIB.
        self.xPelsPerMeter = try dataStream.read(endianess: .littleEndian)
        
        /// YPelsPerMeter (4 bytes): A 32-bit signed integer that defines the vertical resolution, in pixels-permeter, of the target device for the DIB.
        self.yPelsPerMeter = try dataStream.read(endianess: .littleEndian)
        
        /// ColorUsed (4 bytes): A 32-bit unsigned integer that specifies the number of indexes in the color table used by the DIB, as follows:
        ///  If this value is zero, the DIB uses the maximum number of colors that correspond to the BitCount value.
        ///  If this value is nonzero and the BitCount value is less than 16, this value specifies the number of colors used by the DIB.
        ///  If this value is nonzero and the BitCount value is 16 or greater, this value specifies the size of the color table used to optimize
        /// performance of the system palette.
        /// Note If this value is nonzero and greater than the maximum possible size of the color table based on the BitCount value, the
        /// maximum color table size SHOULD be assumed.
        self.colorUsed = try dataStream.read(endianess: .littleEndian)
        
        /// ColorImportant (4 bytes): A 32-bit unsigned integer that defines the number of color indexes that are required for displaying
        /// the DIB. If this value is zero, all color indexes are required.
        /// A DIB is specified by a DeviceIndependentBitmap Object (section 2.2.2.9).
        /// When the array of pixels in the DIB immediately follows the BitmapInfoHeader, the DIB is a packed bitmap. In a packed bitmap,
        /// the ColorUsed value MUST be either 0x00000000 or the actual size of the color table.
        self.colorImportant = try dataStream.read(endianess: .littleEndian)
    }
}
