//
//  BinaryRasterOperation.swift
//  
//
//  Created by Hugh Bellamy on 01/12/2020.
//

/// [MS-WMF] 2.1.1.2 BinaryRasterOperation Enumeration
/// The BinaryRasterOperation Enumeration section lists the binary raster-operation codes. Rasteroperation codes define how metafile
/// processing combines the bits from the selected pen with the bits in the destination bitmap.
/// Each raster-operation code represents a Boolean operation in which the values of the pixels in the selected pen and the destination bitmap
/// are combined. Following are the two operands used in these operations.
/// Operand Meaning
/// P Selected pen
/// D Destination bitmap
/// Following are the Boolean operators used in these operations.
/// Operator Meaning
/// a Bitwise AND
/// n Bitwise NOT (inverse)
/// o Bitwise OR
/// x Bitwise exclusive OR (XOR)
/// All Boolean operations are presented in reverse Polish notation. For example, the following operation replaces the values of the pixels in the
/// destination bitmap with a combination of the pixel values of the pen and the selected brush: DPo.
/// Each raster-operation code is a 32-bit integer whose high-order word is a Boolean operation index and whose low-order word is the operation
/// code. The 16-bit operation index is a zero-extended, 8-bit value that represents all possible outcomes resulting from the Boolean operation
/// on two parameters (in this case, the pen and destination values). For example, the operation indexes for the DPo and DPan operations are
/// shown in the following list.
/// P D DPo DPan
/// 0 0 0 1
/// 0 1 1 1
/// 1 0 1 1
/// 1 1 1 0
/// typedef enum
/// {
///  R2_BLACK = 0x0001,
///  R2_NOTMERGEPEN = 0x0002,
///  R2_MASKNOTPEN = 0x0003,
///  R2_NOTCOPYPEN = 0x0004,
///  R2_MASKPENNOT = 0x0005,
///  R2_NOT = 0x0006,
///  R2_XORPEN = 0x0007,
///  R2_NOTMASKPEN = 0x0008,
///  R2_MASKPEN = 0x0009,
///  R2_NOTXORPEN = 0x000A,
///  R2_NOP = 0x000B,
///  R2_MERGENOTPEN = 0x000C,
///  R2_COPYPEN = 0x000D,
///  R2_MERGEPENNOT = 0x000E,
///  R2_MERGEPEN = 0x000F,
///  R2_WHITE = 0x0010
/// } BinaryRasterOperation;
/// For a monochrome device, WMF format maps the value 0 to black and the value 1 to white. If an application attempts to draw with a black
/// pen on a white destination by using the available binary raster operations, the following results occur.
/// Raster operation Result
/// R2_BLACK Visible black line
/// R2_COPYPEN Visible black line
/// R2_MASKNOTPEN No visible line
/// R2_MASKPEN Visible black line
/// R2_MASKPENNOT Visible black line
/// R2_MERGENOTPEN No visible line
/// R2_MERGEPEN Visible black line
/// R2_MERGEPENNOT Visible black line
/// R2_NOP No visible line
/// R2_NOT Visible black line
/// R2_NOTCOPYPEN No visible line
/// R2_NOTMASKPEN No visible line
/// R2_NOTMERGEPEN Visible black line
/// R2_NOTXORPEN Visible black line
/// R2_WHITE No visible line
/// R2_XORPEN No visible line
/// For a color device, WMF format uses RGB values to represent the colors of the pen and the destination. An RGB color value is a long integer
/// that contains a red, a green, and a blue color field, each specifying the intensity of the given color. Intensities range from 0 through 255. The
/// values are packed in the three low-order bytes of the long integer. The color of a pen is always a solid color, but the color of the destination
/// can be a mixture of any two or three colors. If an application attempts to draw with a white pen on a blue destination by using the available
/// binary raster operations, the following results occur.
/// Raster operation Result
/// R2_BLACK Visible black line
/// R2_COPYPEN Visible white line
/// R2_MASKNOTPEN Visible black line
/// R2_MASKPEN Invisible blue line
/// R2_MASKPENNOT Visible red/green line
/// R2_MERGENOTPEN Invisible blue line
/// R2_MERGEPEN Visible white line
/// R2_MERGEPENNOT Visible white line
/// R2_NOP Invisible blue line
/// R2_NOT Visible red/green line
/// R2_NOTCOPYPEN Visible black line
/// R2_NOTMASKPEN Visible red/green line
/// R2_NOTMERGEPEN Visible black line
/// R2_NOTXORPEN Invisible blue line
/// R2_WHITE Visible white line
/// R2_XORPEN Visible red/green line
public enum BinaryRasterOperation: UInt16, DataStreamCreatable {
    /// R2_BLACK: 0, Pixel is always 0.
    case black = 0x0001
    
    /// R2_NOTMERGEPEN: DPon, Pixel is the inverse of the R2_MERGEPEN color.
    case notMergePen = 0x0002
    
    /// R2_MASKNOTPEN: DPna, Pixel is a combination of the screen color and the inverse of the pen color.
    case maskNotPen = 0x0003
    
    /// R2_NOTCOPYPEN: Pn, Pixel is the inverse of the pen color.
    case notCopyPen = 0x0004
    
    /// R2_MASKPENNOT: PDna, Pixel is a combination of the colors common to both the pen and the inverse of the screen.
    case maskPenNot = 0x0005
    
    /// R2_NOT: Dn, Pixel is the inverse of the screen color.
    case not = 0x0006
    
    /// R2_XORPEN: DPx, Pixel is a combination of the colors in the pen or in the screen, but not in both.
    case xorPen = 0x0007
    
    /// R2_NOTMASKPEN: DPan, Pixel is the inverse of the R2_MASKPEN color.
    case notMaskPen = 0x0008
    
    /// R2_MASKPEN: DPa, Pixel is a combination of the colors common to both the pen and the screen.
    case maskPen = 0x0009
   
    /// R2_NOTXORPEN: DPxn, Pixel is the inverse of the R2_XORPEN color.
    case notXorPen = 0x000A
    
    /// R2_NOP: D, Pixel remains unchanged.
    case nop = 0x000B
    
    /// R2_MERGENOTPEN: DPno, Pixel is a combination of the colors common to both the screen and the inverse of the pen.
    case mergeNotPen = 0x000C
    
    /// R2_COPYPEN: P, Pixel is the pen color.
    case copyPen = 0x000D
    
    /// R2_MERGEPENNOT: PDno, Pixel is a combination of the pen color and the inverse of the screen color.
    case mergePenNot = 0x000E
    
    /// R2_MERGEPEN: DPo, Pixel is a combination of the pen color and the screen color.
    case mergePen = 0x000F
    
    /// R2_WHITE: 1, Pixel is always 1
    case white = 0x0010
}
