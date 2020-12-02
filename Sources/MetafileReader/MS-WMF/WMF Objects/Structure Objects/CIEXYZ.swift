//
//  CIEXYZ.swift
//  
//
//  Created by Hugh Bellamy on 02/12/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.6 CIEXYZ Object
/// The CIEXYZ Object defines information about the CIEXYZ chromaticity object.
public struct CIEXYZ {
    public let ciexyzX: Int32
    public let ciexyzY: Int32
    public let ciexyzZ: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// ciexyzX (4 bytes): A 32-bit 2.30 fixed point type that defines the x chromaticity value.
        self.ciexyzX = try dataStream.read(endianess: .littleEndian)
        
        /// ciexyzY (4 bytes): A 32-bit 2.30 fixed point type that defines the y chromaticity value.
        self.ciexyzY = try dataStream.read(endianess: .littleEndian)
        
        /// ciexyzZ (4 bytes): A 32-bit 2.30 fixed point type that defines the z chromaticity value.
        self.ciexyzZ = try dataStream.read(endianess: .littleEndian)
    }
}
