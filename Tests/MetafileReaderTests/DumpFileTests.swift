import XCTest
@testable import MetafileReader

final class DumpFileTests: XCTestCase {
    func testDumpWmf() throws {
        for (name, fileExtension) in [
            ("dtformats_grid", "wmf"),
            ("libwmf_2doorvan", "wmf"),
            ("libwmf_anim0002", "wmf"),
            ("libwmf_ant", "wmf"),
            ("libwmf_arrow01", "wmf"),
            ("libwmf_cell", "wmf"),
            ("libwmf_Eg", "wmf"),
            ("libwmf_fjftest", "wmf"),
            ("libwmf_formula1", "wmf"),
            ("libwmf_formula2", "wmf"),
            ("libwmf_formula3", "wmf"),
            ("libwmf_formula4", "wmf"),
            ("libwmf_fulltest", "wmf"),
            ("libwmf_p0000001", "wmf"),
            ("libwmf_p0000016", "wmf"),
            ("libwmf_sample", "wmf"),
            ("libwmf_sample2", "wmf"),
            ("libwmf_text", "wmf"),
            ("libreoffice_problemcausing_200000620005A6F10001B215A12FD2C0", "wmf"),
            ("libreoffice_47243_wmf1", "wmf"),
            ("libreoffice_astable", "wmf"),
            ("libreoffice_B_DNA", "wmf"),
            ("libreoffice_dbggfx0", "wmf"),
            ("libreoffice_dbggfx4", "wmf"),
            ("libreoffice_image1", "wmf"),
            ("libreoffice_image1 (1)", "wmf"),
            ("libreoffice_image81", "wmf"),
            ("libreoffice_tdf104028_pg2_image", "wmf"),
            ("libreoffice_ETO_PDY", "wmf"),
            ("libreoffice_tdf39894", "wmf"),
            ("libreoffice_visio_import_source", "wmf"),
            ("libreoffice_OSS-Artwork-stackframe", "wmf")
            ("wmf2canvas_1", "wmf"),
            ("wmf2canvas_2", "wmf"),
            ("wmf2canvas_3", "wmf"),
            ("wmf2canvas_4", "wmf"),
            ("wmf2canvas_5", "wmf"),
            ("wmf2canvas_image21", "wmf"),
            ("wmf2canvas_image22", "wmf"),
            ("wmf2canvas_image25", "wmf"),
            ("wmf2canvas_image26", "wmf"),
            ("wmf2canvas_image27", "wmf"),
            ("wmf2canvas_image28", "wmf"),
            ("wmf2canvas_image29", "wmf"),
            ("wmf2canvas_image32", "wmf"),
            ("wmf2canvas_image33", "wmf"),
            ("wmf2canvas_image34", "wmf"),
            ("wmf2canvas_sample", "wmf"),
            ("wmf2canvas_thistlegirl_wmfsample", "wmf"),
            ("wmf2canvas_tiger", "wmf"),
            ("wmf2canvas_tiger2", "wmf"),
            ("ImageMagick_clock", "wmf"),
            ("ImageMagick_wizard", "wmf"),
            ("WMFPreview_bird", "wmf"),
            ("WMFPreview_cyclist", "wmf"),
            ("WMFPreview_duck", "wmf"),
            ("WMFPreview_eagle", "wmf"),
            ("WMFPreview_owl", "wmf"),
            ("WMFPreview_tucan", "wmf"),
            ("WMFPreview_wmftest", "wmf"),
            ("umbrella2", "wmf"),
            ("wmf2png_world", "wmf"),
            ("A20010", "WMF"),
            ("A20011", "WMF"),
            ("A20018", "WMF"),
            ("A20019", "WMF"),
            ("B20061", "WMF"),
            ("B20080", "WMF"),
            ("B20081", "WMF"),
            ("B20082", "WMF"),
            ("B20083", "WMF"),
            ("B20084", "WMF"),
            ("B20085", "WMF"),
            ("B20087", "WMF"),
            ("B20088", "WMF"),
            ("B20089", "WMF"),
            ("B20090", "WMF"),
            ("B20091", "WMF"),
            ("B20092", "WMF"),
            ("B20093", "WMF"),
            ("B20094", "WMF"),
            ("B20095", "WMF"),
            ("B20096", "WMF"),
            ("B20097", "WMF"),
            ("B20098", "WMF"),
            ("B20099", "WMF"),
            ("APPLE01", "WMF"),
            ("BABY01", "WMF"),
            ("BABY02", "WMF"),
            ("BEAR01", "WMF"),
            ("BIRD01", "WMF"),
            ("BOY01", "WMF"),
            ("BOY02", "WMF"),
            ("BOY04", "WMF"),
            ("BOY05", "WMF"),
            ("BOY06", "WMF"),
            ("BOY07", "WMF"),
            ("BOY08", "WMF"),
            ("BUBBLE01", "WMF"),
            ("BUBBLE02", "WMF"),
            ("BUTFLY01", "WMF"),
            ("CAMEL01", "WMF"),
            ("MAN28", "WMF"),
            ("MAN35", "WMF"),
            ("S21642", "WMF"),
            ("online_abydos", "wmf"),
            ("online_clock", "wmf"),
            ("online_example", "wmf"),
            ("online_example1", "wmf"),
            ("online_sample (1)", "wmf"),
            ("online_sample", "wmf"),
            ("online_wizard", "wmf"),
            ("online_A_DNA_1", "wmf"),
            ("online_A_DNA", "wmf"),
            ("online_B_DNA", "wmf"),
            ("online_dT_dA_dT", "wmf"),
            ("online_poly_A", "wmf"),
            ("online_polydAdT", "wmf"),
            ("runtime-assets_telescope_01", "wmf"),
        ] {
            let data = try getData(name: name, fileExtension: fileExtension)
            let file = try WmfFile(data: data)
            try file.enumerateRecords { record in
                if case .escape = record {
                    print("META_ESCAPE")
                } else if case .dibBitBlt = record {
                    print("META_DIBBITBLT")
                } else if case .dibStretchBlt = record {
                    print("META_DIBSTRECTCHBLT")
                } else if case .stretchDib = record {
                    print("META_STRETCHDIB")
                } else {
                    //print(record)
                }
                
                return .continue
            }
        }
    }

    static var allTests = [
        ("testDumpWmf", testDumpWmf),
    ]
}
