//
//  META_SETLAYOUT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.16 META_SETLAYOUT Record
/// The META_SETLAYOUT Record defines the layout orientation in the playback device context.<59> The layout orientation determines
/// the direction in which text and graphics are drawn
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETLAYOUT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let layout: Layout
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
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETLAYOUT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETLAYOUT.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// Layout (2 bytes): A 16-bit unsigned integer that defines the layout of text and graphics. This MUST be one of the values
        /// in the Layout Enumeration (section 2.1.1.13).
        self.layout = try Layout(dataStream: &dataStream)
        
        if (dataStream.position - startPosition) / 2 == self.recordSize {
            self.reserved = nil
            return
        }
        
        /// Reserved (2 bytes): An optional 16-bit field that MUST be ignored.<60>
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
