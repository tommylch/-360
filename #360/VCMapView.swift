
//  VCMapView.swift
//  360Cam
//
//  Created by Tommy Lam on 29/9/2016.
//  Copyright © 2016 Tommy Lam. All rights reserved.
//

import UIKit
import MapKit

extension Map: MKMapViewDelegate {
    
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton (type: .detailDisclosure) as UIView
                
                let Routebutton = UIButton (type: .custom)
                
                view.leftCalloutAccessoryView = Routebutton as UIView
                let image = UIImage(named: "Routeicon2.png")
                Routebutton.setImage(image, for: .normal)
                Routebutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                
            }
            
            view.pinTintColor = annotation.pinTintColor()
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {

            if let viewController = self.storyboard!.instantiateViewController(withIdentifier: "Annotation Detail") as? AnnotationDetail {

                if let detail = view.annotation as? Artwork {
                    viewController.detail = detail
                    viewController.delegate = self;
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
        else if control == view.leftCalloutAccessoryView {
            
            let location = view.annotation as! Artwork
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem().openInMaps(launchOptions: launchOptions)
            
                }
            }
        }


extension Map: AnnotationDetailDelegate {
    func AnnotationDetailDidFinish(_ controller: AnnotationDetail) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
