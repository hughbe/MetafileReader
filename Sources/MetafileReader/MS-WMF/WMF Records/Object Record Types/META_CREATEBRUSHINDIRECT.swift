//
//  META_CREATEBRUSHINDIRECT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.4.1 META_CREATEBRUSHINDIRECT Record
/// The META_CREATEBRUSHINDIRECT Record creates a Brush Object (section 2.2.1.11) from a LogBrush Object (section 2.2.2.10).
/// The following table shows the types of Brush Objects created by the META_CREATEBRUSHINDIRECT, according to the BrushStyle
/// Enumeration (section 2.1.1.4) table value in the LogBrush Object specified by the LogBrush field.
/// BrushStyle Brush Object created
/// BS_SOLID A solid-color Brush Object.
/// BS_NULL An empty Brush Object.
/// BS_PATTERN A default object, such as a solid-color black Brush Object, SHOULD be created.<56>
/// BS_DIBPATTERNPT Same as preceding BS_PATTERN.
/// BS_HATCHED A hatched Brush Object.
/// See section 2.3.4 for the specification of other Object Records.
public struct META_CREATEBRUSHINDIRECT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let logBrush: LogBrush
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 7 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_CREATEBRUSHINDIRECT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_CREATEBRUSHINDIRECT.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// LogBrush (8 bytes): LogBrush Object data that defines the brush to create. The BrushStyle field specified in the LogBrush Object
        /// SHOULD be BS_SOLID, BS_NULL, or BS_HATCHED; otherwise, a default Brush Object MAY be created. See the following table
        /// for details.
        self.logBrush = try LogBrush(dataStream: &dataStream)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
