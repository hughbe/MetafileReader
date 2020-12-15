//
//  PostScriptCap.swift
//  
//
//  Created by Hugh Bellamy on 02/12/2020.
//

/// [MS-WMF] 2.1.1.26 PostScriptCap Enumeration
/// The PostScriptCap Enumeration defines line-ending types for use with a PostScript printer driver.
/// typedef enum
/// {
///  PostScriptNotSet = -2,
///  PostScriptFlatCap = 0,
///  PostScriptRoundCap = 1,
///  PostScriptSquareCap = 2
/// } PostScriptCap;
public enum PostScriptCap: Int32, DataStreamCreatable {
    /// PostScriptNotSet: Specifies that the line-ending style has not been set and that a default style can be used.<22>
    case notSet = -2
    
    /// PostScriptFlatCap: Specifies that the line ends at the last point. The end is squared off.
    case flatCap = 0
    
    /// PostScriptRoundCap: Specifies a circular cap. The center of the circle is the last point in the line. The diameter of the circle is
    /// the same as the line width; that is, the thickness of the line.
    case roundCap = 1
    
    /// PostScriptSquareCap: Specifies a square cap. The center of the square is the last point in the line. The height and width of the
    /// square are the same as the line width; that is, the thickness of the line.
    case squareCap = 2
}
