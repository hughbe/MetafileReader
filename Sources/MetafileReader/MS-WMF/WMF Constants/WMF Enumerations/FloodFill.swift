//
//  FloodFill.swift
//  
//
//  Created by Hugh Bellamy on 01/12/2020.
//

/// [MS-WMF] 2.1.1.9 FloodFill Enumeration
/// The FloodFill Enumeration specifies the type of fill operation to be performed.
/// typedef enum
/// {
///  FLOODFILLBORDER = 0x0000,
///  FLOODFILLSURFACE = 0x0001
/// } FloodFill;
public enum FloodFill: UInt16, DataStreamCreatable {
    /// FLOODFILLBORDER: The fill area is bounded by the color specified by the Color member. This style is identical to the filling performed
    /// by the META_FLOODFILL Record (section 2.3.3.7).
    case border = 0x0000
    
    /// FLOODFILLSURFACE: The fill area is bounded by the color that is specified by the Color member. Filling continues outward in all
    /// directions as long as the color is encountered. This style is useful for filling areas with multicolored boundaries.
    case surface = 0x0001
}
