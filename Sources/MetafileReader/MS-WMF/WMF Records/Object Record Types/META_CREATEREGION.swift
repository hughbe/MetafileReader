//
//  META_CREATEREGION.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.4.6 META_CREATEREGION Record
/// The META_CREATEREGION Record creates a Region Object (section 2.2.1.5).
public struct META_CREATEREGION {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let region: Region
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 3 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_CREATEREGION.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_CREATEREGION.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// Region (variable): Region Object data that defines the region to create.
        self.region = try Region(dataStream: &dataStream)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
