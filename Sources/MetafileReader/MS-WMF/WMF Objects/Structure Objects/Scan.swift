//
//  Scan.swift
//  
//
//  Created by Hugh Bellamy on 01/12/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.21 Scan Object
/// The Scan Object specifies a collection of scanlines
public struct Scan {
    public let count: UInt16
    public let top: UInt16
    public let bottom: UInt16
    public let scanLines: [(left: UInt16, right: UInt16)]
    public let count2: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// Count (2 bytes): A 16-bit unsigned integer that specifies the number of horizontal (x-axis) coordinates in the ScanLines
        /// array. This value MUST be a multiple of 2, since left and right endpoints are required to specify each scanline.
        self.count = try dataStream.read(endianess: .littleEndian)
        guard (self.count % 2) == 0 else {
            throw WmfReadError.corrupted
        }
        
        /// Top (2 bytes): A 16-bit unsigned integer that defines the vertical (y-axis) coordinate, in logical units, of the top scanline.
        self.top = try dataStream.read(endianess: .littleEndian)
        
        /// Bottom (2 bytes): A 16-bit unsigned integer that defines the vertical (y-axis) coordinate, in logical units, of the bottom scanline.
        self.bottom = try dataStream.read(endianess: .littleEndian)
        
        /// ScanLines (variable): An array of scanlines, each specified by left and right horizontal (x-axis) coordinates of its endpoints.
        var scanLines: [(left: UInt16, right: UInt16)] = []
        scanLines.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            /// Left (2 bytes): A 16-bit unsigned integer that defines the horizontal (x-axis) coordinate, in logical units, of the left endpoint
            /// of the scanline.
            let left: UInt16 = try dataStream.read(endianess: .littleEndian)
            
            /// Right (2 bytes): A 16-bit unsigned integer that defines the horizontal (x-axis) coordinate, in logical units, of the right
            /// endpoint of the scanline.
            let right: UInt16 = try dataStream.read(endianess: .littleEndian)
            
            scanLines.append((left, right))
        }
        
        self.scanLines = scanLines
        
        /// Count2 (2 bytes): A 16-bit unsigned integer that MUST be the same as the value of the Count field; it is present to allow
        /// upward travel in the structure.
        self.count2 = try dataStream.read(endianess: .littleEndian)
    }
}
