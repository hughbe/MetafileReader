//
//  FilBitmapV4Header.swift
//  
//
//  Created by Hugh Bellamy on 02/12/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.4 BitmapV4Header Object
/// The BitmapV4Header Object contains information about the dimensions and color format of a device-independent bitmap (DIB). It is
/// an extension of the BitmapInfoHeader Object (section 2.2.2.3).<46>
public struct BitmapV4Header {
    public let bitmapInfoHeader: BitmapInfoHeader
    public let redMask: UInt32
    public let greenMask: UInt32
    public let blueMask: UInt32
    public let alphaMask: UInt32
    public let colorSpaceType: LogicalColorSpace
    public let endpoints: CIEXYZTriple
    public let gammaRed: Int32
    public let gammaGreen: Int32
    public let gammaBlue: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// BitmapInfoHeader (40 bytes): A BitmapInfoHeader object, which defines properties of the DIB.
        self.bitmapInfoHeader = try BitmapInfoHeader(dataStream: &dataStream)
        
        /// RedMask (4 bytes): A 32-bit unsigned integer that defines the color mask that specifies the red component of each pixel.
        /// If the Compression value in the BitmapInfoHeader object is not BI_BITFIELDS, this value MUST be ignored.
        self.redMask = try dataStream.read(endianess: .littleEndian)
        
        /// GreenMask (4 bytes): A 32-bit unsigned integer that defines the color mask that specifies the green component of each
        /// pixel. If the Compression value in the BitmapInfoHeader object is not BI_BITFIELDS, this value MUST be ignored.
        self.greenMask = try dataStream.read(endianess: .littleEndian)
        
        /// BlueMask (4 bytes): A 32-bit unsigned integer that defines the color mask that specifies the blue component of each
        /// pixel. If the Compression value in the BitmapInfoHeader object is not BI_BITFIELDS, this value MUST be ignored.
        self.blueMask = try dataStream.read(endianess: .littleEndian)
        
        /// AlphaMask (4 bytes): A 32-bit unsigned integer that defines the color mask that specifies the alpha component of each pixel.
        self.alphaMask = try dataStream.read(endianess: .littleEndian)
        
        /// ColorSpaceType (4 bytes): A 32-bit unsigned integer that defines the color space of the DeviceIndependentBitmap
        /// Object (section 2.2.2.9). If this value is LCS_CALIBRATED_RGB from the LogicalColorSpace Enumeration
        /// (section 2.1.1.14), the color values in the DIB are calibrated RGB values, and the endpoints and gamma values in this
        /// structure SHOULD be used to translate the color values before they are passed to the device.
        /// See the LogColorSpace (section 2.2.2.11) and LogColorSpace ObjectW (section 2.2.2.12) objects for details concerning
        /// a logical color space.
        self.colorSpaceType = try LogicalColorSpace(dataStream: &dataStream)
        
        /// Endpoints (36 bytes): A CIEXYZTriple Object (section 2.2.2.7) that defines the CIE chromaticity x, y, and z coordinates
        /// of the three colors that correspond to the red, green, and blue endpoints for the logical color space associated with the
        /// DIB. If the ColorSpaceType field does not specify LCS_CALIBRATED_RGB, this field MUST be ignored.
        self.endpoints = try CIEXYZTriple(dataStream: &dataStream)
        
        /// GammaRed (4 bytes): A 32-bit fixed point value that defines the toned response curve for red. If the ColorSpaceType field
        /// does not specify LCS_CALIBRATED_RGB, this field MUST be ignored.
        self.gammaRed = try dataStream.read(endianess: .littleEndian)
        
        /// GammaGreen (4 bytes): A 32-bit fixed point value that defines the toned response curve for green. If the ColorSpaceType
        /// field does not specify LCS_CALIBRATED_RGB, this field MUST be ignored.
        self.gammaGreen = try dataStream.read(endianess: .littleEndian)
        
        /// GammaBlue (4 bytes): A 32-bit fixed point value that defines the toned response curve for blue. If the ColorSpaceType field
        /// does not specify LCS_CALIBRATED_RGB, this field MUST be ignored.
        /// The gamma value format is an unsigned "8.8" fixed-point integer that is then left-shifted by 8 bits. "8.8" means "8 integer
        /// bits followed by 8 fraction bits": nnnnnnnnffffffff. Taking the shift into account, the required format of the 32-bit DWORD
        /// is: 00000000nnnnnnnnffffffff00000000.
        self.gammaBlue = try dataStream.read(endianess: .littleEndian)
    }
}
