//
//  AnnotationDetail.swift
//  360Cam
//
//  Created by Tommy Lam on 8/10/2016.
//  Copyright © 2016 Tommy Lam. All rights reserved.
//

import UIKit

@objc protocol AnnotationDetailDelegate {
    @objc optional func AnnotationDetailDidFinish(_ controller: AnnotationDetail)
}

@objc class AnnotationDetail: UIViewController {
  weak var delegate: AnnotationDetailDelegate?
    
    @IBOutlet weak var Controller: UISegmentedControl!
    @IBOutlet weak var ViewerButton1: UIButton!
    @IBOutlet weak var ImageView1: UIImageView!
    @IBOutlet weak var ViewerButton2: UIButton!
    @IBOutlet weak var ImageView2: UIImageView!


    let LabelText = String()
    var image1name = NSString()
    var image2name = NSString()
    var videoURL = String()
    
    var detail: Artwork? {
        didSet {
            self.setupWithDetail()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if videoURL == "" {
//            self.Controller.setTitle("360° Image", forSegmentAt: 0)
//        }
//        else {
//            self.Controller.setTitle("360° Video", forSegmentAt: 0)
//        }
        
        ViewerButton1.isHidden = false
        ViewerButton2.isHidden = false
        ImageView1.isHidden = false
        ImageView2.isHidden = false
        
        self.setupWithDetail()
    }
    
    @IBAction func ChangeSegment(_ sender: AnyObject) {
        
        if Controller.selectedSegmentIndex == 0 {
        
            ViewerButton1.isHidden = false
            ViewerButton2.isHidden = false
            ImageView1.isHidden = false
            ImageView2.isHidden = false
        
        }
        
        if Controller.selectedSegmentIndex == 1 {
            
            ViewerButton1.isHidden = true
            ViewerButton2.isHidden = true
            ImageView1.isHidden = true
            ImageView2.isHidden = true
            
        }
        
    }
    
    
    fileprivate func setupWithDetail() {
        if !self.isViewLoaded {
            return
        }
        
        if let detail = self.detail {
            self.title = detail.title
            
            image1name = detail.image1 as NSString
            image2name = detail.image2 as NSString
            
            videoURL = detail.videoURL as String
            print(videoURL)
            
            let image1namestring = image1name as String
            let image2namestring = image2name as String
            print(image1name)

            let url1 = NSURL(string: image1namestring)
            let data1 = NSData(contentsOf: url1 as! URL)
            self.ImageView1.image = UIImage(data: data1! as Data)
            
            if image2namestring.isEmpty {}
            else {
            let url2 = NSURL(string: image2namestring)
            let data2 = NSData(contentsOf: url2 as! URL)
            self.ImageView2.image = UIImage(data: data2! as Data)
        // Do any additional setup after loading the view.
            }
        }

    }
    
    @IBAction func PerformSegue(_ sender: UIButton) {
    
        if videoURL == "" {
            self.performSegue(withIdentifier: "Seguetoviewer1", sender: sender)
        }
        else {
            self.performSegue(withIdentifier: "seguetovideoviewer", sender: sender)
        }
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Seguetoviewer1" {
            
            if let DestViewController = segue.destination as? ViewControllerURL   {
                
                DestViewController.imageName = image1name as String!;}
            
        }
        
        if segue.identifier == "seguetovideoviewer" {
        
            if let DestViewController = segue.destination as? Videoviewer {
            
                DestViewController.videoname = videoURL as String!;            
            }
        }
        
        if segue.identifier == "Seguetoviewer2" {
                
            if let DestViewController = segue.destination as? ViewControllerURL   {
                
                DestViewController.imageName = image2name as String!;}
                
            }
        }


    @IBAction func back(_ sender: Any) {
        
        self.delegate?.AnnotationDetailDidFinish?(self)

    }
}

