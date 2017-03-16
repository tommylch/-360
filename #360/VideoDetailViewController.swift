//
//  VideoDetailViewController.swift
//  360Cam
//
//  Created by Tommy Lam on 15/2/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit

class VideoDetailViewController: UIViewController {
var video: Video?
        @IBOutlet weak var timeText: UILabel!
        @IBOutlet weak var addressText: UILabel!
        @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.descriptionText.text = video?.taskDescription
        self.addressText.text = video?.taskAddress
        self.timeText.text = video?.taskDate
        self.imageView.image = VideoViewController.imageCache.object(forKey: video!.taskImage as NSString)
        
        print(video!.taskImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let DestViewController = segue.destination as? Videoviewer {
            
            DestViewController.videoname = video!.taskvideoUrl as String!;
            
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
