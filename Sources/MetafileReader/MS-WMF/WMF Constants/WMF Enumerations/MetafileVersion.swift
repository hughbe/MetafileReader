//
//  MetafileType.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.19 MetafileVersion Enumeration
/// The MetafileVersion Enumeration defines values that specify support for device-independent
/// bitmaps (DIBs) in metafiles.
/// typedef enum
/// {
///  METAVERSION100 = 0x0100,
///  METAVERSION300 = 0x0300
/// } MetafileVersion;
public enum MetafileVersion: UInt16, DataStreamCreatable {
    /// METAVERSION100: DIBs are not supported.
    case version100 = 0x0100
    
    /// METAVERSION300: DIBs are supported.
    case version300 = 0x0300
}
