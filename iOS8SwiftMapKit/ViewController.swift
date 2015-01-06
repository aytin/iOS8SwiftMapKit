//
//  ViewController.swift
//  iOS8SwiftMapKit
//
//  Created by Kenneth Wilcox on 1/4/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.delegate = self
    
    let location = CLLocationCoordinate2D (latitude: 43.524492, longitude: -116.614745)
    let span = MKCoordinateSpanMake(0.85, 0.85)
    let region = MKCoordinateRegion(center: location, span: span)
    self.mapView.setRegion(region, animated: true)
    self.mapView.mapType = .Hybrid
    
    for precinct in Precincts.allPrecincts {
      let precinctLocation = CLLocationCoordinate2D(latitude: precinct.latitude, longitude: precinct.longitude)
      let annotation = MKPointAnnotation()
      annotation.setCoordinate(precinctLocation)
      annotation.title = "\(precinct.precinctNo) - \(precinct.name)"
      annotation.subtitle = precinct.address
      
      self.mapView.addAnnotation(annotation)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
    
    if annotation is MKUserLocation {
      //return nil so map view draws "blue dot" for standard user location
      return nil
    }
    
    let reuseId = "pin"
    
    var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      pinView!.canShowCallout = true
      //pinView!.animatesDrop = true
      //pinView!.pinColor = .Purple
      pinView!.image = UIImage(named: "vote-hereSmall.png")
      pinView!.calloutOffset = CGPoint(x: 0.0, y: 32.0)
    }
    else {
      pinView!.annotation = annotation
    }
    
    return pinView
  }
  
  /*
  MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
  if (!pinView)
  {
  // If an existing pin view was not available, create one.
  pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
  pinView.canShowCallout = YES;
  pinView.image = [UIImage imageNamed:@"pizza_slice_32.png"];
  pinView.calloutOffset = CGPointMake(0, 32);
  
  // Add a detail disclosure button to the callout.
  UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
  pinView.rightCalloutAccessoryView = rightButton;
  
  // Add an image to the left callout.
  UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pizza_slice_32.png"]];
  pinView.leftCalloutAccessoryView = iconView;
  } else {
  pinView.annotation = annotation;
  }
  return pinView;
*/
}

