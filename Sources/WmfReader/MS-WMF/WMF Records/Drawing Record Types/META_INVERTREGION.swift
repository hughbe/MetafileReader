//
//  META_INVERTREGION.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.9 META_INVERTREGION Record
/// The META_INVERTREGION Record draws a region in which the colors are inverted.
/// The WMF Object Table refers to an indexed table of WMF Objects (section 2.2) that are defined in the metafile. See section
/// 3.1.4.1 for more information.
/// See section 2.3.3 for the specification of other Drawing Records.
public struct META_INVERTREGION {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let region: UInt16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 4 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_INVERTREGION.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_INVERTREGION.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// Region (2 bytes): A 16-bit unsigned integer used to index into the WMF Object Table (section 3.1.4.1) to get the region to
        /// be inverted.
        self.region = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}