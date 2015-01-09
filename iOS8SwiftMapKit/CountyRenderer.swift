//
//  CountyRenderer.swift
//  iOS8SwiftMapKit
//
//  Created by Kenneth Wilcox on 1/8/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import MapKit

class CountyRenderer: MKOverlayRenderer {
  
  private let overlayImage: UIImage
  
  init!(overlay: MKOverlay!, image: UIImage) {
    self.overlayImage = image
    super.init(overlay: overlay)
  }
  
  override func drawMapRect(mapRect: MKMapRect, zoomScale: MKZoomScale, inContext context: CGContext!) {
    /*
    CGImageRef imageReference = self.overlayImage.CGImage;
    
    MKMapRect theMapRect = self.overlay.boundingMapRect;
    CGRect theRect = [self rectForMapRect:theMapRect];
    
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -theRect.size.height);
    CGContextDrawImage(context, theRect, imageReference);
    */
    
    let imageReference = self.overlayImage.CGImage
    let theMapRect = self.overlay.boundingMapRect
    let theRect = rectForMapRect(theMapRect)
    
    CGContextScaleCTM(context, 1.0, -1.0)
    CGContextTranslateCTM(context, 0.0, -theRect.size.height)
    CGContextDrawImage(context, theRect, imageReference)
  }
}
