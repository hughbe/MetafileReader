//
//  GamutMappingIntent.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

/// [MS-WMF] 2.1.1.11 GamutMappingIntent Enumeration
/// The GamutMappingIntent Enumeration specifies the relationship between logical and physical colors.<10>
/// typedef enum
/// {
///  LCS_GM_ABS_COLORIMETRIC = 0x00000008,
///  LCS_GM_BUSINESS = 0x00000001,
///  LCS_GM_GRAPHICS = 0x00000002,
/// LCS_GM_IMAGES = 0x00000004
/// } GamutMappingIntent;
public enum GamutMappingIntent: UInt32, DataStreamCreatable {
    /// LCS_GM_ABS_COLORIMETRIC: Specifies that the white point SHOULD be maintained. Typically used when logical colors
    /// MUST be matched to their nearest physical color in the destination color gamut.
    /// Intent: Match
    /// ICC name: Absolute Colorimetric
    case absColorIMetric = 0x00000008
    
    /// LCS_GM_BUSINESS: Specifies that saturation SHOULD be maintained. Typically used for business charts and other situations
    /// in which dithering is not required.
    /// Intent: Graphic
    /// ICC name: Saturation
    case business = 0x00000001
    
    /// LCS_GM_GRAPHICS: Specifies that a colorimetric match SHOULD be maintained. Typically used for graphic designs and
    /// named colors.
    /// Intent: Proof
    /// ICC name: Relative Colorimetric
    case graphics = 0x00000002
    
    /// LCS_GM_IMAGES: Specifies that contrast SHOULD be maintained. Typically used for photographs and natural images.
    /// Intent: Picture
    /// ICC name: Perceptual
    case images = 0x00000004
}
