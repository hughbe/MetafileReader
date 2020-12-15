//
//  CLOSE_CHANNEL.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.6.7 CLOSE_CHANNEL Record
/// The CLOSE_CHANNEL Record notifies the printer driver that the current print job is ending. This is the same function as the
/// ENDDOC Record (section 2.3.6.13). A CLOSE_CHANNEL MUST be preceded by an OPEN_CHANNEL Record (section 2.3.6.35).
/// See section 2.3.6 for the specification of other Escape Record Types.
public struct CLOSE_CHANNEL {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let escapeFunction: MetafileEscapes
    public let byteCount: UInt16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 5 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ESCAPE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ESCAPE.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// EscapeFunction (2 bytes): A 16-bit unsigned integer that defines the escape function. The value MUST be 0x1010
        /// (CLOSE_CHANNEL) from the MetafileEscapes Enumeration (section 2.1.1.17) table.
        self.escapeFunction = try MetafileEscapes(dataStream: &dataStream)
        guard self.escapeFunction == .CLOSE_CHANNEL else {
            throw WmfReadError.corrupted
        }
        
        /// ByteCount (2 bytes): A 16-bit unsigned integer that MUST be 0x0000.
        self.byteCount = try dataStream.read(endianess: .littleEndian)
        guard self.byteCount == 0x0000 else {
            throw WmfReadError.corrupted
        }
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
