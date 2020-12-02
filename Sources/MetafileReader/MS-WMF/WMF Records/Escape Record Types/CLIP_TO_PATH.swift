//
//  CLIP_TO_PATH.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.6.6 CLIP_TO_PATH Record
/// The CLIP_TO_PATH Record applies a function to the current PostScript clipping path.
/// See section 2.3.6 for the specification of other Escape Record Types.
public struct CLIP_TO_PATH {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let escapeFunction: MetafileEscapes
    public let byteCount: UInt16
    public let clipFunction: PostScriptClipping
    public let reserved1: UInt16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 7 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_ESCAPE.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_ESCAPE.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// EscapeFunction (2 bytes): A 16-bit unsigned integer that defines the escape function. The value MUST be 0x1001
        /// (CLIP_TO_PATH) from the MetafileEscapes Enumeration (section 2.1.1.17) table.
        self.escapeFunction = try MetafileEscapes(dataStream: &dataStream)
        guard self.escapeFunction == .CLIP_TO_PATH else {
            throw MetafileReadError.corrupted
        }
        
        /// ByteCount (2 bytes): A 16-bit unsigned integer that specifies the size, in bytes, of the record data that follows.
        /// This value MUST be 0x0004.
        self.byteCount = try dataStream.read(endianess: .littleEndian)
        guard self.byteCount == 0x0004 else {
            throw MetafileReadError.corrupted
        }
        
        /// ClipFunction (2 bytes): A 16-bit unsigned integer that defines the function to apply to the PostScript clipping path. This
        /// value MUST be a PostScriptClipping Enumeration (section 2.1.1.27) table value.
        /// Name Value
        /// CLIP_SAVE 0x0000
        /// CLIP_RESTORE 0x0001
        /// CLIP_INCLUSIVE 0x0002
        self.clipFunction = try PostScriptClipping(dataStream: &dataStream)
        
        /// Reserved1 (2 bytes): This value SHOULD be zero and SHOULD be ignored by the client.<64>
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
