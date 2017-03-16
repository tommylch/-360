//
//  VPlaceViewController.swift
//  #360
//
//  Created by Chan Sin Tik on 28/2/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit
import Firebase

class VPlaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LoadDetailViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos = [Video]()
    var postToEdit = FIRDataSnapshot()
    var fbPost = FIRDataSnapshot()
    var loadDetailView: LoginViewController?
    var haveICheckedFirebase = false
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        buildTable()
      fetchUser()
        self.navigationItem.backBarButtonItem?.title = "Photo"
        // Do any additional setup after loading the view.
    }
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    var userRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    func fetchUser() {
        
        userRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)").observe(.value, with: { (snapshot) in
            
            DispatchQueue.main.async(execute: {
                let user = User(snapshot: snapshot)
                
                self.navigationItem.title = user.name
                
                
            })
            
            
            
            
        }) { (error) in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let emptyViewMessage = UILabel()
        
        
        
        
        if haveICheckedFirebase {
            emptyViewMessage.text = ""
        } else {
            perform(#selector (doSomething), with: nil, afterDelay: 3)
        }
        
        return emptyViewMessage
    }
    
    func doSomething() {
        haveICheckedFirebase = true
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if self.videos.count > 0 {
            return 0
        } else {
            return view.frame.height
        }
    }
    
    // MARK: func call to load posts array with firebase database data/posts
    func buildTable() {
        
        
        
        DataService.ds.REF_POSTS.child("Video").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            if let postDictionary = snapshot.value as? [String: Any] {
                
                let newPost = Video.transformPost(postDictionary: postDictionary, key: snapshot.key)
                if newPost.taskAuthor == FIRAuth.auth()?.currentUser?.uid {
                
                self.videos.append(newPost)
                self.videos.reverse()
                }
                self.tableView.reloadData()
            }
        }
        
        
        /*
         // MARK: - firebase observer to track new post adds
         DataService.ds.REF_POSTS.child("Video").observe(.childAdded, with: { (snapshot) in
         if let postDict = snapshot.value as? Dictionary<String, AnyObject> {
         let postKey = snapshot.key
         // call custom (convenience) init in Post.swift class to create a post
         let video = Video(postKey: postKey, postData: postDict as! Dictionary<String, String>)
         // append post to posts array (of Post type)
         
         self.videos.append(video)
         
         self.videos.reverse()
         }
         self.tableView.reloadData()
         })
         
         // MARK: - firebase observer to track post edits/changes
         DataService.ds.REF_POSTS.child("Video").observe(.childChanged, with: { (snapshot) in
         let postData = snapshot.value as! Dictionary<String, AnyObject>
         let postKey = snapshot.key
         let updatedPost = Video(postKey: postKey, postData: postData as! Dictionary<String, String>)
         let index = self.videos.index {
         $0.postKey == postKey
         }
         self.videos[index!] = updatedPost
         self.tableView.reloadData()
         })
         
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    
    
    
    // MARK: - tableView Methods :: set up populating table view with cells
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = videos[indexPath.row]
        
        
        
        var cell:PVideoCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "PVideoCell") as! PVideoCell
        
        // check if we can source image from image cache
        if let img = VPlaceViewController.imageCache.object(forKey: post.taskImage as NSString) {
            cell.configureCell(video: post, img: img)
        } else {
            // image is not there :: return post data without image
            cell.configureCell(video: post, img: nil)
        }
        // assign tag attribute in shareButton the cell index row number
        
        
        return cell
    }
    
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: - edit post with segue :: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        performSegue(withIdentifier: "ViewVideo", sender: nil)
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - prepareForSegue for editPost and logOut
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewVideo", let dvc = segue.destination as? PVideoViewController, let postIndex = tableView.indexPathForSelectedRow?.row  {
            
            // back bar text
            let backBar = UIBarButtonItem()
            backBar.title = "Back"
            
            navigationItem.backBarButtonItem = backBar
            
            // assign dvc attributes to carry across to EditView controller on segue
            dvc.video = videos[postIndex]
            
            // when done, deselect the row
            let pathIndex = self.tableView.indexPathForSelectedRow
            self.tableView.deselectRow(at: pathIndex!, animated: true)
        }
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
