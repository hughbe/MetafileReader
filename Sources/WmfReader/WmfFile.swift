//
//  WmfFile.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream
import Foundation

/// [MS-WMF] 1.3.1 Metafile Structure
/// WMF specifies structures for defining a graphical image. A WMF metafile contains drawing commands, property definitions, and graphics
/// objects in a series of WMF records. In effect, a WMF metafile is a digital recording of an image, and the recording can be played back to
/// eproduce that image. Because WMF metafiles are application-independent, they can be shared among applications and used for image storage.
/// Original WMF metafiles were device-specific; that is, the graphical images they contained would only be rendered correctly if played back on
/// the output device for which they were recorded. To overcome this limitation, "placeable" WMF metafiles were developed, which contain an
/// extension to the standard header with information about the placement and scaling of the image.
/// The following figure illustrates the high-level structures of the original and placeable forms of WMF metafile.
/// The META_HEADER Record (section 2.3.2.2) contains information that defines the characteristics of the metafile, including:
///  The type of the metafile
///  The version of the metafile
///  The size of the metafile
///  The number of objects defined in the metafile
///  The size of the largest single record in the metafile
/// The META_PLACEABLE Record (section 2.3.2.3) contains extended information concerning the image, including:
///  A bounding rectangle
///  Logical unit size, for scaling
///  A checksum, for validation
/// WMF records have a generic format, which is specified in section 2.3. Every WMF record contains the following information:
///  The record size
///  The record function
///  Parameters, if any, for the record function
/// All WMF metafiles are terminated by a META_EOF Record (section 2.3.2.1).
public struct WmfFile {
    public let placeable: META_PLACEABLE?
    public let header: META_HEADER
    public let data: DataStream
    
    public init(data: Data) throws {
        var dataStream = DataStream(data)
        try self.init(dataStream: &dataStream)
    }
    
    public init(placeable: META_PLACEABLE, dataStream: inout DataStream) throws {
        self.placeable = placeable
        self.header = try META_HEADER(dataStream: &dataStream)
        self.data = DataStream(slicing: dataStream, startIndex: dataStream.position, count: dataStream.remainingCount)
    }
    
    public init(dataStream: inout DataStream) throws {
        if try dataStream.peek(endianess: .littleEndian) as UInt32 == 0x9AC6CDD7 {
            self.placeable = try META_PLACEABLE(dataStream: &dataStream)
        } else {
            self.placeable = nil
        }
        
        self.header = try META_HEADER(dataStream: &dataStream)
        
        self.data = DataStream(slicing: dataStream, startIndex: dataStream.position, count: dataStream.remainingCount)
    }
    
    public func enumerateRecords(proc: (WmfRecord) -> MetafileEnumerationStatus) throws {
        var dataStream = self.data
        while dataStream.position < dataStream.count {
            let record = try WmfRecord(dataStream: &dataStream)
            if case .eof = record {
                break
            }

            let result = proc(record)
            if result == .break {
                break
            }
        }
    }
    
    public enum MetafileEnumerationStatus {
        case `continue`
        case `break`
    }
}
