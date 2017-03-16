//
//  PVideoViewController.swift
//  #360
//
//  Created by Chan Sin Tik on 27/2/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit

class PVideoViewController: UIViewController {
var video: Video?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.caption.text = video?.taskDescription
        self.address.text = video?.taskAddress
        self.time.text = video?.taskDate
        self.videoImage.image = VPlaceViewController.imageCache.object(forKey: video!.taskImage as NSString)


        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
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
