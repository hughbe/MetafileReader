//
//  CIEXYZTriple.swift
//  
//
//  Created by Hugh Bellamy on 02/12/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.7 CIEXYZTriple Object
/// The CIEXYZTriple Object defines information about the CIEXYZTriple color object.
public struct CIEXYZTriple {
    public let ciexyzRed: CIEXYZ
    public let ciexyzGreen: CIEXYZ
    public let ciexyzBlue: CIEXYZ
    
    public init(dataStream: inout DataStream) throws {
        /// ciexyzRed (12 bytes): A 96-bit CIEXYZ Object (section 2.2.2.6) that defines the red chromaticity values.
        self.ciexyzRed = try CIEXYZ(dataStream: &dataStream)
        
        /// ciexyzGreen (12 bytes): A 96-bit CIEXYZ Object that defines the green chromaticity values.
        self.ciexyzGreen = try CIEXYZ(dataStream: &dataStream)
        
        /// ciexyzBlue (12 bytes): A 96-bit CIEXYZ Object that defines the blue chromaticity values.
        self.ciexyzBlue = try CIEXYZ(dataStream: &dataStream)
    }
}
