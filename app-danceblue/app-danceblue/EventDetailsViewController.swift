//
//  EventDetailsViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import MapKit

class EventDetailsViewController: UIViewController {

    var event: Event?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = event?.title ?? ""
        print(event?.title ?? "Error")
        // Do any additional setup after loading the view.
    }
    
    func setupMapView() {
        
        let geocoder = CLGeocoder()
        var placemark: MKPlacemark?
        geocoder.geocodeAddressString((event?.address)!) { (placemarks: [CLPlacemark]?, error) in
            if (placemarks?.count)! > 0 {
                let result = placemarks?[0]
                placemark = MKPlacemark(placemark: result!)
            }
        }
        
        mapView.addAnnotation(placemark!)
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.7127, longitude: -74.0059), addressDictionary: nil))
        request.destination = MKMapItem(placemark: placemark!)
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.add(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
        mapView.mapType = .hybrid
        
    }

}
