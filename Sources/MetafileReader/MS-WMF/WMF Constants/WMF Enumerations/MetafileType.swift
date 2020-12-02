//
//  MetafileType.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.18 MetafileType Enumeration
/// The MetafileType Enumeration specifies where the metafile is stored
/// typedef enum
/// {
///  MEMORYMETAFILE = 0x0001,
///  DISKMETAFILE = 0x0002
/// } MetafileType;
public enum MetafileType: UInt16, DataStreamCreatable {
    /// MEMORYMETAFILE: Metafile is stored in memory.
    case memory = 0x0001
    
    /// DISKMETAFILE: Metafile is stored on disk.
    case disk = 0x0002
}
