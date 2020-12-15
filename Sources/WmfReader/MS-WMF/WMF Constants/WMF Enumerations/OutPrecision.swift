//
//  OutPrecision.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.21 OutPrecision Enumeration
/// The OutPrecision enumeration defines values for output precision, which is the requirement for the font mapper to match specific font
/// parameters, including height, width, character orientation, escapement, pitch, and font type.
/// typedef enum
/// {
///  OUT_DEFAULT_PRECIS = 0x00000000,
///  OUT_STRING_PRECIS = 0x00000001,
///  OUT_STROKE_PRECIS = 0x00000003,
///  OUT_TT_PRECIS = 0x00000004,
///  OUT_DEVICE_PRECIS = 0x00000005,
///  OUT_RASTER_PRECIS = 0x00000006,
///  OUT_TT_ONLY_PRECIS = 0x00000007,
///  OUT_OUTLINE_PRECIS = 0x00000008,
///  OUT_SCREEN_OUTLINE_PRECIS = 0x00000009,
///  OUT_PS_ONLY_PRECIS = 0x0000000A
/// } OutPrecision;
public enum OutPrecision: UInt8, DataStreamCreatable {
    /// OUT_DEFAULT_PRECIS: A value that specifies default behavior.
    case defaultPrecis = 0x00000000
    
    /// OUT_STRING_PRECIS: A value that is returned when rasterized fonts are enumerated.
    case stringPrecis = 0x00000001
    
    /// OUT_STROKE_PRECIS: A value that is returned when TrueType and other outline fonts, and vector fonts are enumerated.
    case strokePrecis = 0x00000003
    
    /// OUT_TT_PRECIS: A value that specifies the choice of a TrueType font when the system contains multiple fonts with the same name.
    case ttPrecis = 0x00000004
    
    /// OUT_DEVICE_PRECIS: A value that specifies the choice of a device font when the system contains multiple fonts with the same name.
    case devicePrecis = 0x00000005
    
    /// OUT_RASTER_PRECIS: A value that specifies the choice of a rasterized font when the system contains multiple fonts with the same name.
    case rasterPrecis = 0x00000006
    
    /// OUT_TT_ONLY_PRECIS: A value that specifies the requirement for only TrueType fonts. If there are no TrueType fonts installed in the
    /// system, default behavior is specified.
    case ttOnlyPrecis = 0x00000007
    
    /// OUT_OUTLINE_PRECIS: A value that specifies the requirement for TrueType and other outline fonts.
    case outlinePrecis = 0x00000008

    /// OUT_SCREEN_OUTLINE_PRECIS: A value that specifies a preference for TrueType and other outline fonts.
    case screenoutlinePrecis = 0x00000009
    
    /// OUT_PS_ONLY_PRECIS: A value that specifies a requirement for only PostScript fonts. If there are no PostScript fonts installed in the
    /// system, default behavior is specified.
    case psOnlyPrecis = 0x0000000A
}
