//
//  GET_PS_FEATURESETTING.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.6.23 GET_PS_FEATURESETTING Record
/// The GET_PS_FEATURESETTING Record is used to query the driver concerning PostScript features.
/// See section 2.3.6 for the specification of other Escape Record Types.
public struct GET_PS_FEATURESETTING {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let escapeFunction: MetafileEscapes
    public let byteCount: UInt16
    public let feature: PostScriptFeatureSetting
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 7 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ESCAPE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ESCAPE.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// EscapeFunction (2 bytes): A 16-bit unsigned integer that defines the escape function. The value MUST be 0x1019
        /// (GET_PS_FEATURESETTING) from the MetafileEscapes Enumeration (section 2.1.1.17) table.
        self.escapeFunction = try MetafileEscapes(dataStream: &dataStream)
        guard self.escapeFunction == .GET_PS_FEATURESETTING else {
            throw WmfReadError.corrupted
        }
        
        /// ByteCount (2 bytes): A 16-bit unsigned integer that specifies the size, in bytes, of the Feature field.
        /// This MUST be 0x0004.
        self.byteCount = try dataStream.read(endianess: .littleEndian)
        guard self.byteCount == 0x0004 else {
            throw WmfReadError.corrupted
        }
        
        /// Feature (4 bytes): A 32-bit signed integer that identifies the feature setting being queried. Possible values are defined in
        /// the PostScriptFeatureSetting Enumeration (section 2.1.1.28).
        self.feature = try PostScriptFeatureSetting(dataStream: &dataStream)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
