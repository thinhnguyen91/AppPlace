//
//  MapVC.swift
//  Baitaplon
//
//  Created by ThinhNX on 4/26/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit
import MapKit
class MapVC: UIViewController {
    
    var place: Place!
    var places = [Place]()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MAP"
        self.navigationController?.navigationBar.barTintColor = uicolorFromHex(16729344)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        mapView.delegate = self
        zoomToRegion()
        
        
   
        
        //pin
     //   let annotations = getMapAnnotations()
      //  mapView.addAnnotations(annotations)
        
    }
    //MARK:- mapview
  //  func getMapAnnotations() -> [Place] {
        
//        var annotations:Array = [Place]()
//        for var i = 0 ; i <= 20 ; i++ {
//            
//            let place = Place(title: "Nha hang \(i)",
//                locationName: " Da nang \(i)",
//                discipline: "Restaurant30",
//                coordinate: CLLocationCoordinate2D(latitude:16.0718911 - 0.01 * Double(i) , longitude:108.2228753 - 0.001 * Double(i) ))
//            place.index = i
//            place.avatar = "nhahang\(i%6)"
//            annotations.append(place)
//        }
//        return annotations
        
   // }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is MKUserLocation) {
            return nil
        }
        let reuseId = "Restaurant30"
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.image = UIImage(named:"Restaurant30")
            anView!.canShowCallout = true
            
            anView!.calloutOffset = CGPoint(x: 0, y: 0)
            
            let place = annotation as! Place
            let button : UIButton = UIButton(type: UIButtonType.DetailDisclosure)
            button.tag = place.index
            
            button.setImage(UIImage(named: "next")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState:UIControlState.Normal)
            button.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            anView!.rightCalloutAccessoryView = button
            
            let buttonlift: UIButton = UIButton(type: UIButtonType.Custom)
            buttonlift.frame.size.width = 44
            buttonlift.frame.size.height = 44
            buttonlift.setImage(UIImage(named: place.avatar)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState:UIControlState.Normal)
            anView!.leftCalloutAccessoryView = buttonlift
        } else {
            anView!.annotation = annotation
        }
        return anView
    }
    
    func buttonClicked(sender: UIButton){
        print(sender.tag)
        let myshow = ShowVC(nibName: "ShowVC", bundle: nil)
//        let item = Place(title: "Nha Hang \(sender.tag) ",
//            locationName: "Da nang \(sender.tag) ",
//            discipline: "Restaurant30",
//            coordinate: CLLocationCoordinate2D(latitude:16.0356373, longitude:108.2102444 ),json: NSArray)
//        myshow.place = item
        self.navigationController?.pushViewController(myshow, animated: true)
    }
    
    // map zom
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 16.0718911, longitude: 108.2228753)
        let span = MKCoordinateSpanMake(0.05, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
extension MapVC: MKMapViewDelegate  {
    
}
