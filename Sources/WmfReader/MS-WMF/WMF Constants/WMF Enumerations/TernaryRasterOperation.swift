//
//  TernaryRasterOperation.swift
//  
//
//  Created by Hugh Bellamy on 01/12/2020.
//

/// [MS-WMF] 2.1.1.31 TernaryRasterOperation Enumeration
/// The TernaryRasterOperation Enumeration specifies ternary raster operation codes, which define how to combine the bits in a source bitmap
/// with the bits in a destination bitmap.
/// typedef enum
/// {
///  BLACKNESS = 0x00,
///  DPSOON = 0x01,
///  DPSONA = 0x02,
///  PSON = 0x03,
///  SDPONA = 0x04,
///  DPON = 0x05,
///  PDSXNON = 0x06,
///  PDSAON = 0x07,
///  SDPNAA = 0x08,
///  PDSXON = 0x09,
///  DPNA = 0x0A,
///  PSDNAON = 0x0B,
///  SPNA = 0x0C,
///  PDSNAON = 0x0D,
///  PDSONON = 0x0E,
///  PN = 0x0F,
///  PDSONA = 0x10,
///  NOTSRCERASE = 0x11,
///  SDPXNON = 0x12,
///  SDPAON = 0x13,
///  DPSXNON = 0x14,
///  DPSAON = 0x15,
///  PSDPSANAXX = 0x16,
///  SSPXDSXAXN = 0x17,
///  SPXPDXA = 0x18,
///  SDPSANAXN = 0x19,
///  PDSPAOX = 0x1A,
///  SDPSXAXN = 0x1B,
///  PSDPAOX = 0x1C,
///  DSPDXAXN = 0x1D,
///  PDSOX = 0x1E,
///  PDSOAN = 0x1F,
///  DPSNAA = 0x20,
///  SDPXON = 0x21,
///  DSNA = 0x22,
///  SPDNAON = 0x23,
///  SPXDSXA = 0x24,
///  PDSPANAXN = 0x25,
///  SDPSAOX = 0x26,
///  SDPSXNOX = 0x27,
///  DPSXA = 0x28,
///  PSDPSAOXXN = 0x29,
///  DPSANA = 0x2A,
///  SSPXPDXAXN = 0x2B,
///  SPDSOAX = 0x2C,
///  PSDNOX = 0x2D,
///  PSDPXOX = 0x2E,
///  PSDNOAN = 0x2F,
///  PSNA = 0x30,
///  SDPNAON = 0x31,
///  SDPSOOX = 0x32,
///  NOTSRCCOPY = 0x33,
///  SPDSAOX = 0x34,
///  SPDSXNOX = 0x35,
///  SDPOX = 0x36,
///  SDPOAN = 0x37,
///  PSDPOAX = 0x38,
///  SPDNOX = 0x39,
///  SPDSXOX = 0x3A,
///  SPDNOAN = 0x3B,
///  PSX = 0x3C,
///  SPDSONOX = 0x3D,
///  SPDSNAOX = 0x3E,
///  PSAN = 0x3F,
///  PSDNAA = 0x40,
///  DPSXON = 0x41,
///  SDXPDXA = 0x42,
///  SPDSANAXN = 0x43,
///  SRCERASE = 0x44,
///  DPSNAON = 0x45,
///  DSPDAOX = 0x46,
///  PSDPXAXN = 0x47,
///  SDPXA = 0x48,
///  PDSPDAOXXN = 0x49,
///  DPSDOAX = 0x4A,
///  PDSNOX = 0x4B,
///  SDPANA = 0x4C,
///  SSPXDSXOXN = 0x4D,
///  PDSPXOX = 0x4E,
///  PDSNOAN = 0x4F,
///  PDNA = 0x50,
///  DSPNAON = 0x51,
///  DPSDAOX = 0x52,
///  SPDSXAXN = 0x53,
///  DPSONON = 0x54,
///  DSTINVERT = 0x55,
///  DPSOX = 0x56,
///  DPSOAN = 0x57,
///  PDSPOAX = 0x58,
///  DPSNOX = 0x59,
///  PATINVERT = 0x5A,
///  DPSDONOX = 0x5B,
///  DPSDXOX = 0x5C,
///  DPSNOAN = 0x5D,
///  DPSDNAOX = 0x5E,
///  DPAN = 0x5F,
///  PDSXA = 0x60,
///  DSPDSAOXXN = 0x61,
///  DSPDOAX = 0x62,
///  SDPNOX = 0x63,
///  SDPSOAX = 0x64,
///  DSPNOX = 0x65,
///  SRCINVERT = 0x66,
///  SDPSONOX = 0x67,
///  DSPDSONOXXN = 0x68,
///  PDSXXN = 0x69,
///  DPSAX = 0x6A,
///  PSDPSOAXXN = 0x6B,
///  SDPAX = 0x6C,
///  PDSPDOAXXN = 0x6D,
///  SDPSNOAX = 0x6E,
///  PDXNAN = 0x6F,
///  PDSANA = 0x70,
///  SSDXPDXAXN = 0x71,
///  SDPSXOX = 0x72,
///  SDPNOAN = 0x73,
///  DSPDXOX = 0x74,
///  DSPNOAN = 0x75,
///  SDPSNAOX = 0x76,
///  DSAN = 0x77,
///  PDSAX = 0x78,
///  DSPDSOAXXN = 0x79,
///  DPSDNOAX = 0x7A,
///  SDPXNAN = 0x7B,
///  SPDSNOAX = 0x7C,
///  DPSXNAN = 0x7D,
///  SPXDSXO = 0x7E,
///  DPSAAN = 0x7F,
///  DPSAA = 0x80,
///  SPXDSXON = 0x81,
///  DPSXNA = 0x82,
///  SPDSNOAXN = 0x83,
///  SDPXNA = 0x84,
///  PDSPNOAXN = 0x85,
///  DSPDSOAXX = 0x86,
///  PDSAXN = 0x87,
///  SRCAND = 0x88,
///  SDPSNAOXN = 0x89,
///  DSPNOA = 0x8A,
///  DSPDXOXN = 0x8B,
///  SDPNOA = 0x8C,
///  SDPSXOXN = 0x8D,
///  SSDXPDXAX = 0x8E,
///  PDSANAN = 0x8F,
///  PDSXNA = 0x90,
///  SDPSNOAXN = 0x91,
///  DPSDPOAXX = 0x92,
///  SPDAXN = 0x93,
///  PSDPSOAXX = 0x94,
///  DPSAXN = 0x95,
///  DPSXX = 0x96,
///  PSDPSONOXX = 0x97,
///  SDPSONOXN = 0x98,
///  DSXN = 0x99,
///  DPSNAX = 0x9A,
///  SDPSOAXN = 0x9B,
///  SPDNAX = 0x9C,
///  DSPDOAXN = 0x9D,
///  DSPDSAOXX = 0x9E,
///  PDSXAN = 0x9F,
///  DPA = 0xA0,
///  PDSPNAOXN = 0xA1,
///  DPSNOA = 0xA2,
///  DPSDXOXN = 0xA3,
///  PDSPONOXN = 0xA4,
///  PDXN = 0xA5,
///  DSPNAX = 0xA6,
///  PDSPOAXN = 0xA7,
///  DPSOA = 0xA8,
///  DPSOXN = 0xA9,
///  D = 0xAA,
///  DPSONO = 0xAB,
///  SPDSXAX = 0xAC,
///  DPSDAOXN = 0xAD,
///  DSPNAO = 0xAE,
///  DPNO = 0xAF,
///  PDSNOA = 0xB0,
///  PDSPXOXN = 0xB1,
///  SSPXDSXOX = 0xB2,
///  SDPANAN = 0xB3,
///  PSDNAX = 0xB4,
///  DPSDOAXN = 0xB5,
///  DPSDPAOXX = 0xB6,
///  SDPXAN = 0xB7,
///  PSDPXAX = 0xB8,
///  DSPDAOXN = 0xB9,
///  DPSNAO = 0xBA,
///  MERGEPAINT = 0xBB,
///  SPDSANAX = 0xBC,
///  SDXPDXAN = 0xBD,
///  DPSXO = 0xBE,
///  DPSANO = 0xBF,
///  MERGECOPY = 0xC0,
///  SPDSNAOXN = 0xC1,
///  SPDSONOXN = 0xC2,
///  PSXN = 0xC3,
///  SPDNOA = 0xC4,
///  SPDSXOXN = 0xC5,
///  SDPNAX = 0xC6,
///  PSDPOAXN = 0xC7,
///  SDPOA = 0xC8,
///  SPDOXN = 0xC9,
///  DPSDXAX = 0xCA,
///  SPDSAOXN = 0xCB,
///  SRCCOPY = 0xCC,
///  SDPONO = 0xCD,
///  SDPNAO = 0xCE,
///  SPNO = 0xCF,
///  PSDNOA = 0xD0,
///  PSDPXOXN = 0xD1,
///  PDSNAX = 0xD2,
///  SPDSOAXN = 0xD3,
///  SSPXPDXAX = 0xD4,
///  DPSANAN = 0xD5,
///  PSDPSAOXX = 0xD6,
///  DPSXAN = 0xD7,
///  PDSPXAX = 0xD8,
///  SDPSAOXN = 0xD9,
///  DPSDANAX = 0xDA,
///  SPXDSXAN = 0xDB,
///  SPDNAO = 0xDC,
///  SDNO = 0xDD,
///  SDPXO = 0xDE,
///  SDPANO = 0xDF,
///  PDSOA = 0xE0,
///  PDSOXN = 0xE1,
///  DSPDXAX = 0xE2,
///  PSDPAOXN = 0xE3,
///  SDPSXAX = 0xE4,
///  PDSPAOXN = 0xE5,
///  SDPSANAX = 0xE6,
///  SPXPDXAN = 0xE7,
///  SSPXDSXAX = 0xE8,
///  DSPDSANAXXN = 0xE9,
///  DPSAO = 0xEA,
///  DPSXNO = 0xEB,
///  SDPAO = 0xEC,
///  SDPXNO = 0xED,
///  SRCPAINT = 0xEE,
///  SDPNOO = 0xEF,
///  PATCOPY = 0xF0,
///  PDSONO = 0xF1,
///  PDSNAO = 0xF2,
///  PSNO = 0xF3,
///  PSDNAO = 0xF4,
///  PDNO = 0xF5,
///  PDSXO = 0xF6,
///  PDSANO = 0xF7,
///  PDSAO = 0xF8,
///  PDSXNO = 0xF9,
///  DPO = 0xFA,
///  PATPAINT = 0xFB,
///  PSO = 0xFC,
///  PSDNOO = 0xFD,
///  DPSOO = 0xFE,
///  WHITENESS = 0xFF
/// } TernaryRasterOperation;
/// Each ternary raster operation code represents a Boolean operation in which the values of the pixels in the source, the selected brush, and the
/// destination are combined. Following are the three operands used in these operations.
/// Operand Meaning
/// D Destination bitmap
/// P Selected brush (also called pattern)
/// S Source bitmap
/// Following are the Boolean operators used in these operations.
/// Operator Meaning
/// a Bitwise AND
/// n Bitwise NOT (inverse)
/// o Bitwise OR
/// x Bitwise exclusive OR (XOR)
/// All Boolean operations are presented in reverse Polish notation. For example, the following operation replaces the values of the pixels in the
/// destination bitmap with a combination of the pixel values of the source and brush: PSo. For another example, the following operation
/// combines the values of the pixels in the source and brush with the pixel values of the destination bitmap: DPSoo.
/// Each raster operation code is a 32-bit integer whose high-order word is a Boolean operation index and whose low-order word is the operation
/// code. The 16-bit operation index is a zero-extended, 8-bit value that represents the result of the Boolean operation on predefined brush,
/// source, and destination values. For example, the operation indexes for the PSo and DPSoo operations are shown in the following list.
/// P S D PSo DPSoo
/// 0 0 0 0 0
/// 0 0 1 0 1
/// 0 1 0 1 1
/// 0 1 1 1 1
/// 1 0 0 1 1
/// 1 0 1 1 1
/// 1 1 0 1 1
/// 1 1 1 1 1
/// The operation indexes are determined by reading the binary values in a column of the table from the bottom up. For example, in the PSo
/// column, the binary value is 11111100, which is equivalent to 00FC (hexadecimal is implicit for these values), which is the operation index
/// for PSo.
/// Using this method, DPSoo can be seen to have the operation index 00FE. Operation indexes define the locations of corresponding raster
/// operation codes in the preceding enumeration. The PSo operation is in line 252 (0x00FC) of the enumeration; DPSoo is in line 254 (0x00FE).
/// The most commonly used raster operations have been given explicit enumeration names, which SHOULD be used; examples are PATCOPY
/// and WHITENESS.
/// When the source and destination bitmaps are monochrome, a bit value of 0 represents a black pixel and a bit value of 1 represents a white
/// pixel. When the source and the destination bitmaps are color, those colors are represented with red green blue (RGB) values.
public enum TernaryRasterOperation: UInt16, DataStreamCreatable {
    /// BLACKNESS: Reverse Polish = 00000042 Common = 0
    case BLACKNESS = 0x00

