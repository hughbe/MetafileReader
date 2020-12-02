//
//  META_FLOODFILL.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.7 META_FLOODFILL Record
/// The META_FLOODFILL Record fills an area of the output surface with the brush that is defined in the playback device context.
/// See section 2.3.3 for the specification of other Drawing Records.
public struct META_FLOODFILL {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let colorRef: ColorRef
    public let xStart: Int16
    public let yStart: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 7 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_FLOODFILL.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_FLOODFILL.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// ColorRef (4 bytes): A 32-bit ColorRef Object (section 2.2.2.8) that defines the color value.
        self.colorRef = try ColorRef(dataStream: &dataStream)
        
        /// YStart (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the point where filling is to start.
        self.yStart = try dataStream.read(endianess: .littleEndian)
        
        /// XStart (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical units, of the point where filling is to start.
        self.xStart = try dataStream.read(endianess: .littleEndian)
        
        // Seen some cases where there is zero padding of a few more bytes...
        // E.g. libuemf gets META_FLOODFILL and META_EXTFLOODFILL confused.
        // Skip this so that we don't crash.
        while (dataStream.position - startPosition) / 2  < self.recordSize {
            let _: UInt16 = try dataStream.read(endianess: .littleEndian)
        }
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
