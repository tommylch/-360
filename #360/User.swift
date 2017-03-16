//
//  User.swift
//  360Cam
//
//  Created by Silver on 18/10/2016.
//  Copyright © 2016 Tommy Lam. All rights reserved.
//
import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
 //   var username: String!
    var email: String?
  
  //  var photoURL: String!
  

    var ref: FIRDatabaseReference?
    var id: String?
    var name: String?
    
    var profileImageUrl: String?
    
    init(snapshot: FIRDataSnapshot){
        
  
        
        
         self.email = (snapshot.value as? NSDictionary)?["email"] as? String
        self.name = (snapshot.value as? NSDictionary)?["username"] as? String

        
        
        
        
    }

    
}

