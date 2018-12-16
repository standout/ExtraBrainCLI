import XCTest
import class Foundation.Bundle

final class ExtraBrainCLITests: XCTestCase {
    func testTestInput() throws {
        XCTAssertEqual(try outputOfBinary(withArguments: ["logout"]), "Goodbye.\n")
    }

    func testListProjects() throws {
        let expected = """
        | ID | Name              |
        |:---|:------------------|
        | 1  | Example project 1 |
        | 2  | Example project 2 |
        | 3  | Example project 3 |
        | 4  | Example project 4 |
        | 5  | Example project 5 |

        """
        XCTAssertEqual(try outputOfBinary(withArguments: ["projects", "ls"]), expected)
    }

    func testListTasks() throws {
        let expected = """
        | ID | Title          |
        |:---|:---------------|
        | 1  | Example task 1 |
        | 2  | Example task 2 |
        | 3  | Example task 3 |
        | 4  | Example task 4 |
        | 5  | Example task 5 |

        """
        XCTAssertEqual(try outputOfBinary(withArguments: ["tasks", "ls"]), expected)
    }

    func testShowCurrentTask() throws {
        let expected = """
        | ID | Title          |
        |:---|:---------------|
        | 1  | Example task 1 |

        """
        XCTAssertEqual(try outputOfBinary(withArguments: ["tasks", "current"]), expected)
    }

    func testTimeLogsForToday() throws {
        let expected = """
        | ID | Description | Project                  | Task                       | Duration |
        |:---|:------------|:-------------------------|:---------------------------|:---------|
        | 1  | The meeting | (1233) Example project 1 | (12312) Project management | 01h 32m  |
        | 2  | The meeting | (1233) Example project 1 | (12312) Project management | 01h 33m  |
        | 3  | The meeting | (1233) Example project 1 | (12312) Project management | 01h 34m  |
        | 4  | The meeting | (1233) Example project 1 | (12312) Project management | 01h 35m  |
        | 5  | The meeting | (1233) Example project 1 | (12312) Project management | 01h 36m  |
        |    | Total       |                          |                            | 07h 50m  |

        """
        XCTAssertEqual(try outputOfBinary(withArguments: ["time", "ls"]), expected)
    }

    func testAddTimeLog() throws {
        let expected = """
        | ID | Description | Project | Task | Duration |
        |:---|:------------|:--------|:-----|:---------|
        | 1  | The meeting |         |      | 01h 23m  |

        """
        XCTAssertEqual(try outputOfBinary(withArguments: ["time", "add", "--project", "1233", "1h23m", "The meeting"]), expected)
    }

    func testStartTimeLog() throws {
        let expected = """
        | ID | Description | Project | Task | Duration |
        |:---|:------------|:--------|:-----|:---------|
        | 1  | The meeting |         |      | 00m      |

        """
        XCTAssertEqual(try outputOfBinary(withArguments: ["time", "start", "--project", "1233", "The meeting"]), expected)
    }


    static var allTests = [
        ("testTestInput", testTestInput),
    ]

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    func outputOfBinary(withArguments arguments: [String] = [String]()) throws -> String {
        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            fatalError("Only available on macOS 10.13 and above")
        }

        let binary = productsDirectory.appendingPathComponent("ExtraBrainCLI")

        let process = Process()
        process.executableURL = binary
        process.arguments = arguments

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else {
            fatalError("No string was generated at all")
        }

        return output
    }
}