    /// DPSOON: Reverse Polish = 00010289 Common = DPSoon
    case DPSOON = 0x01

    /// DPSONA: Reverse Polish = 00020C89 Common = DPSona
    case DPSONA = 0x02

    /// PSON: Reverse Polish = 000300AA Common = PSon
    case PSON = 0x03

    /// SDPONA: Reverse Polish = 00040C88 Common = SDPona
    case SDPONA = 0x04

    /// DPON: Reverse Polish = 000500A9 Common = DPon
    case DPON = 0x05

    /// PDSXNON: Reverse Polish = 00060865 Common = PDSxnon
    case PDSXNON = 0x06

    /// PDSAON: Reverse Polish = 000702C5 Common = PDSaon
    case PDSAON = 0x07

    /// SDPNAA: Reverse Polish = 00080F08 Common = SDPnaa
    case SDPNAA = 0x08

    /// PDSXON: Reverse Polish = 00090245 Common = PDSxon
    case PDSXON = 0x09

    /// DPNA: Reverse Polish = 000A0329 Common = DPna
    case DPNA = 0x0A

    /// PSDNAON: Reverse Polish = 000B0B2A Common = PSDnaon
    case PSDNAON = 0x0B

    /// SPNA: Reverse Polish = 000C0324 Common = SPna
    case SPNA = 0x0C

