//
//  Compression.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

/// [MS-WMF] 2.1.1.7 Compression Enumeration
/// The Compression Enumeration specifies the type of compression for a bitmap image.
/// typedef enum
/// {
///  BI_RGB = 0x0000,
///  BI_RLE8 = 0x0001,
///  BI_RLE4 = 0x0002,
///  BI_BITFIELDS = 0x0003,
///  BI_JPEG = 0x0004,
///  BI_PNG = 0x0005,
///  BI_CMYK = 0x000B,
///  BI_CMYKRLE8 = 0x000C,
///  BI_CMYKRLE4 = 0x000D
/// } Compression;
/// Note A bottom-up bitmap can be compressed, but a top-down bitmap cannot.
/// See section 3.1.6 for more information on RLE compression.
public enum Compression: UInt16, DataStreamCreatable {
    /// BI_RGB: The bitmap is in uncompressed red green blue (RGB) format that is not compressed and does not use color masks.
    case rgb = 0x0000
    
    /// BI_RLE8: An RGB format that uses run-length encoding (RLE) compression for bitmaps with 8 bits per pixel. The compression uses a
    /// 2-byte format consisting of a count byte followed by a byte containing a color index.
    case rle8 = 0x0001
    
    /// BI_RLE4: An RGB format that uses RLE compression for bitmaps with 4 bits per pixel. The compression uses a 2-byte format consisting
    /// of a count byte followed by two word-length color indexes.
    case rle4 = 0x0002
    
    /// BI_BITFIELDS: The bitmap is not compressed, and the color table consists of three DWORD (defined in [MS-DTYP] section 2.2.9) color
    /// masks that specify the red, green, and blue components, respectively, of each pixel. This is valid when used with 16 and 32-bits per pixel
    /// bitmaps.
    case bitfields = 0x0003
    
    /// BI_JPEG: The image is a JPEG image, as specified in [JFIF]. This value SHOULD only be used in certain bitmap operations, such as
    /// JPEG pass-through. The application MUST query for the passthrough support, since not all devices support JPEG pass-through. Using
    /// non-RGB bitmaps MAY limit the portability of the metafile to other devices. For instance, display device contexts generally do not support
    /// this pass-through.
    case jpeg = 0x0004
    
    /// BI_PNG: The image is a PNG image, as specified in [RFC2083]. This value SHOULD only be used certain bitmap operations, such
    /// as JPEG/PNG pass-through. The application MUST query for the pass-through support, because not all devices support JPEG/PNG
    /// pass-through. Using non-RGB bitmaps MAY limit the portability of the metafile to other devices. For instance, display device contexts
    /// generally do not support this pass-through.
    case png = 0x0005
    
    /// BI_CMYK: The image is an uncompressed CMYK format.
    case cmyk = 0x000B
    
    /// BI_CMYKRLE8: A CMYK format that uses RLE compression for bitmaps with 8 bits per pixel. The compression uses a 2-byte format
    /// consisting of a count byte followed by a byte containing a color index.
    case cmykRle8 = 0x000C
    
    /// BI_CMYKRLE4: A CMYK format that uses RLE compression for bitmaps with 4 bits per pixel. The compression uses a 2-byte format
    /// consisting of a count byte followed by two word-length color indexes.
    case cmykRle4 = 0x000D
}
