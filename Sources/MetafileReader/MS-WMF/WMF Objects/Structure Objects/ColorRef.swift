//
//  ColorRef.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.8 ColorRef Object
/// The ColorRef Object defines the RGB color.
public struct ColorRef {
    public let red: UInt8
    public let green: UInt8
    public let blue: UInt8
    public let reserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// Red (1 byte): An 8-bit unsigned integer that defines the relative intensity of red.
        self.red = try dataStream.read()
        
        /// Green (1 byte): An 8-bit unsigned integer that defines the relative intensity of green.
        self.green = try dataStream.read()
        
        /// Blue (1 byte): An 8-bit unsigned integer that defines the relative intensity of blue.
        self.blue = try dataStream.read()
        
        /// Reserved (1 byte): An 8-bit unsigned integer that MUST be 0x00.
        self.reserved = try dataStream.read()
    }
}
