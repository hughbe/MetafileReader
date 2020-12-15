//
//  StretchMode.swift
//  
//
//  Created by Hugh Bellamy on 01/12/2020.
//

/// [MS-WMF] 2.1.1.30 StretchMode Enumeration
/// The StretchMode Enumeration specifies the bitmap stretching mode, which defines how the system combines rows or columns of a
/// bitmap with existing pixels.
/// typedef enum
/// {
///  BLACKONWHITE = 0x0001,
///  WHITEONBLACK = 0x0002,
///  COLORONCOLOR = 0x0003,
///  HALFTONE = 0x0004
/// } StretchMode;
public enum StretchMode: UInt16, DataStreamCreatable {
    /// BLACKONWHITE: Performs a Boolean AND operation by using the color values for the eliminated and existing pixels. If the bitmap is a
    /// monochrome bitmap, this mode preserves black pixels at the expense of white pixels.<27>
    case blackOnWhite = 0x0001

    /// WHITEONBLACK: Performs a Boolean OR operation by using the color values for the eliminated and existing pixels. If the bitmap is a
    /// monochrome bitmap, this mode preserves white pixels at the expense of black pixels.<28>
    case whiteOnBlack = 0x0002

    /// COLORONCOLOR: Deletes the pixels. This mode deletes all eliminated lines of pixels without trying to preserve their information.<29>
    case colorOnColor = 0x0003

    /// HALFTONE: Maps pixels from the source rectangle into blocks of pixels in the destination rectangle. The average color over the
    /// destination block of pixels approximates the color of the source pixels.<30>
    case halftone = 0x0004
}