    /// PDSNAON: Reverse Polish = 000D0B25 Common = PDSnaon
    case PDSNAON = 0x0D

    /// PDSONON: Reverse Polish = 000E08A5 Common = PDSonon
    case PDSONON = 0x0E

    /// PN: Reverse Polish = 000F0001 Common = Pn
    case PN = 0x0F

    /// PDSONA: Reverse Polish = 00100C85 Common = PDSona
    case PDSONA = 0x10

    /// NOTSRCERASE: Reverse Polish = 001100A6 Common = DSon
    case NOTSRCERASE = 0x11

    /// SDPXNON: Reverse Polish = 00120868 Common = SDPxnon
    case SDPXNON = 0x12

    /// SDPAON: Reverse Polish = 001302C8 Common = SDPaon
    case SDPAON = 0x13

    /// DPSXNON: Reverse Polish = 00140869 Common = DPSxnon
    case DPSXNON = 0x14

    /// DPSAON: Reverse Polish = 001502C9 Common = DPSaon
    case DPSAON = 0x15

    /// PSDPSANAXX: Reverse Polish = 00165CCA Common = PSDPSanaxx
    case PSDPSANAXX = 0x16

    /// SSPXDSXAXN: Reverse Polish = 00171D54 Common = SSPxDSxaxn
    case SSPXDSXAXN = 0x17

    /// SPXPDXA: Reverse Polish = 00180D59 Common = SPxPDxa
    case SPXPDXA = 0x18

    /// SDPSANAXN: Reverse Polish = 00191CC8 Common = SDPSanaxn
    case SDPSANAXN = 0x19

    /// PDSPAOX: Reverse Polish = 001A06C5 Common = PDSPaox
    case PDSPAOX = 0x1A

    /// SDPSXAXN: Reverse Polish = 001B0768 Common = SDPSxaxn
    case SDPSXAXN = 0x1B

    /// PSDPAOX: Reverse Polish = 001C06CA Common = PSDPaox
    case PSDPAOX = 0x1C

    /// DSPDXAXN: Reverse Polish = 001D0766 Common = DSPDxaxn
    case DSPDXAXN = 0x1D

    /// PDSOX: Reverse Polish = 001E01A5 Common = PDSox
    case PDSOX = 0x1E

    /// PDSOAN: Reverse Polish = 001F0385 Common = PDSoan
    case PDSOAN = 0x1F

    /// DPSNAA: Reverse Polish = 00200F09 Common = DPSnaa
    case DPSNAA = 0x20

