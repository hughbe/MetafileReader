//
//  META_CREATEFONTINDIRECT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.4.2 META_CREATEFONTINDIRECT Record
/// The META_CREATEFONTINDIRECT Record creates a Font Object (section 2.2.1.2)
/// See section 2.3.4 for the specification of other Object Records.
public struct META_CREATEFONTINDIRECT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let font: Font
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 12 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_CREATEFONTINDIRECT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_CREATEFONTINDIRECT.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// Font (variable): Font Object data that defines the font to create.
        self.font = try Font(dataStream: &dataStream, startPosition: startPosition, recordSize: recordSize)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
