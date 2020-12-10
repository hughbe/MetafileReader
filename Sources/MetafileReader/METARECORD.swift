//
//  METARECORD.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

public enum METARECORD {
    case eof(_: META_EOF)
    case saveDC(_: META_SAVEDC)
    case realizePalette(_: META_REALIZEPALETTE)
    case setPalEntries(_: META_SETPALENTRIES)
    case createPalette(_: META_CREATEPALETTE)
    case setBkMode(_: META_SETBKMODE)
    case setMapMode(_: META_SETMAPMODE)
    case setRop2(_: META_SETROP2)
    case setRelabs(_: META_SETRELABS)
    case setPolyFillMode(_: META_SETPOLYFILLMODE)
    case setStretchBltMode(_: META_SETSTRETCHBLTMODE)
    case setTextCharExtra(_: META_SETTEXTCHAREXTRA)
    case restoreDC(_: META_RESTOREDC)
    case invertRegion(_: META_INVERTREGION)
    case paintRegion(_: META_PAINTREGION)
    case selectClipRegion(_: META_SELECTCLIPREGION)
    case selectObject(_: META_SELECTOBJECT)
    case textAlign(_: META_SETTEXTALIGN)
    case resizePalette(_: META_RESIZEPALETTE)
    case dibCreatePatternBrush(_: META_DIBCREATEPATTERNBRUSH)
    case setLayout(_: META_SETLAYOUT)
    case deleteObject(_: META_DELETEOBJECT)
    case createPatternBrush(_: META_CREATEPATTERNBRUSH)
    case setBkColor(_: META_SETBKCOLOR)
    case setTextColor(_: META_SETTEXTCOLOR)
    case setTextJustification(_: META_SETTEXTJUSTIFICATION)
    case setWindowOrg(_: META_SETWINDOWORG)
    case setWindowExt(_: META_SETWINDOWEXT)
    case setViewportOrg(_: META_SETVIEWPORTORG)
    case setViewportExt(_: META_SETVIEWPORTEXT)
    case offsetWindowOrg(_: META_OFFSETWINDOWORG)
    case offsetViewportOrg(_: META_OFFSETVIEWPORTORG)
    case lineTo(_: META_LINETO)
    case moveTo(_: META_MOVETO)
    case offsetClipRgn(_: META_OFFSETCLIPRGN)
    case fillRegion(_: META_FILLREGION)
    case setMapperFlags(_: META_SETMAPPERFLAGS)
    case selectPalette(_: META_SELECTPALETTE)
    case createPenIndirect(_: META_CREATEPENINDIRECT)
    case createFontIndirect(_: META_CREATEFONTINDIRECT)
    case createBrushIndirect(_: META_CREATEBRUSHINDIRECT)
    case polygon(_: META_POLYGON)
    case polyline(_: META_POLYLINE)
    case scaleWindowExt(_: META_SCALEWINDOWEXT)
    case scaleViewportExt(_: META_SCALEVIEWPORTEXT)
    case excludeClipRect(_: META_EXCLUDECLIPRECT)
    case intersectClipRect(_: META_INTERSECTCLIPRECT)
    case ellipse(_: META_ELLIPSE)
    case floodFill(_: META_FLOODFILL)
    case rectangle(_: META_RECTANGLE)
    case setPixel(_: META_SETPIXEL)
    case frameRegion(_: META_FRAMEREGION)
    case animatePalette(_: META_ANIMATEPALETTE)
    case textOut(_: META_TEXTOUT)
    case polyPolygon(_: META_POLYPOLYGON)
    case extFloodFill(_: META_EXTFLOODFILL)
    case roundRect(_: META_ROUNDRECT)
    case patBlt(_: META_PATBLT)
    case escape(_: META_ESCAPE)
    case createRegion(_: META_CREATEREGION)
    case arc(_: META_ARC)
    case pie(_: META_PIE)
    case chord(_: META_CHORD)
    case bitBlt(_: META_BITBLT)
    case dibBitBlt(_: META_DIBBITBLT)
    case stretchBlt(_: META_STRETCHBLT)
    case dibStretchBlt(_: META_DIBSTRETCHBLT)
    case extTextOut(_: META_EXTTEXTOUT)
    case setDibToDev(_: META_SETDIBTODEV)
    case stretchDib(_: META_STRETCHDIB)
    
