//
//  ProfileViewController.swift
//  #360
//
//  Created by Chan Sin Tik on 4/1/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if FIRAuth.auth()?.currentUser == nil{
            
            let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDel.logUser()
            
        }else{
            
            fetchUser()
            
            
            
            
        }

        // Do any additional setup after loading the view.
    }
    
    var userRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }

    func fetchUser() {
        
        userRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)").observe(.value, with: { (snapshot) in
            
            DispatchQueue.main.async(execute: {
                let user = User(snapshot: snapshot)
                self.emailText.text =  user.email!
 
                
                
                
            })
            
            
            
            
        }) { (error) in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    


}
