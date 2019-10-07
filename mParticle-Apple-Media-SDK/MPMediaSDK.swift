import UIKit
import mParticle_Apple_SDK

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
    @objc public let mediaSessionId: String
    @objc public var adContent: MPMediaAdContent?
    @objc public var adBreak: MPMediaAdBreak?
    @objc public var segment: MPMediaSegment?

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
    }

    // MARK: factory method
    /// Creates an event using the state of the media session. (This method is called internally by the Media SDK.)
    /// :returns: a Media event
    /// :param: type the media event type for the event
    @objc func makeEvent(type: MPMediaEventType) -> MPMediaEvent {
        let mediaEvent = MPMediaEvent(type: type, title: self.title, mediaContentId: self.mediaContentId, duration: self.duration, contentType: self.contentType, streamType: self.streamType, mediaSessionId: self.mediaSessionId)
        return mediaEvent!
    }

    /// Begins a media session
    @objc public func logMediaSessionStart() {
        let mediaEvent = self.makeEvent(type: .sessionStart)
        coreSDK.logEvent(mediaEvent)
    }

    /// Ends the media session
    @objc public func logMediaSessionEnd() {
        let mediaEvent = self.makeEvent(type: .sessionEnd)
        coreSDK.logEvent(mediaEvent)
    }

    /// Denotes that the playhead position has reached the final position in the content
    @objc public func logMediaContentEnd() {
        let mediaEvent = self.makeEvent(type: .contentEnd)
        coreSDK.logEvent(mediaEvent)
    }

    // MARK: play/pause
    /// Logs a play event. This should be called when the user has clicked the play button or autoplay takes place.
    @objc public func logPlay() {
        let mediaEvent = self.makeEvent(type: .play)
        coreSDK.logEvent(mediaEvent)
    }

    /// Logs a pause event. This can be due to a system generated event or user action.
    @objc public func logPause() {
        let mediaEvent = self.makeEvent(type: .pause)
        coreSDK.logEvent(mediaEvent)
    }

    // MARK: seek
    /// Indicates that the user has started scrubbing through the content
    /// :param: position The starting position before the seek began
    @objc public func logSeekStart(position: NSNumber) {
        let mediaEvent = self.makeEvent(type: .seekStart)
        mediaEvent.seekPosition = position
        coreSDK.logEvent(mediaEvent)
    }

    /// Indicates that the user has stopped scrubbing through the content
    /// :param: position The ending position where the seek finished
    @objc public func logSeekEnd(position: NSNumber) {
        let mediaEvent = self.makeEvent(type: .seekEnd)
        mediaEvent.seekPosition = position
        coreSDK.logEvent(mediaEvent)
    }

    // MARK: buffer
    /// Records time spent loading remote content for playback
    @objc public func logBufferStart(duration: NSNumber, bufferPercent: NSNumber, position: NSNumber) {
        let mediaEvent = self.makeEvent(type: .bufferStart)
        mediaEvent.bufferDuration = duration
        mediaEvent.bufferPercent = bufferPercent
        mediaEvent.bufferPosition = position
        coreSDK.logEvent(mediaEvent)
    }

    /// Indicates that content loading has completed
    @objc public func logBufferEnd(duration: NSNumber, bufferPercent: NSNumber, position: NSNumber) {
        let mediaEvent = self.makeEvent(type: .bufferEnd)
        mediaEvent.bufferDuration = duration
        mediaEvent.bufferPercent = bufferPercent
        mediaEvent.bufferPosition = position
        coreSDK.logEvent(mediaEvent)
    }

    // MARK: ad break
    /// Logs that a sequence of one or more ads has begun
    @objc public func logAdBreakStart(adBreak: MPMediaAdBreak) {
        self.adBreak = adBreak
        self.adBreak?.duration = duration
        let mediaEvent = self.makeEvent(type: .adBreakStart)
        mediaEvent.adBreak = self.adBreak
        coreSDK.logEvent(mediaEvent)
    }

    /// Indicates that the ad break is complete
    @objc public func logAdBreakEnd() {
        let mediaEvent = self.makeEvent(type: .adBreakEnd)
        mediaEvent.adBreak = self.adBreak
        coreSDK.logEvent(mediaEvent)
        self.adBreak = nil
    }

    // MARK: ad content
    /// Indicates a given ad creative has started playing
    @objc public func logAdStart(adContent: MPMediaAdContent) {
        self.adContent = adContent
        let mediaEvent = self.makeEvent(type: .adStart)
        mediaEvent.adContent = self.adContent
        coreSDK.logEvent(mediaEvent)
    }

    /// Records that the user clicked on the ad
    @objc public func logAdClick() {
        let mediaEvent = self.makeEvent(type: .adClick)
        mediaEvent.adContent = self.adContent
        coreSDK.logEvent(mediaEvent)
    }

    /// Records that the user skipped the ad
    @objc public func logAdSkip() {
        let mediaEvent = self.makeEvent(type: .adSkip)
        mediaEvent.adContent = self.adContent
        coreSDK.logEvent(mediaEvent)
        self.adContent = nil
    }

    /// Ends the currently playing ad
    @objc public func logAdEnd() {
        let mediaEvent = self.makeEvent(type: .adEnd)
        mediaEvent.adContent = self.adContent
        coreSDK.logEvent(mediaEvent)
        self.adContent = nil
    }

    // MARK: segment
    /// Log that a new segment has begun
    @objc public func logSegmentStart(segment: MPMediaSegment) {
        self.segment = segment
        let mediaEvent = self.makeEvent(type: .segmentStart)
        mediaEvent.segment = self.segment
        coreSDK.logEvent(mediaEvent)
    }

    /// Indicate that the user skipped the current segment
    @objc public func logSegmentSkip() {
        let mediaEvent = self.makeEvent(type: .segmentSkip)
        mediaEvent.segment = self.segment
        coreSDK.logEvent(mediaEvent)
        self.segment = nil
    }

    /// End the current segment
    @objc public func logSegmentEnd() {
        let mediaEvent = self.makeEvent(type: .segmentEnd)
        mediaEvent.segment = self.segment
        coreSDK.logEvent(mediaEvent)
        self.segment = nil
    }

    /// Notify the SDK that the currently playing position of the content has changed
    /// :param: position The updated playhead position in milliseconds
    @objc public func logPlayheadPosition(position: NSNumber) {
        let mediaEvent = self.makeEvent(type: .updatePlayheadPosition)
        mediaEvent.playheadPosition = position
        coreSDK.logEvent(mediaEvent)
    }

    /// Update Quality of Service (Qos) data
    /// :param: metadata The new QoS data object
    @objc public func logQoS(metadata: MPMediaQoS) {
        let mediaEvent = self.makeEvent(type: .updateQoS)
        mediaEvent.qos = metadata
        coreSDK.logEvent(mediaEvent)
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
    @objc public var mediaEventType: MPMediaEventType
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
    @objc public init?(type: MPMediaEventType, title: String, mediaContentId: String, duration: NSNumber?, contentType: MPMediaContentType, streamType: MPMediaStreamType, mediaSessionId: String) {
        self.mediaEventType = type
        self.mediaContentTitle = title
        self.mediaContentId = mediaContentId
        self.duration = duration
        self.contentType = contentType
        self.streamType = streamType
        self.mediaSessionId = mediaSessionId
        super.init(eventType: MPEventTypeMedia)
    }

    @objc public override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? MPMediaEvent {
            return (self.mediaEventType == object.mediaEventType &&
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
        let object: MPMediaEvent? = MPMediaEvent(type: self.mediaEventType, title: self.mediaContentTitle, mediaContentId: self.mediaContentId, duration: self.duration, contentType: self.contentType, streamType: self.streamType, mediaSessionId: self.mediaSessionId)
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

}

// MARK: event type
/// The type of a media event--this is set internally by the Media SDK on media event objects before forwarding to the core SDK.
/// (You generally won't need this unless you need to call logBaseEvent for some reason.)
@objc public enum MPMediaEventType: Int, RawRepresentable {
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
}
