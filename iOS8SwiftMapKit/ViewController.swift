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
    self.mapView.setRegion(region, animated: true)
    self.mapView.mapType = MKMapTypeStandard//MKMapTypeHybrid
    
    for data in Data {
      // I wonder if data.keys and data.values dump the dictionary in the same order?
      // Woot - they ARE!
      let keys = [String](data.keys)
      let values = [String](data.values)
      
      var precinct = ""
      if let index = find(keys, "PrecinctNo") {
        precinct = values[index]
      }
      
      var lat:Double = 0.0
      if let index = find(keys, "Latitude") {
        lat = (values[index] as NSString).doubleValue
      }
      
      var lon:Double = 0.0
      if let index = find(keys, "Longitude") {
        lon = (values[index] as NSString).doubleValue
      }
      
      if let index = find(keys, "PollingPlaceName") {
        precinct = "\(precinct) - \(values[index])"
      }
      
      var address = ""
      if let index = find(keys, "Address") {
        address = values[index]
      }
      
      let precinctLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
      
      let annotation = MKPointAnnotation()
      annotation.setCoordinate(precinctLocation)
      annotation.title = precinct
      annotation.subtitle = address
      
      self.mapView.addAnnotation(annotation)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

