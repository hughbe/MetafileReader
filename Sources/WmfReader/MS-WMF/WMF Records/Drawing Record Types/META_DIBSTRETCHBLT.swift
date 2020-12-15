//
//  META_DIBSTRETCHBLT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream
import Foundation

/// [MS-WMF] 2.3.1.3 META_DIBSTRETCHBLT Record
/// The META_DIBSTRETCHBLT Record specifies the transfer of a block of pixels in device-independent format according to a raster operation,
/// with possible expansion or contraction.
/// The destination of the transfer is the current output region in the playback device context.
/// There are two forms of META_DIBSTRETCHBLT, one which specifies a device-independent bitmap (DIB) as the source, and the other which
/// uses the playback device context as the source. Definitions follow for the fields that are the same in the two forms of META_DIBSTRETCHBLT.
/// The subsections that follow specify the packet structures of the two forms of META_DIBSTRETCHBLT.
/// The expansion or contraction is performed according to the stretching mode currently set in the playback device context, which MUST be a
/// value from the StretchMode Enumeration (section 2.1.1.30).
public struct META_DIBSTRETCHBLT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let rasterOperation: UInt32
    public let srcHeight: Int16
    public let srcWidth: Int16
    public let ySrc: Int16
    public let xSrc: Int16
    public let reserved: UInt16?
    public let destHeight: Int16
    public let destWidth: Int16
    public let yDest: Int16
    public let xDest: Int16
    public let dib: [UInt8]?
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 8 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_DIBSTRETCHBLT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_DIBSTRETCHBLT.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        let noDib = self.recordSize == ((self.recordFunction >> 8) + 3)

        /// RasterOperation: A 32-bit unsigned integer that defines how the source pixels, the current brush in the playback device context,
        /// and the destination pixels are to be combined to form the new image. This code MUST be one of the values in the Ternary Raster
        /// Operation Enumeration (section 2.1.1.31).
        self.rasterOperation = try dataStream.read(endianess: .littleEndian)
        
        /// SrcHeight: A 16-bit signed integer that defines the height, in logical units, of the source rectangle.
        self.srcHeight = try dataStream.read(endianess: .littleEndian)
        
        /// SrcWidth: A 16-bit signed integer that defines the width, in logical units, of the source rectangle.
        self.srcWidth = try dataStream.read(endianess: .littleEndian)
        
        /// YSrc: A 16-bit signed integer that defines the y-coordinate, in logical units, of the source rectangle.
        self.ySrc = try dataStream.read(endianess: .littleEndian)
        
        /// XSrc: A 16-bit signed integer that defines the x-coordinate, in logical units, of the source rectangle.
        self.xSrc = try dataStream.read(endianess: .littleEndian)
            
        /// [MS-WMF] 2.3.1.3.2 Without Bitmap
        /// This section specifies the structure of the META_DIBSTRETCHBLT Record (section 2.3.1.3) when it does not contain an embedded
        /// source device-independent bitmap (DIB). The source for this operation is the current region in the playback device context.
        /// Fields not specified in this section are specified in the META_DIBSTRETCHBLT Record section.
        /// Reserved (2 bytes): This field MUST be ignored.
        if noDib {
            self.reserved = try dataStream.read(endianess: .littleEndian)
        } else {
            self.reserved = nil
        }
        
        /// DestHeight: A 16-bit signed integer that defines the height, in logical units, of the destination rectangle.
        self.destHeight = try dataStream.read(endianess: .littleEndian)
        
        /// DestWidth: A 16-bit signed integer that defines the width, in logical units, of the destination rectangle.
        self.destWidth = try dataStream.read(endianess: .littleEndian)
        
        /// YDest: A 16-bit signed integer that defines the y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
        self.yDest = try dataStream.read(endianess: .littleEndian)
        
        /// XDest: A 16-bit signed integer that defines the x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
        /// The RecordSize and RecordFunction fields SHOULD be used to differentiate between the two forms of META_DIBBITBLT. If the
        /// following Boolean expression is TRUE, a source DIB is not specified in the record.
        /// RecordSize == ((RecordFunction >> 8) + 3)
        self.xDest = try dataStream.read(endianess: .littleEndian)
        
        /// [MS-WMF] 2.3.1.3.1 With Bitmap
        /// This section specifies the structure of the META_DIBSTRETCHBLT Record (section 2.3.1.3) when it contains an embedded
        /// device-independent bitmap (DIB).
        /// Fields not specified in this section are specified in the META_DIBSTRETCHBLT Record section.
        /// DIB (variable): A variable-sized DeviceIndependentBitmap Object (section 2.2.2.9) that is the source of the color data.
        if !noDib {
            let remainingCount = (Int(self.recordSize) - (dataStream.position - startPosition) / 2) * 2
            self.dib = try dataStream.readBytes(count: remainingCount)
        } else {
            self.dib = nil
        }

        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