    /// SDPXON: Reverse Polish = 00210248 Common = SDPxon
    case SDPXON = 0x21

    /// DSNA: Reverse Polish = 00220326 Common = DSna
    case DSNA = 0x22

    /// SPDNAON: Reverse Polish = 00230B24 Common = SPDnaon
    case SPDNAON = 0x23

    /// SPXDSXA: Reverse Polish = 00240D55 Common = SPxDSxa
    case SPXDSXA = 0x24

    /// PDSPANAXN: Reverse Polish = 00251CC5 Common = PDSPanaxn
    case PDSPANAXN = 0x25

    /// SDPSAOX: Reverse Polish = 002606C8 Common = SDPSaox
    case SDPSAOX = 0x26

    /// SDPSXNOX: Reverse Polish = 00271868 Common = SDPSxnox
    case SDPSXNOX = 0x27

    /// DPSXA: Reverse Polish = 00280369 Common = DPSxa
    case DPSXA = 0x28

    /// PSDPSAOXXN: Reverse Polish = 002916CA Common = PSDPSaoxxn
    case PSDPSAOXXN = 0x29

    /// DPSANA: Reverse Polish = 002A0CC9 Common = DPSana
    case DPSANA = 0x2A

    /// SSPXPDXAXN: Reverse Polish = 002B1D58 Common = SSPxPDxaxn
    case SSPXPDXAXN = 0x2B

    /// SPDSOAX: Reverse Polish = 002C0784 Common = SPDSoax
    case SPDSOAX = 0x2C

    /// PSDNOX: Reverse Polish = 002D060A Common = PSDnox
    case PSDNOX = 0x2D

    /// PSDPXOX: Reverse Polish = 002E064A Common = PSDPxox
    case PSDPXOX = 0x2E

    /// PSDNOAN: Reverse Polish = 002F0E2A Common = PSDnoan
    case PSDNOAN = 0x2F

    /// PSNA: Reverse Polish = 0030032A Common = PSna
    case PSNA = 0x30

    /// SDPNAON: Reverse Polish = 00310B28 Common = SDPnaon
    case SDPNAON = 0x31

    /// SDPSOOX: Reverse Polish = 00320688 Common = SDPSoox
    case SDPSOOX = 0x32

    /// NOTSRCCOPY: Reverse Polish = 00330008 Common = Sn
    case NOTSRCCOPY = 0x33

    /// SPDSAOX: Reverse Polish = 003406C4 Common = SPDSaox
    case SPDSAOX = 0x34

    /// SPDSXNOX: Reverse Polish = 00351864 Common = SPDSxnox
    case SPDSXNOX = 0x35

    /// SDPOX: Reverse Polish = 003601A8 Common = SDPox
    case SDPOX = 0x36

    /// SDPOAN: Reverse Polish = 00370388 Common = SDPoan
    case SDPOAN = 0x37

    /// PSDPOAX: Reverse Polish = 0038078A Common = PSDPoax
    case PSDPOAX = 0x38
    
    /// SPDNOX: Reverse Polish = 0390604 Common = SPDnox
    case SPDNOX = 0x39
    
    /// SPDSXOX: Reverse Polish = 003A0644 Common = SPDSxox
    case SPDSXOX = 0x3A
    
    /// SPDNOAN: Reverse Polish = 003B0E24 Common = SPDnoan
    case SPDNOAN = 0x3B
    
    /// PSX: Reverse Polish = 003C004A Common = PSx
    case PSX = 0x3C
    
    /// SPDSONOX: Reverse Polish = 003D18A4 Common = SPDSonox
    case SPDSONOX = 0x3D
    
    /// SPDSNAOX: Reverse Polish = 003E1B24 Common = SPDSnaox
    case SPDSNAOX = 0x3E
    
    /// PSAN: Reverse Polish = 003F00EA Common = PSan
    case PSAN = 0x3F
    
    /// PSDNAA: Reverse Polish = 00400F0A Common = PSDnaa
    case PSDNAA = 0x40
    
    /// DPSXON: Reverse Polish = 00410249 Common = DPSxon
    case DPSXON = 0x41
    
    /// SDXPDXA: Reverse Polish = 00420D5D Common = SDxPDxa
    case SDXPDXA = 0x42
    
    /// SPDSANAXN: Reverse Polish = 00431CC4 Common = SPDSanaxn
    case SPDSANAXN = 0x43
    
    /// SRCERASE: Reverse Polish = 00440328 Common = SDna
    case SRCERASE = 0x44
    
    /// DPSNAON: Reverse Polish = 00450B29 Common = DPSnaon
    case DPSNAON = 0x45
    
    /// DSPDAOX: Reverse Polish = 004606C6 Common = DSPDaox
    case DSPDAOX = 0x46
    
    /// PSDPXAXN: Reverse Polish = 0047076A Common = PSDPxaxn
    case PSDPXAXN = 0x47
    
    /// SDPXA: Reverse Polish = 00480368 Common = SDPxa
    case SDPXA = 0x48
    
    /// PDSPDAOXXN: Reverse Polish = 004916C5 Common = PDSPDaoxxn
    case PDSPDAOXXN = 0x49
    
    /// DPSDOAX: Reverse Polish = 004A0789 Common = DPSDoax
    case DPSDOAX = 0x4A
    
    /// PDSNOX: Reverse Polish = 004B0605 Common = PDSnox
    case PDSNOX = 0x4B
    
    /// SDPANA: Reverse Polish = 004C0CC8 Common = SDPana
    case SDPANA = 0x4C
    
    /// SSPXDSXOXN: Reverse Polish = 004D1954 Common = SSPxDSxoxn
    case SSPXDSXOXN = 0x4D
    
    /// PDSPXOX: Reverse Polish = 004E0645 Common = PDSPxox
    case PDSPXOX = 0x4E
    
