import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RazeColorTests.allTests),
        testcase(RazeNetworkingTests.allTests)
         
    ]
}
#endif
