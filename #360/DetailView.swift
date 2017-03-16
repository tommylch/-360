//
//  DetailView.swift
//  #360
//
//  Created by Chan Sin Tik on 4/1/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit
import Firebase


class DetailView: UIViewController, UITableViewDelegate, UITableViewDataSource, LoadDetailViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!

    var imagename = NSString()
    
    var posts = [Post]()
    var postToEdit = FIRDataSnapshot()
    var fbPost = FIRDataSnapshot()
    var loadDetailView: LoginViewController?
    var haveICheckedFirebase = false
    
    @IBOutlet weak var pic4: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pc: UIPageControl!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var sv: UIScrollView!

    // MARK: - declare global cache var
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        getEventPhoto()

        
        for i in 1...3{ //loading the images
            
            imagename = "pic\(i).jpg" as NSString
            
            let image = UIImage(named: "\(imagename)")!
            let x = CGFloat(i - 1) * sv.bounds.width
            let imageView = UIImageView(frame: CGRect(x: x, y: 0, width: sv.bounds.width, height: sv.bounds.height))
            imageView.image = image
            sv.isPagingEnabled = true
            sv.showsHorizontalScrollIndicator = false
            sv.isScrollEnabled = true
            sv.addSubview(imageView)
            sv.delegate = self
            
        let pageNumber = round(sv.contentOffset.x / sv.frame.size.width)
        pc.currentPage = Int(pageNumber)
        
            print(pc.currentPage)
            
        }
        
        sv.contentSize = CGSize(width: (sv.frame.width * 3), height:sv.bounds.height)
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = UIColor.red
        pc.pageIndicatorTintColor = UIColor.white
      
        
        if FIRAuth.auth()?.currentUser?.email == nil {
            logout.title = "Login"
        }
        
        
        
        self.tableView.delegate = self
        

            
            buildTable()
        
        
    }
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    func getEventPhoto() {
        
        databaseRef.child("banner").child("1").observe(.value, with: { (snapshot) in
            
            DispatchQueue.main.async(execute: {
                let event = Event(snapshot: snapshot)

                if let eventphotoURL = event.photoURL{
                    
                    self.pic1.loadImageUsingCacheWithUrlString(urlString: eventphotoURL)
                    
                    
                    
                }
                
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
        
        if self.posts.count > 0 {
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
                let post = Post(postKey: postKey, postData: postDict as! Dictionary<String, String>)
                // append post to posts array (of Post type)
            
                self.posts.append(post)
              
                self.posts.reverse() 
            }
            self.tableView.reloadData()
        })
        
        // MARK: - firebase observer to track post edits/changes
        DataService.ds.REF_POSTS.child("Post").observe(.childChanged, with: { (snapshot) in
            let postData = snapshot.value as! Dictionary<String, AnyObject>
            let postKey = snapshot.key
            let updatedPost = Post(postKey: postKey, postData: postData as! Dictionary<String, String>)
            let index = self.posts.index {
                $0.postKey == postKey
            }
            self.posts[index!] = updatedPost
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
 
    }
    

    
    // MARK: - tableView Methods :: set up populating table view with cells
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        
 
        var cell:PostCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "PostCellID") as! PostCell
        
        // check if we can source image from image cache
        if let img = DetailView.imageCache.object(forKey: post.taskImage as NSString) {
            cell.configureCell(post: post, img: img)
        } else {
            // image is not there :: return post data without image
            cell.configureCell(post: post, img: nil)
        }
        // assign tag attribute in shareButton the cell index row number
   
 
        return cell
            }

    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count 
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - logout user

    
    @IBAction func logout(_ sender: Any) {
        
        let currentUser = FIRAuth.auth()?.currentUser
        do {
            try! FIRAuth.auth()!.signOut()
            print("DetailView: RGM: user named, \(currentUser?.email), successfully logged out")
        }
        posts = [Post]()
        haveICheckedFirebase = false
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    @IBOutlet weak var logout: UIBarButtonItem!
    // MARK: - edit post with segue :: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
            
       
        
        performSegue(withIdentifier: "editPostSegue", sender: nil)
        self.tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    // MARK: - prepareForSegue for editPost and logOut
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPostSegue", let dvc = segue.destination as? EditPostView, let postIndex = tableView.indexPathForSelectedRow?.row  {
            
            // back bar text
            let backBar = UIBarButtonItem()
            backBar.title = "Back"
          
            navigationItem.backBarButtonItem = backBar
            
            // assign dvc attributes to carry across to EditView controller on segue
            dvc.post = posts[postIndex]
            
            // when done, deselect the row
            let pathIndex = self.tableView.indexPathForSelectedRow
            self.tableView.deselectRow(at: pathIndex!, animated: true)
        } else if segue.identifier == "goToSignIn" {
            loadDetailView = segue.destination as? LoginViewController
            loadDetailView?.delegate = self
        } else if segue.identifier == "addPostSegue" {
            navigationController?.navigationBar.tintColor = .white
        }
        
            
        if let DestViewController = segue.destination as? Videoviewer {
            
            if pc.currentPage + 1 == 1 {
            
                DestViewController.videoname = "https://firebasestorage.googleapis.com/v0/b/fyp-12f9e.appspot.com/o/R0010158_er.MP4?alt=media&token=c0bc38bd-9065-4c0e-b0ae-785fa973721e" as String!;
            }
            
            if pc.currentPage + 1 == 2 {
                
                DestViewController.videoname = "https://firebasestorage.googleapis.com/v0/b/fyp-12f9e.appspot.com/o/Concourse.mp4?alt=media&token=80487953-c2ad-481c-b8dd-bb7d1eeab676" as String!;
            
            }
            
            if pc.currentPage + 1 == 3 {
                
                DestViewController.videoname = "https://firebasestorage.googleapis.com/v0/b/fyp-12f9e.appspot.com/o/Atrium.MP4?alt=media&token=6c9b2179-6e29-4d8c-8710-97c004d1d87a" as String!;
                
            }
            
//            if pc.currentPage + 1 == 4 {
//                
//                DestViewController.videoname = "https://firebasestorage.googleapis.com/v0/b/fyp-12f9e.appspot.com/o/R0010158_er.MP4?alt=media&token=c0bc38bd-9065-4c0e-b0ae-785fa973721e" as String!;
//                
//            }
            
        }
        
    }
    
    
    
    
    
    
     var timer:Timer!

       func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
              let width = self.view.frame.width
        
              let offsetX = scrollView.contentOffset.x
        
            let index = (offsetX + width / 2) / width
                pc.currentPage = Int(index)
        
            }
    


    
    
        func nextImage() {
           var pageIndex = pc.currentPage
              if pageIndex == 2 {
            
                        pageIndex = 0
            
                  } else {
            
                       pageIndex += 1
            
                     }
   
                let offsetX = CGFloat(pageIndex) * self.view.frame.width
        
            sv.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
            }
    
    
    
}


