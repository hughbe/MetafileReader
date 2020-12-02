//
//  META_HEADER.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.2.2 META_HEADER Record
/// The META_HEADER Record is the first record in a standard (nonplaceable) WMF metafile
/// See section 2.3.2 for the specification of similar records.
public struct META_HEADER {
    public let type: MetafileType
    public let headerSize: UInt16
    public let version: MetafileVersion
    public let sizeLow: UInt16
    public let sizeHigh: UInt16
    public let numberOfObjects: UInt16
    public let maxRecord: UInt32
    public let numberOfMembers: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// Type (2 bytes): A 16-bit unsigned integer that defines the type of metafile. It MUST be a value in the MetafileType Enumeration
        /// (section 2.1.1.18).
        self.type = try MetafileType(dataStream: &dataStream)
        
        /// HeaderSize (2 bytes): A 16-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the header.
        self.headerSize = try dataStream.read(endianess: .littleEndian)
        guard self.headerSize == 9 else {
            throw MetafileReadError.corrupted
        }
        
        /// Version (2 bytes): A 16-bit unsigned integer that defines the metafile version. It MUST be a value in the MetafileVersion Enumeration
        /// (section 2.1.1.19).<54>
        self.version = try MetafileVersion(dataStream: &dataStream)
        
        /// SizeLow (2 bytes): A 16-bit unsigned integer that defines the low-order word of the number of 16-bit WORD structures in the entire
        /// metafile.
        self.sizeLow = try dataStream.read(endianess: .littleEndian)
        
        /// SizeHigh (2 bytes): A 16-bit unsigned integer that defines the high-order word of the number of 16-bit WORD structures in the entire
        /// metafile.
        self.sizeHigh = try dataStream.read(endianess: .littleEndian)
        
        /// NumberOfObjects (2 bytes): A 16-bit unsigned integer that specifies the number of graphics objects that are defined in the entire
        /// metafile. These objects include brushes, pens, and the other objects specified in section 2.2.1.
        self.numberOfObjects = try dataStream.read(endianess: .littleEndian)
        
        /// MaxRecord (4 bytes): A 32-bit unsigned integer that specifies the size of the largest record used in the metafile (in 16-bit elements).
        self.maxRecord = try dataStream.read(endianess: .littleEndian)
        
        /// NumberOfMembers (2 bytes): A 16-bit unsigned integer that is not used. It SHOULD be 0x0000.
        self.numberOfMembers = try dataStream.read(endianess: .littleEndian)
    }
}
