//
//  META_CREATEPENINDIRECT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.4.5 META_CREATEPENINDIRECT Record
/// The META_CREATEPENINDIRECT Record creates a Pen Object (section 2.2.1.4).
/// See section 2.3.4 for the specification of other Object Records.
public struct META_CREATEPENINDIRECT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let pen: Pen
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        let recordSize: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard recordSize == 8 || recordSize == 9 else {
            throw MetafileReadError.corrupted
        }
        
        self.recordSize = recordSize
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_CREATEPENINDIRECT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_CREATEPENINDIRECT.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// Pen (10 bytes): Pen Object data that defines the pen to create.
        self.pen = try Pen(dataStream: &dataStream)
        
        if recordSize == 9 {
            let _: UInt16 = try dataStream.read(endianess: .littleEndian)
        }
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
