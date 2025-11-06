import UIKit
#if canImport(mParticle_Apple_Media_SDK_NoLocation)
import mParticle_Apple_SDK_NoLocation
#else
import mParticle_Apple_SDK
#endif

let MediaAttributeKeysMediaSessionId = "media_session_id"

let MediaAttributeKeysPlayheadPosition = "playhead_position"

//MediaConent
let MediaAttributeKeysTitle = "content_title"
let MediaAttributeKeysContentId = "content_id"
let MediaAttributeKeysDuration = "content_duration"
let MediaAttributeKeysStreamType = "stream_type"
public enum MPMediaStreamTypeString: String, RawRepresentable {
    case liveStream = "LiveStream"
    case onDemand = "OnDemand"
    case linear = "Linear"
    case podcast = "Podcast"
    case audiobook = "Audiobook"
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
let MediaAttributeKeysAdPosition = "ad_content_position"
let MediaAttributeKeysAdSiteId = "ad_content_site_id"

//MediaAdBreak
let MediaAttributeKeysAdBreakTitle = "ad_break_title"
let MediaAttributeKeysAdBreakDuration = "ad_break_duration"
let MediaAttributeKeysAdBreakPlaybackTime = "ad_break_playback_time"
let MediaAttributeKeysAdBreakId = "ad_break_id"

//Segment
let MediaAttributeKeysSegTitle = "segment_title"
let MediaAttributeKeysSegIndex = "segment_index"
let MediaAttributeKeysSegDuration = "segment_duration"

//Summary Event
let MPSessionSummary = "Media Session Summary"
let MPSegmentSummary = "Media Segment Summary"
let MPAdSummary = "Media Ad Summary"

// Session Summary Attributes
let startTimestampKey = "media_session_start_time"
let endTimestampKey = "media_session_end_time"
let contentIdKey = "content_id"
let contentTitleKey = "content_title"
let mediaTimeSpentKey = "media_time_spent"
let contentTimeSpentKey = "media_content_time_spent"
let contentCompleteKey = "media_content_complete"
let totalSegmentsKey = "media_session_segment_total"
let totalAdTimeSpentKey = "media_total_ad_time_spent"
let adTimeSpentRateKey = "media_ad_time_spent_rate"
let totalAdsKey = "media_session_ad_total"
let adIDsKey = "media_session_ad_objects"

// Ad Summary Attributes
let adBreakIdKey = "ad_break_id"
let adContentIdKey = "ad_content_id"
let adContentStartTimestampKey = "ad_content_start_time"
let adContentEndTimestampKey = "ad_content_end_time"
let adContentTitleKey = "ad_content_title"
let adContentSkippedKey = "ad_skipped"
let adContentCompletedKey = "ad_completed"

// Segment Summary Attributes
let segmentIndexKey = "segment_index"
let segmentTitleKey = "segment_title"
let segmentStartTimestampKey = "segment_start_time"
let segmentEndTimestampKey = "segment_end_time"
let segmentTimeSpentKey = "media_segment_time_spent"
let segmentSkippedKey = "segment_skipped"
let segmentCompletedKey = "segment_completed"

/**
* This is a series of constants that can be used to specify Media characteristics to be included
* in a {@link com.mparticle.media.events.MediaEvent} or {@link com.mparticle.MPEvent}.
* These values are common values used in Media services, and may be included in a {@link com.mparticle.media.events.MediaEvent} via
* an {@link com.mparticle.media.events.Options} instance.
*
* @see com.mparticle.media.events.Options
*/
let AdIds = "media_session_ad_objects"
let ContentAssetId = "content_asset_id"
let ContentSeason = "content_season"
let ContentEpisode = "content_episode"
let ContentDaypart = "content_daypart"
let ContentOriginator = "content_originator"
let ContentNetwork = "content_network"
let ContentMVPD = "content_mvpd"
let ContentFeed = "content_feed"
let ContentShow = "content_show"
let ContentShowType = "content_show_type"
let ContentGenre = "content_genre"
let ContentRating = "content_rating"
let ContentAuthorized = "content_authorized"
let ContentFirstAirDate = "content_first_air_date"
let ContentDigitalDate = "content_digital_date"
let Milestone = "milestone"
let PlayerInitialResolution = "player_initial_resolution"
let PlayerName = "player_name"
let PlayerOvp = "player_ovp"

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
    case onDemand
    case liveStream
    case linear
    case podcast
    case audiobook
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
    @objc public var placement: String?
    @objc public var position: NSNumber?
    @objc public var siteId: String?
    
