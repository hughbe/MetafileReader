//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.24 PitchFont Enumeration
/// The PitchFont Enumeration defines values that are used for specifying characteristics of a font. The values are used to indicate whether the
/// characters in a font have a fixed or variable width, or pitch.
/// typedef enum
/// {
///  DEFAULT_PITCH = 0,
///  FIXED_PITCH = 1,
///  VARIABLE_PITCH = 2
/// } PitchFont;
/// In a Font Object (section 2.2.1.2), when a FamilyFont Enumeration (section 2.1.1.8) value is packed into a byte with a PitchFont value, the
/// result is a PitchAndFamily Object (section 2.2.2.14).
public enum PitchFont: UInt8, DataStreamCreatable {
    /// DEFAULT_PITCH: The default pitch, which is implementation-dependent.
    case `default` = 0

    /// FIXED_PITCH: A fixed pitch, which means that all the characters in the font occupy the same width when output in a string.
    case fixed = 1
    
    /// VARIABLE_PITCH: A variable pitch, which means that the characters in the font occupy widths that are proportional to the actual widths
    /// of the glyphs when output in a string. For example, the "i" and space characters usually have much smaller widths than a "W" or "O"
    /// character.
    case variable = 2
}
