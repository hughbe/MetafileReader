//
//  LogBrush.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.10 LogBrush Object
/// The LogBrush Object defines the style, color, and pattern of a brush. This object is used only in the META_CREATEBRUSHINDIRECT Record
/// (section 2.3.4.1) to create a Brush Object (section 2.2.1.1).
public struct LogBrush {
    public let brushStyle: BrushStyle
    public let colorRef: ColorRef
    public let brushHatch: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// BrushStyle (2 bytes): A 16-bit unsigned integer that defines the brush style. This MUST be a value from the BrushStyle Enumeration
        /// (section 2.1.1.4). For the meanings of different values, see the following table. The BS_NULL style specifies a brush that has no
        /// effect.<48>
        self.brushStyle = try BrushStyle(dataStream: &dataStream)
        
        /// ColorRef (4 bytes): A 32-bit ColorRef Object section 2.2.2.8) that specifies a color. Its interpretation depends on the value of
        /// BrushStyle, as explained in the following.
        self.colorRef = try ColorRef(dataStream: &dataStream)
        
        /// BrushHatch (2 bytes): A 16-bit field that specifies the brush hatch type. Its interpretation depends on the value of BrushStyle,
        /// as explained in the following.
        /// The following table shows the relationship between values in the BrushStyle, ColorRef and BrushHatch fields in a LogBrush Object.
        /// Only supported brush styles are listed.
        /// BrushStyle ColorRef BrushHatch
        /// BS_SOLID SHOULD be a ColorRef Object, which determines the color of the brush. Not used, and SHOULD be ignored.
        /// BS_NULL Not used, and SHOULD be ignored. Not used, and SHOULD be ignored.
        /// BS_PATTERN Not used, and SHOULD be ignored. Not used. A solid-color black Brush Object SHOULD be created by default.<49>
        /// BS_DIBPATTERN Not used, and SHOULD be ignored. Not used. A solid-color black Brush Object SHOULD be created by default.
        /// BS_DIBPATTERNPT Not used, and SHOULD be ignored. Not used. A default object, such as a solid-color black Brush Object,
        /// MAY be created.
        /// BS_HATCHED SHOULD be a ColorRef Object, which determines the foreground color of the hatch pattern.
        /// A value from the HatchStyle Enumeration (section 2.1.1.12) that specifies the orientation of lines used to create the hatch.
        self.brushHatch = try dataStream.read(endianess: .littleEndian)
    }
}
