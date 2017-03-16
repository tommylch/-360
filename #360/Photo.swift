//
//  File.swift
//  360Cam
//
//  Created by Chan Sin Tik on 30/1/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import Foundation

class Photo {
    
    // declare Post vars as Private and as getters
    
    
    private var _taskAddress: String!
    private var _taskSubAddress: String!
    private var _taskImage: String!
    private var _postKey: String!
    private var _tasklat: String!
    private var _tasklong: String!
    private var _taskDescription: String!
    private var _taskDate: String!
    private var _taskAuthor: String!
    
    
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
    
    var taskAuthor: String {
        if _taskAuthor == nil {
            _taskAuthor = ""
        }
        return _taskAuthor
    }
    var postKey: String {
        return _postKey
    }
    
    
    init(address: String, Subaddress: String, image: String, lat: String, long: String, description: String, date: String, author: String) {
        
        self._taskAddress = address
        self._taskSubAddress = Subaddress
        self._taskImage = image
        self._tasklat = lat
        print(_tasklat)
        self._tasklong = long
        self._taskDescription = description
        self._taskDate = date
        self._taskAuthor = author
    }
    
    init(postKey: String!, postData: Dictionary<String, String>) {
        
        
        self._postKey = postKey
        
        if let tasklat = postData["tasklat"] {
            self._tasklat = tasklat
        }
        
        if let tasklong = postData["tasklong"] {
            self._tasklong = tasklong
        }
        
        if let taskAddress = postData["taskAddress"] {
            self._taskAddress = taskAddress
        }
        
        if let taskSubAddress = postData["taskSubAddress"] {
            self._taskSubAddress = taskSubAddress
        }
        
        if let taskImage = postData["taskImage"] {
            self._taskImage = taskImage
        }
        
        if let taskDescription = postData["taskDescription"] {
            self._taskDescription = taskDescription
        }
        
        if let taskDate = postData["taskDate"] {
            self._taskDate = taskDate
        }
        
        if let taskAuthor = postData["taskAuthor"] {
            self._taskAuthor = taskAuthor
        }
    }
}
