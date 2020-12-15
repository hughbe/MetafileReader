//
//  META_SETDIBTODEV.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream
import Foundation

/// [MS-WMF] 2.3.1.4 META_SETDIBTODEV Record
/// The META_SETDIBTODEV Record sets a block of pixels in the playback device context using device-independent color data.
/// The source of the color data is a DIB.
/// The source image in the DIB is specified in one of the following formats:
///  An array of pixels with a structure specified by the ColorUsage field and information in the DeviceIndependentBitmap header.
///  A JPEG image [JFIF].<50>
///  A PNG image [W3C-PNG].<51>
/// See section 2.3.1 for the specification of additional bitmap records.
public struct META_SETDIBTODEV {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let colorUsage: ColorUsage
    public let scanCount: UInt16
    public let startScan: UInt16
    public let yDib: UInt16
    public let xDib: UInt16
    public let height: UInt16
    public let width: UInt16
    public let yDest: UInt16
    public let xDest: UInt16
    public let dib: DeviceIndependentBitmap
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 12 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_SETDIBTODEV.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_SETDIBTODEV.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }

        /// ColorUsage (2 bytes): A 16-bit unsigned integer that defines whether the Colors field of the DIB contains explicit RGB
        /// values or indexes into a palette. This MUST be one of the values in the ColorUsage Enumeration (section 2.1.1.6).
        self.colorUsage = try ColorUsage(dataStream: &dataStream)
        
        /// ScanCount (2 bytes): A 16-bit unsigned integer that defines the number of scan lines in the source.
        self.scanCount = try dataStream.read(endianess: .littleEndian)
        
        /// StartScan (2 bytes): A 16-bit unsigned integer that defines the starting scan line in the source.
        self.startScan = try dataStream.read(endianess: .littleEndian)
        
        /// yDib (2 bytes): A 16-bit unsigned integer that defines the y-coordinate, in logical units, of the source rectangle.
        self.yDib = try dataStream.read(endianess: .littleEndian)
        
        /// xDib (2 bytes): A 16-bit unsigned integer that defines the x-coordinate, in logical units, of the source rectangle.
        self.xDib = try dataStream.read(endianess: .littleEndian)
        
        /// Height (2 bytes): A 16-bit unsigned integer that defines the height, in logical units, of the source and destination rectangles.
        self.height = try dataStream.read(endianess: .littleEndian)
        
        /// Width (2 bytes): A 16-bit unsigned integer that defines the width, in logical units, of the source and destination rectangles.
        self.width = try dataStream.read(endianess: .littleEndian)
        
        /// yDest (2 bytes): A 16-bit unsigned integer that defines the y-coordinate, in logical units, of the upper-left corner of the
        /// destination rectangle.
        self.yDest = try dataStream.read(endianess: .littleEndian)
        
        /// xDest (2 bytes): A 16-bit unsigned integer that defines the x-coordinate, in logical units, of the upper-left corner of the
        /// destination rectangle.
        self.xDest = try dataStream.read(endianess: .littleEndian)
        
        /// DIB (variable): A variable-sized DeviceIndependentBitmap Object (section 2.2.2.9) that is the source of the color data.
        self.dib = try DeviceIndependentBitmap(dataStream: &dataStream)

        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
