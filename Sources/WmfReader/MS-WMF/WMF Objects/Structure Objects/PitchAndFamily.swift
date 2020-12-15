//
//  PitchAndFamily.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.14 PitchAndFamily Object
/// The PitchAndFamily Object specifies the pitch and family properties of a Font Object (section 2.2.1.2). Pitch refers to the width of the
/// characters, and family refers to the general appearance of a font.
public struct PitchAndFamily {
    public let family: FamilyFont
    public let pitch: PitchFont
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// Family (4 bits): A property of a font that describes its general appearance. This MUST be a value in the FamilyFont Enumeration
        /// (section 2.1.1.8).
        guard let family = FamilyFont(rawValue: flags.readBits(count: 4)) else {
            throw WmfReadError.corrupted
        }
        
        self.family = family
        
        let _: UInt8 = flags.readBits(count: 2)
        
        /// Pitch (2 bits): A property of a font that describes the pitch, of the characters. This MUST be a value in the PitchFont Enumeration
        /// (section 2.1.1.24).
        guard let pitch = PitchFont(rawValue: flags.readBits(count: 2)) else {
            throw WmfReadError.corrupted
        }
        
        self.pitch = pitch
    }
}
