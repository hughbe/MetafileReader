//
//  LogicalColorSpace.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.14 LogicalColorSpace Enumeration
/// The LogicalColorSpace Enumeration specifies the type of color space.<12>
/// typedef enum
/// {
///  LCS_CALIBRATED_RGB = 0x00000000,
///  LCS_sRGB = 0x73524742,
///  LCS_WINDOWS_COLOR_SPACE = 0x57696E20
/// } LogicalColorSpace;
public enum LogicalColorSpace: UInt32, DataStreamCreatable {
    /// LCS_CALIBRATED_RGB: Color values are calibrated red green blue (RGB) values.
    case calibratedRGB = 0x00000000
    
    /// LCS_sRGB: The value is an encoding of the ASCII characters "sRGB", and it indicates that the color values are sRGB values.
    case srgb = 0x73524742
    
    /// LCS_WINDOWS_COLOR_SPACE: The value is an encoding of the ASCII characters "Win ", including the trailing space, and
    /// it indicates that the color values are Windows default color space values.
    case windowsColorSpace = 0x57696E20
}
