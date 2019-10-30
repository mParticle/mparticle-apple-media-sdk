import XCTest
@testable import mParticle_Apple_Media_SDK

class mParticle_Apple_MediaTests: XCTestCase, MPListenerProtocol {
    var coreSDK: MParticle?
    var mediaSession: MPMediaSession?
    var mediaEventHandler: ((MPMediaEvent) -> Void)?
    var eventHandler: ((MPEvent) -> Void)?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreSDK = MParticle.sharedInstance()
        mediaSession = MPMediaSession(coreSDK: coreSDK, mediaContentId: "12345", title: "foo title", duration: 90000, contentType: .video, streamType: .onDemand)
        MPListenerController.sharedInstance().addSdkListener(self)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        MPListenerController.sharedInstance().removeSdkListener(self)
        mediaEventHandler = nil
    }
    
    func testInits() {
        XCTAssertNotNil(mediaSession)
        
        XCTAssertFalse(mediaSession!.logMPEvents, "logMPEvents should default to false")
        XCTAssertTrue(mediaSession!.logMediaEvents, "logMediaEvent should default to true")
        XCTAssertEqual(mediaSession?.mediaContentId, "12345")
        XCTAssertEqual(mediaSession?.title, "foo title")
        XCTAssertEqual(mediaSession?.duration?.intValue, 90000)
        XCTAssertEqual(mediaSession?.contentType, .video)
        XCTAssertEqual(mediaSession?.streamType, .onDemand)
        
        let mediaEvent1 = mediaSession?.makeMediaEvent(name: .play)
        
        XCTAssertEqual(mediaEvent1?.mediaEventName, .play)
        XCTAssertEqual(mediaEvent1?.mediaContentId, "12345")
        XCTAssertEqual(mediaEvent1?.mediaContentTitle, "foo title")
        XCTAssertEqual(mediaEvent1?.duration?.intValue, 90000)
        XCTAssertEqual(mediaEvent1?.contentType, .video)
        XCTAssertEqual(mediaEvent1?.streamType, .onDemand)

        mediaSession = MPMediaSession(coreSDK: coreSDK, mediaContentId: "678", title: "foo title 2", duration: 80000, contentType: .audio, streamType: .liveStream, logMPEvents: true, logMediaEvents: false)

        XCTAssertTrue(mediaSession!.logMPEvents, "logMPEvents should have been set to true")
        XCTAssertFalse(mediaSession!.logMediaEvents, "logMediaEvent should have been set to false")
        XCTAssertEqual(mediaSession?.mediaContentId, "678")
        XCTAssertEqual(mediaSession?.title, "foo title 2")
        XCTAssertEqual(mediaSession?.duration?.intValue, 80000)
        XCTAssertEqual(mediaSession?.contentType, .audio)
        XCTAssertEqual(mediaSession?.streamType, .liveStream)
        
        let mediaEvent2 = mediaSession?.makeMediaEvent(name: .play)
        
        XCTAssertEqual(mediaEvent2?.mediaEventName, .play)
        XCTAssertEqual(mediaEvent2?.mediaContentId, "678")
        XCTAssertEqual(mediaEvent2?.mediaContentTitle, "foo title 2")
        XCTAssertEqual(mediaEvent2?.duration?.intValue, 80000)
        XCTAssertEqual(mediaEvent2?.contentType, .audio)
        XCTAssertEqual(mediaEvent2?.streamType, .liveStream)
    }

    func testLogMediaSessionStart() {
        mediaSession?.logMediaSessionStart()
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .sessionStart)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLogMediaSessionStartAlternet() {
        mediaSession = MPMediaSession(coreSDK: coreSDK, mediaContentId: "12345", title: "foo title", duration: 90000, contentType: .video, streamType: .onDemand, logMPEvents: true, logMediaEvents: false)

        mediaSession?.logMediaSessionStart()
        let expectation = self.expectation(description: "async work")
        self.eventHandler = { (event: MPEvent) -> Void in
            XCTAssertEqual(event.name, MPMediaEventNameString.sessionStart.rawValue)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogMediaSessionEnd() {
        mediaSession?.logMediaSessionEnd()
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .sessionEnd)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogMediaContentEnd() {
        mediaSession?.logMediaContentEnd()
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .contentEnd)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogPlay() {
        mediaSession?.logPlay()
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .play)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogPause() {
        mediaSession?.logPause()
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .pause)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogSeekStart() {
        mediaSession?.logSeekStart(position: 20000)
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .seekStart)
            XCTAssertEqual(event.seekPosition, 20000)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogSeekEnd() {
        mediaSession?.logSeekEnd(position: 30000)
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .seekEnd)
            XCTAssertEqual(event.seekPosition, 30000)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdStart() {
        let adContent = MPMediaAdContent(title: "foo ad title", id: "12345")
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adStart)
            XCTAssertEqual(event.adContent, adContent)
            expectation.fulfill()
        }
        mediaSession?.logAdStart(adContent: adContent)
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdEnd() {
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adEnd)
            expectation.fulfill()
        }
        mediaSession?.logAdEnd()
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdClick() {
        mediaSession?.logAdClick()
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adClick)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdSkip() {
        mediaSession?.logAdSkip()
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adSkip)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdBreakStart() {
        let adBreak = MPMediaAdBreak(title: "foo adbreak title", id: "12345")
        mediaSession?.logAdBreakStart(adBreak: adBreak)
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adBreakStart)
            XCTAssertEqual(event.adBreak, adBreak)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogAdBreakEnd() {
        mediaSession?.logAdBreakEnd()
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adBreakEnd)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogSegmentStart() {
        let segment = MPMediaSegment(title: "foo segment title", index: 3, duration: 30000)
        mediaSession?.logSegmentStart(segment: segment)
                let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .segmentStart)
            XCTAssertEqual(event.segment, segment)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogSegmentEnd() {
        mediaSession?.logSegmentEnd()
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .segmentEnd)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogSegmentSkip() {
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .segmentSkip)
            expectation.fulfill()
        }
        mediaSession?.logSegmentSkip()
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogPlayheadPosition() {
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .updatePlayheadPosition)
            XCTAssertEqual(event.playheadPosition, 45000)
            expectation.fulfill()
        }
        mediaSession?.logPlayheadPosition(position: 45000)
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogQoS() {
        let expectation = self.expectation(description: "async work")
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .updateQoS)
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
        let firstObj: Any
        guard let objects = objects else {
            XCTAssert(false); return
        }
        if (objects.count > 0) {
            firstObj = objects[0]
            
            if let first = firstObj as? MPMediaEvent {
                guard let mediaHandler = self.mediaEventHandler else {
                    return
                }

                mediaHandler(first)
            }
            
            if let first = firstObj as? MPEvent {
                guard let eventHandler = self.eventHandler else {
                    return
                }

                eventHandler(first)
            }
        }
    }
}
