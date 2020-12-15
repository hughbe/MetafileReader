//
//  ClipPrecision.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.2.1 ClipPrecision Flags
/// ClipPrecision Flags specify clipping precision, which defines how to clip characters that are partially outside a clipping region. These flags
/// can be combined to specify multiple options.
public struct ClipPrecision: OptionSet, DataStreamCreatable {
    public let rawValue: UInt8
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    /// CLIP_DEFAULT_PRECIS 0x00000000 Specifies that default clipping MUST be used.
    public static let defaultPrecis = ClipPrecision([])
    
    /// CLIP_CHARACTER_PRECIS 0x00000001 This value SHOULD NOT be used.
    public static let characterPrecis = ClipPrecision(rawValue: 0x01)
    
    /// CLIP_STROKE_PRECIS 0x00000002 This value MAY be returned when enumerating rasterized, TrueType and vector fonts.<31>
    public static let strokePrecis = ClipPrecision(rawValue: 0x01)
    
    /// CLIP_LH_ANGLES 0x00000010 This value is used to control font rotation, as follows:
    ///  If set, the rotation for all fonts SHOULD be determined by the orientation of the coordinate system; that is, whether the orientation is
    /// left-handed or right-handed.
    ///  If clear, device fonts SHOULD rotate counterclockwise, but the rotation of other fonts SHOULD be determined by the orientation of
    /// the coordinate system.
    public static let lhAngles = ClipPrecision(rawValue: 0x10)
    
    /// CLIP_TT_ALWAYS 0x00000020 This value SHOULD NOT<32> be used.
    public static let ttAlways = ClipPrecision(rawValue: 0x20)

    /// CLIP_DFA_DISABLE 0x00000040 This value specifies that font association SHOULD<33> be turned off.
    public static let dfaDisable = ClipPrecision(rawValue: 0x40)
    
    /// CLIP_EMBEDDED 0x00000080 This value specifies that font embedding MUST be used to render document content; embedded fonts
    /// are read-only.
    public static let embedded = ClipPrecision(rawValue: 0x80)
    
    public static let all: ClipPrecision = [
        .defaultPrecis,
        .characterPrecis,
        .strokePrecis,
        .lhAngles,
        .ttAlways,
        .dfaDisable,
        .embedded
    ]
}
