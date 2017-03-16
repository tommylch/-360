//
//  PVideoCell.swift
//  #360
//
//  Created by Chan Sin Tik on 27/2/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit
import Firebase

class PVideoCell: UITableViewCell {
    weak var placeviewcontroller = UIViewController()
    
    var video: Video!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var ad: UILabel!
    @IBOutlet weak var cap: UILabel!
    @IBOutlet weak var imahe: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(video: Video, img: UIImage? = nil) {
        
        self.video = video
        self.time.text = video.taskDate
        self.ad.text = video.taskAddress + " " + video.taskSubAddress
        
        
        if img != nil {
            // set image in cell to image in cache
            self.imahe.image = img
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
                            self.imahe.image = img
                            PlaceViewController.imageCache.setObject(img, forKey: video.taskImage as NSString)
                        }
                    }
                }
            })
        }
    }


}
