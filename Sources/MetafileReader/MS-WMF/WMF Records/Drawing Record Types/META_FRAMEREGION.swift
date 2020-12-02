//
//  META_FRAMEREGION.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.8 META_FRAMEREGION Record
/// The META_FRAMEREGION Record draws a border around a specified region using a specified brush.
/// The WMF Object Table refers to an indexed table of WMF Objects (section 2.2) that are defined in the metafile. See section
/// 3.1.4.1 for more information. 
/// See section 2.3.3 for the specification of other Drawing Records.
public struct META_FRAMEREGION {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let region: UInt16
    public let brush: UInt16
    public let height: Int16
    public let width: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 7 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_FRAMEREGION.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_FRAMEREGION.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// Region (2 bytes): A 16-bit unsigned integer used to index into the WMF Object Table (section 3.1.4.1) to get the region to
        /// be framed.
        self.region = try dataStream.read(endianess: .littleEndian)
        
        /// Brush (2 bytes): A 16-bit unsigned integer used to index into the WMF Object Table to get the Brush to use for filling the
        /// region.
        self.brush = try dataStream.read(endianess: .littleEndian)
        
        /// Height (2 bytes): A 16-bit signed integer that defines the height, in logical units, of the region frame.
        self.height = try dataStream.read(endianess: .littleEndian)
        
        /// Width (2 bytes): A 16-bit signed integer that defines the width, in logical units, of the region frame.
        self.width = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
