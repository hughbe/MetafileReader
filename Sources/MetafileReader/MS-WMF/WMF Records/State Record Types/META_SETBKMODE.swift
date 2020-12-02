//
//  META_SETBKMODE.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.15 META_SETBKMODE Record
/// The META_SETBKMODE Record defines the background raster operation mix mode in the playback device context. The background
/// mix mode is the mode for combining pens, text, hatched brushes, and interiors of filled objects with background colors on the output
/// surface.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETBKMODE {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let bkMode: MixMode
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
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETBKMODE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETBKMODE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// BkMode (2 bytes): A 16-bit unsigned integer that defines background mix mode. This MUST be one of the values in the MixMode
        /// Enumeration (section 2.1.1.20).
        self.bkMode = try MixMode(dataStream: &dataStream)
        
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
