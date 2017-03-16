//
//  VideoCell.swift
//  360Cam
//
//  Created by Tommy Lam on 14/2/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit
import Firebase

class VideoCell: UITableViewCell {
    

    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var ad: UILabel!
    @IBOutlet weak var time: UILabel!
    weak var videoviewcontroller = UIViewController()
    
    var video: Video!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func configureCell(video: Video, img: UIImage? = nil) {
        
        self.video = video
        self.time.text = video.taskDate
        self.ad.text = video.taskAddress + ", " + video.taskSubAddress
        
        
        if img != nil {
            // set image in cell to image in cache
            self.videoImage.image = img
        } else {
            // image is not in cache, so retrieve image from firebase storage
            let ref = FIRStorage.storage().reference(forURL: video.taskImage)
            ref.data(withMaxSize: 6 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("PostCell -> configureCell -> DetailView: RGM: problem downloading image from firebase storage")
                } else {
                    // image downloaded from firebase storage
                    // download the image from firebase storage into cache
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.videoImage.image = img
                            VideoViewController.imageCache.setObject(img, forKey: video.taskImage as NSString)
                        }
                    }
                }
            })
        }
    }
}