    public init(dataStream: inout DataStream) throws {
        let remainingCount = dataStream.remainingCount
        let position = dataStream.position

        let recordSize: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard recordSize >= 0 &&
                recordSize < UInt32.max / 2 &&
                recordSize * 2 <= remainingCount else {
            throw WmfReadError.corrupted
        }
        
        let recordFunction: UInt16 = try dataStream.read(endianess: .littleEndian)
        dataStream.position = position
        
        switch recordFunction {
        case RecordType.META_SAVEDC.rawValue: // 0x001E
            self = .saveDC(try META_SAVEDC(dataStream: &dataStream))
        case RecordType.META_REALIZEPALETTE.rawValue: // 0x0035
            self = .realizePalette(try META_REALIZEPALETTE(dataStream: &dataStream))
        case RecordType.META_SETPALENTRIES.rawValue: // 0x0037
            self = .setPalEntries(try META_SETPALENTRIES(dataStream: &dataStream))
        case RecordType.META_CREATEPALETTE.rawValue: // 0x00F7
            self = .createPalette(try META_CREATEPALETTE(dataStream: &dataStream))
        case RecordType.META_SETBKMODE.rawValue: // 0x0102
            self = .setBkMode(try META_SETBKMODE(dataStream: &dataStream))
        case RecordType.META_SETMAPMODE.rawValue: // 0x0103
            self = .setMapMode(try META_SETMAPMODE(dataStream: &dataStream))
        case RecordType.META_SETROP2.rawValue: // 0x0104
            self = .setRop2(try META_SETROP2(dataStream: &dataStream))
        case RecordType.META_SETRELABS.rawValue: // 0x0105
            self = .setRelabs(try META_SETRELABS(dataStream: &dataStream))
        case RecordType.META_SETPOLYFILLMODE.rawValue: // 0x0106
            self = .setPolyFillMode(try META_SETPOLYFILLMODE(dataStream: &dataStream))
        case RecordType.META_SETSTRETCHBLTMODE.rawValue: // 0x0107
            self = .setStretchBltMode(try META_SETSTRETCHBLTMODE(dataStream: &dataStream))
        case RecordType.META_SETTEXTCHAREXTRA.rawValue: // 0x0108
            self = .setTextCharExtra(try META_SETTEXTCHAREXTRA(dataStream: &dataStream))
        case RecordType.META_RESTOREDC.rawValue: // 0x0127
            self = .restoreDC(try META_RESTOREDC(dataStream: &dataStream))
        case RecordType.META_INVERTREGION.rawValue: // 0x012A
            self = .invertRegion(try META_INVERTREGION(dataStream: &dataStream))
        case RecordType.META_PAINTREGION.rawValue: // 0x012B
            self = .paintRegion(try META_PAINTREGION(dataStream: &dataStream))
        case RecordType.META_SELECTCLIPREGION.rawValue: // 0x012C
            self = .selectClipRegion(try META_SELECTCLIPREGION(dataStream: &dataStream))
        case RecordType.META_SELECTOBJECT.rawValue: // 0x012D
            self = .selectObject(try META_SELECTOBJECT(dataStream: &dataStream))
        case RecordType.META_SETTEXTALIGN.rawValue: // 0x012E
            self = .textAlign(try META_SETTEXTALIGN(dataStream: &dataStream))
        case RecordType.META_RESIZEPALETTE.rawValue: // 0x0139
            self = .resizePalette(try META_RESIZEPALETTE(dataStream: &dataStream))
        case RecordType.META_DIBCREATEPATTERNBRUSH.rawValue: // 0x0142
            self = .dibCreatePatternBrush(try META_DIBCREATEPATTERNBRUSH(dataStream: &dataStream))
        case RecordType.META_SETLAYOUT.rawValue: // 0x0149
            self = .setLayout(try META_SETLAYOUT(dataStream: &dataStream))
        case RecordType.META_DELETEOBJECT.rawValue: // 0x01F0
            self = .deleteObject(try META_DELETEOBJECT(dataStream: &dataStream))
        case RecordType.META_CREATEPATTERNBRUSH.rawValue: // 0x01F9
            self = .createPatternBrush(try META_CREATEPATTERNBRUSH(dataStream: &dataStream))
        case RecordType.META_SETBKCOLOR.rawValue: // 0x0201
            self = .setBkColor(try META_SETBKCOLOR(dataStream: &dataStream))
        case RecordType.META_SETTEXTCOLOR.rawValue: // 0x0209
            self = .setTextColor(try META_SETTEXTCOLOR(dataStream: &dataStream))
        case RecordType.META_SETTEXTJUSTIFICATION.rawValue: // 0x020A
            self = .setTextJustification(try META_SETTEXTJUSTIFICATION(dataStream: &dataStream))
        case RecordType.META_SETWINDOWORG.rawValue: // 0x020B
            self = .setWindowOrg(try META_SETWINDOWORG(dataStream: &dataStream))
        case RecordType.META_SETWINDOWEXT.rawValue: // 0x020C
            self = .setWindowExt(try META_SETWINDOWEXT(dataStream: &dataStream))
        case RecordType.META_SETVIEWPORTORG.rawValue: // 0x020D
            self = .setViewportOrg(try META_SETVIEWPORTORG(dataStream: &dataStream))
        case RecordType.META_SETVIEWPORTEXT.rawValue: // 0x020E
            self = .setViewportExt(try META_SETVIEWPORTEXT(dataStream: &dataStream))
        case RecordType.META_OFFSETWINDOWORG.rawValue: // 0x020F
            self = .offsetWindowOrg(try META_OFFSETWINDOWORG(dataStream: &dataStream))
        case RecordType.META_OFFSETVIEWPORTORG.rawValue: // 0x0211
            self = .offsetViewportOrg(try META_OFFSETVIEWPORTORG(dataStream: &dataStream))
        case RecordType.META_LINETO.rawValue: // 0x0213
            self = .lineTo(try META_LINETO(dataStream: &dataStream))
        case RecordType.META_MOVETO.rawValue: // 0x0214
            self = .moveTo(try META_MOVETO(dataStream: &dataStream))
        case RecordType.META_OFFSETCLIPRGN.rawValue: // 0x0220
            self = .offsetClipRgn(try META_OFFSETCLIPRGN(dataStream: &dataStream))
        case RecordType.META_FILLREGION.rawValue: // 0x0228
            self = .fillRegion(try META_FILLREGION(dataStream: &dataStream))
        case RecordType.META_SETMAPPERFLAGS.rawValue: // 0x0231
            self = .setMapperFlags(try META_SETMAPPERFLAGS(dataStream: &dataStream))
        case RecordType.META_SELECTPALETTE.rawValue: // 0x0234
            self = .selectPalette(try META_SELECTPALETTE(dataStream: &dataStream))
        case RecordType.META_CREATEPENINDIRECT.rawValue: // 0x02FA
            self = .createPenIndirect(try META_CREATEPENINDIRECT(dataStream: &dataStream))
        case RecordType.META_CREATEFONTINDIRECT.rawValue: // 0x02FA
            self = .createFontIndirect(try META_CREATEFONTINDIRECT(dataStream: &dataStream))
        case RecordType.META_CREATEBRUSHINDIRECT.rawValue: // 0x02FC
            self = .createBrushIndirect(try META_CREATEBRUSHINDIRECT(dataStream: &dataStream))
        case RecordType.META_POLYGON.rawValue: // 0x0324
            self = .polygon(try META_POLYGON(dataStream: &dataStream))
        case RecordType.META_POLYLINE.rawValue: // 0x0325
            self = .polyline(try META_POLYLINE(dataStream: &dataStream))
        case RecordType.META_SCALEWINDOWEXT.rawValue: // 0x0410
            self = .scaleWindowExt(try META_SCALEWINDOWEXT(dataStream: &dataStream))
        case RecordType.META_SCALEVIEWPORTEXT.rawValue: // 0x0412
            self = .scaleViewportExt(try META_SCALEVIEWPORTEXT(dataStream: &dataStream))
        case RecordType.META_EXCLUDECLIPRECT.rawValue: // 0x0416
            self = .excludeClipRect(try META_EXCLUDECLIPRECT(dataStream: &dataStream))
        case RecordType.META_INTERSECTCLIPRECT.rawValue: // 0x0416
            self = .intersectClipRect(try META_INTERSECTCLIPRECT(dataStream: &dataStream))
        case RecordType.META_ELLIPSE.rawValue: // 0x0418
            self = .ellipse(try META_ELLIPSE(dataStream: &dataStream))
        case RecordType.META_FLOODFILL.rawValue: // 0x0419
            self = .floodFill(try META_FLOODFILL(dataStream: &dataStream))
        case RecordType.META_RECTANGLE.rawValue: // 0x041B
            self = .rectangle(try META_RECTANGLE(dataStream: &dataStream))
        case RecordType.META_SETPIXEL.rawValue: // 0x041F
            self = .setPixel(try META_SETPIXEL(dataStream: &dataStream))
        case RecordType.META_FRAMEREGION.rawValue: // 0x0429
            self = .frameRegion(try META_FRAMEREGION(dataStream: &dataStream))
        case RecordType.META_ANIMATEPALETTE.rawValue: // 0x0436
            self = .animatePalette(try META_ANIMATEPALETTE(dataStream: &dataStream))
        case RecordType.META_TEXTOUT.rawValue: // 0x0521
            self = .textOut(try META_TEXTOUT(dataStream: &dataStream))
        case RecordType.META_POLYPOLYGON.rawValue: // 0x0538
            self = .polyPolygon(try META_POLYPOLYGON(dataStream: &dataStream))
        case RecordType.META_EXTFLOODFILL.rawValue: // 0x0548
            self = .extFloodFill(try META_EXTFLOODFILL(dataStream: &dataStream))
        case RecordType.META_ROUNDRECT.rawValue: // 0x061C
            self = .roundRect(try META_ROUNDRECT(dataStream: &dataStream))
        case RecordType.META_PATBLT.rawValue: // 0x061D
            self = .patBlt(try META_PATBLT(dataStream: &dataStream))
        case RecordType.META_ESCAPE.rawValue: // 0x0626
            self = .escape(try META_ESCAPE(dataStream: &dataStream))
        case RecordType.META_CREATEREGION.rawValue: // 0x06FF
            self = .createRegion(try META_CREATEREGION(dataStream: &dataStream))
        case RecordType.META_ARC.rawValue: // 0x0817
            self = .arc(try META_ARC(dataStream: &dataStream))
        case RecordType.META_PIE.rawValue: // 0x081A
            self = .pie(try META_PIE(dataStream: &dataStream))
        case RecordType.META_CHORD.rawValue: // 0x0830
            self = .chord(try META_CHORD(dataStream: &dataStream))
        case RecordType.META_BITBLT.rawValue: // 0x0922
            self = .bitBlt(try META_BITBLT(dataStream: &dataStream))
        case RecordType.META_DIBBITBLT.rawValue: // 0x0940
            self = .dibBitBlt(try META_DIBBITBLT(dataStream: &dataStream))
        case RecordType.META_EXTTEXTOUT.rawValue: // 0x0A32
            self = .extTextOut(try META_EXTTEXTOUT(dataStream: &dataStream))
        case RecordType.META_STRETCHBLT.rawValue: // 0x0B41
            self = .stretchBlt(try META_STRETCHBLT(dataStream: &dataStream))
        case RecordType.META_DIBSTRETCHBLT.rawValue: // 0x0B41
            self = .dibStretchBlt(try META_DIBSTRETCHBLT(dataStream: &dataStream))
        case RecordType.META_SETDIBTODEV.rawValue: // 0x0D33
            self = .setDibToDev(try META_SETDIBTODEV(dataStream: &dataStream))
        case RecordType.META_STRETCHDIB.rawValue: // 0x0F43
            self = .stretchDib(try META_STRETCHDIB(dataStream: &dataStream))
        case RecordType.META_EOF.rawValue:
            self = .eof(try META_EOF(dataStream: &dataStream))
        default:
            fatalError("NYI: \(recordFunction.hexString)")
        }
    }
}
