//
//  PlaceViewController.swift
//  360Cam
//
//  Created by Chan Sin Tik on 1/2/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit
import Firebase

class PlaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LoadDetailViewDelegate {
    
    
    @IBOutlet weak var seg: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var imagename = NSString()
    
    var photos = [Photo]()
    var postToEdit = FIRDataSnapshot()
    var fbPost = FIRDataSnapshot()
    var loadDetailView: LoginViewController?
    var haveICheckedFirebase = false
    var videos = [Video]()
    
    
    @IBOutlet weak var tableView1: UITableView!
    
    // MARK: - declare global cache var
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        
        
        
        
        
         if (FIRAuth.auth()?.currentUser?.isAnonymous)!  {
            performSegue(withIdentifier: "goToSignIn", sender: nil)
        } else {
           fetchUser()
            
            buildTable()
        }
        
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

    
    // MARK: display message while waiting for posts to download from firebase
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let emptyViewMessage = UILabel()
        
        // initiate a 'wait' message
        emptyViewMessage.text = "Please wait while we see if you have any posts."
        emptyViewMessage.textAlignment = .center
        emptyViewMessage.numberOfLines = 0
        emptyViewMessage.textColor = .darkGray
        emptyViewMessage.font = UIFont(name: "NotoSans", size: 20)
        
        
        if haveICheckedFirebase {
            emptyViewMessage.text = "You have no posts. Time to start posting."
        } else {
            perform(#selector (doSomething), with: nil, afterDelay: 3)
        }
        
        return emptyViewMessage
    }
    
    
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    
    
    
    
    
    func doSomething() {
        haveICheckedFirebase = true
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        if self.photos.count > 0 {
            return 0
        } else {
            return view.frame.height
        }
        
    }
    
    // MARK: func call to load posts array with firebase database data/posts
    func buildTable() {
        
        
        
        // MARK: - firebase observer to track new post adds
        DataService.ds.REF_POSTS.child("Post").observe(.childAdded, with: { (snapshot) in
            if let postDict = snapshot.value as? Dictionary<String, AnyObject> {
                let postKey = snapshot.key
                
                // call custom (convenience) init in Post.swift class to create a post
                let photo = Photo(postKey: postKey, postData: postDict as! Dictionary<String, String>)
                
                if photo.taskAuthor == FIRAuth.auth()?.currentUser?.uid {
                    
                    // append post to posts array (of Post type)
                    
                    self.photos.append(photo)
                    
                    self.photos.reverse()
                }
                self.tableView.reloadData()
            }
        })
        
        // MARK: - firebase observer to track post edits/changes
        DataService.ds.REF_POSTS.child("Post").observe(.childChanged, with: { (snapshot) in
            let postData = snapshot.value as! Dictionary<String, AnyObject>
            let postKey = snapshot.key
            let updatedPhoto = Photo(postKey: postKey, postData: postData as! Dictionary<String, String>)
            if updatedPhoto.taskAuthor == FIRAuth.auth()?.currentUser?.uid {
                let index = self.photos.index {
                    $0.postKey == postKey
                }
                self.photos[index!] = updatedPhoto
                self.tableView.reloadData()
            }
        })
    }
    /*
     
     DataService.ds.REF_POSTS.child("Video").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
     if let postDictionary = snapshot.value as? [String: Any] {
     
     let newPost = Video.transformPost(postDictionary: postDictionary, key: snapshot.key)
     
     
     self.videos.append(newPost)
     self.videos.reverse()
     
     self.tableView.reloadData()
     }
     }
     
     */
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    
    
    
    // MARK: - tableView Methods :: set up populating table view with cells
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        
        let photo = photos[indexPath.row]
        
        
        
        
        
        let cell: PlaceCell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as! PlaceCell
        if photo.taskAuthor == FIRAuth.auth()?.currentUser?.uid {
            // check if we can source image from image cache
            if let img = PlaceViewController.imageCache.object(forKey: photo.taskImage as NSString) {
                cell.configureCell(photo: photo, img: img)
            } else {
                // image is not there :: return post data without image
                cell.configureCell(photo: photo, img: nil)
            }
            // assign tag attribute in shareButton the cell index row number
            
        }
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return photos.count
        
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        performSegue(withIdentifier: "ViewPhotoSegue", sender: nil)
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - prepareForSegue for editPost and logOut
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewPhotoSegue", let dvc = segue.destination as? ViewPhotoController, let postIndex = tableView.indexPathForSelectedRow?.row  {
            
            // back bar text
            let backBar = UIBarButtonItem()
            backBar.title = "Back"
            
            navigationItem.backBarButtonItem = backBar
            
            // assign dvc attributes to carry across to EditView controller on segue
            dvc.photo = photos[postIndex]
            
            // when done, deselect the row
            let pathIndex = self.tableView.indexPathForSelectedRow
            self.tableView.deselectRow(at: pathIndex!, animated: true)
        }
        
        
        if segue.identifier == "ViewVideo", let dvc1 = segue.destination as? PVideoViewController, let postIndex = tableView.indexPathForSelectedRow?.row  {
            
            // back bar text
            let backBar = UIBarButtonItem()
            backBar.title = "Back"
            
            navigationItem.backBarButtonItem = backBar
            
            // assign dvc attributes to carry across to EditView controller on segue
            dvc1.video = videos[postIndex]
            
            // when done, deselect the row
            let pathIndex = self.tableView.indexPathForSelectedRow
            self.tableView.deselectRow(at: pathIndex!, animated: true)
        }
        
        
        
        
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let postImageURL = photos[indexPath.row].taskImage
            
            let postKey = photos[indexPath.row].postKey
            
            photos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            DataService.ds.REF_POSTS.child("Post").child(postKey).removeValue()
            
            let storage = FIRStorage.storage()
            let storageRef = storage.reference(forURL: postImageURL)
            
            storageRef.delete(completion: { (error ) in
                if (error != nil) {
                    print("DetailView -> RGM: error deleting image \(error)")
                } else {
                    print("DetailView -> RGM: image deleted")
                }
            })
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    
    
}


