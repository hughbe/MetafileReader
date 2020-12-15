//
//  LogicalColorSpaceV5.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.15 LogicalColorSpaceV5 Enumeration
/// The LogicalColorSpaceV5 Enumeration is used to specify where to find color profile information for a DeviceIndependentBitmap
/// (DIB) Object (section 2.2.2.9) that has a header of type BitmapV5Header Object (section 2.2.2.5).<13>
/// typedef enum
/// {
///  LCS_PROFILE_LINKED = 0x4C494E4B,
///  LCS_PROFILE_EMBEDDED = 0x4D424544
/// } LogicalColorSpaceV5;
public enum LogicalColorSpaceV5: UInt32, DataStreamCreatable {
    /// LCS_PROFILE_LINKED: The value consists of the string "LINK" from the Windows character set (code page 1252). It indicates
    /// that the color profile MUST be linked with the DIB Object.
    case profileLinked = 0x4C494E4B
    
    /// LCS_PROFILE_EMBEDDED: The value consists of the string "MBED" from the Windows character set (code page 1252). It
    /// indicates that the color profile MUST be embedded in the DIB Object.
    case profileEmbedded = 0x4D424544
}
