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
  
  @IBAction func buttonPressed(sender: AnyObject) {
    // keep this around for debugging
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.delegate = self
    
    let location = CLLocationCoordinate2D (latitude: 43.583962700238274, longitude: -116.67824378418591)
    let span = MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 1.5) // 0.85 previously
    let region = MKCoordinateRegion(center: location, span: span)
    self.mapView.setRegion(region, animated: true)
    self.mapView.mapType = .Standard
    
    for pollingLocation in PollingLocations.allPollingLocations {
      let precinctLocation = CLLocationCoordinate2D(latitude: pollingLocation.latitude, longitude: pollingLocation.longitude)
      let annotation = MKPointAnnotation()
      annotation.setCoordinate(precinctLocation)
      annotation.title = "\(pollingLocation.precinctNo): \(pollingLocation.name)".capitalizedString
      annotation.subtitle = pollingLocation.address.capitalizedString
      
      self.mapView.addAnnotation(annotation)
    }
    
//    var coordinates = [CLLocationCoordinate2DMake(43.786266, -116.943101),
//      CLLocationCoordinate2DMake(43.725804, -116.800402),
//      CLLocationCoordinate2DMake(43.735839, -116.696920)]
//    let overlay = MKPolygon(coordinates: &coordinates, count: coordinates.count)
//    
//    self.mapView.addOverlay(overlay)
    
    var northEast = CLLocationCoordinate2DMake(43.85532635264545, -116.17790222851562)
    var neOrigin: MKMapPoint = MKMapPointForCoordinate(northEast)
    
    var southWest = CLLocationCoordinate2DMake(43.358137025577584, -117.1392059394531)
    var swOrigin = MKMapPointForCoordinate(southWest)
    
    var size: MKMapSize = MKMapSizeMake(swOrigin.x - neOrigin.x, swOrigin.y - neOrigin.y)
    var origin = MKMapPoint(x: swOrigin.x - neOrigin.x, y: swOrigin.y - neOrigin.y)
    var rect: MKMapRect = MKMapRect(origin: neOrigin, size: size)
    var county = CountyOverlay(rect: rect)
    self.mapView.addOverlay(county)
    
    let ne = MKPointAnnotation()
    ne.setCoordinate(northEast)
    ne.title = "northEast"
    self.mapView.addAnnotation(ne)
    
    let sw = MKPointAnnotation()
    sw.setCoordinate(southWest)
    sw.title = "southWest"
    self.mapView.addAnnotation(sw)
    
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
      pinView!.animatesDrop = true
      pinView!.pinColor = .Purple
      //pinView!.image = UIImage(named: "vote-hereSmall.png")
      //pinView!.calloutOffset = CGPoint(x: 0.0, y: 32.0)
    }
    else {
      pinView!.annotation = annotation
    }
    
    return pinView
  }
  
  func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
    if overlay is MKPolygon {
      var view = MKPolygonRenderer(overlay: overlay)
      view!.fillColor = UIColor.cyanColor().colorWithAlphaComponent(0.2)
      view!.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.7)
      view!.lineWidth = 3.0
      return view
    }
    else if overlay is CountyOverlay {
      /*
      UIImage *magicMountainImage = [UIImage imageNamed:@"overlay_park"];
      PVParkMapOverlayView *overlayView = [[PVParkMapOverlayView alloc] initWithOverlay:overlay overlayImage:magicMountainImage];
      
      return overlayView;
*/
      
      let countyImage = UIImage(named: "canyon.png")
      let view = CountyRenderer(overlay: overlay, image: countyImage!)
      return view
    }
    
    return nil
  }
  
  func mapView(mapView: MKMapView!, viewForOverlay overlay: MKOverlay!) -> MKOverlayView! {
    var pV  = MKPolygonView(overlay: overlay)
    
    return pV
  }
}

