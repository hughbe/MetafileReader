//
//  VerticalTextAlignmentMode.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.2.4 VerticalTextAlignmentMode Flags
/// VerticalTextAlignmentMode Flags specify the relationship between a reference point and a bounding rectangle, for text alignment. These flags
/// can be combined to specify multiple options, with the restriction that only one flag can be chosen that alters the drawing position in the
/// playback device context.
/// Vertical text alignment is performed when the font has a vertical default baseline, such as Kanji.
public struct VerticalTextAlignmentMode: OptionSet, DataStreamCreatable {
    public let rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
    
    /// VTA_TOP 0x0000 The reference point MUST be on the top edge of the bounding rectangle.
    public static let top = VerticalTextAlignmentMode([])
    
    /// VTA_RIGHT 0x0000 The reference point MUST be on the right edge of the bounding rectangle.
    public static let right = VerticalTextAlignmentMode([])
    
    /// VTA_BOTTOM 0x0002 The reference point MUST be on the bottom edge of the bounding rectangle.
    public static let bottom = VerticalTextAlignmentMode(rawValue: 0x0002)
    
    /// VTA_CENTER 0x0006 The reference point MUST be aligned vertically with the center of the bounding rectangle.
    public static let center = VerticalTextAlignmentMode(rawValue: 0x0006)
    
    /// VTA_LEFT 0x0008 The reference point MUST be on the left edge of the bounding rectangle.
    public static let left = VerticalTextAlignmentMode(rawValue: 0x0008)
    
    /// VTA_BASELINE 0x0018 The reference point MUST be on the baseline of the text.
    public static let baseline = VerticalTextAlignmentMode(rawValue: 0x0018)
    
    public static let all: VerticalTextAlignmentMode = [
        .top,
        .right,
        .bottom,
        .center,
        .left,
        .baseline
    ]
}
