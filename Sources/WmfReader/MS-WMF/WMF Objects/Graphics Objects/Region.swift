//
//  Region.swift
//  
//
//  Created by Hugh Bellamy on 01/12/2020.
//

import DataStream

/// [MS-WMF] 2.2.1.5 Region Object
/// The Region Object defines a potentially non-rectilinear shape defined by an array of scanlines
public struct Region {
    public let nextInChain: UInt16
    public let objectType: UInt16
    public let objectCount: UInt32
    public let regionSize: Int16
    public let scanCount: Int16
    public let maxScan: Int16
    public let boundingRectangle: Rect
    public let aScans: [Scan]
    
    public init(dataStream: inout DataStream) throws {
        /// nextInChain (2 bytes): A value that MUST be ignored.<41>
        self.nextInChain = try dataStream.read(endianess: .littleEndian)
        
        /// ObjectType (2 bytes): A 16-bit signed integer that specifies the region identifier. It MUST be 0x0006.
        self.objectType = try dataStream.read(endianess: .littleEndian)
        guard self.objectType == 0x0006 else {
            throw WmfReadError.corrupted
        }
        
        /// ObjectCount (4 bytes): A value that MUST be ignored.<42>
        self.objectCount = try dataStream.read(endianess: .littleEndian)
        
        /// RegionSize (2 bytes): A 16-bit signed integer that defines the size of the region in bytes plus the size of aScans in bytes.
        self.regionSize = try dataStream.read(endianess: .littleEndian)
        
        /// ScanCount (2 bytes): A 16-bit signed integer that defines the number of scanlines composing the region.
        self.scanCount = try dataStream.read(endianess: .littleEndian)
        
        /// maxScan (2 bytes): A 16-bit signed integer that defines the maximum number of points in any one scan in this region.
        self.maxScan = try dataStream.read(endianess: .littleEndian)
        
        /// BoundingRectangle (8 bytes): A Rect Object (section 2.2.2.18) that defines the bounding rectangle.
        self.boundingRectangle = try Rect(dataStream: &dataStream)
        
        /// aScans (variable): An array of Scan Objects (section 2.2.2.21) that define the scanlines in the region.
        var aScans: [Scan] = []
        aScans.reserveCapacity(Int(self.scanCount))
        for _ in 0..<self.scanCount {
            aScans.append(try Scan(dataStream: &dataStream))
        }
        
        self.aScans = aScans
    }
}
