//
//  VideoSharingActivity.swift
//  SharePlay-Demo
//
//  Created by Kanishka on 13/12/21.
//


import GroupActivities
import AVKit

 

struct VideoSharingActivity : GroupActivity {
    
    let video: Video
    
    static var activityIdentifier = "com.parjanya-org.SharePlay-Demo.Shareplay-Demo"

     
    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.type = .watchTogether
        metadata.fallbackURL = video.url
        metadata.title = video.title
        return metadata
    }
}


