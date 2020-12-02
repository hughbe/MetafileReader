//
//  META_SETBKCOLOR.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.5.14 META_SETBKCOLOR Record
/// The META_SETBKCOLOR Record sets the background color in the playback device context to a specified color, or to the nearest
/// physical color if the device cannot represent the specified color.
/// See section 2.3.5 for the specification of other State Record Types.
public struct META_SETBKCOLOR {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let colorRef: ColorRef
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 5 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETBKCOLOR.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETBKCOLOR.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// ColorRef (4 bytes): A 32-bit ColorRef Object (section 2.2.2.8) that defines the color value.
        self.colorRef = try ColorRef(dataStream: &dataStream)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
