//
//  META_DIBCREATEPATTERNBRUSH.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.3.4.8 META_DIBCREATEPATTERNBRUSH Record
/// The META_DIBCREATEPATTERNBRUSH Record creates a Brush Object (section 2.2.1.1) with a pattern specified by a
/// DeviceIndependentBitmap (DIB) Object (section 2.2.2.9).
/// The following table shows the types of Brush Objects created by the META_DIBCREATEPATTERNBRUSH Record (section 2.3.4.8),
/// according to BrushStyle
/// Enumeration values.
/// BrushStyle ColorUsage Brush Object created
/// BS_SOLID Same as the following BS_DIBPATTERNPT. Same as the following BS_DIBPATTERNPT.
/// BS_NULL Same as the following BS_DIBPATTERNPT. Same as the following BS_DIBPATTERNPT.
/// BS_PATTERN A ColorUsage Enumeration value, which SHOULD define how to interpret the logical color values in the brush pattern.
/// A BS_PATTERN Brush Object that SHOULD contain a pattern defined by a Bitmap16 Object (section 2.2.2.1).
/// BS_DIBPATTERNPT A ColorUsage Enumeration value, which SHOULD define how to interpret the logical color values in the brush
/// pattern. A BS_DIBPATTERNPT Brush Object that SHOULD contain a pattern defined by a DIB Object.
/// BS_HATCHED Same as the preceding BS_DIBPATTERNPT. Same as preceding BS_DIBPATTERNPT.
/// See section 2.3.4 for the specification of other Object Records.
public struct META_DIBCREATEPATTERNBRUSH {
    public let recordSize: UInt32
    public let recordFunction: UInt16
    public let style: BrushStyle
    public let colorUsage: ColorUsage
    public let target: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// RecordSize (4 bytes): A 32-bit unsigned integer that defines the number of 16-bit WORD structures, defined in [MS-DTYP]
        /// section 2.2.61, in the record.
        self.recordSize = try dataStream.read(endianess: .littleEndian)
        guard self.recordSize >= 5 else {
            throw MetafileReadError.corrupted
        }
        
        /// RecordFunction (2 bytes): A 16-bit unsigned integer that defines this WMF record type. The lower byte MUST match the lower byte
        /// of the RecordType Enumeration (section 2.1.1.1) table value META_DIBCREATEPATTERNBRUSH.
        self.recordFunction = try dataStream.read(endianess: .littleEndian)
        guard self.recordFunction & 0xFF == RecordType.META_DIBCREATEPATTERNBRUSH.rawValue & 0xFF else {
            throw MetafileReadError.corrupted
        }
        
        /// Style (2 bytes): A 16-bit unsigned integer that defines the brush style. The legal values for this field are defined as follows:
        /// if the value is not BS_PATTERN, BS_DIBPATTERNPT MUST be assumed. These values are specified in the BrushStyle
        /// Enumeration (section 2.1.1.4).
        self.style = try BrushStyle(dataStream: &dataStream)
        
        /// ColorUsage (2 bytes): A 16-bit unsigned integer that defines whether the Colors field of a DIB Object contains explicit
        /// RGB values, or indexes into a palette.
        /// If the Style field specifies BS_PATTERN, a ColorUsage value of DIB_RGB_COLORS MUST be used regardless of the
        /// contents of this field.
        /// If the Style field specified anything but BS_PATTERN, this field MUST be one of the values in the ColorUsage Enumeration
        /// (section 2.1.1.6).
        self.colorUsage = try ColorUsage(dataStream: &dataStream)
        
        /// Target (variable): Variable-bit DIB Object data that defines the pattern to use in the brush.
        let remainingCount = (Int(self.recordSize) - (dataStream.position - startPosition) / 2) * 2
        self.target = try dataStream.readBytes(count: remainingCount)
        
        guard (dataStream.position - startPosition) / 2 == self.recordSize else {
            throw MetafileReadError.corrupted
        }
    }
}
