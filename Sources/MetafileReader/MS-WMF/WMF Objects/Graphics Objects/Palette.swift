//
//  Palette.swift
//  
//
//  Created by Hugh Bellamy on 02/12/2020.
//

import DataStream

/// [MS-WMF] 2.2.1.3 Palette Object
/// The Palette Object specifies the colors in a logical palette.
public struct Palette {
    public let start: UInt16
    public let numberOfEntries: UInt16
    public let aPaletteEntries: [PaletteEntry]
    
    public init(dataStream: inout DataStream) throws {
        /// Start (2 bytes): A 16-bit unsigned integer that defines the offset into the Palette Object when used with the
        /// META_SETPALENTRIES and META_ANIMATEPALETTE record types. When used with META_CREATEPALETTE record
        /// type, it MUST be 0x0300.
        self.start = try dataStream.read(endianess: .littleEndian)
        guard self.start == 0x0300 else {
            throw MetafileReadError.corrupted
        }
        
        /// NumberOfEntries (2 bytes): A 16-bit unsigned integer that defines the number of objects in aPaletteEntries.
        self.numberOfEntries = try dataStream.read(endianess: .littleEndian)
        
        /// aPaletteEntries (variable): An array of NumberOfEntries 32-bit PaletteEntry Objects (section 2.2.2.13).
        var aPaletteEntries: [PaletteEntry] = []
        aPaletteEntries.reserveCapacity(Int(self.numberOfEntries))
        for _ in 0..<self.numberOfEntries {
            aPaletteEntries.append(try PaletteEntry(dataStream: &dataStream))
        }
        
        self.aPaletteEntries = aPaletteEntries
    }
}
