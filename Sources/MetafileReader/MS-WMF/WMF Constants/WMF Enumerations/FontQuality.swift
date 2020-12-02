//
//  FontQuality.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.10 FontQuality Enumeration
/// The FontQuality Enumeration specifies how closely the attributes of the logical font match those of the physical font when rendering text.
/// typedef enum
/// {
///  DEFAULT_QUALITY = 0x00,
///  DRAFT_QUALITY = 0x01,
///  PROOF_QUALITY = 0x02,
///  NONANTIALIASED_QUALITY = 0x03,
///  ANTIALIASED_QUALITY = 0x04,
///  CLEARTYPE_QUALITY = 0x05
/// } FontQuality;
public enum FontQuality: UInt8, DataStreamCreatable {
    /// DEFAULT_QUALITY: Specifies that the character quality of the font does not matter, so DRAFT_QUALITY can be used.
    case `default` = 0x00
    
    /// DRAFT_QUALITY: Specifies that the character quality of the font is less important than the matching of logical attribuetes. For rasterized
    /// fonts, scaling SHOULD be enabled, which means that more font sizes are available.
    case draft = 0x01
    
    /// PROOF_QUALITY: Specifies that the character quality of the font is more important than the matching of logical attributes. For rasterized
    /// fonts, scaling SHOULD be disabled, and the font closest in size SHOULD be chosen.
    case proof = 0x02
    
    /// NONANTIALIASED_QUALITY: Specifies that anti-aliasing SHOULD NOT be used when rendering text.<7>
    case nonAntiAliased = 0x03
    
    /// ANTIALIASED_QUALITY: Specifies that anti-aliasing SHOULD be used when rendering text, if the font supports it.<8>
    case antiAliased = 0x04
    
    /// CLEARTYPE_QUALITY: Specifies that ClearType anti-aliasing SHOULD be used when rendering text, if the font supports it.<9>
    /// Fonts that do not support ClearType anti-aliasing include type 1 fonts, PostScript fonts, OpenType fonts without TrueType outlines,
    /// rasterized fonts, vector fonts, and device fonts.
    case clearType = 0x05
}