    internal var adStartTimestamp: Date?
    internal var adEndTimestamp: Date?
    internal var adSkipped = false
    internal var adCompleted = false

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
    
    internal var segmentStartTimestamp: Date?
    internal var segmentEndTimestamp: Date?
    internal var segmentSkipped = false
    internal var segmentCompleted = false

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
    @objc public var mediaSessionAttributes: [String:Any]
    @objc public var adContent: MPMediaAdContent?
    @objc public var adBreak: MPMediaAdBreak?
    @objc public var segment: MPMediaSegment?
    @objc public var mediaEventListener: ((MPMediaEvent)->Void)?
    
    private(set) public var mediaSessionStartTimestamp: Date //Timestamp created on logMediaSessionStart event
    private(set) public var mediaSessionEndTimestamp: Date //Timestamp updated when any event is logged
    public var mediaTimeSpent: Double {
        get { //total seconds between media session start and current timestamp
            return Date().timeIntervalSince(mediaSessionStartTimestamp)
        }
    }
    public var mediaContentTimeSpent: Double {
        get { //total seconds spent playing content
            if (self.currentPlaybackStartTimestamp != nil) {
                return self.storedPlaybackTime + Date().timeIntervalSince(self.currentPlaybackStartTimestamp!)
            } else {
                return self.storedPlaybackTime
            }
        }
    }
    private(set) public var mediaContentCompleteLimit: Int = 100
    private(set) public var mediaContentComplete: Bool = false //Updates to true triggered by logMediaContentEnd (or if 90% or 95% of the content played), 0 or false if complete milestone not reached or a forced quit.
    private(set) public var mediaSessionSegmentTotal: Int = 0 //number incremented with each logSegmentStart
    private(set) public var mediaTotalAdTimeSpent: Double = 0 //total second sum of ad break time spent
    public var mediaAdTimeSpentRate: Double {
        get { //ad time spent / content time spent x 100
            return self.mediaTotalAdTimeSpent/self.mediaContentTimeSpent*100
        }
    }
    private(set) public var mediaSessionAdTotal: Int = 0 //number of ads played in the media session - increment on logAdStart
    private(set) public var mediaSessionAdObjects: [String] = [] //array of unique identifiers for ads played in the media session - append ad_content_ID on logAdStart
    
    private(set) public var currentPlaybackStartTimestamp: Date? //Timestamp for beginning of current playback
    private(set) public var storedPlaybackTime: Double = 0 //On Pause calculate playback time and clear currentPlaybackTime
    private var sessionSummarySent = false // Ensures we only send summary event once
    

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
        self.mediaSessionAttributes = [:]
        self.logMPEvents = false
        self.logMediaEvents = true
        
