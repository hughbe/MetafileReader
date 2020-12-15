//
//  META_STRETCHDIB.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream
import Foundation

/// [MS-WMF] 2.3.1.6 META_STRETCHDIB Record
/// The META_STRETCHDIB Record specifies the transfer of color data from a block of pixels in deviceindependent format
/// according to a raster operation, with possible expansion or contraction.
/// The source of the color data is a DIB, and the destination of the transfer is the current output region in the playback device context.
/// The source image in the DIB is specified in one of the following formats:
///  An array of pixels with a structure specified by the ColorUsage field and information in the DeviceIndependentBitmap header.
///  A JPEG image [JFIF].<52>
///  A PNG image [W3C-PNG].<53>
/// If the image format is JPEG or PNG, the ColorUsage field in this record MUST be set to DIB_RGB_COLORS, and the RasterOperation
/// field MUST be set to SRCCOPY.
/// See section 2.3.1 for the specification of additional bitmap records.
public struct META_STRETCHDIB {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let rasterOperation: UInt32
    public let colorUsage: ColorUsage
    public let srcHeight: Int16
    public let srcWidth: Int16
    public let ySrc: Int16
    public let xSrc: Int16
    public let destHeight: Int16
    public let destWidth: Int16
    public let yDst: Int16
    public let xDst: Int16
    public let dib: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 14 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_STRETCHDIB.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_STRETCHDIB.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }

        /// RasterOperation (4 bytes): A 32-bit unsigned integer that defines how the source pixels, the current brush in the
        /// playback device context, and the destination pixels are to be combined to form the new image. This code MUST be one
        /// of the values in the Ternary Raster Operation Enumeration (section 2.1.1.31).
        self.rasterOperation = try dataStream.read(endianess: .littleEndian)
        
        /// ColorUsage (2 bytes): A 16-bit unsigned integer that defines whether the Colors field of the DIB contains explicit RGB
        /// values or indexes into a palette. This value MUST be in the ColorUsage Enumeration (section 2.1.1.6).
        self.colorUsage = try ColorUsage(dataStream: &dataStream)
        
        /// SrcHeight (2 bytes): A 16-bit signed integer that defines the height, in logical units, of the source rectangle.
        self.srcHeight = try dataStream.read(endianess: .littleEndian)
        
        /// SrcWidth (2 bytes): A 16-bit signed integer that defines the width, in logical units, of the source rectangle.
        self.srcWidth = try dataStream.read(endianess: .littleEndian)
        
        /// YSrc (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the source rectangle.
        self.ySrc = try dataStream.read(endianess: .littleEndian)
        
        /// XSrc (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical units, of the source rectangle.
        self.xSrc = try dataStream.read(endianess: .littleEndian)
        
        /// DestHeight (2 bytes): A 16-bit signed integer that defines the height, in logical units, of the destination rectangle.
        self.destHeight = try dataStream.read(endianess: .littleEndian)
        
        /// DestWidth (2 bytes): A 16-bit signed integer that defines the width, in logical units, of the destination rectangle.
        self.destWidth = try dataStream.read(endianess: .littleEndian)
        
        /// YyDst (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the upperleft corner of the
        /// destination rectangle.
        self.yDst = try dataStream.read(endianess: .littleEndian)
        
        /// xDst (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical units, of the upperleft corner of the
        /// destination rectangle.
        self.xDst = try dataStream.read(endianess: .littleEndian)
        
        /// DIB (variable): A variable-sized DeviceIndependentBitmap Object (section 2.2.2.9) that is the source of the color data.
        let remainingCount = (Int(self.recordSize) - (dataStream.position - startPosition) / 2) * 2
        self.dib = try dataStream.readBytes(count: remainingCount)

        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
