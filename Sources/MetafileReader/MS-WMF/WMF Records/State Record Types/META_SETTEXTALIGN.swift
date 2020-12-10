//
//  META_SETTEXTALIGN.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.24 META_SETTEXTALIGN Record
/// The META_SETTEXTALIGN Record defines text-alignment values in the playback device context.
public struct META_SETTEXTALIGN {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let textAlignmentMode: UInt16
    public let reserved: UInt16?
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        let recordSize: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard recordSize == 4 || recordSize == 5 else {
            throw WmfReadError.corrupted
        }
        
        self.recordSize = recordSize
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETTEXTALIGN.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETTEXTALIGN.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// TextAlignmentMode (2 bytes): A 16-bit unsigned integer that defines text alignment. This value MUST be a combination of one or
        /// more TextAlignmentMode Flags (section 2.1.2.3) for text with a horizontal baseline, and VerticalTextAlignmentMode Flags
        /// (section 2.1.2.4) for text with a vertical baseline.
        self.textAlignmentMode = try dataStream.read(endianess: .littleEndian)
        
        if (dataStream.position - startPosition) / 2 == self.recordSize {
            self.reserved = nil
            return
        }
        
        /// Reserved (2 bytes): An optional 16-bit field that MUST be ignored.<63>
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
