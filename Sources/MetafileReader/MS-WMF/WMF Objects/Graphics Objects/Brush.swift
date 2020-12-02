//
//  Brush.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.1.1 Brush Object
/// The Brush Object defines the style, color, and pattern of a brush. Brush Objects are created by the META_CREATEBRUSHINDIRECT
/// (section 2.3.4.1), META_CREATEPATTERNBRUSH (section 2.3.4.4) and META_DIBCREATEPATTERNBRUSH (section 2.3.4.8) records.
public struct Brush {
    public let brushStyle: BrushStyle
    public let colorRef: ColorRef
    public let brushHatch: BrushHatch
    
    public init(dataStream: inout DataStream) throws {
        /// BrushStyle (2 bytes): A 16-bit unsigned integer that defines the brush style. The value MUST be an enumeration from the
        /// BrushStyle Enumeration table (section 2.1.1.4). For the meanings of the different values, see the following table.
        self.brushStyle = try BrushStyle(dataStream: &dataStream)
        
        /// ColorRef (4 bytes): A 32-bit field that specifies how to interpret color values in the object defined in the BrushHatch field.
        /// Its interpretation depends on the value of BrushStyle, as explained in the following table.
        self.colorRef = try ColorRef(dataStream: &dataStream)
        
        /// BrushHatch (variable): A variable-size field that contains the brush hatch or pattern data. The content depends on the
        /// value of BrushStyle, as explained below.
        /// The BrushStyle field determines how the ColorRef and BrushHatch fields SHOULD be interpreted, as specified in the
        /// following table.
        /// The following table shows the relationship between the BrushStyle, ColorRef, and BrushHatch fields in a Brush Object.
        /// BrushStyle ColorRef BrushHatch
        /// BS_SOLID SHOULD be a ColorRef Object, specified in section 2.2.2.8. Not used, and SHOULD be ignored.
        /// BS_NULL SHOULD be ignored. Not used, and SHOULD be ignored.
        /// BS_PATTERN SHOULD be ignored. SHOULD be a Bitmap16 Object, specified in section 2.2.2.1, which defines the brush
        /// pattern.
        /// BS_DIBPATTERNPT SHOULD be a 32-bit ColorUsage Enumeration value, specified in section 2.1.1.6; the low-order word
        /// specifies the meaning of color values in the DIB. SHOULD be a DIB Object, specified in section 2.2.2.9, which defines the
        /// brush pattern.
        /// BS_HATCHED SHOULD be a ColorRef Object, specified in section 2.2.2.8. SHOULD be a 16-bit value from the
        /// HatchStyle Enumeration table, specified in section 2.1.1.12, which defines the brush pattern.
        switch self.brushStyle {
        case .pattern:
            self.brushHatch = .bitmap16(try Bitmap16(dataStream: &dataStream))
        case .dibPatternPt:
            self.brushHatch = .dib(try DeviceIndependentBitmap(dataStream: &dataStream))
        case .hatched:
            self.brushHatch = .hatchStyle(try HatchStyle(dataStream: &dataStream))
        default:
            self.brushHatch = .none
        }
    }
    
    public enum BrushHatch {
        case none
        case bitmap16(_: Bitmap16)
        case dib(_: DeviceIndependentBitmap)
        case hatchStyle(_: HatchStyle)
    }
}
