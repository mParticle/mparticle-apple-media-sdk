import XCTest
@testable import mParticle_Apple_Media_SDK

class mParticle_Apple_MediaTests: XCTestCase, MPListenerProtocol {
    var coreSDK: MParticle?
    var mediaSession: MPMediaSession?
    var mediaEventHandler: ((MPMediaEvent) -> Void)?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreSDK = MParticle.sharedInstance()
        mediaSession = MPMediaSession(coreSDK: coreSDK, title: "foo title", mediaContentId: "12345", duration: 90000, contentType: .video, streamType: .onDemand)
        MPListenerController.sharedInstance().addSdkListener(self)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        MPListenerController.sharedInstance().removeSdkListener(self)
        mediaEventHandler = nil
    }

    func testLogMediaSessionStart() {
        mediaSession?.logMediaSessionStart()
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .sessionStart)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogMediaSessionEnd() {
        mediaSession?.logMediaSessionEnd()
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .sessionEnd)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogMediaContentEnd() {
        mediaSession?.logMediaContentEnd()
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .contentEnd)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogPlay() {
        mediaSession?.logPlay()
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .play)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogPause() {
        mediaSession?.logPause()
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .pause)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogSeekStart() {
        mediaSession?.logSeekStart(position: 20000)
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .seekStart)
            XCTAssertEqual(event.seekPosition, 20000)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogSeekEnd() {
        mediaSession?.logSeekEnd(position: 30000)
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .seekEnd)
            XCTAssertEqual(event.seekPosition, 30000)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdStart() {
        let adContent = MPMediaAdContent(title: "foo ad title", id: "12345")
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .adStart)
            XCTAssertEqual(event.adContent, adContent)
            expectation.fulfill()
        }
        mediaSession?.logAdStart(adContent: adContent)
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdEnd() {
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .adEnd)
            expectation.fulfill()
        }
        mediaSession?.logAdEnd()
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdClick() {
        mediaSession?.logAdClick()
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .adClick)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdSkip() {
        mediaSession?.logAdSkip()
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .adSkip)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdBreakStart() {
        let adBreak = MPMediaAdBreak(title: "foo adbreak title", id: "12345")
        mediaSession?.logAdBreakStart(adBreak: adBreak)
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .adBreakStart)
            XCTAssertEqual(event.adBreak, adBreak)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdBreakEnd() {
        mediaSession?.logAdBreakEnd()
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .adBreakEnd)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogSegmentStart() {
        let segment = MPMediaSegment(title: "foo segment title", index: 3, duration: 30000)
        mediaSession?.logSegmentStart(segment: segment)
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .segmentStart)
            XCTAssertEqual(event.segment, segment)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogSegmentEnd() {
        mediaSession?.logSegmentEnd()
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .segmentEnd)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogSegmentSkip() {
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .segmentSkip)
            expectation.fulfill()
        }
        mediaSession?.logSegmentSkip()
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogPlayheadPosition() {
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .updatePlayheadPosition)
            XCTAssertEqual(event.playheadPosition, 45000)
            expectation.fulfill()
        }
        mediaSession?.logPlayheadPosition(position: 45000)
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogQoS() {
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventType, .updateQoS)
            XCTAssertEqual(event.qos?.bitRate, 80)
            XCTAssertEqual(event.qos?.droppedFrames, 7)
            XCTAssertEqual(event.qos?.fps, 60)
            XCTAssertEqual(event.qos?.startupTime, 2000)
            expectation.fulfill()
        }
        let qos = MPMediaQoS()
        qos.bitRate = 80
        qos.droppedFrames = 7
        qos.fps = 60
        qos.startupTime = 2000
        mediaSession?.logQoS(metadata: qos)
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func onAPICalled(_: String, stackTrace: [Any], isExternal: Bool, objects: [Any]?) {
        var firstObj: Any
        guard let objects = objects else {
            XCTAssert(false); return
        }
        if (objects.count > 0) {
            firstObj = objects[0]
            guard let first = firstObj as? MPMediaEvent else {
                // Ignore non-media events
                return
            }

            guard let handler = self.mediaEventHandler else {
                XCTAssert(false); return
            }

            handler(first)
        }
    }
}
