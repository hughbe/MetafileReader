//
//  ColorUsage.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

/// [MS-WMF] 2.1.1.6 ColorUsage Enumeration
/// The ColorUsage Enumeration specifies whether a color table exists in a device-independent bitmap (DIB) and how to interpret its values.
/// typedef enum
/// {
///  DIB_RGB_COLORS = 0x0000,
///  DIB_PAL_COLORS = 0x0001,
///  DIB_PAL_INDICES = 0x0002
/// } ColorUsage;
/// A DIB is specified by a DeviceIndependentBitmap Object (section 2.2.2.9).
public enum ColorUsage: UInt16 {
    /// DIB_RGB_COLORS: The color table contains RGB values specified by RGBQuad Objects (section 2.2.2.20).
    case rgbColors = 0x0000
    
    /// DIB_PAL_COLORS: The color table contains 16-bit indices into the current logical palette in the playback device context.
    case palColors = 0x0001
    
    /// DIB_PAL_INDICES: No color table exists. The pixels in the DIB are indices into the current logical palette in the playback device context.
    case palIndices = 0x0002
}
