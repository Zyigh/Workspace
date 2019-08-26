import XCTest

import workspaceTests

var tests = [XCTestCaseEntry]()
tests += workspaceTests.allTests()
XCTMain(tests)