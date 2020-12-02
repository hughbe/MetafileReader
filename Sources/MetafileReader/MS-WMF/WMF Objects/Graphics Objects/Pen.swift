//
//  Pen.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.1.4 Pen Object
/// The Pen Object specifies the style, width, and color of a pen.
public struct Pen {
    public let penStyle: PenStyle
    public let width: PointS
    public let colorRef: ColorRef
    
    public init(dataStream: inout DataStream) throws {
        /// PenStyle (2 bytes): A 16-bit unsigned integer that specifies the pen style. The value MUST be defined from the PenStyle Enumeration
        /// (section 2.1.1.23) table.
        self.penStyle = try PenStyle(dataStream: &dataStream)
        
        /// Width (4 bytes): A 32-bit PointS Object (section 2.2.2.16) that specifies a point for the object dimensions. The x-coordinate is the
        /// pen width. The y-coordinate is ignored.
        self.width = try PointS(dataStream: &dataStream)
        
        /// ColorRef (4 bytes): A 32-bit ColorRef Object (section 2.2.2.8) that specifies the pen color value.
        self.colorRef = try ColorRef(dataStream: &dataStream)
    }
}
