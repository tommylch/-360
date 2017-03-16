//
//  Post.swift
//  photoLogger
//
//  Created by Richard Martin on 2016-07-20.
//  Copyright © 2016 richard martin. All rights reserved.
//

import Foundation

class Post {
    
    // declare Post vars as Private and as getters
    
    private var _taskAuthor: String!
    private var _taskTitle: String!
    private var _taskDescription: String!
    private var _taskDate: String!
    private var _taskAddress: String!
    private var _taskImage: String!
    private var _postKey: String!
    private var _tasklat: String!
    private var _tasklong: String!
    private var _taskSubAddress: String!

    
    var taskTitle: String {
        if _taskTitle == nil {
            _taskTitle = ""
        }
        return _taskTitle
    }
    var taskDescription: String {
        if _taskDescription == nil {
            _taskDescription = ""
        }
        return _taskDescription
    }
    var taskDate: String {
        if _taskDate == nil {
            _taskDate = ""
        }
        return _taskDate
     }
     var taskAddress: String {
        if _taskAddress == nil {
            _taskAddress = ""
        }
         return _taskAddress
     }
    var taskSubAddress: String {
        if _taskSubAddress == nil {
            _taskSubAddress = ""
        }
        return _taskSubAddress
    }
     var taskImage: String {
        if _taskImage == nil {
            _taskImage = ""
        }
         return _taskImage
     }
     var postKey: String {
        return _postKey
     }
    
    var taskAuthor: String {
        if _taskAuthor == nil {
            _taskAuthor = ""
        }
        return _taskAuthor
    }
    
    var tasklat: String {
        if _tasklat == nil {
            _tasklat = ""
        }
        return _tasklat
    }

    var tasklong: String {
        if _tasklong == nil {
            _tasklong = ""
        }
        return _tasklong
    }
    
    init(title: String, desc: String, date: String, address: String, image: String, author: String, lat: String, long: String, subAddress: String) {
        self._taskTitle = title
        self._taskDescription = desc
        self._taskDate = date
        self._taskAddress = address
        self._taskImage = image
        self._taskAuthor = author
        self._tasklong = long
        self._tasklat = lat
        self._taskSubAddress = subAddress
    }
    
    init(postKey: String!, postData: Dictionary<String, String>) {
            
        
        self._postKey = postKey
            
        if let taskTitle = postData["taskTitle"] {
            self._taskTitle = taskTitle
        }
            
        if let taskDescription = postData["taskDescription"] {
            self._taskDescription = taskDescription
        }
            
        if let taskDate = postData["taskDate"] {
            self._taskDate = taskDate
        }
            
        if let taskAddress = postData["taskAddress"] {
            self._taskAddress = taskAddress
        }
            
        if let taskImage = postData["taskImage"] {
            self._taskImage = taskImage
        }
        
        if let taskAuthor = postData["taskAuthor"] {
            self._taskAuthor = taskAuthor
        }
        
        if let tasklat = postData["tasklat"] {
            self._tasklat = tasklat
        }
        
        if let tasklong = postData["tasklong"] {
            self._tasklong = tasklong
        }
        if let taskSubAddress = postData["taskSubAddress"] {
            self._taskSubAddress = taskSubAddress
        }
    }
}
