//
//  META_EOF.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.2.1 META_EOF Record
/// The META_EOF Record indicates the end of the WMF metafile.
/// See section 2.3.2 for the specification of similar records.
public struct META_EOF {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 3 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines the type of this record. For META_EOF, this value MUST be
        /// 0x0000, as specified in the RecordType Enumeration (section 2.1.1.1) table.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction == RecordType.META_EOF.rawValue else {
            throw MetafileReadError.corrupted
        }
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
