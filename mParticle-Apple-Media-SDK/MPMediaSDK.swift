import UIKit
import mParticle_Apple_SDK

let MediaAttributeKeysMediaSessionId = "media_session_id"

let MediaAttributeKeysPlayheadPosition = "playhead_position"

//MediaConent
let MediaAttributeKeysTitle = "content_title"
let MediaAttributeKeysContentId = "content_id"
let MediaAttributeKeysDuration = "content_duration"
let MediaAttributeKeysStreamType = "stream_type"
public enum MPMediaStreamTypeString: String, RawRepresentable {
    case liveStream = "liveStream"
    case onDemand = "onDemand"
}
let MediaAttributeKeysContentType = "content_type"
public enum MPMediaContentTypeString: String, RawRepresentable {
    case video = "video"
    case audio = "audio"
}

//Seek
let MediaAttributeKeysSeekPosition = "seek_position"

//Buffer
let MediaAttributeKeysBufferDuration = "buffer_duration"
let MediaAttributeKeysBufferPercent = "buffer_percent"
let MediaAttributeKeysBufferPosition = "buffer_position"

//QoS
let MediaAttributeKeysQosBitrate = "qos_bitrate"
let MediaAttributeKeysQosFramesPerSecond = "qos_fps"
let MediaAttributeKeysQosStartupTime = "qos_startup_time"
let MediaAttributeKeysQosDroppedFrames = "qos_dropped_frames"

//MediaAd
let MediaAttributeKeysAdTitle = "ad_content_title"
let MediaAttributeKeysAdDuration = "ad_content_duration"
let MediaAttributeKeysAdId = "ad_content_id"
let MediaAttributeKeysAdAdvertiser = "ad_content_advertiser"
let MediaAttributeKeysAdCampaign = "ad_content_campaign"
let MediaAttributeKeysAdCreative = "ad_content_creative"
let MediaAttributeKeysAdPlacement = "ad_content_placement"
let MediaAttributeKeysAdSiteId = "ad_content_site_id"

//MediaAdBreak
let MediaAttributeKeysAdBreakTitle = "ad_break_title"
let MediaAttributeKeysAdBreakDuration = "ad_break_duration"
let MediaAttributeKeysAdBreakPlaybackTime = "ad_break_playback_time"
let MediaAttributeKeysAdBreakId = "ad_break"

//Segment
let MediaAttributeKeysSegTitle = "segment_title"
let MediaAttributeKeysSegIndex = "segment_index"
let MediaAttributeKeysSegDuration = "segment_duration"

/// __ Time values, like duration and position, should be passed to the Media SDK in **milliseconds** __

// MARK: content type
/// The type of the content, video or audio
@objc public enum MPMediaContentType: Int, RawRepresentable {
    /// Visual video media content
    case video
    /// Sound based content like music or audiobooks
    case audio
}

// MARK: stream type
/// The type of the stream delivering the video or audio data
@objc public enum MPMediaStreamType: Int, RawRepresentable {
    /// User-chosen content that can be started and stopped at any time
    case onDemand
    /// Content where the user can choose the station or stream, but not the playhead position
    case liveStream
}

// MARK: ad break
/// A sequence of ads played as a group
@objc public class MPMediaAdBreak: NSObject {
    @objc public var title: String
    @objc public var id: String
    @objc public var duration: NSNumber?

    @objc public init(title: String, id: String) {
        self.title = title
        self.id = id
    }
}

// MARK: ad content
/// An individual ad
@objc public class MPMediaAdContent: NSObject {
    @objc public var title: String
    @objc public var id: String
    @objc public var duration: NSNumber?
    @objc public var advertiser: String?
    @objc public var campaign: String?
    @objc public var creative: String?
    @objc public var placement: NSNumber?
    @objc public var siteId: String?

    @objc public init(title: String, id: String) {
        self.title = title
        self.id = id
    }
}

// MARK: segment
/// A subset of the content item (e.g. chapter)
@objc public class MPMediaSegment: NSObject {
    @objc public var title: String
    @objc public var index: Int
    @objc public var duration: NSNumber

    @objc public init(title: String, index: Int, duration: NSNumber) {
        self.title = title
        self.index = index
        self.duration = duration
    }
}

// MARK: qos data
/// Quality of Service (QoS) data
@objc public class MPMediaQoS: NSObject {
    /// Start up time to begin playing in milliseconds
    @objc public var startupTime: NSNumber?
    /// Number of dropped frames that have occurred
    @objc public var droppedFrames: NSNumber?
    /// Bit rate in kbps
    @objc public var bitRate: NSNumber?
    /// Frames per second
    @objc public var fps: NSNumber?

