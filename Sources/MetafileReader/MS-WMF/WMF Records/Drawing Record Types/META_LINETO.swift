//
//  META_LINETO.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.10 META_LINETO Record
/// The META_LINETO Record draws a line from the drawing position that is defined in the playback device context up to, but not including,
/// the specified point.
/// See section 2.3.3 for the specification of other Drawing Records.
public struct META_LINETO {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let x: Int16
    public let y: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 5 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_LINETO.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_LINETO.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// Y (2 bytes): A 16-bit signed integer that defines the vertical component of the drawing destination position, in logical units.
        self.y = try dataStream.read(endianess: .littleEndian)
        
        /// X (2 bytes): A 16-bit signed integer that defines the horizontal component of the drawing destination position, in logical units.
        self.x = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
