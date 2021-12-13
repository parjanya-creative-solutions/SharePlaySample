//
//  Video.swift
//  SharePlay-Demo
//
//  Created by Kanishka on 13/12/21.
//

import Foundation



struct Video : Codable, Equatable, Hashable {
    var title: String
    var url : URL
}

var videos = [Video(title: "Video 1",
                    url: URL(string: "https://prayoga-v2-videos.s3.ap-south-1.amazonaws.com/Ardha_Baddha_Padma_Pascimottanasana-4_9.fmp4/progressive.mp4")!),
                Video(title: "Video 2",
                      url: URL(string: "https://prayoga-v2-videos.s3.ap-south-1.amazonaws.com/Ardha_Baddha_Padma_Pascimottanasana.fmp4/progressive.mp4")!)]