    /// Creates QoS object, empty by default
    @objc override public init() {
    }
}

// MARK: session
/// State associated with playback of a single media item
@objc public class MPMediaSession: NSObject {
    @objc public let coreSDK: MParticle
    @objc public let title: String
    @objc public let mediaContentId: String
    @objc public var duration: NSNumber?
    @objc public let contentType: MPMediaContentType
    @objc public let streamType: MPMediaStreamType
    @objc public var currentPlayheadPosition: NSNumber?
    @objc public let logMPEvents: Bool
    @objc public let logMediaEvents: Bool
    @objc public let mediaSessionId: String
    @objc public var adContent: MPMediaAdContent?
    @objc public var adBreak: MPMediaAdBreak?
    @objc public var segment: MPMediaSegment?
    @objc public var mediaEventListener: ((MPMediaEvent)->Void)?

    // MARK: init
    /// Creates a media session object. This does not start a session, you can do so by calling `logMediaSessionStart`.
    /// :returns: a Media session
    /// :param: coreSDK The instance of mParticle core SDK to use
    /// :param: mediaContentId A machine readable identifier representing the current media item
    /// :param: title Session title
    /// :param: duration The playback time of the media content in milliseconds
    /// :param: contentType The type of the media content (e.g. video)
    /// :param: streamType The stream type for the media (e.g. on-demand)
    @objc public init(coreSDK: MParticle?, mediaContentId: String, title: String, duration: NSNumber?, contentType: MPMediaContentType, streamType: MPMediaStreamType) {
        if let coreSDK = coreSDK {
            self.coreSDK = coreSDK
        } else {
            self.coreSDK = MParticle.sharedInstance()
        }

        self.title = title
        self.mediaContentId = mediaContentId
        self.duration = duration
        self.contentType = contentType
        self.streamType = streamType
        self.mediaSessionId = NSUUID().uuidString
        self.logMPEvents = false
        self.logMediaEvents = true
    }
    
    // MARK: init
    /// Creates a media session object. This does not start a session, you can do so by calling `logMediaSessionStart`.
    /// :returns: a Media session
    /// :param: coreSDK The instance of mParticle core SDK to use
    /// :param: mediaContentId A machine readable identifier representing the current media item
    /// :param: title Session title
    /// :param: duration The playback time of the media content in milliseconds
    /// :param: contentType The type of the media content (e.g. video)
    /// :param: streamType The stream type for the media (e.g. on-demand)
    @objc public init(coreSDK: MParticle?, mediaContentId: String, title: String, duration: NSNumber?, contentType: MPMediaContentType, streamType: MPMediaStreamType, logMPEvents: Bool, logMediaEvents: Bool) {
        if let coreSDK = coreSDK {
            self.coreSDK = coreSDK
        } else {
            self.coreSDK = MParticle.sharedInstance()
        }

        self.title = title
        self.mediaContentId = mediaContentId
        self.duration = duration
        self.contentType = contentType
        self.streamType = streamType
        self.mediaSessionId = NSUUID().uuidString
        self.logMPEvents = logMPEvents
        self.logMediaEvents = logMediaEvents
    }

    // MARK: factory method
    /// Creates an event using the state of the media session. (This method is called internally by the Media SDK.)
    /// :returns: a Media event
    /// :param: type the media event type for the event
    @objc func makeMediaEvent(name: MPMediaEventName) -> MPMediaEvent {
        let mediaEvent = MPMediaEvent(name: name, title: self.title, mediaContentId: self.mediaContentId, duration: self.duration, contentType: self.contentType, streamType: self.streamType, mediaSessionId: self.mediaSessionId)
        return mediaEvent!
    }
    
    /// Attempt to log the event with the Core SDK
    @objc func logEvent(mediaEvent: MPMediaEvent) {
        if let eventListener = self.mediaEventListener {
            eventListener(mediaEvent)
        }
        
        if self.logMediaEvents {
            coreSDK.logEvent(mediaEvent)
        }
        
        //We never want to log UpdatePlayheadPosition Media Events, they are far to high volume to be logging to our server
        if self.logMPEvents && (mediaEvent.mediaEventName != .updatePlayheadPosition) {
            let event = mediaEvent.toMPEvent()
            coreSDK.logEvent(event)
        }
    }

