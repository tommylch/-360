//
//  PostCell.swift
//  photoLogger
//
//  Created by Richard Martin on 2016-07-25.
//  Copyright © 2016 richard martin. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var time: UILabel!

    
    weak var detailViewController = UIViewController()
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    func configureCell(post: Post, img: UIImage? = nil) {
        
        self.post = post
        


        time.text = post.taskDate
        address.text = post.taskAddress + ", " + post.taskSubAddress
        
        
        if img != nil {
            // set image in cell to image in cache
            self.postImage.image = img
        } else {
            // image is not in cache, so retrieve image from firebase storage
            let ref = FIRStorage.storage().reference(forURL: post.taskImage)
            ref.data(withMaxSize: 6 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("PostCell -> configureCell -> DetailView: RGM: problem downloading image from firebase storage")
                } else {
                    // image downloaded from firebase storage
                    // download the image from firebase storage into cache
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImage.image = img
                            DetailView.imageCache.setObject(img, forKey: post.taskImage as NSString)
                        }
                    }
                }
            })
        }
    }
}
