//
//  CountyOverlay.swift
//  iOS8SwiftMapKit
//
//  Created by Kenneth Wilcox on 1/8/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import MapKit

class CountyOverlay: NSObject, MKOverlay {
  
  private let realBoundingMapRect : MKMapRect

  init(rect:MKMapRect) {
    self.realBoundingMapRect = rect
    super.init()
  }
  
  var coordinate : CLLocationCoordinate2D {
    get {
      let pt = MKMapPointMake(MKMapRectGetMidX(self.boundingMapRect), MKMapRectGetMidY(self.boundingMapRect))
      return MKCoordinateForMapPoint(pt)
    }
  }
  
  var boundingMapRect : MKMapRect {
    get {
      return realBoundingMapRect
    }
  }
}