    /// Begins a media session
    @objc public func logMediaSessionStart() {
        let mediaEvent = self.makeMediaEvent(name: .sessionStart)
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Ends the media session
    @objc public func logMediaSessionEnd() {
        let mediaEvent = self.makeMediaEvent(name: .sessionEnd)
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Denotes that the playhead position has reached the final position in the content
    @objc public func logMediaContentEnd() {
        let mediaEvent = self.makeMediaEvent(name: .contentEnd)
        self.logEvent(mediaEvent: mediaEvent)
    }

    // MARK: play/pause
    /// Logs a play event. This should be called when the user has clicked the play button or autoplay takes place.
    @objc public func logPlay() {
        let mediaEvent = self.makeMediaEvent(name: .play)
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Logs a pause event. This can be due to a system generated event or user action.
    @objc public func logPause() {
        let mediaEvent = self.makeMediaEvent(name: .pause)
        self.logEvent(mediaEvent: mediaEvent)
    }

    // MARK: seek
    /// Indicates that the user has started scrubbing through the content
    /// :param: position The starting position before the seek began
    @objc public func logSeekStart(position: NSNumber) {
        let mediaEvent = self.makeMediaEvent(name: .seekStart)
        mediaEvent.seekPosition = position
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Indicates that the user has stopped scrubbing through the content
    /// :param: position The ending position where the seek finished
    @objc public func logSeekEnd(position: NSNumber) {
        let mediaEvent = self.makeMediaEvent(name: .seekEnd)
        mediaEvent.seekPosition = position
        self.logEvent(mediaEvent: mediaEvent)
    }

    // MARK: buffer
    /// Records time spent loading remote content for playback
    @objc public func logBufferStart(duration: NSNumber, bufferPercent: NSNumber, position: NSNumber) {
        let mediaEvent = self.makeMediaEvent(name: .bufferStart)
        mediaEvent.bufferDuration = duration
        mediaEvent.bufferPercent = bufferPercent
        mediaEvent.bufferPosition = position
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Indicates that content loading has completed
    @objc public func logBufferEnd(duration: NSNumber, bufferPercent: NSNumber, position: NSNumber) {
        let mediaEvent = self.makeMediaEvent(name: .bufferEnd)
        mediaEvent.bufferDuration = duration
        mediaEvent.bufferPercent = bufferPercent
        mediaEvent.bufferPosition = position
        self.logEvent(mediaEvent: mediaEvent)
    }

    // MARK: ad break
    /// Logs that a sequence of one or more ads has begun
    @objc public func logAdBreakStart(adBreak: MPMediaAdBreak) {
        self.adBreak = adBreak
        self.adBreak?.duration = duration
        let mediaEvent = self.makeMediaEvent(name: .adBreakStart)
        mediaEvent.adBreak = self.adBreak
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Indicates that the ad break is complete
    @objc public func logAdBreakEnd() {
        let mediaEvent = self.makeMediaEvent(name: .adBreakEnd)
        mediaEvent.adBreak = self.adBreak
        coreSDK.logEvent(mediaEvent)
        self.adBreak = nil
    }

    // MARK: ad content
    /// Indicates a given ad creative has started playing
    @objc public func logAdStart(adContent: MPMediaAdContent) {
        self.adContent = adContent
        let mediaEvent = self.makeMediaEvent(name: .adStart)
        mediaEvent.adContent = self.adContent
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Records that the user clicked on the ad
    @objc public func logAdClick() {
        let mediaEvent = self.makeMediaEvent(name: .adClick)
        mediaEvent.adContent = self.adContent
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Records that the user skipped the ad
    @objc public func logAdSkip() {
        let mediaEvent = self.makeMediaEvent(name: .adSkip)
        mediaEvent.adContent = self.adContent
        self.logEvent(mediaEvent: mediaEvent)
        self.adContent = nil
    }

    /// Ends the currently playing ad
    @objc public func logAdEnd() {
        let mediaEvent = self.makeMediaEvent(name: .adEnd)
        mediaEvent.adContent = self.adContent
        coreSDK.logEvent(mediaEvent)
        self.adContent = nil
    }

    // MARK: segment
    /// Log that a new segment has begun
    @objc public func logSegmentStart(segment: MPMediaSegment) {
        self.segment = segment
        let mediaEvent = self.makeMediaEvent(name: .segmentStart)
        mediaEvent.segment = self.segment
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Indicate that the user skipped the current segment
    @objc public func logSegmentSkip() {
        let mediaEvent = self.makeMediaEvent(name: .segmentSkip)
        mediaEvent.segment = self.segment
        self.logEvent(mediaEvent: mediaEvent)
        self.segment = nil
    }

    /// End the current segment
    @objc public func logSegmentEnd() {
        let mediaEvent = self.makeMediaEvent(name: .segmentEnd)
        mediaEvent.segment = self.segment
        self.logEvent(mediaEvent: mediaEvent)
        self.segment = nil
    }

    /// Notify the SDK that the currently playing position of the content has changed
    /// :param: position The updated playhead position in milliseconds
    @objc public func logPlayheadPosition(position: NSNumber) {
        currentPlayheadPosition = position
        let mediaEvent = self.makeMediaEvent(name: .updatePlayheadPosition)
        mediaEvent.playheadPosition = position
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Update Quality of Service (Qos) data
    /// :param: metadata The new QoS data object
    @objc public func logQoS(metadata: MPMediaQoS) {
        let mediaEvent = self.makeMediaEvent(name: .updateQoS)
        mediaEvent.qos = metadata
        self.logEvent(mediaEvent: mediaEvent)
    }
    
    /// Log a custom media event
    @objc public func buildMPEvent(name: String, customAttributes: Dictionary<String, Any>) -> MPEvent {
        let mpEvent = MPEvent.init(name: name, type: .media)
        let mediaEvent = self.makeMediaEvent(name: .play)
        mpEvent?.customAttributes = mediaEvent.getEventAttributes()
                
        return mpEvent!
    }
}

// MARK: event
/// Media Event
/// Typically media events are managed internally by the Media SDK, but you can also create them yourself if needed.
@objc public class MPMediaEvent: MPBaseEvent {

    // all properties are mutable and public, but needs to be a class
    // (rather than struct) in order to inherit from base event

    // MARK: common
    // Properties all or most events will have
    @objc public var mediaEventName: MPMediaEventName
    @objc public var mediaContentTitle: String
    @objc public var mediaContentId: String
    @objc public var duration: NSNumber?
    @objc public var contentType: MPMediaContentType
    @objc public var streamType: MPMediaStreamType
    @objc public var mediaSessionId: String

    // MARK: specialized
    // Properties only applicable to certain kinds of events
    @objc public var adContent: MPMediaAdContent?
    @objc public var segment: MPMediaSegment?
    @objc public var adBreak: MPMediaAdBreak?
    @objc public var seekPosition: NSNumber?
    @objc public var bufferDuration: NSNumber?
    @objc public var bufferPercent: NSNumber?
    @objc public var bufferPosition: NSNumber?
    @objc public var playheadPosition: NSNumber?
    @objc public var qos: MPMediaQoS?

    @objc public override var dictionaryRepresentation: [String: Any] {
        return [:]
    }

    // MARK: init
    @objc public init?(name: MPMediaEventName, title: String, mediaContentId: String, duration: NSNumber?, contentType: MPMediaContentType, streamType: MPMediaStreamType, mediaSessionId: String) {
        self.mediaEventName = name
        self.mediaContentTitle = title
        self.mediaContentId = mediaContentId
        self.duration = duration
        self.contentType = contentType
        self.streamType = streamType
        self.mediaSessionId = mediaSessionId
        super.init(eventType: .media)
    }

    @objc public override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? MPMediaEvent {
            return (self.mediaEventName == object.mediaEventName &&
                self.mediaContentTitle == object.mediaContentTitle &&
                self.mediaContentId == object.mediaContentId &&
                self.duration == object.duration &&
                self.contentType == object.contentType &&
                self.streamType == object.streamType &&
                self.mediaSessionId == object.mediaSessionId &&
                ((self.adContent == nil && object.adContent == nil) || self.adContent == object.adContent) &&
                ((self.segment == nil && object.segment == nil) || self.segment == object.segment) &&
                ((self.adBreak == nil && object.adBreak == nil) || self.adBreak == object.adBreak) &&
                ((self.seekPosition == nil && object.seekPosition == nil) || self.seekPosition == object.seekPosition) &&
                ((self.bufferDuration == nil && object.bufferDuration == nil) || self.bufferDuration == object.bufferDuration) &&
                ((self.bufferPercent == nil && object.bufferPercent == nil) || self.bufferPercent == object.bufferPercent) &&
                ((self.bufferPosition == nil && object.bufferPosition == nil) || self.bufferPosition == object.bufferPosition) &&
                ((self.playheadPosition == nil && object.playheadPosition == nil) || self.playheadPosition == object.playheadPosition) &&
                ((self.qos == nil && object.qos == nil) || self.qos == object.qos))
        } else {
            return false
        }
    }

    @objc public override func copy(with zone: NSZone? = nil) -> Any {
        let object: MPMediaEvent? = MPMediaEvent(name: self.mediaEventName, title: self.mediaContentTitle, mediaContentId: self.mediaContentId, duration: self.duration, contentType: self.contentType, streamType: self.streamType, mediaSessionId: self.mediaSessionId)
        if let object = object {
            object.adContent = self.adContent
            object.segment = self.segment
            object.adBreak = self.adBreak
            object.seekPosition = self.seekPosition
            object.bufferDuration = self.bufferDuration
            object.bufferPercent = self.bufferPercent
            object.bufferPosition = self.bufferPosition
            object.playheadPosition = self.playheadPosition
            object.qos = self.qos
            return object
        } else {
            return MPBaseEvent()
        }
    }

    @objc public func toMPEvent() -> MPEvent {
        let eventNameString = MPMediaEvent.mediaEventTypeString(mediaEventType: self.mediaEventName)

        let mpEvent = MPEvent.init(name: eventNameString, type: .media)
        mpEvent?.customAttributes = self.getEventAttributes()
                
        return mpEvent!
    }
    
    @objc func getSessionAttributes() -> Dictionary<String, Any> {
        var sessionAttributes = Dictionary<String, String>()
        sessionAttributes[MediaAttributeKeysMediaSessionId] = mediaSessionId
        sessionAttributes[MediaAttributeKeysPlayheadPosition] = playheadPosition?.stringValue
        sessionAttributes[MediaAttributeKeysTitle] = mediaContentTitle
        sessionAttributes[MediaAttributeKeysContentId] = mediaContentId
        sessionAttributes[MediaAttributeKeysDuration] = duration?.stringValue
        sessionAttributes[MediaAttributeKeysStreamType] = (streamType == MPMediaStreamType.liveStream) ? MPMediaStreamTypeString.liveStream.rawValue : MPMediaStreamTypeString.onDemand.rawValue
        sessionAttributes[MediaAttributeKeysContentType] = (contentType == MPMediaContentType.video) ? MPMediaContentTypeString.video.rawValue : MPMediaContentTypeString.video.rawValue
        
        return sessionAttributes
    }
    
    @objc func getEventAttributes() -> Dictionary<String, Any> {
        var sessionAttributes = self.getSessionAttributes()
        
        sessionAttributes[MediaAttributeKeysSeekPosition] = seekPosition?.stringValue
        sessionAttributes[MediaAttributeKeysBufferDuration] = bufferDuration?.stringValue
        sessionAttributes[MediaAttributeKeysBufferPercent] = bufferPercent?.stringValue
        sessionAttributes[MediaAttributeKeysBufferPosition] = bufferPosition?.stringValue
        
        if let qos = qos {
            sessionAttributes[MediaAttributeKeysQosBitrate] = qos.bitRate?.stringValue
            sessionAttributes[MediaAttributeKeysQosFramesPerSecond] = qos.fps?.stringValue
            sessionAttributes[MediaAttributeKeysQosStartupTime] = qos.startupTime?.stringValue
            sessionAttributes[MediaAttributeKeysQosDroppedFrames] = qos.droppedFrames?.stringValue
        }
        
        if let adContent = adContent {
            sessionAttributes[MediaAttributeKeysAdTitle] = adContent.title
            sessionAttributes[MediaAttributeKeysAdId] = adContent.id
            sessionAttributes[MediaAttributeKeysAdAdvertiser] = adContent.advertiser
            sessionAttributes[MediaAttributeKeysAdCampaign] = adContent.campaign
            sessionAttributes[MediaAttributeKeysAdCreative] = adContent.creative
            sessionAttributes[MediaAttributeKeysAdSiteId] = adContent.siteId
            sessionAttributes[MediaAttributeKeysAdDuration] = adContent.duration?.stringValue
            sessionAttributes[MediaAttributeKeysAdPlacement] = adContent.placement?.stringValue
        }
        
        if let segment = segment {
            sessionAttributes[MediaAttributeKeysSegTitle] = segment.title
            sessionAttributes[MediaAttributeKeysSegIndex] = NSNumber(value: segment.index).stringValue
            sessionAttributes[MediaAttributeKeysSegDuration] = segment.duration.stringValue
        }
        
        if let adBreak = adBreak {
            sessionAttributes[MediaAttributeKeysAdBreakTitle] = adBreak.title
            sessionAttributes[MediaAttributeKeysAdBreakDuration] = adBreak.duration?.stringValue
            sessionAttributes[MediaAttributeKeysAdBreakPlaybackTime] = playheadPosition?.stringValue
            sessionAttributes[MediaAttributeKeysAdBreakId] = adBreak.id
        }
        
        if let existingAttributes = customAttributes {
            for key in existingAttributes.keys {
                sessionAttributes[key] = existingAttributes[key]
            }
        }
        
        return sessionAttributes
    }
    
    class func mediaEventTypeString(mediaEventType: MPMediaEventName) -> String {
        switch mediaEventType {
        case .play:
            return MPMediaEventNameString.play.rawValue
        case .pause:
            return MPMediaEventNameString.pause.rawValue
        case .contentEnd:
            return MPMediaEventNameString.contentEnd.rawValue
        case .sessionStart:
            return MPMediaEventNameString.sessionStart.rawValue
        case .sessionEnd:
            return MPMediaEventNameString.sessionEnd.rawValue
        case .seekStart:
            return MPMediaEventNameString.seekStart.rawValue
        case .seekEnd:
            return MPMediaEventNameString.seekEnd.rawValue
        case .bufferStart:
            return MPMediaEventNameString.bufferStart.rawValue
        case .bufferEnd:
            return MPMediaEventNameString.bufferEnd.rawValue
        case .updatePlayheadPosition:
            return MPMediaEventNameString.updatePlayheadPosition.rawValue
        case .adClick:
            return MPMediaEventNameString.adClick.rawValue
        case .adBreakStart:
            return MPMediaEventNameString.adBreakStart.rawValue
        case .adBreakEnd:
            return MPMediaEventNameString.adBreakEnd.rawValue
        case .adStart:
            return MPMediaEventNameString.adStart.rawValue
        case .adEnd:
            return MPMediaEventNameString.adEnd.rawValue
        case .adSkip:
            return MPMediaEventNameString.adSkip.rawValue
        case .segmentStart:
            return MPMediaEventNameString.segmentStart.rawValue
        case .segmentSkip:
            return MPMediaEventNameString.segmentSkip.rawValue
        case .segmentEnd:
            return MPMediaEventNameString.segmentEnd.rawValue
        case .updateQoS:
            return MPMediaEventNameString.updateQoS.rawValue
        default:
            return "unknown"
        }
    }
}

// MARK: event type
/// The type of a media event--this is set internally by the Media SDK on media event objects before forwarding to the core SDK.
/// (You generally won't need this unless you need to call logBaseEvent for some reason.)
@objc public enum MPMediaEventName: Int, RawRepresentable {
    case play = 23
    case pause = 24
    case contentEnd = 25
    case sessionStart = 30
    case sessionEnd = 31
    case seekStart = 32
    case seekEnd = 33
    case bufferStart = 34
    case bufferEnd = 35
    case updatePlayheadPosition = 36
    case adClick = 37
    case adBreakStart = 38
    case adBreakEnd = 39
    case adStart = 40
    case adEnd = 41
    case adSkip = 42
    case segmentStart = 43
    case segmentSkip = 44
    case segmentEnd = 45
    case updateQoS = 46
    case milestone = 47
    case sessionSummary = 48
    case adSessionSummary = 49
}

public enum MPMediaEventNameString: String, RawRepresentable {
    case play = "Play"  //23
    case pause = "Pause"  //24
    case contentEnd = "Media Content End"  //25
    case sessionStart = "Media Session Start"  //30
    case sessionEnd = "Media Session End"  //31
    case seekStart = "Seek Start"  //32
    case seekEnd = "Seek End"  //33
    case bufferStart = "Buffer Start"  //34
    case bufferEnd = "Buffer End"  //35
    case updatePlayheadPosition = "Update Playhead Position"  //36
    case adClick = "Ad Click"  //37
    case adBreakStart = "Ad Break Start"  //38
    case adBreakEnd = "Ad Break End"  //39
    case adStart = "Ad Start"  //40
    case adEnd = "Ad End"  //41
    case adSkip = "Ad Skip"  //42
    case segmentStart = "Segment Start"  //43
    case segmentSkip = "Segment Skip"  //44
    case segmentEnd = "Segment End"  //45
    case updateQoS = "Update QoS"  //46
    case milestone = "Milestone"  //47
    case sessionSummary = "Media Session Summary"  //48
    case adSessionSummary = "Ad Session Summary"  //49
}
