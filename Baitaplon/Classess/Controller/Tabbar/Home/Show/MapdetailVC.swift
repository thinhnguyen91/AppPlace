//
//  MapdetailVC.swift
//  Baitaplon
//
//  Created by ThinhNX on 5/5/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit
import MapKit
class MapdetailVC: UIViewController {
    var place: Place!
    var mypapvc: MapVC!
    var myshow: ShowVC!
    var myhome: HomeVC!
    var btn = UIButton()
    var btn1 = UIButton()
    @IBOutlet weak var mapdetailview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MapdetailVC"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
         //custom button
        btn.setImage(UIImage(named: "List-25"), forState: .Normal)
        btn.frame = CGRectMake(0, 0, 25, 25)
        btn.addTarget(self, action: Selector("backhome:"), forControlEvents: .TouchUpInside)
        let item = UIBarButtonItem()
        item.customView = btn
        self.navigationItem.rightBarButtonItem = item
        
        btn1.setImage(UIImage(named: "Back-25"), forState: .Normal)
        btn1.frame = CGRectMake(0, 0, 25, 25)
        btn1.setTitle("", forState: UIControlState.Normal)
        btn1.addTarget(self, action: Selector("back:"), forControlEvents: .TouchUpInside)
        let item1 = UIBarButtonItem()
        item1.customView = btn1
        self.navigationItem.leftBarButtonItem = item1
        self.navigationItem.hidesBackButton = true

//        //mapview
//        let location = CLLocationCoordinate2D(
//            latitude: 16.071685,
//            longitude: 108.219485)
//        let span = MKCoordinateSpanMake(0.01, 0.01)
//        let region = MKCoordinateRegion(center: location, span: span)
//        mapdetailview.setRegion(region, animated: true)
//        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        
//        annotation.title = place.title
//        annotation.subtitle = place.subtitle
//        
//        mapdetailview.addAnnotation(annotation)
//       
//        
        self.zoomToRegion()
        // 1.
        mapdetailview.delegate = self
        
        // 2.
        // toa do cho minh
        let sourceLocation = CLLocationCoordinate2D(latitude: 16.075383, longitude:108.233780)
        //toa do nha hang
        let destinationLocation = CLLocationCoordinate2D(latitude: (place.location?.lat)!, longitude: (place.location?.long)!)
        
        // 3.
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "THINH"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = place.title
        destinationAnnotation.subtitle = place.subtitle
       
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        self.mapdetailview.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .Automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculateDirectionsWithCompletionHandler {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapdetailview.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapdetailview.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
    }
    
    func backhome (sender: UIBarButtonItem){
     self.navigationController?.popToRootViewControllerAnimated(true)
    }
    func back(sender: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func mapView(mapView: MKMapView,
        viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
          
            let annotationReuseId = "thinh"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationReuseId)
            if anView == nil {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
            } else {
                anView!.annotation = annotation
            }
            anView!.image = UIImage(named: "map25")
            anView!.backgroundColor = UIColor.clearColor()
            anView!.canShowCallout = true
            
            let buttonlift: UIButton = UIButton(type: UIButtonType.Custom)
            buttonlift.frame.size.width = 44
            buttonlift.frame.size.height = 44
            buttonlift.setImage(UIImage(named: place.avatar)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState:UIControlState.Normal)
            anView!.leftCalloutAccessoryView = buttonlift
            
            return anView
            
    }
 
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.redColor()
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    // map zom
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 16.072096, longitude: 108.226992)
        let span = MKCoordinateSpanMake(0.05, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapdetailview.setRegion(region, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension MapdetailVC: MKMapViewDelegate {
    
}