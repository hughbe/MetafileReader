@testable import MetafileReader
import XCTest

final class MetafileTests: XCTestCase {
    func testExample() throws {
        do {
            let data = try getData(name: "online_sample", fileExtension: "wmf")
            let file = try WmfFile(data: data)
            try file.enumerateRecords { record in
                return .continue
            }
        }
        do {
            let data = try getData(name: "online_example", fileExtension: "wmf")
            let file = try WmfFile(data: data)
            try file.enumerateRecords { record in
                return .continue
            }
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
