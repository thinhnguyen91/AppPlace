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
    var photoVenues = [PhotoVenue]()
    var photo: PhotoVenue!
    var venues = [Venue]()
    var venue: Venue!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MAP"
        self.navigationController?.navigationBar.barTintColor = uicolorFromHex(16729344)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        mapView.delegate = self
        zoomToRegion()
        
        //API
        let api = APIController()
        api.getDataFromurl(AppDefine.url) { (success, result, error) -> Void in
            if !success {
                if let error = error {
                    print(error.localizedDescription)
                }
            } else {
                if let result = result {
                    
                    self.venues = result
                    // pin
                    let annotations = self.getMapAnnotations()
                    self.mapView.showAnnotations(annotations, animated: true)

                    
                    api.getDataImageurl(AppDefine.urlImage) { (success, imageListString, error) -> Void in
                        if success {
                            if let imageListString = imageListString {
                                self.photoVenues = imageListString
                            }
                            self.mapView.reloadInputViews()
                        } else {
                            if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }

        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("ok")
       
    }
    
    
    
    func buttonClicked(sender: UIButton){
        print(sender.tag)
        let myshow = ShowVC(nibName: "ShowVC", bundle: nil)
        let item = Place(title: venue.name,
            locationName: (venue.location?.address)! ,
            discipline: "Restaurant30",
            coordinate: CLLocationCoordinate2D(latitude: (venue.location?.lat)! , longitude: (venue.location?.long)! ))
        myshow.place = item
        self.navigationController?.pushViewController(myshow, animated: true)
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
    
    
    // MARK:- mapview
    func getMapAnnotations()-> [Place] {
        
        var placesTemp = [Place]()
        for index in venues {
            let pin = Place(title: index.name , locationName: (index.location?.address)!, discipline: "", coordinate: CLLocationCoordinate2D(latitude:(index.location?.lat)! , longitude: (index.location?.long)!))
            placesTemp.append(pin)
        }
        return placesTemp
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is MKUserLocation) {
            return nil
        }
        let reuseId = "Restaurant30"
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.image = UIImage(named:"Marker-25")
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
            //buttonlift.setImage(UIImage(named: photo.getURLPath(44, sizeH: 44))?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState:UIControlState.Normal)
            anView!.leftCalloutAccessoryView = buttonlift
        } else {
            anView!.annotation = annotation
        }
        return anView
    }
    
    func mapViewWillStartLoadingMap(mapView: MKMapView){
        self.activityIndicator.startAnimating()
        
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView){
        self.activityIndicator.stopAnimating()
        activityIndicator.hidden = true
    }
    // map zom
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 16.0718911, longitude: 108.2228753)
        let span = MKCoordinateSpanMake(0.05, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}
