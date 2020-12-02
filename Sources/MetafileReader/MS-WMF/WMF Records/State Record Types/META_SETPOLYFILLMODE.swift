//
//  META_SETPOLYFILLMODE.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.20 META_SETPOLYFILLMODE Record
/// The META_SETPOLYFILLMODE Record sets polygon fill mode in the playback device context for graphics operations that fill polygons.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETPOLYFILLMODE {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let polyFillMode: PolyFillMode
    public let reserved: UInt16?
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        let recordSize: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard recordSize == 4 || recordSize == 5 else {
            throw MetafileReadError.corrupted
        }
        
        self.recordSize = recordSize
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETPOLYFILLMODE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETPOLYFILLMODE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// PolyFillMode (2 bytes): A 16-bit unsigned integer that defines polygon fill mode. This MUST be one of the values in the PolyFillMode
        /// Enumeration (section 2.1.1.25).
        self.polyFillMode = try PolyFillMode(dataStream: &dataStream)
        
        if (dataStream.position - startPosition) / 2 == self.recordSize {
            self.reserved = nil
            return
        }
        
        /// Reserved (2 bytes): An optional 16-bit field that MUST be ignored.<60>
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
