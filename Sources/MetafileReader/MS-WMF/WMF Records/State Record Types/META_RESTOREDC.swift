//
//  META_RESTOREDC.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.10 META_RESTOREDC Record
/// The META_RESTOREDC Record restores the playback device context from a previously saved device context.
/// See section 3.1.5 for a description of the state defined by the playback device context.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_RESTOREDC {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let nSavedDC: UInt16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 4 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_RESTOREDC.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_RESTOREDC.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// nSavedDC (2 bytes): A 16-bit signed integer that defines the saved state to be restored. If this member is positive, nSavedDC
        /// represents a specific instance of the state to be restored. If this member is negative, nSavedDC represents an instance relative
        /// to the current state.
        self.nSavedDC = try dataStream.read(endianess: .littleEndian)

        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
