//
//  Video.swift
//  360Cam
//
//  Created by Tommy Lam on 14/2/2017.
//  Copyright © 2017 tik. All rights reserved.
//


class Video {
    
     var taskAuthor: String!
  var taskDescription: String!
    var taskDate: String!
    var taskAddress: String!
     var taskImage: String!
    var postKey: String!
     var tasklat: String!
     var tasklong: String!
     var taskvideoUrl: String!
     var taskSubAddress: String!
     var tasktimestamp: String!
}

extension Video {
    
    static func transformPost(postDictionary: [String: Any], key: String) -> Video {
        let video = Video()
        
        video.postKey = key
        video.taskDescription = postDictionary["taskDescription"] as? String
        video.taskDate = postDictionary["taskDate"] as? String
        video.taskAddress = postDictionary["taskAddress"] as? String
        video.tasklat = postDictionary["taskLat"] as? String
        video.tasklong = postDictionary["tasklong"] as? String
        video.taskvideoUrl = postDictionary["videoUrl"] as? String
        video.taskSubAddress = postDictionary["taskSubAddress"] as? String
        video.tasktimestamp = postDictionary["timestamp"] as? String
        video.taskAuthor = postDictionary["taskAuthor"] as? String
        video.taskImage = postDictionary["taskImage"] as? String
        
        
        return video
    }
    
}

