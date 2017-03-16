//
//  Map.swift
//  360Cam//
//  Created by Tommy Lam on 8/9/2016.//  Copyright © 2016 Tommy Lam. All rights reserved.
//

import UIKit
import MapKit
import Firebase


protocol HandleMapSearch {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}

class Map: UIViewController {
    
    var selectedPin:MKPlacemark? = nil
    
    var resultSearchController:UISearchController? = nil
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadInitialData()

        getallannotation()
        
//        mapView.addAnnotations(artworks)
        

        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
        
        // Do any additional setup after loading the view.
        
        

        // show artwork on map
//        let latitude = (latlng.lat! as NSString).doubleValue
//        let longitude = (latlng.long! as NSString).doubleValue
//        
//        let artwork = Artwork(title: latlng.address!,
//                              locationName: "test",
//                              discipline: "Sculpture",
//                              coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
//                              image1: latlng.imageURL!,
//                              image2: latlng.imageURL!)
//        print("\(latlng.imageURL)")
//
//        mapView.addAnnotation(artwork)

        
        mapView.delegate = self
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        // set initial location in HKUST
        let initialLocation = CLLocation(latitude: 22.336102, longitude: 114.263863)
        centerMapOnLocation(initialLocation)
        

    }
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    
        var artworks = [Artwork]()
    
//        func loadInitialData() {
//            // 1
//            let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json");
//            var data: Data?
//            do {
//                data = try Data(contentsOf: URL(fileURLWithPath: fileName!), options: NSData.ReadingOptions(rawValue: 0))
//            } catch _ {
//                data = nil
//            }
//            
//            // 2
//            var jsonObject: Any? = nil
//            if let data = data {
//                do {
//                    jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
//                } catch _ {
//                    jsonObject = nil
//                }
//            }
//            
//            // 3
//            if let jsonObject = jsonObject as? [String: Any],
//                // 4
//                let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
//                for artworkJSON in jsonData {
//                    if let artworkJSON = artworkJSON.array,
//                        // 5
//                        let artwork = Artwork.fromJSON(artworkJSON) {
//                        artworks.append(artwork)
//                    }
//                }
//            }
//        }
//    
        func centerMapOnLocation(_ location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 0.5, regionRadius * 0.5)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    
    func getallannotation() {
        
        databaseRef.child("Post").observe(.childAdded, with: {(snapshot) in
            
            let postData = snapshot.value as! Dictionary<String, AnyObject>
//            let postKey = snapshot.key
            
            let latitude = (postData["taskLat"] as! NSString).doubleValue
            let longitude = (postData["tasklong"] as! NSString).doubleValue
            
            let artwork = Artwork(title: postData["taskAddress"] as! String,
                                  locationName: postData["taskSubAddress"] as! String,
                                  discipline: "Image",
                                  coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                  image1: postData["taskImage"] as! String,
                                  image2: "",
                                  videoURL: "") 

            self.mapView.addAnnotation(artwork)
            
            })
        
        databaseRef.child("Video").observe(.childAdded, with: {(snapshot) in
        
            let VideoData = snapshot.value as! Dictionary<String, AnyObject>
            
            let latitude = (VideoData["taskLat"] as! NSString).doubleValue
            let longitude = (VideoData["tasklong"] as! NSString).doubleValue
            
            let artwork = Artwork(title: VideoData["taskAddress"] as! String,
                                  locationName: VideoData["taskSubAddress"] as! String,
                                  discipline: "Video",
                                  coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                  image1: VideoData["taskImage"] as! String,
                                  image2: "",
                                  videoURL: VideoData["videoUrl"] as! String)
        
            self.mapView.addAnnotation(artwork)
            
        })
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension Map : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}

extension Map: HandleMapSearch {
    func dropPinZoomIn(_ placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        getallannotation()
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}

