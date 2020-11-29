//
//  DeviceIndependentBitmap.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-WMF] 2.2.2.9 DeviceIndependentBitmap Object
/// The DeviceIndependentBitmap (DIB) Object defines an image in device-independent bitmap (DIB) format.
public struct DeviceIndependentBitmap {
    public let dibHeaderInfo: Header
    public let colors: Colors?
    public let bitmapBuffer: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// DIBHeaderInfo (variable): Either a BitmapCoreHeader Object (section 2.2.2.2) or a BitmapInfoHeader Object (section 2.2.2.3)
        /// that specifies information about the image.
        /// The first 32 bits of this field is the HeaderSize value. If it is 0x0000000C, then this is a BitmapCoreHeader; otherwise, this is
        /// a BitmapInfoHeader.
        let size: UInt32 = try dataStream.peek(endianess: .littleEndian)
        switch size {
        case 0x0000000C:
            self.dibHeaderInfo = .coreHeader(try BitmapCoreHeader(dataStream: &dataStream))
        default:
            self.dibHeaderInfo = .bitmapInfoHeader(try BitmapInfoHeader(dataStream: &dataStream))
        }
        
        /// Colors (variable): An optional array of either RGBQuad Objects (section 2.2.2.20) or 16-bit unsigned integers that define a color table.
        /// The size and contents of this field SHOULD be determined from the metafile record or object that contains this
        /// DeviceIndependentBitmap Object and from information in the DIBHeaderInfo field. See ColorUsage Enumeration
        /// (section 2.1.1.6) and BitCount Enumeration (section 2.1.1.3) for additional details.
        switch self.dibHeaderInfo.bitCount {
        case .one:
            let count = 2
            var colors: [RGBQuad] = []
            colors.reserveCapacity(count)
            for _ in 0..<count {
                colors.append(try RGBQuad(dataStream: &dataStream))
            }
            
            self.colors = .rgbQuad(colors)
        case .two:
            let count = 16
            var colors: [RGBQuad] = []
            colors.reserveCapacity(count)
            for _ in 0..<count {
                colors.append(try RGBQuad(dataStream: &dataStream))
            }
            
            self.colors = .rgbQuad(colors)
        case .three:
            let count = 256
            var colors: [RGBQuad] = []
            colors.reserveCapacity(count)
            for _ in 0..<count {
                colors.append(try RGBQuad(dataStream: &dataStream))
            }
            
            self.colors = .rgbQuad(colors)
        case .four, .six:
            if case let .bitmapInfoHeader(bitmapInfoHeader) = self.dibHeaderInfo,
               bitmapInfoHeader.compression == .bitfields {
                let count = 3
                var colors: [UInt32] = []
                colors.reserveCapacity(count)
                for _ in 0..<count {
                    colors.append(try dataStream.read(endianess: .littleEndian))
                }
                
                self.colors = .colorTable(colors)
            } else {
                self.colors = nil
            }
        default:
            self.colors = nil
        }
        
        /// BitmapBuffer (variable): A buffer containing the image, which is not required to be contiguous with the DIB header, unless this
        /// is a packed bitmap.
        /// UndefinedSpace (variable): An optional field that MUST be ignored. If this DIB is a packed bitmap, this field MUST NOT be present.
        /// aData (variable): An array of bytes that define the image.
        /// The size and format of this data is determined by information in the DIBHeaderInfo field. If it is a BitmapCoreHeader, the size in bytes
        /// MUST be calculated as follows: (((Width * Planes * BitCount + 31) & ~31) / 8) * abs(Height)
        /// This formula SHOULD also be used to calculate the size of aData when DIBHeaderInfo is a BitmapInfoHeader Object, using values
        /// from that object, but only if its Compression value is BI_RGB, BI_BITFIELDS, or BI_CMYK.
        /// Otherwise, the size of aData MUST be the BitmapInfoHeader Object value ImageSize
        let dataSize: Int
        switch self.dibHeaderInfo {
        case .coreHeader(let coreHeader):
            dataSize = (((Int(coreHeader.width) * Int(coreHeader.planes) * coreHeader.bitCount.size + 31) & ~31) / 8) * abs(Int(coreHeader.height))
        case .bitmapInfoHeader(let bitmapInfoHeader):
            if bitmapInfoHeader.compression == .rgb || bitmapInfoHeader.compression == .bitfields || bitmapInfoHeader.compression == .cmyk {
                dataSize = (((Int(bitmapInfoHeader.width) * Int(bitmapInfoHeader.planes) * bitmapInfoHeader.bitCount.size + 31) & ~31) / 8) * abs(Int(bitmapInfoHeader.height))
            } else {
                dataSize = Int(bitmapInfoHeader.imageSize)
            }
        }
        
        self.bitmapBuffer = try dataStream.readBytes(count: dataSize)
    }
    
    /// DIBHeaderInfo (variable): Either a BitmapCoreHeader Object (section 2.2.2.2) or a BitmapInfoHeader Object (section 2.2.2.3)
    /// that specifies information about the image.
    /// The first 32 bits of this field is the HeaderSize value. If it is 0x0000000C, then this is a BitmapCoreHeader; otherwise, this is
    /// a BitmapInfoHeader.
    public enum Header {
        case coreHeader(_: BitmapCoreHeader)
        case bitmapInfoHeader(_: BitmapInfoHeader)
        
        var bitCount: BitCount {
            switch self {
            case .coreHeader(let coreHeader):
                return coreHeader.bitCount
            case .bitmapInfoHeader(let bitmapInfoHeader):
                return bitmapInfoHeader.bitCount
            }
        }
    }
    
    /// Colors (variable): An optional array of either RGBQuad Objects (section 2.2.2.20) or 16-bit unsigned integers that define a color table.
    /// The size and contents of this field SHOULD be determined from the metafile record or object that contains this
    /// DeviceIndependentBitmap Object and from information in the DIBHeaderInfo field. See ColorUsage Enumeration
    /// (section 2.1.1.6) and BitCount Enumeration (section 2.1.1.3) for additional details.
    public enum Colors {
        case rgbQuad(_: [RGBQuad])
        case colorTable(_: [UInt32])
    }
}
