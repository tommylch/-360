//
//  ViewPhotoController.swift
//  360Cam
//
//  Created by Chan Sin Tik on 1/2/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit

class ViewPhotoController: UIViewController {

    var photo: Photo?
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskImage: UIImageView!


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskDescription.text = photo?.taskDescription
        self.address.text = photo?.taskAddress
        self.time.text = photo?.taskDate
        self.taskImage.image = PlaceViewController.imageCache.object(forKey: photo!.taskImage as NSString)
        
        print(photo!.taskImage)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DestViewController = segue.destination as? ViewControllerURL {
            
            DestViewController.imageName = photo!.taskImage as String!;
            
        }

  
    }

}
