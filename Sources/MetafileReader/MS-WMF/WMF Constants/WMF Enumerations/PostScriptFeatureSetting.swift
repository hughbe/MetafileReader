//
//  PostScriptFeatureSetting.swift
//
//
//  Created by Hugh Bellamy on 02/12/2020.
//

/// [MS-WMF] 2.1.1.28 PostScriptFeatureSetting Enumeration
/// The PostScriptFeatureSetting Enumeration defines values that are used to retrieve information about specific features in a
/// PostScript printer driver.<23>
/// typedef enum
/// {
///  FEATURESETTING_NUP = 0x00000000,
///  FEATURESETTING_OUTPUT = 0x00000001,
///  FEATURESETTING_PSLEVEL = 0x00000002,
///  FEATURESETTING_CUSTPAPER = 0x00000003,
///  FEATURESETTING_MIRROR = 0x00000004,
///  FEATURESETTING_NEGATIVE = 0x00000005,
///  FEATURESETTING_PROTOCOL = 0x00000006,
///  FEATURESETTING_PRIVATE_BEGIN = 0x00001000,
///  FEATURESETTING_PRIVATE_END = 0x00001FFF
/// } PostScriptFeatureSetting;
public enum PostScriptFeatureSetting: UInt32, DataStreamCreatable {
    /// FEATURESETTING_NUP: Specifies the n-up printing (page layout) setting.
    case nup = 0x00000000
    
    /// FEATURESETTING_OUTPUT: Specifies PostScript driver output options.
    case output = 0x00000001
    
    /// FEATURESETTING_PSLEVEL: Specifies the language level.
    case psLevel = 0x00000002
    
    /// FEATURESETTING_CUSTPAPER: Specifies custom paper parameters.
    case custPape = 0x00000003
    
    /// FEATURESETTING_MIRROR: Specifies the mirrored output setting.
    case mirror = 0x00000004
    
    /// FEATURESETTING_NEGATIVE: Specifies the negative output setting.
    case negative = 0x00000005
    
    /// FEATURESETTING_PROTOCOL: Specifies the output protocol setting.
    case `protocol` = 0x00000006
    
    /// FEATURESETTING_PRIVATE_BEGIN: Specifies the start of a range of values that a driver can use for retrieving data
    /// concerning proprietary features.<24>
    case privateBegin = 0x00001000
    
    /// FEATURESETTING_PRIVATE_END: Specifies the end of a range of values that a driver can use for retrieving data concerning
    /// proprietary features.<25>
    case privateEnd = 0x00001FFF
}
