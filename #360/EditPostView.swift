//
//  EditPostView.swift
//  photoLogger
//
//  Created by Richard Martin on 2016-09-20.
//  Copyright © 2016 richard martin. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class EditPostView: UIViewController {
    
    var post: Post?
    
    
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var time: UILabel!

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.taskDescription.text = post?.taskDescription
        self.address.text = post?.taskAddress
        self.time.text = post?.taskDate
        self.taskImage.image = DetailView.imageCache.object(forKey: post!.taskImage as NSString)

        print(post!.taskImage)
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DestViewController = segue.destination as? ViewControllerURL {
        
            DestViewController.imageName = post!.taskImage as String!;
            
        }

        
    }
    
   /* func updateFirebasePost() {
        
        let newTaskTitle = taskTitle.text
        print("EditView -> RGM -> newTaskTitle is: \(newTaskTitle)")
        let newTaskDescription = taskDescription.text
        print("EditView -> RGM -> newTaskDescription is: \(newTaskDescription)")
        
        let postUpdate: Dictionary<String, String> = [
            "taskTitle": newTaskTitle!,
            "taskDescription": newTaskDescription!,
            "taskAddress": (post?.taskAddress)!,
            "taskDate": (post?.taskDate)!,
            "taskImage": (post?.taskImage)!
        ]
        let firebasePostKey = post!.postKey
        print("EditView -> RGM -> postKey (aka firebasePost.key) is: \(firebasePostKey)")
        let firebasePostDetail = DataService.ds.REF_POSTS.child((FIRAuth.auth()?.currentUser?.uid)!).child(firebasePostKey)
        print("EditView -> RGM -> DataService.ds.REF_POSTS.child((FIRAuth.auth()?.currentUser?.uid)!).child(firebasePostKey) is \(firebasePostDetail)")
        firebasePostDetail.setValue(postUpdate)
    }
 */
}