    /// PDSNOAN: Reverse Polish = 004F0E25 Common = PDSnoan
    case PDSNOAN = 0x4F
    
    /// PDNA: Reverse Polish = 00500325 Common = PDna
    case PDNA = 0x50
    
    /// DSPNAON: Reverse Polish = 00510B26 Common = DSPnaon
    case DSPNAON = 0x51
    
    /// DPSDAOX: Reverse Polish = 005206C9 Common = DPSDaox
    case DPSDAOX = 0x52
    
    /// SPDSXAXN: Reverse Polish = 00530764 Common = SPDSxaxn
    case SPDSXAXN = 0x53
    
    /// DPSONON: Reverse Polish = 005408A9 Common = DPSonon
    case DPSONON = 0x54
    
    /// DSTINVERT: Reverse Polish = 00550009 Common = Dn
    case DSTINVERT = 0x55
    
    /// DPSOX: Reverse Polish = 005601A9 Common = DPSox
    case DPSOX = 0x56
    
    /// DPSOAN: Reverse Polish = 000570389 Common = DPSoan
    case DPSOAN = 0x57
    
    /// PDSPOAX: Reverse Polish = 00580785 Common = PDSPoax
    case PDSPOAX = 0x58
    
    /// DPSNOX: Reverse Polish = 00590609 Common = DPSnox
    case DPSNOX = 0x59
    
    /// PATINVERT: Reverse Polish = 005A0049 Common = DPx
    case PATINVERT = 0x5A
    
    /// DPSDONOX: Reverse Polish = 005B18A9 Common = DPSDonox
    case DPSDONOX = 0x5B
    
    /// DPSDXOX: Reverse Polish = 005C0649 Common = DPSDxox
    case DPSDXOX = 0x5C
    
    /// DPSNOAN: Reverse Polish = 005D0E29 Common = DPSnoan
    case DPSNOAN = 0x5D
    
    /// DPSDNAOX: Reverse Polish = 005E1B29 Common = DPSDnaox
    case DPSDNAOX = 0x5E
    
    /// DPAN: Reverse Polish = 005F00E9 Common = DPan
    case DPAN = 0x5F
    
    /// PDSXA: Reverse Polish = 00600365 Common = PDSxa
    case PDSXA = 0x60
    
    /// DSPDSAOXXN: Reverse Polish = 006116C6 Common = DSPDSaoxxn
    case DSPDSAOXXN = 0x61
    
    /// DSPDOAX: Reverse Polish = 00620786 Common = DSPDoax
    case DSPDOAX = 0x62
    
    /// SDPNOX: Reverse Polish = 00630608 Common = SDPnox
    case SDPNOX = 0x63
    
    /// SDPSOAX: Reverse Polish = 00640788 Common = SDPSoax
    case SDPSOAX = 0x64
    
    /// DSPNOX: Reverse Polish = 00650606 Common = DSPnox
    case DSPNOX = 0x65
    
    /// SRCINVERT: Reverse Polish = 00660046 Common = DSx
    case SRCINVERT = 0x66
    
    /// SDPSONOX: Reverse Polish = 006718A8 Common = SDPSonox
    case SDPSONOX = 0x67
    
    /// DSPDSONOXXN: Reverse Polish = 006858A6 Common = DSPDSonoxxn
    case DSPDSONOXXN = 0x68
    
    /// PDSXXN: Reverse Polish = 00690145 Common = PDSxxn
    case PDSXXN = 0x69
    
    /// DPSAX: Reverse Polish = 006A01E9 Common = DPSax
    case DPSAX = 0x6A
    
    /// PSDPSOAXXN: Reverse Polish = 006B178A Common = PSDPSoaxxn
    case PSDPSOAXXN = 0x6B
    
    /// SDPAX: Reverse Polish = 006C01E8 Common = SDPax
    case SDPAX = 0x6C
    
    /// PDSPDOAXXN: Reverse Polish = 006D1785 Common = PDSPDoaxxn
    case PDSPDOAXXN = 0x6D
    
    /// SDPSNOAX: Reverse Polish = 006E1E28 Common = SDPSnoax
    case SDPSNOAX = 0x6E
    
    /// PDXNAN: Reverse Polish = 006F0C65 Common = PDXnan
    case PDXNAN = 0x6F
    
    /// PDSANA: Reverse Polish = 00700CC5 Common = PDSana
    case PDSANA = 0x70
    
    /// SSDXPDXAXN: Reverse Polish = 00711D5C Common = SSDxPDxaxn
    case SSDXPDXAXN = 0x71
    
    /// SDPSXOX: Reverse Polish = 00720648 Common = SDPSxox
    case SDPSXOX = 0x72
    
    /// SDPNOAN: Reverse Polish = 00730E28 Common = SDPnoan
    case SDPNOAN = 0x73
    
    /// DSPDXOX: Reverse Polish = 00740646 Common = DSPDxox
    case DSPDXOX = 0x74
    
    /// DSPNOAN: Reverse Polish = 00750E26 Common = DSPnoan
    case DSPNOAN = 0x75
    
    /// SDPSNAOX: Reverse Polish = 00761B28 Common = SDPSnaox
    case SDPSNAOX = 0x76
    
    /// DSAN: Reverse Polish = 007700E6 Common = DSan
    case DSAN = 0x77
    
    /// PDSAX: Reverse Polish = 007801E5 Common = PDSax
    case PDSAX = 0x78
    
    /// DSPDSOAXXN: Reverse Polish = 00791786 Common = DSPDSoaxxn
    case DSPDSOAXXN = 0x79
    
    /// DPSDNOAX: Reverse Polish = 007A1E29 Common = DPSDnoax
    case DPSDNOAX = 0x7A
    
