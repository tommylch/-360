//
//  PlaceCell.swift
//  360Cam
//
//  Created by Chan Sin Tik on 1/2/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PlaceCell: UITableViewCell {
    
    weak var detailViewController = UIViewController()
    
    var photo: Photo!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var placeView: UIImageView!
    
    func configureCell(photo: Photo, img: UIImage? = nil) {
        
        self.photo = photo
        self.time.text = photo.taskDate
        self.address.text = photo.taskAddress + " " + photo.taskSubAddress
        // descriptiontext.text = photo.taskDescription
        
        
        
        if img != nil {
            // set image in cell to image in cache
            self.placeView.image = img
        } else {
           // SVProgressHUD.show(withStatus: "Loading")
            
            // image is not in cache, so retrieve image from firebase storage
            let ref = FIRStorage.storage().reference(forURL: photo.taskImage)
            ref.data(withMaxSize: 6 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("PostCell -> configureCell -> DetailView: RGM: problem downloading image from firebase storage")
                } else {
                    // image downloaded from firebase storage
                    // download the image from firebase storage into cache
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                           // SVProgressHUD.dismiss()
                            self.placeView.image = img
                            PlaceViewController.imageCache.setObject(img, forKey: photo.taskImage as NSString)
                        }
                    }
                }
            })
        }
    }
    
    
}
