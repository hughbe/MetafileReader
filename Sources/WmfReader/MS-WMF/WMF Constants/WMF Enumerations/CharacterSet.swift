//
//  CharacterSet.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-WMF] 2.1.1.5 CharacterSet Enumeration
/// The CharacterSet Enumeration defines the possible sets of character glyphs that are defined in fonts for graphics output.
/// typedef enum
/// {
///  ANSI_CHARSET = 0x00000000,
///  DEFAULT_CHARSET = 0x00000001,
///  SYMBOL_CHARSET = 0x00000002,
///  MAC_CHARSET = 0x0000004D,
///  SHIFTJIS_CHARSET = 0x00000080,
///  HANGUL_CHARSET = 0x00000081,
///  JOHAB_CHARSET = 0x00000082,
///  GB2312_CHARSET = 0x00000086,
///  CHINESEBIG5_CHARSET = 0x00000088,
///  GREEK_CHARSET = 0x000000A1,
///  TURKISH_CHARSET = 0x000000A2,
///  VIETNAMESE_CHARSET = 0x000000A3,
///  HEBREW_CHARSET = 0x000000B1,
///  ARABIC_CHARSET = 0x000000B2,
///  BALTIC_CHARSET = 0x000000BA,
///  RUSSIAN_CHARSET = 0x000000CC,
///  THAI_CHARSET = 0x000000DE,
///  EASTEUROPE_CHARSET = 0x000000EE,
///  OEM_CHARSET = 0x000000FF
/// } CharacterSet;
public enum CharacterSet: UInt8, DataStreamCreatable {
    /// ANSI_CHARSET: Specifies the English character set.
    case ansi = 0x00
    
    /// DEFAULT_CHARSET: Specifies a character set based on the current system locale; for example, when the system locale is United
    /// States English, the default character set is ANSI_CHARSET.
    case `default` = 0x01
    
    /// SYMBOL_CHARSET: Specifies a character set of symbols.
    case symbol = 0x02
    
    /// MAC_CHARSET: Specifies the Apple Macintosh character set.<6>
    case mac = 0x4D
    
    /// SHIFTJIS_CHARSET: Specifies the Japanese character set.
    case shiftjis = 0x80
    
    /// HANGUL_CHARSET: Also spelled "Hangeul". Specifies the Hangul Korean character set.
    case hangul = 0x81
    
    /// JOHAB_CHARSET: Also spelled "Johap". Specifies the Johab Korean character set.
    case johab = 0x82
    
    /// GB2312_CHARSET: Specifies the "simplified" Chinese character set for People's Republic of China.
    case gb2312 = 0x86
    
    /// CHINESEBIG5_CHARSET: Specifies the "traditional" Chinese character set, used mostly in Taiwan and in the Hong Kong and Macao
    /// Special Administrative Regions.
    case chineseBig5 = 0x88
    
    /// GREEK_CHARSET: Specifies the Greek character set.
    case greek = 0xA1
    
    /// TURKISH_CHARSET: Specifies the Turkish character set.
    case turkish = 0xA2
    
    /// VIETNAMESE_CHARSET: Specifies the Vietnamese character set.
    case vietnamese = 0xA3
    
    /// HEBREW_CHARSET: Specifies the Hebrew character set
    case hebrew = 0xB1
    
    /// ARABIC_CHARSET: Specifies the Arabic character set
    case arabic = 0xB2
    
    /// BALTIC_CHARSET: Specifies the Baltic (Northeastern European) character set
    case baltic = 0xBA
    
    /// RUSSIAN_CHARSET: Specifies the Russian Cyrillic character set.
    case russian = 0xCC
    
    /// THAI_CHARSET: Specifies the Thai character set.
    case thai = 0xDE
    
    /// EASTEUROPE_CHARSET: Specifies a Eastern European character set.
    case eastEurope = 0xEE
    
    /// OEM_CHARSET: Specifies a mapping to one of the OEM code pages, according to the current system locale setting.
    case oem = 0xFF
}
