//
//  MetafileType.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.20 MixMode Enumeration
/// The MixMode Enumeration specifies the background mix mode for text, hatched brushes, and other
/// nonsolid pen styles.
/// typedef enum
/// {
///  TRANSPARENT = 0x0001,
///  OPAQUE = 0x0002
/// } MixMode;
public enum MixMode: UInt16, DataStreamCreatable {
    /// TRANSPARENT: The background remains untouched.
    case transparent = 0x0001
    
    /// OPAQUE: The background is filled with the background color that is currently defined in the playback device context before the text,
    /// hatched brush, or pen is drawn.
    case opaque = 0x0002
}