    /// SDPXNAN: Reverse Polish = 007B0C68 Common = SDPxnan
    case SDPXNAN = 0x7B
    
    /// SPDSNOAX: Reverse Polish = 007C1E24 Common = SPDSnoax
    case SPDSNOAX = 0x7C
    
    /// DPSXNAN: Reverse Polish = 007D0C69 Common = DPSxnan
    case DPSXNAN = 0x7D
    
    /// SPXDSXO: Reverse Polish = 007E0955 Common = SPxDSxo
    case SPXDSXO = 0x7E
    
    /// DPSAAN: Reverse Polish = 007F03C9 Common = DPSaan
    case DPSAAN = 0x7F
    
    /// DPSAA: Reverse Polish = 008003E9 Common = DPSaa
    case DPSAA = 0x80
    
    /// SPXDSXON: Reverse Polish = 00810975 Common = SPxDSxon
    case SPXDSXON = 0x81
    
    /// DPSXNA: Reverse Polish = 00820C49 Common = DPSxna
    case DPSXNA = 0x82
    
    /// SPDSNOAXN: Reverse Polish = 00831E04 Common = SPDSnoaxn
    case SPDSNOAXN = 0x83
    
    /// SDPXNA: Reverse Polish = 00840C48 Common = SDPxna
    case SDPXNA = 0x84
    
    /// PDSPNOAXN: Reverse Polish = 00851E05 Common = PDSPnoaxn
    case PDSPNOAXN = 0x85
    
    /// DSPDSOAXX: Reverse Polish = 008617A6 Common = DSPDSoaxx
    case DSPDSOAXX = 0x86
    
    /// PDSAXN: Reverse Polish = 008701C5 Common = PDSaxn
    case PDSAXN = 0x87
    
    /// SRCAND: Reverse Polish = 008800C6 Common = DSa
    case SRCAND = 0x88
    
    /// SDPSNAOXN: Reverse Polish = 00891B08 Common = SDPSnaoxn
    case SDPSNAOXN = 0x89
    
    /// DSPNOA: Reverse Polish = 008A0E06 Common = DSPnoa
    case DSPNOA = 0x8A
    
    /// DSPDXOXN: Reverse Polish = 008B0666 Common = DSPDxoxn
    case DSPDXOXN = 0x8B
    
    /// SDPNOA: Reverse Polish = 008C0E08 Common = SDPnoa
    case SDPNOA = 0x8C
    
    /// SDPSXOXN: Reverse Polish = 008D0668 Common = SDPSxoxn
    case SDPSXOXN = 0x8D
    
    /// SSDXPDXAX: Reverse Polish = 008E1D7C Common = SSDxPDxax
    case SSDXPDXAX = 0x8E
    
    /// PDSANAN: Reverse Polish = 008F0CE5 Common = PDSanan
    case PDSANAN = 0x8F
    
    /// PDSXNA: Reverse Polish = 00900C45 Common = PDSxna
    case PDSXNA = 0x90
    
    /// SDPSNOAXN: Reverse Polish = 00911E08 Common = SDPSnoaxn
    case SDPSNOAXN = 0x91
    
    /// DPSDPOAXX: Reverse Polish = 009217A9 Common = DPSDPoaxx
    case DPSDPOAXX = 0x92
    
    /// SPDAXN: Reverse Polish = 009301C4 Common = SPDaxn
    case SPDAXN = 0x93
    
    /// PSDPSOAXX: Reverse Polish = 009417AA Common = PSDPSoaxx
    case PSDPSOAXX = 0x94
    
    /// DPSAXN: Reverse Polish = 009501C9 Common = DPSaxn
    case DPSAXN = 0x95
    
    /// DPSXX: Reverse Polish = 00960169 Common = DPSxx
    case DPSXX = 0x96
    
    /// PSDPSONOXX: Reverse Polish = 0097588A Common = PSDPSonoxx
    case PSDPSONOXX = 0x97
    
    /// SDPSONOXN: Reverse Polish = 00981888 Common = SDPSonoxn
    case SDPSONOXN = 0x98
    
    /// DSXN: Reverse Polish = 00990066 Common = DSxn
    case DSXN = 0x99
    
    /// DPSNAX: Reverse Polish = 009A0709 Common = DPSnax
    case DPSNAX = 0x9A
    
    /// SDPSOAXN: Reverse Polish = 009B07A8 Common = SDPSoaxn
    case SDPSOAXN = 0x9B
    
    /// SPDNAX: Reverse Polish = 009C0704 Common = SPDnax
    case SPDNAX = 0x9C
    
    /// DSPDOAXN: Reverse Polish = 009D07A6 Common = DSPDoaxn
    case DSPDOAXN = 0x9D
    
    /// DSPDSAOXX: Reverse Polish = 009E16E6 Common = DSPDSaoxx
    case DSPDSAOXX = 0x9E
    
    /// PDSXAN: Reverse Polish = 009F0345 Common = PDSxan
    case PDSXAN = 0x9F
    
    /// DPA: Reverse Polish = 00A000C9 Common = DPa
    case DPA = 0xA0
    
    /// PDSPNAOXN: Reverse Polish = 00A11B05 Common = PDSPnaoxn
    case PDSPNAOXN = 0xA1
    
    /// DPSNOA: Reverse Polish = 00A20E09 Common = DPSnoa
    case DPSNOA = 0xA2
    
    /// DPSDXOXN: Reverse Polish = 00A30669 Common = DPSDxoxn
    case DPSDXOXN = 0xA3
    
    /// PDSPONOXN: Reverse Polish = 00A41885 Common = PDSPonoxn
    case PDSPONOXN = 0xA4
    
    /// PDXN: Reverse Polish = 00A50065 Common = PDxn
    case PDXN = 0xA5
    
