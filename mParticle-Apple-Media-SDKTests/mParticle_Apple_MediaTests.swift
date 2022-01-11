import XCTest
@testable import mParticle_Apple_Media_SDK

private let defaultTimeout = 10.0

class mParticle_Apple_MediaTests: XCTestCase, MPListenerProtocol {
    var coreSDK: MParticle?
    var mediaSession: MPMediaSession?
    
    private var _mediaEventExpectation: XCTestExpectation?
    private var _mediaEventHandler: ((MPMediaEvent) -> Void)?
    var mediaEventHandler: ((MPMediaEvent) -> Void)? {
        set {
            guard let mediaHandler = newValue else {
                _mediaEventHandler = nil
                return
            }
            self._mediaEventHandler = newValue
            self._mediaEventExpectation = self.expectation(description: "MediaSession event listener")
            self.mediaSession?.mediaEventListener = { (event: MPMediaEvent) -> Void in
                XCTAssertEqual(event.messageType, MPMessageType.media)
                mediaHandler(event)
                self._mediaEventExpectation?.fulfill()
                
            }
        }
        get {
            return _mediaEventHandler
        }
    }
    private var _coreMediaEventExpectation: XCTestExpectation?
    private var _coreMediaEventHandler: ((MPMediaEvent) -> Void)? = {(event: MPMediaEvent) -> Void in XCTFail("Unexpected MediaEvent sent to Core")
    }
    var coreMediaEventHandler: ((MPMediaEvent) -> Void)? {
        set {
            guard let mediaEventHandler = newValue else {
                _coreMediaEventHandler = nil
                return
            }
            self._coreMediaEventExpectation = self.expectation(description: "Core SDK MediaEvent Listener")
            self._coreMediaEventHandler = { (event: MPMediaEvent) -> Void in
                XCTAssertEqual(event.messageType, MPMessageType.media)
                mediaEventHandler(event)
                self._coreMediaEventExpectation?.fulfill()
            }
        }
        get {
            return self._coreMediaEventHandler
        }
    }
    
    private var _coreMPEventExpectation: XCTestExpectation?
    private var _coreMPEventHandler: ((MPEvent) -> Void)? = {(event: MPEvent) -> Void in XCTFail("Unexpected MPEvent sent to Core")
    }
    var coreMPEventHandler: ((MPEvent) -> Void)? {
        set {
            guard let mpEventHandler = newValue else {
                self._coreMPEventHandler = nil
                return
            }
            self._coreMPEventExpectation = self.expectation(description: "Core SDK MPEvent Listener")
                self._coreMPEventHandler = { (event: MPEvent) -> Void in
                    XCTAssertEqual(event.type, MPEventType.media)
                    XCTAssertEqual(event.messageType, MPMessageType.event)
                    mpEventHandler(event)
                    self._coreMPEventExpectation?.fulfill()
                }
        }
        get {
            return self._coreMPEventHandler
        }
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreSDK = MParticle.sharedInstance()
        mediaSession = MPMediaSession(coreSDK: coreSDK, mediaContentId: "12345", title: "foo title", duration: 90000, contentType: .video, streamType: .onDemand, logMPEvents: false, logMediaEvents: true, completeLimit: 90, testing: true)
        MPListenerController.sharedInstance().addSdkListener(self)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        MPListenerController.sharedInstance().removeSdkListener(self)
        mediaEventHandler = nil
        coreMPEventHandler = nil
        coreMediaEventHandler = nil
    }
    
    func testInits() {
        XCTAssertNotNil(mediaSession)
        
        XCTAssertTrue(mediaSession!.logMediaEvents, "logMediaEvent should be set to true")
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

        mediaSession = MPMediaSession(coreSDK: coreSDK, mediaContentId: "678", title: "foo title 2", duration: 80000, contentType: .audio, streamType: .liveStream, logMPEvents: true, logMediaEvents: false, completeLimit: 90, testing: true)

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
         
        let customName = "some custom name"
        let customMediaEvent = MPMediaEvent(customName: customName, session: mediaSession!, options: nil)
        let customMPEvent = customMediaEvent?.toMPEvent()
        
        XCTAssertEqual(customMediaEvent?.customEventName, customName)
        XCTAssertEqual(customMediaEvent?.mediaEventName, .custom)
        XCTAssertEqual(customMPEvent?.name, customName)
        XCTAssertEqual(customMPEvent?.type, .media)
    }
    
