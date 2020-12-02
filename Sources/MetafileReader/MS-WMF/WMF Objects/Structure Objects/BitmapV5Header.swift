//
//  BitmapV5Header.swift
//
//
//  Created by Hugh Bellamy on 02/12/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.5 BitmapV5Header Object
/// The BitmapV5Header Object contains information about the dimensions and color format of a device-independent bitmap (DIB). It is
/// an extension of the BitmapV4Header Object (section 2.2.2.4).<47>
public struct BitmapV5Header {
    public let bitmapV4Header: BitmapV4Header
    public let intent: GamutMappingIntent
    public let profileData: UInt32
    public let profileSize: UInt32
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// BitmapV4Header (108 bytes): A BitmapV4Header Object, which defines properties of the DIB Object (section 2.2.2.9).
        /// When it is part of a BitmapV5Header, the ColorSpaceType field of a BitmapV4Header can be a logical color space value
        /// in the LogicalColorSpaceV5 Enumeration (section 2.1.1.15).
        self.bitmapV4Header = try BitmapV4Header(dataStream: &dataStream)
        
        /// Intent (4 bytes): A 32-bit unsigned integer that defines the rendering intent for the DIB. This MUST be defined in the
        /// GamutMappingIntent Enumeration (section 2.1.1.11).
        self.intent = try GamutMappingIntent(dataStream: &dataStream)
        
        /// ProfileData (4 bytes): A 32-bit unsigned integer that defines the offset, in bytes, from the beginning of this structure to the
        /// start of the color profile data.
        /// If the color profile is embedded in the DIB, ProfileData is the offset to the actual color profile; if the color profile is linked,
        /// ProfileData is the offset to the null-terminated file name of the color profile. This MUST NOT be a Unicode string, but
        /// MUST be composed exclusively of characters from the Windows character set (code page 1252).
        /// If the ColorSpaceType field in the BitmapV4Header does not specify LCS_PROFILE_LINKED or LCS_PROFILE_EMBEDDED,
        /// the color profile data SHOULD be ignored.
        self.profileData = try dataStream.read(endianess: .littleEndian)
        
        /// ProfileSize (4 bytes): A 32-bit unsigned integer that defines the size, in bytes, of embedded color profile data.
        self.profileSize = try dataStream.read(endianess: .littleEndian)
        
        /// Reserved (4 bytes): A 32-bit unsigned integer that is undefined and SHOULD be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
