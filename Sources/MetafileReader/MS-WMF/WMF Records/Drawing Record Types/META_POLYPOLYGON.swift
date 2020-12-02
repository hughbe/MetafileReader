//
//  META_POLYPOLYGON.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.16 META_POLYPOLYGON Record
/// The META_POLYPOLYGON Record paints a series of closed polygons. Each polygon is outlined by using the pen and filled by using the
/// brush and polygon fill mode; these are defined in the playback device context. The polygons drawn by this function can overlap.
/// See section 2.3.3 for the specification of other Drawing Records.
public struct META_POLYPOLYGON {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let polyPolygon: PolyPolygon
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 4 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_POLYPOLYGON.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_POLYPOLYGON.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// PolyPolygon (variable): A variable-sized PolyPolygon Object (section 2.2.2.17) that defines the point information.
        self.polyPolygon = try PolyPolygon(dataStream: &dataStream, recordSize: self.recordSize)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
