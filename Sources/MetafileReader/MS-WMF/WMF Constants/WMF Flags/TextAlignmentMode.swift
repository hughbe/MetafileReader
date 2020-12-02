//
//  TextAlignmentMode.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.2.3 TextAlignmentMode Flags
/// TextAlignmentMode Flags specify the relationship between a reference point and a bounding rectangle, for text alignment. These flags can
/// be combined to specify multiple options, with the restriction that only one flag can be chosen that alters the drawing position in the playback
/// device context.
/// Horizontal text alignment is performed when the font has a horizontal default baseline.
/// TextAlignmentMode flags specify three different components of text alignment:
///  The horizontal position of the reference point is determined by TA_RIGHT and TA_CENTER; if those bits are clear, the alignment MUST
/// be TA_LEFT.
///  The vertical position of the reference point is determined by TA_BOTTOM and TA_BASELINE; if those bits are clear, the alignment MUST
/// be TA_TOP.
///  Whether to update the output position in the playback device context after text output is determined by TA_UPDATECP; if that bit is clear,
/// the position MUST NOT be updated.
/// This is the reason for defining three different zero values in the enumeration; they represent the default states of the three components of
/// text alignment.
public struct TextAlignmentMode: OptionSet, DataStreamCreatable {
    public let rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
    
    /// TA_NOUPDATECP 0x0000 The drawing position in the playback device context MUST NOT be updated after each text output call.
    /// The reference point MUST be passed to the text output function.
    public static let noUpdateCp = TextAlignmentMode([])
    
    /// TA_LEFT 0x0000 The reference point MUST be on the left edge of the bounding rectangle.
    public static let left = TextAlignmentMode([])
    
    /// TA_TOP 0x0000 The reference point MUST be on the top edge of the bounding rectangle.
    public static let top = TextAlignmentMode([])
    
    /// TA_UPDATECP 0x0001 The drawing position in the playback device context MUST be updated after each text output call. It MUST be
    /// used as the reference point.
    public static let updateCp = TextAlignmentMode(rawValue: 0x0001)
    
    /// TA_RIGHT 0x0002 The reference point MUST be on the right edge of the bounding rectangle.
    public static let right = TextAlignmentMode(rawValue: 0x0002)
    
    /// TA_CENTER 0x0006 The reference point MUST be aligned horizontally with the center of the bounding rectangle.
    public static let center = TextAlignmentMode(rawValue: 0x0006)
    
    /// TA_BOTTOM 0x0008 The reference point MUST be on the bottom edge of the bounding rectangle.
    public static let bottom = TextAlignmentMode(rawValue: 0x0008)
    
    /// TA_BASELINE 0x0018 The reference point MUST be on the baseline of the text.
    public static let baseline = TextAlignmentMode(rawValue: 0x0018)
    
    /// TA_RTLREADING 0x0100 The text MUST be laid out in right-to-left reading order, instead of the default left-to-right order. This SHOULD
    /// be applied only when the font that is defined in the playback device context is either Hebrew or Arabic.<39>
    public static let rtlLeading = TextAlignmentMode(rawValue: 0x0100)
    
    public static let all: TextAlignmentMode = [
        .noUpdateCp,
        .left,
        .top,
        .updateCp,
        .right,
        .center,
        .bottom,
        .baseline,
        .rtlLeading
    ]
}
