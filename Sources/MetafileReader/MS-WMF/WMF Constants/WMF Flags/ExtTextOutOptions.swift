//
//  ExtTextOutOptions.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.2.2 ExtTextOutOptions Flags
/// ExtTextOutOptions Flags specify various characteristics of the output of text. These flags can be combined to specify multiple options.
public struct ExtTextOutOptions: OptionSet, DataStreamCreatable {
    public let rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
    
    /// ETO_OPAQUE 0x0002 Indicates that the background color that is defined in the playback device context SHOULD be used to fill the
    /// rectangle.
    public static let opaque = ExtTextOutOptions(rawValue: 0x0002)
    
    /// ETO_CLIPPED 0x0004 Indicates that the text SHOULD be clipped to the rectangle.
    public static let clipped = ExtTextOutOptions(rawValue: 0x0004)
    
    /// ETO_GLYPH_INDEX 0x0010 Indicates that the string to be output SHOULD NOT require further processing with respect to the placement
    /// of the characters, and an array of character placement values SHOULD be provided. This character placement process is useful for fonts
    /// in which diacritical characters affect character spacing.<34>
    public static let glyphIndex = ExtTextOutOptions(rawValue: 0x0010)
    
    /// ETO_RTLREADING 0x0080 Indicates that the text MUST be laid out in right-to-left reading order, instead of the default left-to-right order.
    /// This SHOULD be applied only when the font that is defined in the playback device context is either Hebrew or Arabic.<35>
    public static let rtlLeading = ExtTextOutOptions(rawValue: 0x0080)
    
    /// ETO_NUMERICSLOCAL 0x0400 Indicates that to display numbers, digits appropriate to the locale SHOULD be used.<36>
    public static let numericsLocal = ExtTextOutOptions(rawValue: 0x0400)
    
    /// ETO_NUMERICSLATIN 0x0800 Indicates that to display numbers, European digits SHOULD be used.<37>
    public static let numericsLatin = ExtTextOutOptions(rawValue: 0x0800)

    /// ETO_PDY 0x2000 Indicates that both horizontal and vertical character displacement values SHOULD be provided.<38>
    public static let pdy = ExtTextOutOptions(rawValue: 0x2000)
    
    public static let all: ExtTextOutOptions = [
        .opaque,
        .clipped,
        .glyphIndex,
        .numericsLocal,
        .numericsLatin,
        .pdy
    ]
}
