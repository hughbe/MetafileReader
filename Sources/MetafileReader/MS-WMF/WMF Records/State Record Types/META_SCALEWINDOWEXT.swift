//
//  META_SCALEWINDOWEXT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.13 META_SCALEWINDOWEXT Record
/// The META_SCALEWINDOWEXT Record scales the horizontal and vertical extents of the output window that is defined in the
/// playback device context by using the ratios formed by specified multiplicands and divisors.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SCALEWINDOWEXT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let yDenom: Int16
    public let yNum: Int16
    public let xDenom: Int16
    public let xNum: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 7 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SCALEWINDOWEXT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SCALEWINDOWEXT.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// yDenom (2 bytes): A 16-bit signed integer that defines the amount by which to divide the result of multiplying the current
        /// y-extent by the value of the yNum member.
        self.yDenom = try dataStream.read(endianess: .littleEndian)
        
        /// yNum (2 bytes): A 16-bit signed integer that defines the amount by which to multiply the current yextent.
        self.yNum = try dataStream.read(endianess: .littleEndian)
        
        /// xDenom (2 bytes): A 16-bit signed integer that defines the amount by which to divide the result of multiplying the current
        /// x-extent by the value of the xNum member.
        self.xDenom = try dataStream.read(endianess: .littleEndian)
        
        /// xNum (2 bytes): A 16-bit signed integer that defines the amount by which to multiply the current x-extent.
        self.xNum = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
