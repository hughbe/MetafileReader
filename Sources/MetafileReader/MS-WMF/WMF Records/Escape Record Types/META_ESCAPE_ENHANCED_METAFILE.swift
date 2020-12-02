//
//  META_ESCAPE_ENHANCED_METAFILE.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.6.25 META_ESCAPE_ENHANCED_METAFILE Record
/// The META_ESCAPE_ENHANCED_METAFILE Record is used to embed an EMF metafile within a WMF metafile. The EMF metafile
/// is broken up into sections, each represented by one META_ESCAPE_ENHANCED_METAFILE.
/// See section 2.3.6 for the specification of other Escape Record Types.
public struct META_ESCAPE_ENHANCED_METAFILE {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let escapeFunction: MetafileEscapes
    public let byteCount: UInt16
    public let commentIdentifier: UInt32
    public let commentType: UInt32
    public let version: UInt32
    public let checksum: UInt16
    public let flags: UInt32
    public let commentRecordCount: UInt32
    public let currentRecordSize: UInt32
    public let remainingBytes: UInt32
    public let enhancedMetafileDataSize: UInt32
    public let enhancedMetafileData: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 22 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ESCAPE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ESCAPE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// EscapeFunction (2 bytes): A 16-bit unsigned integer that defines the escape function. The value MUST be 0x000F
        /// (META_ESCAPE_ENHANCED_METAFILE) from the MetafileEscapes Enumeration (section 2.1.1.17) table.
        self.escapeFunction = try MetafileEscapes(dataStream: &dataStream)
        guard self.escapeFunction == .META_ESCAPE_ENHANCED_METAFILE else {
            throw MetafileReadError.corrupted
        }
        
        /// ByteCount (2 bytes): A 16-bit unsigned integer that specifies the size, in bytes, of the record data that follows. This value
        /// MUST be 34 plus the value of the EnhancedMetafileDataSize field.
        self.byteCount = try dataStream.read(endianess: .littleEndian)
        guard self.byteCount >= 34 else {
            throw MetafileReadError.corrupted
        }
        
        /// CommentIdentifier (4 bytes): A 32-bit unsigned integer that defines this record as a WMF Comment record. This value
        /// MUST be 0x43464D57.
        self.commentIdentifier = try dataStream.read(endianess: .littleEndian)
        guard self.commentIdentifier == 0x43464D57 else {
            throw MetafileReadError.corrupted
        }
        
        /// CommentType (4 bytes): A 32-bit unsigned integer that identifies the type of comment in this record. This value MUST
        /// be 0x00000001.
        self.commentType = try dataStream.read(endianess: .littleEndian)
        guard self.commentType == 0x00000001 else {
            throw MetafileReadError.corrupted
        }
        
        /// Version (4 bytes): A 32-bit unsigned integer that specifies EMF metafile interoperability. This SHOULD be 0x00010000.<66>
        self.version = try dataStream.read(endianess: .littleEndian)
        
        /// Checksum (2 bytes): A 16-bit unsigned integer used to validate the correctness of the embedded EMF stream. This value
        /// MUST be the one's-complement of the result of applying an XOR operation to all WORD structures, defined in
        /// [MS-DTYP] section 2.2.61, in the EMF stream.
        self.checksum = try dataStream.read(endianess: .littleEndian)
        
        /// Flags (4 bytes): This 32-bit unsigned integer is unused and MUST be set to zero.
        self.flags = try dataStream.read(endianess: .littleEndian)
        guard self.flags == 0 else {
            throw MetafileReadError.corrupted
        }
        
        /// CommentRecordCount (4 bytes): A 32-bit unsigned integer that specifies the total number of consecutive
        /// META_ESCAPE_ENHANCED_METAFILE records that contain the embedded EMF metafile.
        self.commentRecordCount = try dataStream.read(endianess: .littleEndian)
        guard self.commentRecordCount > 0 else {
            throw MetafileReadError.corrupted
        }
        
        /// CurrentRecordSize (4 bytes): A 32-bit unsigned integer that specifies the size, in bytes, of the EnhancedMetafileData field.
        /// This value MUST be less than or equal to 8,192.
        self.currentRecordSize = try dataStream.read(endianess: .littleEndian)
        guard self.currentRecordSize <= 8192 else {
            throw MetafileReadError.corrupted
        }
        
        /// RemainingBytes (4 bytes): A 32-bit unsigned integer that specifies the number of bytes in the EMF stream that remain to
        /// be processed after this record. Those additional EMF bytes MUST follow in the EnhancedMetafileData fields of
        /// subsequent META_ESCAPE_ENHANDED_METAFILE escape records.
        self.remainingBytes = try dataStream.read(endianess: .littleEndian)
        
        /// EnhancedMetafileDataSize (4 bytes): A 32-bit unsigned integer that specifies the total size of the EMF stream embedded
        /// in this sequence of META_ESCAPE_ENHANCED_METAFILE records.
        self.enhancedMetafileDataSize = try dataStream.read(endianess: .littleEndian)
        guard self.byteCount == 34 + self.enhancedMetafileDataSize else {
            throw MetafileReadError.corrupted
        }
        guard self.recordSize == 22 + self.enhancedMetafileDataSize / 2 else {
            throw MetafileReadError.corrupted
        }

        /// EnhancedMetafileData (variable): A segment of an EMF file. The bytes in consecutive
        /// META_ESCAPE_ENHANCED_METAFILE records MUST be concatenated to represent the entire embedded EMF file.
        self.enhancedMetafileData = try dataStream.readBytes(count: Int(self.enhancedMetafileDataSize))
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
