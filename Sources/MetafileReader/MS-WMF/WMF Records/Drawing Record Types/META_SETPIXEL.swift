//
//  META_SETPIXEL.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.19 META_SETPIXEL Record
/// The META_SETPIXEL Record sets the pixel at the specified coordinates to the specified color.
/// See section 2.3.3 for the specification of other Drawing Records.
public struct META_SETPIXEL {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let colorRef: ColorRef
    public let x: Int16
    public let y: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 7 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETPIXEL.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETPIXEL.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// ColorRef (4 bytes): A ColorRef Object (section 2.2.2.8) that defines the color value.
        self.colorRef = try ColorRef(dataStream: &dataStream)
        
        /// Y (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the point to be set.
        self.y = try dataStream.read(endianess: .littleEndian)
        
        /// Y (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the point to be set.
        self.x = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
