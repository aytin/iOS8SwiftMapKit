//
//  ViewController.swift
//  iOS8SwiftMapKit
//
//  Created by Kenneth Wilcox on 1/4/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let location = CLLocationCoordinate2D (latitude: 43.524492, longitude: -116.614745)
    let span = MKCoordinateSpanMake(0.85, 0.85)
    let region = MKCoordinateRegion(center: location, span: span)
    mapView.setRegion(region, animated: true)
    
    //    let annotation = MKPointAnnotation()
    //    annotation.setCoordinate(location)
    //    annotation.title = "Big Ben"
    //    annotation.subtitle = "London"
    //    mapView.addAnnotation(annotation)
    
    for item in Data {
      let dictionary: AnyObject? = item.1
      if let dict = dictionary as? Dictionary<String, AnyObject> {
        if let address = dict["DisplayAddress"] as? NSString {
          //let address: AnyObject? = dict["DisplayAddress"] as String
          println("Precinct: \(item.0) - Address: \(address)")
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

