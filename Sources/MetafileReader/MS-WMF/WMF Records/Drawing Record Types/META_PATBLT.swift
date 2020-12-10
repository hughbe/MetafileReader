//
//  META_PATBLT.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.3.12 META_PATBLT Record
/// The META_PATBLT Record paints a specified rectangle using the brush that is defined in the playback device context. The brush
/// color and the surface color or colors are combined using the specified raster operation.
/// See section 2.3.3 for the specification of other Drawing Records.
public struct META_PATBLT {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let rasterOperation: UInt32
    public let height: Int16
    public let width: Int16
    public let yLeft: Int16
    public let xLeft: Int16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize == 9 else {
            throw WmfReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_PATBLT.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_PATBLT.rawValue & 0xFF else {
            throw WmfReadError.corrupted
        }
        
        /// RasterOperation (4 bytes): A 32-bit unsigned integer that defines the raster operation code. This code MUST be one of the
        /// values in the TernaryRasterOperation Enumeration (section 2.1.1.31) table.
        self.rasterOperation = try dataStream.read(endianess: .littleEndian)
        
        /// Height (2 bytes): A 16-bit signed integer that defines the height, in logical units, of the rectangle.
        self.height = try dataStream.read(endianess: .littleEndian)
        
        /// Width (2 bytes): A 16-bit signed integer that defines the width, in logical units, of the rectangle.
        self.width = try dataStream.read(endianess: .littleEndian)
        
        /// YLeft (2 bytes): A 16-bit signed integer that defines the y-coordinate, in logical units, of the upperleft corner of the
        /// rectangle to be filled.
        self.yLeft = try dataStream.read(endianess: .littleEndian)
        
        /// XLeft (2 bytes): A 16-bit signed integer that defines the x-coordinate, in logical units, of the upperleft corner of the
        /// rectangle to be filled.
        self.xLeft = try dataStream.read(endianess: .littleEndian)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw WmfReadError.corrupted
        }
    }
}
