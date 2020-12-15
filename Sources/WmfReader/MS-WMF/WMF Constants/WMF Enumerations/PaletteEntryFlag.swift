//
//  PaletteEntryFlag.swift
//  
//
//  Created by Hugh Bellamy on 02/12/2020.
//

/// [MS-WMF] 2.1.1.22 PaletteEntryFlag Enumeration
/// The PaletteEntryFlag Enumeration specifies how the palette entry is used.
/// typedef enum
/// {
///  PC_RESERVED = 0x01,
///  PC_EXPLICIT = 0x02,
///  PC_NOCOLLAPSE = 0x04
/// } PaletteEntryFlag;
public enum PaletteEntryFlag: UInt8, DataStreamCreatable {
    case none = 0x00
    
    /// PC_RESERVED: Specifies that the logical palette entry be used for palette animation. This value prevents other windows from
    /// matching colors to the palette entry because the color frequently changes. If an unused system-palette entry is available, the
    /// color is placed in that entry. Otherwise, the color is not available for animation.
    case reserved = 0x01
    
    /// PC_EXPLICIT: Specifies that the low-order word of the logical palette entry designates a hardware palette index. This value
    /// allows the application to show the contents of the display device palette.
    case explicit = 0x02
    
    /// PC_NOCOLLAPSE: Specifies that the color be placed in an unused entry in the system palette instead of being matched to
    /// an existing color in the system palette. If there are no unused entries in the system palette, the color is matched normally.
    /// Once this color is in the system palette, colors in other logical palettes can be matched to this color.
    case noCollapse = 0x04
}
