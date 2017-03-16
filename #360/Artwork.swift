//
//  Artwork.swift
//  360Cam
//
//  Created by Tommy Lam on 29/9/2016.
//  Copyright © 2016 Tommy Lam. All rights reserved.
//

import Foundation
import MapKit
import Contacts


class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let image1: String
    let image2: String
    let videoURL: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, image1: String, image2: String, videoURL: String) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.image1 = image1
        self.image2 = image2
        self.videoURL = videoURL
        
        super.init()
    }

//    class func fromJSON(_ json: [JSONValue]) -> Artwork? {
//        // 1
//        var title: String
//        if let titleOrNil = json[16].string {
//            title = titleOrNil
//        } else {
//            title = ""
//        }
//        let locationName = json[12].string
//        let image1 = json[14].string
//        let image2 = json[13].string
//        let discipline = json[15].string
//        
//        // 2
//        let latitude = (json[18].string! as NSString).doubleValue
//        let longitude = (json[19].string! as NSString).doubleValue
//        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        
//        print(longitude)
//        
//        // 3
//        return Artwork(title: title, locationName: locationName!, discipline: discipline!, coordinate: coordinate, image1: image1!, image2: image2!)
//        
//    }
    
    func pinTintColor() -> UIColor {
        switch discipline {
        case "Image":
            return .red
        case "Video":
            return .green
        default:
            return.red
        }
    }
    
    var subtitle: String? {
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
}