        let currentTimestamp = Date()
        self.mediaSessionStartTimestamp = currentTimestamp
        self.mediaSessionEndTimestamp = currentTimestamp
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
    /// :param: logMPEvents Set to true if you would like custom events forwarded to the mParticle SDK
    /// :param: logMediaEvents Set to true if you would like media events forwarded to the mParticle SDK
    /// :param: completeLimit Int from 1 to 100 denotes percentage of progress needed to be considered "completed"
    @objc public init(coreSDK: MParticle?, mediaContentId: String, title: String, duration: NSNumber?, contentType: MPMediaContentType, streamType: MPMediaStreamType, logMPEvents: Bool, logMediaEvents: Bool, completeLimit: Int) {
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
        self.mediaSessionAttributes = [:]
        self.logMPEvents = logMPEvents
        self.logMediaEvents = logMediaEvents
        if ( 100 >= completeLimit && completeLimit > 0) {
            self.mediaContentCompleteLimit = completeLimit
        }
        
        let currentTimestamp = Date()
        self.mediaSessionStartTimestamp = currentTimestamp
        self.mediaSessionEndTimestamp = currentTimestamp
    }
    
    internal convenience init(coreSDK: MParticle?, mediaContentId: String, title: String, duration: NSNumber?, contentType: MPMediaContentType, streamType: MPMediaStreamType, logMPEvents: Bool, logMediaEvents: Bool, completeLimit: Int, testing: Bool) {
        self.init(coreSDK: coreSDK, mediaContentId: mediaContentId, title: title, duration: duration, contentType: contentType, streamType: streamType, logMPEvents: logMPEvents, logMediaEvents: logMediaEvents, completeLimit: completeLimit)
        
        self.sessionSummarySent = true
    }
    
    deinit {
        self.logAdSummary()
        self.logSegmentSummary()
        self.logSessionSummary()
    }

    // MARK: factory method
    /// Creates an event using the state of the media session. (This method is called internally by the Media SDK.)
    /// :returns: a Media event
    /// :param: type the media event type for the event
    @objc func makeMediaEvent(name: MPMediaEventName, options: Options? = nil) -> MPMediaEvent {
        let mediaEvent = MPMediaEvent(name: name, session: self, options: options)
        return mediaEvent!
    }
    
