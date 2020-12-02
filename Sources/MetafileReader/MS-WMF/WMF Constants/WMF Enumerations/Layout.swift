//
//  Layout.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.13 Layout Enumeration
/// The Layout Enumeration defines options for controlling the direction in which text and graphics are drawn.<11>
/// typedef enum
/// {
///  LAYOUT_LTR = 0x0000,
///  LAYOUT_RTL = 0x0001,
///  LAYOUT_BITMAPORIENTATIONPRESERVED = 0x0008
/// } Layout;
public enum Layout: UInt16, DataStreamCreatable {
    /// LAYOUT_LTR: Sets the default horizontal layout to be left-to-right.
    case ltr = 0x0000
    
    /// LAYOUT_RTL: Sets the default horizontal layout to be right-to-left. Switching to this layout SHOULD cause the mapping mode
    /// in the playback device context to become MM_ISOTROPIC (section 2.1.1.16).
    case rtl = 0x0001
    
    /// LAYOUT_BITMAPORIENTATIONPRESERVED: Disables mirroring of bitmaps that are drawn by META_BITBLT Record (section
    /// 2.3.1.1) and META_STRETCHBLT Record (section 2.3.1.5) operations, when the layout is right-to-left.
    case bitmapOrientationPreserved = 0x0008
}
