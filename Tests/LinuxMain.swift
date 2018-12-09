import XCTest

import ExtraBrainTests
import ExtraBrainCLITests

var tests = [XCTestCaseEntry]()
tests += ExtraBrainTests.allTests()
tests += ExtraBrainCLITests.allTests()
XCTMain(tests)