    /// DSPNAX: Reverse Polish = 00A60706 Common = DSPnax
    case DSPNAX = 0xA6
    
    /// PDSPOAXN: Reverse Polish = 00A707A5 Common = PDSPoaxn
    case PDSPOAXN = 0xA7
    
    /// DPSOA: Reverse Polish = 00A803A9 Common = DPSoa
    case DPSOA = 0xA8
    
    /// DPSOXN: Reverse Polish = 00A90189 Common = DPSoxn
    case DPSOXN = 0xA9
    
    /// D: Reverse Polish = 00AA0029 Common = D
    case D = 0xAA
    
    /// DPSONO: Reverse Polish = 00AB0889 Common = DPSono
    case DPSONO = 0xAB
    
    /// SPDSXAX: Reverse Polish = 00AC0744 Common = SPDSxax
    case SPDSXAX = 0xAC
    
    /// DPSDAOXN: Reverse Polish = 00AD06E9 Common = DPSDaoxn
    case DPSDAOXN = 0xAD
    
    /// DSPNAO: Reverse Polish = 00AE0B06 Common = DSPnao
    case DSPNAO = 0xAE
    
    /// DPNO: Reverse Polish = 00AF0229 Common = DPno
    case DPNO = 0xAF
    
    /// PDSNOA: Reverse Polish = 00B00E05 Common = PDSnoa
    case PDSNOA = 0xB0
    
    /// PDSPXOXN: Reverse Polish = 00B10665 Common = PDSPxoxn
    case PDSPXOXN = 0xB1
    
    /// SSPXDSXOX: Reverse Polish = 00B21974 Common = SSPxDSxox
    case SSPXDSXOX = 0xB2
    
    /// SDPANAN: Reverse Polish = 00B30CE8 Common = SDPanan
    case SDPANAN = 0xB3
    
    /// PSDNAX: Reverse Polish = 00B4070A Common = PSDnax
    case PSDNAX = 0xB4
    
    /// DPSDOAXN: Reverse Polish = 00B507A9 Common = DPSDoaxn
    case DPSDOAXN = 0xB5
    
    /// DPSDPAOXX: Reverse Polish = 00B616E9 Common = DPSDPaoxx
    case DPSDPAOXX = 0xB6
    
    /// SDPXAN: Reverse Polish = 00B70348 Common = SDPxan
    case SDPXAN = 0xB7
    
    /// PSDPXAX: Reverse Polish = 00B8074A Common = PSDPxax
    case PSDPXAX = 0xB8
    
    /// DSPDAOXN: Reverse Polish = 00B906E6 Common = DSPDaoxn
    case DSPDAOXN = 0xB9
    
    /// DPSNAO: Reverse Polish = 00BA0B09 Common = DPSnao
    case DPSNAO = 0xBA
    
    /// MERGEPAINT: Reverse Polish = 00BB0226 Common = DSno
    case MERGEPAINT = 0xBB
    
    /// SPDSANAX: Reverse Polish = 00BC1CE4 Common = SPDSanax
    case SPDSANAX = 0xBC
    
    /// SDXPDXAN: Reverse Polish = 00BD0D7D Common = SDxPDxan
    case SDXPDXAN = 0xBD
    
    /// DPSXO: Reverse Polish = 00BE0269 Common = DPSxo
    case DPSXO = 0xBE
    
    /// DPSANO: Reverse Polish = 00BF08C9 Common = DPSano
    case DPSANO = 0xBF
    
    /// MERGECOPY: Reverse Polish = 00C000CA Common = PSa
    case MERGECOPY = 0xC0
    
    /// SPDSNAOXN: Reverse Polish = 00C11B04 Common = SPDSnaoxn
    case SPDSNAOXN = 0xC1
    
    /// SPDSONOXN: Reverse Polish = 00C21884 Common = SPDSonoxn
    case SPDSONOXN = 0xC2
    
    /// PSXN: Reverse Polish = 00C3006A Common = PSxn
    case PSXN = 0xC3

    /// SPDNOA: Reverse Polish = 00C40E04 Common = SPDnoa
    case SPDNOA = 0xC4

    /// SPDSXOXN: Reverse Polish = 00C50664 Common = SPDSxoxn
    case SPDSXOXN = 0xC5

    /// SDPNAX: Reverse Polish = 00C60708 Common = SDPnax
    case SDPNAX = 0xC6

    /// PSDPOAXN: Reverse Polish = 00C707AA Common = PSDPoaxn
    case PSDPOAXN = 0xC7

    /// SDPOA: Reverse Polish = 00C803A8 Common = SDPoa
    case SDPOA = 0xC8

    /// SPDOXN: Reverse Polish = 00C90184 Common = SPDoxn
    case SPDOXN = 0xC9

    /// DPSDXAX: Reverse Polish = 00CA0749 Common = DPSDxax
    case DPSDXAX = 0xCA

    /// SPDSAOXN: Reverse Polish = 00CB06E4 Common = SPDSaoxn
    case SPDSAOXN = 0xCB

    /// SRCCOPY: Reverse Polish = 00CC0020 Common = S
    case SRCCOPY = 0xCC

    /// SDPONO: Reverse Polish = 00CD0888 Common = SDPono
    case SDPONO = 0xCD

    /// SDPNAO: Reverse Polish = 00CE0B08 Common = SDPnao
    case SDPNAO = 0xCE

    /// SPNO: Reverse Polish = 00CF0224 Common = SPno
    case SPNO = 0xCF

    /// PSDNOA: Reverse Polish =00D00E0A Common = PSDnoa
    case PSDNOA = 0xD0

    /// PSDPXOXN: Reverse Polish = 00D1066A Common = PSDPxoxn
    case PSDPXOXN = 0xD1

