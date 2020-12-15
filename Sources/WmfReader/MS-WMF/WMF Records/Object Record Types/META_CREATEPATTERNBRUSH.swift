//
//  META_CREATEPATTERNBRUSH.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.4.4 META_CREATEPATTERNBRUSH Record
/// The META_CREATEPATTERNBRUSH Record creates a brush object with a pattern specified by a bitmap.<57>
/// See section 2.3.4 for the specification of other Object Records.
public struct META_CREATEPATTERNBRUSH {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let bitmap16: Bitmap16WithoutBits
    public let reserved: [UInt8]
    public let pattern: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        let recordSize: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard recordSize >= 19 else {
            throw WmfReadError.corrupted
        }
        
        self.recordSize = recordSize
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_CREATEPATTERNBRUSH.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_CREATEPATTERNBRUSH.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// Bitmap16 (14 bytes): A partial Bitmap16 Object (section 2.2.2.1), which defines parameters for the bitmap that specifies the
        /// pattern for the brush. Fields not described below are specified in section 2.2.2.1.
        /// Bits (4 bytes): This field MUST be ignored.
        self.bitmap16 = try Bitmap16WithoutBits(dataStream: &dataStream)
        
        /// Reserved (18 bytes): This field MUST be ignored.
        self.reserved = try dataStream.readBytes(count: 18)
        
        /// Pattern (variable): A variable-length array of bytes that defines the bitmap pixel data that composes the brush pattern.
        /// The length of this field, in bytes, can be computed from bitmap parameters as follows.
        /// (((Width * BitsPixel + 15) >> 4) << 1) * Height
        /// The Width, BitsPixel, and Height values are specified in the Bitmap16 field of this record.
        /// The BrushStyle Enumeration (section 2.1.1.4) table value for the brush object created by this record MUST be BS_PATTERN.
        let count = (((Int(self.bitmap16.width) * Int(self.bitmap16.bitsPixel) + 15) >> 4) << 1) * Int(self.bitmap16.height)
        self.pattern = try dataStream.readBytes(count: count)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }

    /// [MS-WMF] 2.2.2.1 Bitmap16 Object
    /// The Bitmap16 Object specifies information about the dimensions and color format of a bitmap.
    public struct Bitmap16WithoutBits {
        public let type: Int16
        public let width: Int16
        public let height: Int16
        public let widthBytes: Int16
        public let planes: UInt8
        public let bitsPixel: UInt8
        public let bits: UInt32
        
        public init(dataStream: inout DataStream) throws {
            /// Type (2 bytes): A 16-bit signed integer that defines the bitmap type.
            self.type = try dataStream.read(endianess: .littleEndian)
            
            /// Width (2 bytes): A 16-bit signed integer that defines the width of the bitmap in pixels.
            self.width = try dataStream.read(endianess: .littleEndian)
            
            /// Height (2 bytes): A 16-bit signed integer that defines the height of the bitmap in scan lines.
            self.height = try dataStream.read(endianess: .littleEndian)
            
            /// WidthBytes (2 bytes): A 16-bit signed integer that defines the number of bytes per scan line.
            self.widthBytes = try dataStream.read(endianess: .littleEndian)
            
            /// Planes (1 byte): An 8-bit unsigned integer that defines the number of color planes in the bitmap. The value of this field MUST be 0x01.
            self.planes = try dataStream.read()
            guard self.planes == 0x01 else {
                throw WmfReadError.corrupted
            }
            
            /// BitsPixel (1 byte): An 8-bit unsigned integer that defines the number of adjacent color bits on each plane.
            self.bitsPixel = try dataStream.read()
            
            /// Bits (4 bytes): This field MUST be ignored.
            self.bits = try dataStream.read(endianess: .littleEndian)
        }
    }
}
