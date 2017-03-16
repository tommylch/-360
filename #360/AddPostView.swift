//
//  AddPostView.swift
//  photoLogger
//
//  Created by Richard Martin on 2016-08-24.
//  Copyright © 2016 richard martin. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import SVProgressHUD
import MobileCoreServices
import AVFoundation

class AddPostView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var drop: DropMenuButton!
    @IBOutlet weak var subText: UILabel!
    
    @IBOutlet weak var longText: UILabel!
    @IBOutlet weak var latText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var addressText: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    var imagePicker: UIImagePickerController!
    var imageSelected: Bool = false
    var locationManager = CLLocationManager()
    var address: String?
    var postDate: String?
    var choice = "blank"
    var lat: String?
    var long: String?
    var subaddress: String?
    
    
    @IBOutlet weak var save: UIButton!
    
    
    
    @IBOutlet weak var videoView: UIImageView!
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drop.setTitle("Location", for: .normal)
        let subaddress = "HKUST"
        drop.initMenu(["North Gate", "North Gate (Video)" , "Sundial", "Sundial (Video)", "Atrium", "Atrium (Video)", "Barn B",  "Barn B (Video)", "Science Common", "Science Common (Video)", "Engine Common", "Engine Common (Video)", "CYT", "CYT (Video)", "Meadow", "Meadow (Video)", "South Gate", "South Gate (Video)", "LSK Entrance", "LSK Entrance (Video)", "UniBar & UC Bistro", "UniBar & UC Bistro (Video)", "LKC University Center", "LKC University Center (Video)", "Concourse", "Concourse (Video)", "Cafe", "Cafe (Video)", "Blue Bridge", "Blue Bridge (Video)", "LG7", "LG7 (Video)", "Bridge Link", "Bridge Link (Video)", "Hall I", "Hall I (Video)", "LSK", "LSK (Video)", "Mushroom", "Mushroom (Video)", "Lo Ka Chung Building", "Lo Ka Chung Building (Video)", "Real Time"],
                      actions: [({ () -> (Void) in
                        print("North Gate" + " " + subaddress)
                        let lat = "22.338758323130296"
                        let long = "114.26210671663284"
                        self.addressText.text = "North Gate"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("North Gate" + " " + subaddress)
                        let lat = "22.339575"
                        let long = "114.259339"
                        self.addressText.text = "North Gate"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Sundial" + " " + subaddress)
                        let lat = "22.337502973582936"
                        let long = "114.26296770572662"
                        self.addressText.text = "Sundial"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Sundial" + " " + subaddress)
                        let lat = "22.337451"
                        let long = "114.262826"
                        self.addressText.text = "Sundial"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                        
                      }), ({ () -> (Void) in
                        print("Atrium" + " " + subaddress)
                        let lat = "22.33747320231023"
                        let long = "114.26356583833694"
                        self.addressText.text = "Atrium"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Atrium" + " " + subaddress)
                        let lat = "22.337503"
                        let long = "114.263786"
                        self.addressText.text = "Atrium"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                        
                      }), ({ () -> (Void) in
                        print("Barn B" + " " + subaddress)
                        let lat = "22.336914989770165"
                        let long = "114.2633955180645"
                        self.addressText.text = "Barn B"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Barn B" + " " + subaddress)
                        let lat = "22.336677"
                        let long = "114.263417"
                        self.addressText.text = "Barn B"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Science Common" + " " + subaddress)
                        let lat = "22.336413837052795"
                        let long = "114.26338210701942"
                        self.addressText.text = "Science Common"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Science Common" + " " + subaddress)
                        let lat = "22.336485"
                        let long = "114.263675"
                        self.addressText.text = "Science Common"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Engine Common" + " " + subaddress)
                        let lat = "22.33604665471073"
                        let long = "114.26343038678169"
                        self.addressText.text = "Engine Common"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Engine Common" + " " + subaddress)
                        let lat = "22.335754"
                        let long = "114.263588"
                        self.addressText.text = "Engine Common"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("CYT" + " " + subaddress)
                        let lat = "22.334801204700703"
                        let long = "114.2635028064251"
                        self.addressText.text = "CYT"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("CYT" + " " + subaddress)
                        let lat = "22.335066"
                        let long = "114.263647"
                        self.addressText.text = "CYT"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Meadow" + " " + subaddress)
                        let lat = "22.33478383778925"
                        let long = "114.26306560635567"
                        self.addressText.text = "Meadow"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Meadow" + " " + subaddress)
                        let lat = "22.334814"
                        let long = "114.263032"
                        self.addressText.text = "Meadow"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("South Gate" + " " + subaddress)
                        let lat = "22.333126528290048"
                        let long = "114.26335126161575"
                        self.addressText.text = "South Gate"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("South Gate" + " " + subaddress)
                        let lat = "22.333258"
                        let long = "114.263275"
                        self.addressText.text = "South Gate"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("LSK Entrance" + " " + subaddress)
                        let lat = "22.33367235095879"
                        let long = "114.26467090845108"
                        self.addressText.text = "LSK Entrance"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("LSK Entrance" + " " + subaddress)
                        let lat = "22.333831"
                        let long = "114.264040"
                        self.addressText.text = "LSK Entrance"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Uni Bar" + " " + subaddress)
                        let lat = "22.33587546801811"
                        let long = "114.26502831280231"
                        self.addressText.text = "Uni Bar"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Uni Bar" + " " + subaddress)
                        let lat = "22.335971"
                        let long = "114.264905"
                        self.addressText.text = "Uni Bar"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("LKC University Center" + " " + subaddress)
                        let lat = "22.335660864113834"
                        let long = "114.26511012017727"
                        self.addressText.text = "LKC University Center"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("LKC University Center" + " " + subaddress)
                        let lat = "22.336041"
                        let long = "114.265039"
                        self.addressText.text = "LKC University Center"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Concourse" + " " + subaddress)
                        let lat = "22.336520518227672"
                        let long = "114.2635390162468"
                        self.addressText.text = "Concourse"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Concourse" + " " + subaddress)
                        let lat = "22.336186"
                        let long = "114.263476"
                        self.addressText.text = "Concourse"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Cafe" + " " + subaddress)
                        let lat = "22.336327003478104"
                        let long = "114.26376700401306"
                        self.addressText.text = "Cafe"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Cafe" + " " + subaddress)
                        let lat = "22.336255"
                        let long = "114.263707"
                        self.addressText.text = "Cafe"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Blue Bridge" + " " + subaddress)
                        let lat = "22.335267629513194"
                        let long = "114.26437452435493"
                        self.addressText.text = "Blue Bridge"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Blue Bridge" + " " + subaddress)
                        let lat = "22.335235"
                        let long = "114.264413"
                        self.addressText.text = "Blue Bridge"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("LG7" + " " + subaddress)
                        let lat = "22.337721296055197"
                        let long = "114.26439061760902"
                        self.addressText.text = "LG7"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("LG7" + " " + subaddress)
                        let lat = "22.337564"
                        let long = "114.264377"
                        self.addressText.text = "LG7"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Bridge Link" + " " + subaddress)
                        let lat = "22.337500492643784"
                        let long = "114.2652328312397"
                        self.addressText.text = "Bridge Link"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Bridge Link" + " " + subaddress)
                        let lat = "22.337343"
                        let long = "114.264341"
                        self.addressText.text = "Bridge Link"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Hall I" + " " + subaddress)
                        let lat = "22.33750545452203"
                        let long = "114.265828281641"
                        self.addressText.text = "Hall I"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Hall I" + " " + subaddress)
                        let lat = "22.337464"
                        let long = "114.265550"
                        self.addressText.text = "Hall I"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("LSK" + " " + subaddress)
                        let lat = "22.333215844872928"
                        let long = "114.2649619281292"
                        self.addressText.text = "LSK"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("LSK" + " " + subaddress)
                        let lat = "22.333461"
                        let long = "114.264940"
                        self.addressText.text = "LSK"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Mushroom" + " " + subaddress)
                        let lat = "22.337361559980984"
                        let long = "114.26412507891655"
                        self.addressText.text = "Mushroom"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Mushroom" + " " + subaddress)
                        let lat = "22.337445"
                        let long = "114.264208"
                        self.addressText.text = "Mushroom"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Lo Ka Chung Building" + " " + subaddress)
                        let lat = "22.332863"
                        let long = "114.266222"
                        self.addressText.text = "Mushroom"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        print("Lo Ka Chung Building" + " " + subaddress)
                        let lat = "22.332882"
                        let long = "114.266053"
                        self.addressText.text = "Mushroom"
                        self.subText.text = subaddress
                        self.latText.text = lat
                        self.longText.text = long
                      }), ({ () -> (Void) in
                        
                        self.locationManager.startUpdatingLocation()
                      })
            ])
        
        
        
        if (FIRAuth.auth()?.currentUser?.isAnonymous)! {
            
            let viewController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
            
            // Creating a navigation controller with viewController at the root of the navigation stack.
            
            present(viewController, animated: true, completion: nil)
            
        }
        
        
        
        
        // self.hideKeyboardWhenTappedAround()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        // initialize and set locationManager property values
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        getDateAndTime()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == UIColor.lightGray {
            descriptionTextView.text = nil
            
        }
    }
    @IBAction func savePost(_ sender: Any) {
        
        self.dismissKeyboard()
        
        // determine time save post button is pushed
        self.postDate = getDateAndTime()
        print("PostView: RGM: self.postDate is ... \(self.postDate)")
        
        // determine if access to user location was denied and if yes, request access again
        if CLLocationManager.authorizationStatus() == .denied {
            let alertController = UIAlertController(
                title: "You Have Denied Access to Your Location",
                message: "In order to provide the address of where your image was taken, please open this app's settings and allow location access to 'While Using the App'.",
                preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .default, handler: { (action) in
                if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            })
            alertController.addAction(openAction)
            self.present(alertController, animated: true, completion: nil)
        }
        guard let postAddress = self.address, postAddress != "" else {
            return
        }
        guard let postDate = self.postDate, postDate != "" else {
            return
        }
        
        
        
        // check to make sure post entries complete
        
        if self.imageView.image == nil {
            if self.videoView.image == nil {
                displayAlert(messageToDisplay: "Please choose a photo or video to upload.")
            }else{
                
            }
            
        }else{
            //upload photo
            // prepare image and post to Firebase Storage
            let imageUID = NSUUID().uuidString
            let imageData = UIImageJPEGRepresentation(self.imageView.image!, 0.2)
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpg"
            
            // initiate progress indicator
            SVProgressHUD.show(withStatus: "Saving Post.")
            
            DataService.ds.REF_IMAGES.child(imageUID).put(imageData!, metadata: metaData) { (metaData, error) in
                if error != nil {
                    print("PostView: RGM: error uploading image to firebase storage")
                } else {
                    print("PostView: RGM: image upload to firebase storage was successful")
                    print("PostView: RGM: imageUID is \(imageUID)")
                    print("PostView: RGM: metaData is \(metaData)")
                    
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                    print("PostView: RGM: downloadURL is \(downloadURL)")
                    if let url = downloadURL {
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            // post data to firebase
                            self.postDataToFirebase(imageURL: url)
                            
                            DispatchQueue.main.async {
                                SVProgressHUD.dismiss()
                                _ = self.navigationController?.popViewController(animated: true)
                                
                            }
                        }
                    }
                }
            }
            
        }
        
        
        
    }
    
    
    
    
    
    // Create the method you want to call (see target before)
    
    
    
    func handleVideoSelectedForUrl(_ url: URL) {
        self.videoView.isHidden = false
        self.imageView.isHidden = true
        self.videoView.image = self.thumbnailImageForFileUrl(url)
        
        
        
        
        
        
        SVProgressHUD.show(withStatus: "Saving Video.")
        let filename = UUID().uuidString + ".mov"
        let uploadTask = FIRStorage.storage().reference().child("message_movies").child(filename).putFile(url, metadata: nil, completion: { (metadata, error) in
            
            if error != nil {
                print("Failed upload of video:")
                return
            }
            
            if let videoUrl = metadata?.downloadURL()?.absoluteString {
                if let thumbnailImage = self.thumbnailImageForFileUrl(url) {
                    
                    self.uploadToFirebaseStorageUsingImage(thumbnailImage, completion: { (imageUrl) in
                        let properties: [String: AnyObject] = ["taskImage": imageUrl as AnyObject, "imageWidth": thumbnailImage.size.width as AnyObject, "imageHeight": thumbnailImage.size.height as AnyObject, "videoUrl": videoUrl as AnyObject , "taskAuthor": FIRAuth.auth()?.currentUser?.uid as AnyObject, "taskDescription": self.descriptionTextView.text as AnyObject, "taskAddress": self.addressText.text as AnyObject, "taskSubAddress": self.subText.text as AnyObject, "taskLat": self.latText.text as AnyObject, "tasklong": self.longText.text as AnyObject, "taskDate": self.timeText.text as AnyObject]
                        self.sendMessageWithProperties(properties)
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            _ = self.navigationController?.popViewController(animated: true)
                            
                        }
                    })
                }
            }
        })
        
        uploadTask.observe(.progress) { (snapshot) in
            if let completedUnitCount = snapshot.progress?.completedUnitCount {
                self.navigationItem.title = "Saving"                        }
        }
        
        uploadTask.observe(.success) { (snapshot) in
            
        }
        
        
    }
    
    
    
    
    
    
    // determine address where photo is taken
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil {
                print(error!)
            } else {
                if let placemark = placemarks?[0] {
                    print("PostView: RGM: placemark: \(placemark)")
                    
                    
                    self.locationManager = CLLocationManager()
                    self.locationManager.delegate = self
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager.requestAlwaysAuthorization()
                    
                    if CLLocationManager.locationServicesEnabled() {
                        self.locationManager.startUpdatingLocation()
                        //locationManager.startUpdatingHeading()
                    }
                    
                    
                    var thoroughfare = ""
                    if placemark.thoroughfare != nil {
                        thoroughfare = placemark.thoroughfare!
                    }
                    var subLocality = ""
                    if placemark.subLocality != nil {
                        subLocality = placemark.subLocality!
                    }
                    var subAdministrativeArea = ""
                    if placemark.subAdministrativeArea != nil {
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                    
                    print("user latitude = \(userLocation.coordinate.latitude)")
                    print("user longitude = \(userLocation.coordinate.longitude)")
                    self.address = subLocality
                    self.subaddress = subAdministrativeArea
                    print("\(self.address)")
                    
                    self.lat = "\(userLocation.coordinate.latitude)"
                    self.long = "\(userLocation.coordinate.longitude)"
                    self.locationManager.stopUpdatingLocation()
                    self.addressText.text = self.address!
                    self.latText.text = self.lat
                    self.longText.text = self.long
                    self.subText.text = self.subaddress
                    
                }
            }
        }
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    
    // determine time and date photo is taken
    func getDateAndTime() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy HH:mm"
        let dateAndTime = dateFormatter.string(from: date as Date)
        self.timeText.text = dateAndTime
        return dateAndTime
    }
    
    
    
    
    // take photo or select image from library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        
        
        if let videoUrl = info[UIImagePickerControllerMediaURL] as? URL {
            //we selected a video
            picker.videoQuality = .typeHigh
            
            
            handleVideoSelectedForUrl(videoUrl)
            
            dismiss(animated: true, completion: nil)
        } else {
            //we selected an image
            
            
            
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            imageView.image = image
            imageView.isHidden = false
            videoView.isHidden = true
            imageSelected = true
            imageView.backgroundColor = UIColor.clear
            imagePicker.dismiss(animated: true, completion: nil)
            
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    fileprivate func uploadToFirebaseStorageUsingImage(_ image: UIImage, completion: @escaping (_ imageUrl: String) -> ()) {
        let imageName = UUID().uuidString
        let ref = FIRStorage.storage().reference().child("post-images").child(imageName)
        
        if let uploadData = UIImageJPEGRepresentation(image, 1.0) {
            ref.put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print("Failed to upload image:")
                    return
                }
                
                if let imageUrl = metadata?.downloadURL()?.absoluteString {
                    completion(imageUrl)
                }
                
            })
        }
    }
    
    fileprivate func thumbnailImageForFileUrl(_ fileUrl: URL) -> UIImage? {
        let asset = AVAsset(url: fileUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            
            let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(1, 60), actualTime: nil)
            
            return UIImage(cgImage: thumbnailCGImage)
            
            
        } catch let err {
            print(err)
        }
        
        return nil
    }
    
    
    
    fileprivate func sendMessageWithProperties(_ properties: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference().child("Video")
        let childRef = ref.childByAutoId()
        let timestamp = NSNumber(value: Int(Date().timeIntervalSince1970))
        
        var values: [String: AnyObject] = [ "timestamp": timestamp]
        
        //append properties dictionary onto values somehow??
        //key $0, value $1
        properties.forEach({values[$0] = $1})
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
            
        }
    }
    
    
    
    
    // upload post data (with image url) to Firebase database
    func postDataToFirebase(imageURL: String) {
        let photoLoggerPost: Dictionary<String, String> = [
            "taskImage": imageURL,
            "taskDescription": descriptionTextView.text!,
            "taskAddress": addressText.text!,
            "taskSubAddress": subText.text!,
            "taskDate": self.postDate!,
            "taskAuthor": FIRAuth.auth()!.currentUser!.uid,
            "taskLat": latText.text!,
            "tasklong": longText.text!
            
        ]
        
        let firebasePost = DataService.ds.REF_POSTS.child("Post").childByAutoId()
        firebasePost.setValue(photoLoggerPost)
    }
    
    
    
    
    // The didFinishPickingMediaWithInfo let's you select an image/video and let's you decide what to do with it. In my example, I decided to convert the selected data into video and upload it to Firebase Storage
    func handleSend() {
        let properties = ["text": self.descriptionTextView.text!]
        sendMessageWithProperties(properties as [String : AnyObject])
    }
    
    
    
    
    @IBAction func chmedia(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // alert controller to display message to user
    func displayAlert(messageToDisplay: String) {
        
        let alertController = UIAlertController(title: "Not Enough Information to Create Post", message: messageToDisplay, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK. Try Again", style: .default) { (action: UIAlertAction!) in
            print("RGM -> AddPostView -> OK button tapped on Alert")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
