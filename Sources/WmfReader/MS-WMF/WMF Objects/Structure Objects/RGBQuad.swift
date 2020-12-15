//
//  RGBQuad.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.20 RGBQuad Object
/// The RGBQuad Object defines the pixel color values in an uncompressed DIB Object (section 2.2.2.9).
public struct RGBQuad {
    public let blue: UInt8
    public let green: UInt8
    public let red: UInt8
    public let reserved: UInt8

    public init(dataStream: inout DataStream) throws {
        /// Blue (1 byte): An 8-bit unsigned integer that defines the relative intensity of blue.
        self.blue = try dataStream.read()

        /// Green (1 byte): An 8-bit unsigned integer that defines the relative intensity of green.
        self.green = try dataStream.read()

        /// Red (1 byte): An 8-bit unsigned integer that defines the relative intensity of red.
        self.red = try dataStream.read()

        /// Reserved (1 byte): An 8-bit unsigned integer that MUST be 0x00.
        self.reserved = try dataStream.read()
        //guard self.reserved == 0x00 else {
        //    throw WmfReaderror.corrupted
        //}
    }
}
