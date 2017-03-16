//
//  Event.swift
//  360Cam
//
//  Created by Chan Sin Tik on 18/1/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Event {
    

    var photoURL: String!

    var ref: FIRDatabaseReference?
    var key: String?
    
    init(snapshot: FIRDataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        
        

        
        self.photoURL = (snapshot.value as? NSDictionary)?["photoURL"] as? String

        
        
        
        
        
    }
    
    init(photoUrl: String){

        self.photoURL = photoUrl
    }
    
}