    /// Attempt to log the event with the Core SDK
    @objc func logEvent(mediaEvent: MPMediaEvent) {
        self.mediaSessionEndTimestamp = Date()
        if (self.mediaContentCompleteLimit != 100) {
            if ((duration != nil) && (duration!.intValue != 0) && (self.currentPlayheadPosition?.intValue ?? 0)/duration!.intValue > (self.mediaContentCompleteLimit/100)) {
                self.mediaContentComplete = true
            }
        }

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
    @objc public func logMediaSessionStart(options: Options?  = nil) {
        self.mediaSessionStartTimestamp = Date()
        
        let mediaEvent = self.makeMediaEvent(name: .sessionStart, options: options)
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Ends the media session
    @objc public func logMediaSessionEnd(options: Options?  = nil) {
        let mediaEvent = self.makeMediaEvent(name: .sessionEnd, options: options)
        self.logEvent(mediaEvent: mediaEvent)
        
        self.logSessionSummary()
    }

    /// Denotes that the playhead position has reached the final position in the content
    @objc public func logMediaContentEnd(options: Options?  = nil) {
        self.mediaContentComplete = true
        self.storedPlaybackTime = self.storedPlaybackTime + Date().timeIntervalSince(self.currentPlaybackStartTimestamp ?? Date())
        self.currentPlaybackStartTimestamp = nil;
        
        let mediaEvent = self.makeMediaEvent(name: .contentEnd, options: options)
        self.logEvent(mediaEvent: mediaEvent)
    }

    // MARK: play/pause
    /// Logs a play event. This should be called when the user has clicked the play button or autoplay takes place.
    @objc public func logPlay(options: Options?  = nil) {
        if (self.currentPlaybackStartTimestamp == nil) {
            self.currentPlaybackStartTimestamp = Date()
        }
        
        let mediaEvent = self.makeMediaEvent(name: .play, options: options)
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Logs a pause event. This can be due to a system generated event or user action.
    @objc public func logPause(options: Options?  = nil) {
        self.storedPlaybackTime = self.storedPlaybackTime + Date().timeIntervalSince(self.currentPlaybackStartTimestamp ?? Date())
        self.currentPlaybackStartTimestamp = nil;
        
        let mediaEvent = self.makeMediaEvent(name: .pause, options: options)
        self.logEvent(mediaEvent: mediaEvent)
    }

    // MARK: seek
    /// Indicates that the user has started scrubbing through the content
    /// :param: position The starting position before the seek began
    @objc public func logSeekStart(position: NSNumber, options: Options?  = nil) {
        let mediaEvent = self.makeMediaEvent(name: .seekStart, options: options)
        mediaEvent.seekPosition = position
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Indicates that the user has stopped scrubbing through the content
    /// :param: position The ending position where the seek finished
    @objc public func logSeekEnd(position: NSNumber, options: Options?  = nil) {
        let mediaEvent = self.makeMediaEvent(name: .seekEnd, options: options)
        mediaEvent.seekPosition = position
        self.logEvent(mediaEvent: mediaEvent)
    }

    // MARK: buffer
    /// Records time spent loading remote content for playback
    @objc public func logBufferStart(duration: NSNumber, bufferPercent: NSNumber, position: NSNumber, options: Options?  = nil) {
        let mediaEvent = self.makeMediaEvent(name: .bufferStart, options: options)
        mediaEvent.bufferDuration = duration
        mediaEvent.bufferPercent = bufferPercent
        mediaEvent.bufferPosition = position
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Indicates that content loading has completed
    @objc public func logBufferEnd(duration: NSNumber, bufferPercent: NSNumber, position: NSNumber, options: Options?  = nil) {
        let mediaEvent = self.makeMediaEvent(name: .bufferEnd, options: options)
        mediaEvent.bufferDuration = duration
        mediaEvent.bufferPercent = bufferPercent
        mediaEvent.bufferPosition = position
        self.logEvent(mediaEvent: mediaEvent)
    }

    // MARK: ad break
    /// Logs that a sequence of one or more ads has begun
    @objc public func logAdBreakStart(adBreak: MPMediaAdBreak, options: Options?  = nil) {
        self.adBreak = adBreak
        let mediaEvent = self.makeMediaEvent(name: .adBreakStart, options: options)
        mediaEvent.adBreak = self.adBreak
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Indicates that the ad break is complete
    @objc public func logAdBreakEnd(options: Options?  = nil) {
        let mediaEvent = self.makeMediaEvent(name: .adBreakEnd, options: options)
        mediaEvent.adBreak = self.adBreak
        self.logEvent(mediaEvent: mediaEvent)
        self.adBreak = nil
    }

    // MARK: ad content
    /// Indicates a given ad creative has started playing
    @objc public func logAdStart(adContent: MPMediaAdContent, options: Options?  = nil) {
        self.mediaSessionAdTotal += 1
        self.mediaSessionAdObjects.append(adContent.id)
        self.adContent = adContent
        self.adContent?.adStartTimestamp = Date()
        
        let mediaEvent = self.makeMediaEvent(name: .adStart, options: options)
        mediaEvent.adContent = self.adContent
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Records that the user clicked on the ad
    @objc public func logAdClick(options: Options?  = nil) {
        let mediaEvent = self.makeMediaEvent(name: .adClick, options: options)
        mediaEvent.adContent = self.adContent
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Records that the user skipped the ad
    @objc public func logAdSkip(options: Options?  = nil) {
        if (self.adContent?.adStartTimestamp != nil) {
            self.adContent?.adEndTimestamp = Date()
            self.adContent?.adSkipped = true
            self.mediaTotalAdTimeSpent += self.adContent!.adEndTimestamp!.timeIntervalSince(self.adContent!.adStartTimestamp!)
        }
        
        let mediaEvent = self.makeMediaEvent(name: .adSkip, options: options)
        mediaEvent.adContent = self.adContent
        self.logEvent(mediaEvent: mediaEvent)
        self.logAdSummary()
    }

    /// Ends the currently playing ad
    @objc public func logAdEnd(options: Options?  = nil) {
        if (self.adContent?.adStartTimestamp != nil) {
            self.adContent?.adEndTimestamp = Date()
            self.adContent?.adCompleted = true
            self.mediaTotalAdTimeSpent += self.adContent!.adEndTimestamp!.timeIntervalSince(self.adContent!.adStartTimestamp!)
        }
        
        let mediaEvent = self.makeMediaEvent(name: .adEnd, options: options)
        mediaEvent.adContent = self.adContent
        self.logEvent(mediaEvent: mediaEvent)
        self.logAdSummary()
    }

    // MARK: segment
    /// Log that a new segment has begun
    @objc public func logSegmentStart(segment: MPMediaSegment, options: Options?  = nil) {
        self.mediaSessionSegmentTotal += 1
        self.segment = segment
        self.segment?.segmentStartTimestamp = Date()
        
        let mediaEvent = self.makeMediaEvent(name: .segmentStart, options: options)
        mediaEvent.segment = self.segment
        self.logEvent(mediaEvent: mediaEvent)
    }

    /// Indicate that the user skipped the current segment
    @objc public func logSegmentSkip(options: Options?  = nil) {
        self.segment?.segmentEndTimestamp = Date()
        self.segment?.segmentSkipped = true
        
        let mediaEvent = self.makeMediaEvent(name: .segmentSkip, options: options)
        mediaEvent.segment = self.segment
        self.logEvent(mediaEvent: mediaEvent)
        
        self.logSegmentSummary()
    }

    /// End the current segment
    @objc public func logSegmentEnd(options: Options?  = nil) {
        self.segment?.segmentEndTimestamp = Date()
        self.segment?.segmentCompleted = true
        
        let mediaEvent = self.makeMediaEvent(name: .segmentEnd, options: options)
        mediaEvent.segment = self.segment
        self.logEvent(mediaEvent: mediaEvent)
        
        self.logSegmentSummary()
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
    @objc public func logQoS(metadata: MPMediaQoS, options: Options?  = nil) {
        let mediaEvent = self.makeMediaEvent(name: .updateQoS, options: options)
        mediaEvent.qos = metadata
        self.logEvent(mediaEvent: mediaEvent)
    }
    
    /// Log a custom media event
    @objc public func buildMPEvent(name: String, options: Options?  = nil) -> MPEvent {
        let mpEvent = MPEvent.init(name: name, type: .media)
        let mediaEvent = self.makeMediaEvent(name: .play, options: options)
        mpEvent?.customAttributes = mediaEvent.getEventAttributes()
                
        return mpEvent!
    }
    
    private func logSessionSummary() {
        if (!self.sessionSummarySent) {
            let event = MPEvent.init(name: MPSessionSummary, type: .media)!
            let mediaEvent = self.makeMediaEvent(name: .sessionSummary, options: nil)
            
            var customAttributes: [String:Any] = mediaEvent.getEventAttributes()
            customAttributes[startTimestampKey] = Int(self.mediaSessionStartTimestamp.timeIntervalSince1970  * 1_000)
            customAttributes[endTimestampKey] = Int(self.mediaSessionEndTimestamp.timeIntervalSince1970  * 1_000)
            customAttributes[contentIdKey] = self.mediaContentId
            customAttributes[contentTitleKey] = self.title
            customAttributes[mediaTimeSpentKey] = self.mediaTimeSpent
            customAttributes[contentTimeSpentKey] = self.mediaContentTimeSpent
            customAttributes[contentCompleteKey] = self.mediaContentComplete
            customAttributes[totalSegmentsKey] = self.mediaSessionSegmentTotal
            customAttributes[totalAdTimeSpentKey] = self.mediaTotalAdTimeSpent
            customAttributes[adTimeSpentRateKey] = self.mediaAdTimeSpentRate
            customAttributes[totalAdsKey] = self.mediaSessionAdTotal
            customAttributes[adIDsKey] = self.mediaSessionAdObjects.joined(separator: ", ")
            
            event.customAttributes = customAttributes
            coreSDK.logEvent(event)
            
            self.sessionSummarySent = true
        }
    }
    
    private func logSegmentSummary() {
        if ((self.segment?.segmentStartTimestamp != nil)) {
            if (self.segment!.segmentEndTimestamp == nil) {
                self.segment!.segmentEndTimestamp = Date()
            }
            
            let event = MPEvent.init(name: MPSegmentSummary, type: .media)!
            let mediaEvent = self.makeMediaEvent(name: .segmentEnd, options: nil)
            
            var customAttributes: [String:Any] = mediaEvent.getEventAttributes()
            customAttributes[contentIdKey] = self.mediaContentId
            customAttributes[segmentIndexKey] = self.segment?.index
            customAttributes[segmentTitleKey] = self.segment?.title
            customAttributes[segmentStartTimestampKey] = self.segment!.segmentStartTimestamp
            customAttributes[segmentEndTimestampKey] = self.segment!.segmentEndTimestamp
            customAttributes[segmentTimeSpentKey] = self.segment!.segmentEndTimestamp!.timeIntervalSince(self.segment!.segmentStartTimestamp!)
            customAttributes[segmentSkippedKey] = self.segment!.segmentSkipped
            customAttributes[segmentCompletedKey] = self.segment!.segmentCompleted

            event.customAttributes = customAttributes
            coreSDK.logEvent(event)
            
            self.segment = nil
        }
    }
    
    private func logAdSummary() {
        if (self.adContent != nil) {
            if (self.adContent?.adStartTimestamp != nil) {
                self.adContent?.adEndTimestamp = Date()
                self.mediaTotalAdTimeSpent += self.adContent!.adEndTimestamp!.timeIntervalSince(self.adContent!.adStartTimestamp!)
            }
            
            let event = MPEvent.init(name: MPAdSummary, type: .media)!
            let mediaEvent = self.makeMediaEvent(name: .adSessionSummary, options: nil)
            
            var customAttributes: [String:Any] = mediaEvent.getEventAttributes()
            customAttributes[adBreakIdKey] = self.adBreak?.id
            customAttributes[adContentIdKey] = self.adContent?.id
            customAttributes[adContentStartTimestampKey] = self.adContent?.adStartTimestamp
            customAttributes[adContentEndTimestampKey] = self.adContent?.adEndTimestamp
            customAttributes[adContentTitleKey] = self.adContent?.title
            customAttributes[adContentSkippedKey] = self.adContent?.adSkipped
            customAttributes[adContentCompletedKey] = self.adContent?.adCompleted
            
            event.customAttributes = customAttributes
            coreSDK.logEvent(event)
            
            self.adContent = nil
        }
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
    @objc public var customEventName: String?
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
    @objc public init?(name: MPMediaEventName, session: MPMediaSession, options: Options? = nil) {
        self.mediaEventName = name
        self.mediaContentTitle = session.title
        self.mediaContentId = session.mediaContentId
        self.duration = session.duration
        self.contentType = session.contentType
        self.streamType = session.streamType
        self.mediaSessionId = session.mediaSessionId
        
        super.init(eventType: .media)
        self.messageType = MPMessageType.media
        
        self.customAttributes = session.mediaSessionAttributes.merging(options?.customAttributes ?? [:]) { (_, new) in new }
        if (options?.currentPlayheadPosition != nil) {
            self.playheadPosition = options?.currentPlayheadPosition
            session.currentPlayheadPosition = options?.currentPlayheadPosition
        } else {
            self.playheadPosition = session.currentPlayheadPosition
        }
    }
    
    @objc public convenience init?(customName: String, session: MPMediaSession, options: Options? = nil) {
        self.init(name: MPMediaEventName.custom, session: session, options: options)
        self.customEventName = customName
    }
    
    internal init?(name: MPMediaEventName, title: String, mediaContentId: String, duration: NSNumber?, contentType: MPMediaContentType, streamType: MPMediaStreamType, mediaSessionId: String, options: Options) {
        self.mediaEventName = name
        self.mediaContentTitle = title
        self.mediaContentId = mediaContentId
        self.duration = duration
        self.contentType = contentType
        self.streamType = streamType
        self.mediaSessionId = mediaSessionId
        
        super.init(eventType: .media)
        
        self.playheadPosition = options.currentPlayheadPosition
        self.customAttributes = options.customAttributes
    }

    @objc public override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? MPMediaEvent {
            return (self.mediaEventName == object.mediaEventName &&
                self.customEventName == object.customEventName &&
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
        let options = Options()
        options.currentPlayheadPosition = self.playheadPosition
        options.customAttributes = self.customAttributes
        
        let object: MPMediaEvent? = MPMediaEvent(name: self.mediaEventName, title: self.mediaContentTitle, mediaContentId: mediaContentId, duration: duration, contentType: contentType, streamType: streamType, mediaSessionId: mediaSessionId, options: options)
        if let object = object {
            object.customEventName = self.customEventName
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
        let eventNameString: String
        if let customEventName = customEventName, mediaEventName == .custom {
            eventNameString = customEventName
        } else {
            eventNameString = MPMediaEvent.mediaEventTypeString(mediaEventType: mediaEventName)
        }
        let mpEvent = MPEvent(name: eventNameString, type: .media)
        mpEvent?.customAttributes = getEventAttributes()
                
        return mpEvent!
    }
    
    @objc func getSessionAttributes() -> Dictionary<String, Any> {
        var sessionAttributes = self.customAttributes ?? [:]
        sessionAttributes[MediaAttributeKeysMediaSessionId] = mediaSessionId
        sessionAttributes[MediaAttributeKeysPlayheadPosition] = playheadPosition?.stringValue
        sessionAttributes[MediaAttributeKeysTitle] = mediaContentTitle
        sessionAttributes[MediaAttributeKeysContentId] = mediaContentId
        sessionAttributes[MediaAttributeKeysDuration] = duration?.stringValue
        sessionAttributes[MediaAttributeKeysStreamType] = MPMediaEvent.mediaStreamTypeString(mediaStreamType:streamType);
        sessionAttributes[MediaAttributeKeysContentType] = (contentType == MPMediaContentType.video) ? MPMediaContentTypeString.video.rawValue : MPMediaContentTypeString.audio.rawValue
        
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
            sessionAttributes[MediaAttributeKeysAdPlacement] = adContent.placement
            sessionAttributes[MediaAttributeKeysAdPosition] = adContent.position?.stringValue
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
    
    class func mediaStreamTypeString(mediaStreamType: MPMediaStreamType) -> String {
        switch mediaStreamType {
        case .liveStream:
            return MPMediaStreamTypeString.liveStream.rawValue
        case .onDemand:
            return MPMediaStreamTypeString.onDemand.rawValue
        case .linear:
            return MPMediaStreamTypeString.linear.rawValue
        case .podcast:
            return MPMediaStreamTypeString.podcast.rawValue
        case .audiobook:
            return MPMediaStreamTypeString.audiobook.rawValue
        default:
            return ""
        }
    }
}

@objc public class Options: NSObject {
    /**
     * Update the playhead position for the given event, and for the MediaSession
     */
     @objc public var currentPlayheadPosition: NSNumber?
    
    /**
     * Custom Attributes to be included within the generated {@link MediaEvent}. The key values
     * can either be values defined in {@link com.mparticle.media.events.OptionsAttributeKeys} or custom
     */
     @objc public var customAttributes: Dictionary<String, Any>?
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
    case custom = 50
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
