//
//  META_SETMAPMODE.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.17 META_SETMAPMODE Record
/// The META_SETMAPMODE Record defines the mapping mode in the playback device context.
/// The mapping mode defines the unit of measure used to transform page-space units into device-space units, and also defines the orientation
/// of the device's x and y axes.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETMAPMODE {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let mapMode: MapMode
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 4 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETMAPMODE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETMAPMODE.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// MapMode (2 bytes): A 16-bit unsigned integer that defines the mapping mode. This MUST be one of the values enumerated in the
        /// MapMode Enumeration (section 2.1.1.16) table.
        self.mapMode = try MapMode(dataStream: &dataStream)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
