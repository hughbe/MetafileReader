//
//  FamilyFont.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.8 FamilyFont Enumeration
/// The FamilyFont Enumeration specifies the font family. Font families describe the look of a font in a general way. They are intended for specifying
/// fonts when the exact typeface desired is not available.
/// typedef enum
/// {
///  FF_DONTCARE = 0x00,
///  FF_ROMAN = 0x01,
///  FF_SWISS = 0x02,
///  FF_MODERN = 0x03,
///  FF_SCRIPT = 0x04,
///  FF_DECORATIVE = 0x05
/// } FamilyFont;
/// In a Font Object (section 2.2.1.2), when a FamilyFont value is packed into a byte with a PitchFont Enumeration (section 2.1.1.24) value, the
/// result is a PitchAndFamily Object (section 2.2.2.14).
public enum FamilyFont: UInt8, DataStreamCreatable {
    /// FF_DONTCARE: The default font is specified, which is implementation-dependent.
    case dontCare = 0x00
    
    /// FF_ROMAN: Fonts with variable stroke widths, which are proportional to the actual widths of the glyphs, and which have serifs.
    /// "MS Serif" is an example.
    case roman = 0x01
    
    /// FF_SWISS: Fonts with variable stroke widths, which are proportional to the actual widths of the glyphs, and which do not have serifs.
    /// "MS Sans Serif" is an example.
    case swiss = 0x02
    
    /// FF_MODERN: Fonts with constant stroke width, with or without serifs. Fixed-width fonts are usually modern. "Pica", "Elite", and
    /// "Courier New" are examples.
    case modern = 0x03
    
    /// FF_SCRIPT: Fonts designed to look like handwriting. "Script" and "Cursive" are examples.
    case script = 0x04
    
    /// FF_DECORATIVE: Novelty fonts. "Old English" is an example.
    case decorative = 0x05
    
    case unknown0x07 = 0x07
}
