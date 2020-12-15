//
//  PolyFillMode.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.25 PolyFillMode Enumeration
/// The PolyFillMode Enumeration specifies the method used for filling a polygon.
/// typedef enum
/// {
///  ALTERNATE = 0x0001,
///  WINDING = 0x0002
/// } PolyFillMode;
public enum PolyFillMode: UInt16, DataStreamCreatable {
    /// ALTERNATE: Selects alternate mode (fills the area between odd-numbered and even-numbered polygon sides on each scan line).
    case alternate = 0x0001
    
    /// WINDING: Selects winding mode (fills any region with a nonzero winding value).
    case winding = 0x0002
}