    /// PDSNAX: Reverse Polish = 00D20705 Common = PDSnax
    case PDSNAX = 0xD2

    /// SPDSOAXN: Reverse Polish = 00D307A4 Common = SPDSoaxn
    case SPDSOAXN = 0xD3

    /// SSPXPDXAX: Reverse Polish = 00D41D78 Common = SSPxPDxax
    case SSPXPDXAX = 0xD4

    /// DPSANAN: Reverse Polish = 00D50CE9 Common = DPSanan
    case DPSANAN = 0xD5

    /// PSDPSAOXX: Reverse Polish = 00D616EA Common = PSDPSaoxx
    case PSDPSAOXX = 0xD6

    /// DPSXAN: Reverse Polish = 00D70349 Common = DPSxan
    case DPSXAN = 0xD7

    /// PDSPXAX: Reverse Polish = 00D80745 Common = PDSPxax
    case PDSPXAX = 0xD8

    /// SDPSAOXN: Reverse Polish = 00D906E8 Common = SDPSaoxn
    case SDPSAOXN = 0xD9

    /// DPSDANAX: Reverse Polish = 00DA1CE9 Common = DPSDanax
    case DPSDANAX = 0xDA

    /// SPXDSXAN: Reverse Polish = 00DB0D75 Common = SPxDSxan
    case SPXDSXAN = 0xDB

    /// SPDNAO: Reverse Polish = 00DC0B04 Common = SPDnao
    case SPDNAO = 0xDC

    /// SDNO: Reverse Polish = 00DD0228 Common = SDno
    case SDNO = 0xDD

    /// SDPXO: Reverse Polish = 00DE0268 Common = SDPxo
    case SDPXO = 0xDE

    /// SDPANO: Reverse Polish = 00DF08C8 Common = SDPano
    case SDPANO = 0xDF

    /// PDSOA: Reverse Polish = 00E003A5 Common = PDSoa
    case PDSOA = 0xE0

    /// PDSOXN: Reverse Polish = 00E10185 Common = PDSoxn
    case PDSOXN = 0xE1

    /// DSPDXAX: Reverse Polish = 00E20746 Common = DSPDxax
    case DSPDXAX = 0xE2

    /// PSDPAOXN: Reverse Polish = 00E306EA Common = PSDPaoxn
    case PSDPAOXN = 0xE3

    /// SDPSXAX: Reverse Polish = 00E40748 Common = SDPSxax
    case SDPSXAX = 0xE4

    /// PDSPAOXN: Reverse Polish = 00E506E5 Common = PDSPaoxn
    case PDSPAOXN = 0xE5

    /// SDPSANAX: Reverse Polish = 00E61CE8 Common = SDPSanax
    case SDPSANAX = 0xE6

    /// SPXPDXAN: Reverse Polish = 00E70D79 Common = SPxPDxan
    case SPXPDXAN = 0xE7

    /// SSPXDSXAX: Reverse Polish = 00E81D74 Common = SSPxDSxax
    case SSPXDSXAX = 0xE8

    /// DSPDSANAXXN: Reverse Polish = 00E95CE6 Common = DSPDSanaxxn
    case DSPDSANAXXN = 0xE9

    /// DPSAO: Reverse Polish = 00EA02E9 Common = DPSao
    case DPSAO = 0xEA

    /// DPSXNO: Reverse Polish = 00EB0849 Common = DPSxno
    case DPSXNO = 0xEB

    /// SDPAO: Reverse Polish = 00EC02E8 Common = SDPao
    case SDPAO = 0xEC

    /// SDPXNO: Reverse Polish = 00ED0848 Common = SDPxno
    case SDPXNO = 0xED

    /// SRCPAINT: Reverse Polish = 00EE0086 Common = DSo
    case SRCPAINT = 0xEE

    /// SDPNOO: Reverse Polish = 00EF0A08 Common = SDPnoo
    case SDPNOO = 0xEF

    /// PATCOPY: Reverse Polish = 00F00021 Common = P
    case PATCOPY = 0xF0

    /// PDSONO: Reverse Polish = 00F10885 Common = PDSono
    case PDSONO = 0xF1

    /// PDSNAO: Reverse Polish = 00F20B05 Common = PDSnao
    case PDSNAO = 0xF2

    /// PSNO: Reverse Polish = 00F3022A Common = PSno
    case PSNO = 0xF3

    /// PSDNAO: Reverse Polish = 00F40B0A Common = PSDnao
    case PSDNAO = 0xF4

    /// PDNO: Reverse Polish = 00F50225 Common = PDno
    case PDNO = 0xF5

    /// PDSXO: Reverse Polish = 00F60265 Common = PDSxo
    case PDSXO = 0xF6

    /// PDSANO: Reverse Polish = 00F708C5 Common = PDSano
    case PDSANO = 0xF7

    /// PDSAO: Reverse Polish = 00F802E5 Common = PDSao
    case PDSAO = 0xF8

    /// PDSXNO: Reverse Polish = 00F90845 Common = PDSxno
    case PDSXNO = 0xF9

    /// DPO: Reverse Polish = 00FA0089 Common = DPo
    case DPO = 0xFA

    /// PATPAINT: Reverse Polish = 00FB0A09 Common = DPSnoo
    case PATPAINT = 0xFB

    /// PSO: Reverse Polish = 00FC008A Common = PSo
    case PSO = 0xFC

    /// PSDNOO: Reverse Polish = 00FD0A0A Common = PSDnoo
    case PSDNOO = 0xFD

    /// DPSOO: Reverse Polish = 00FE02A9 Common = DPSoo
    case DPSOO = 0xFE

    /// WHITENESS: Reverse Polish = 00FF0062 Common = 1
    case WHITENESS = 0xFF
}