    func testLogMediaSessionStart() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .sessionStart)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler

        mediaSession?.logMediaSessionStart()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }
    
    func testLogMediaSessionStartWithOptions() {
        let option = Options();
        let customAtt = [
            "testKey": "testValue"
        ]
        option.customAttributes = customAtt
        option.currentPlayheadPosition = 6000;
        
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .sessionStart)
            XCTAssertEqual((event.customAttributes?["testKey"] as? String), customAtt["testKey"])
            XCTAssertEqual(event.playheadPosition, 6000)
            
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logMediaSessionStart(options: option)
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }
    
    func testLogMediaSessionStartAlternet() {
        mediaSession = MPMediaSession(coreSDK: coreSDK, mediaContentId: "12345", title: "foo title", duration: 90000, contentType: .video, streamType: .onDemand, logMPEvents: true, logMediaEvents: false, completeLimit: 90, testing: true)
        
        self.mediaEventHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .sessionStart)
        }
        
        self.coreMPEventHandler = { (event: MPEvent) -> Void in
            XCTAssertEqual(event.name, MPMediaEventNameString.sessionStart.rawValue)
        }
        
        mediaSession?.logMediaSessionStart()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogMediaSessionEnd() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .sessionEnd)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logMediaSessionEnd()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogMediaContentEnd() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .contentEnd)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logMediaContentEnd()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogPlay() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .play)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logPlay()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }
    
    func testLogPlayWithExistingPlayhead() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .play)
            XCTAssertEqual(event.playheadPosition, 1400)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.currentPlayheadPosition = 1400
        mediaSession?.logPlay()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }
    
    func testLogPlayWithOptions() {
        let options = Options()
        options.currentPlayheadPosition = 45000
        
        mediaSession?.currentPlayheadPosition = 40
        
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .play)
            XCTAssertEqual(event.playheadPosition, 45000)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logPlay(options: options)
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogPause() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .pause)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logPause()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }
    
    func testLogPauseWithOptions() {
        let options = Options()
        options.currentPlayheadPosition = 48000
        options.customAttributes = ["test": "tester"]

        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .pause)
            XCTAssertEqual(event.playheadPosition, 48000)
            XCTAssertEqual(event.customAttributes?["test"] as? String, "tester")
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logPause(options: options)
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogSeekStart() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .seekStart)
            XCTAssertEqual(event.seekPosition, 20000)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logSeekStart(position: 20000)
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogSeekEnd() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .seekEnd)
            XCTAssertEqual(event.seekPosition, 30000)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logSeekEnd(position: 30000)
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogAdStart() {
        let adContent = MPMediaAdContent(title: "foo ad title", id: "12345")
        adContent.placement = "first"
        adContent.position = 0
        
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adStart)
            XCTAssertEqual(event.adContent, adContent)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logAdStart(adContent: adContent)
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogAdEnd() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adEnd)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logAdEnd()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogAdClick() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adClick)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logAdClick()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogAdSkip() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adSkip)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logAdSkip()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogAdBreakStart() {
        let adBreak = MPMediaAdBreak(title: "foo adbreak title", id: "12345")
        adBreak.duration = 50
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adBreakStart)
            XCTAssertEqual(event.adBreak, adBreak)
            XCTAssertEqual(event.adBreak?.duration, 50)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logAdBreakStart(adBreak: adBreak)
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogAdBreakEnd() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .adBreakEnd)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logAdBreakEnd()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogSegmentStart() {
        let segment = MPMediaSegment(title: "foo segment title", index: 3, duration: 30000)
        
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .segmentStart)
            XCTAssertEqual(event.segment, segment)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logSegmentStart(segment: segment)
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogSegmentEnd() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .segmentEnd)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logSegmentEnd()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogSegmentSkip() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .segmentSkip)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logSegmentSkip()
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogPlayheadPosition() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .updatePlayheadPosition)
            XCTAssertEqual(event.playheadPosition, 45000)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        mediaSession?.logPlayheadPosition(position: 45000)
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testLogQoS() {
        let mediaHandler = { (event: MPMediaEvent) -> Void in
            XCTAssertEqual(event.mediaEventName, .updateQoS)
            XCTAssertEqual(event.qos?.bitRate, 80)
            XCTAssertEqual(event.qos?.droppedFrames, 7)
            XCTAssertEqual(event.qos?.fps, 60)
            XCTAssertEqual(event.qos?.startupTime, 2000)
        }
        self.mediaEventHandler = mediaHandler
        self.coreMediaEventHandler = mediaHandler
        
        let qos = MPMediaQoS()
        qos.bitRate = 80
        qos.droppedFrames = 7
        qos.fps = 60
        qos.startupTime = 2000
        mediaSession?.logQoS(metadata: qos)
        self.waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func onAPICalled(_: String, stackTrace: [Any], isExternal: Bool, objects: [Any]?) {
        let firstObj: Any
        guard let objects = objects else {
            XCTAssert(false); return
        }
        if (objects.count > 0) {
            firstObj = objects[0]
            
            if let first = firstObj as? MPMediaEvent {
                guard let mediaHandler = self.coreMediaEventHandler else {
                    return
                }

                mediaHandler(first)
            }
            
            if let first = firstObj as? MPEvent {
                guard let eventHandler = self.coreMPEventHandler else {
                    return
                }

                eventHandler(first)
            }
        }
    }
}
