//
//  PostScriptJoin.swift
//
//
//  Created by Hugh Bellamy on 02/12/2020.
//

/// [MS-WMF] 2.1.1.29 PostScriptJoin Enumeration
/// The PostScriptJoin Enumeration defines line-joining capabilities for use with a PostScript printer driver.
/// typedef enum
/// {
///  PostScriptNotSet = -2,
///  PostScriptMiterJoin = 0,
///  PostScriptRoundJoin = 1,
///  PostScriptBevelJoin = 2
/// } PostScriptJoin;
public enum PostScriptJoin: Int32, DataStreamCreatable {
    /// PostScriptNotSet: Specifies that the line-joining style has not been set and that a default style can be used.<26>
    case notSet = -2
    
    /// PostScriptMiterJoin: Specifies a mitered join, which produces a sharp or clipped corner.
    case miter = 0
    
    /// PostScriptRoundJoin: Specifies a circular join, which produces a smooth, circular arc between the lines.
    case round = 1
    
    /// PostScriptBevelJoin: Specifies a beveled join, which produces a diagonal corner.
    case bevel = 2
}
