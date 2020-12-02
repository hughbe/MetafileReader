//
//  META_SELECTOBJECT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.4.10 META_SELECTOBJECT Record
/// The META_SELECTOBJECT Record specifies a graphics object for the playback device context.
/// The new object replaces the previous object of the same type, unless if the previous object is a palette object. If the previous object is a Palette
/// Object (section 2.2.1.3), then the META_SELECTPALETTE Record (section 2.3.4.11) MUST be used instead of the META_SELECTOBJECT
/// Record (section 2.3.4.10), because the META_SELECTOBJECT Record does not support replacing the Palette Object type.
/// The WMF Object Table refers to an indexed table of WMF Objects (section 2.2) that are defined in the metafile. See section 3.1.4.1 for more
/// information.
/// See section 2.3.4 for the specification of other Object Records.
public struct META_SELECTOBJECT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let objectIndex: UInt16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 4 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SELECTOBJECT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SELECTOBJECT.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// ObjectIndex (2 bytes): A 16-bit unsigned integer used to index into the WMF Object Table (section 3.1.4.1) to get the object to
        /// be selected.
        self.objectIndex = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
