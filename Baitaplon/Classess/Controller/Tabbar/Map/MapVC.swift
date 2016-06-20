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
//    var places = [Place]()
    var photoVenues = [PhotoVenue]()
    var photo: PhotoVenue!
    var venues = [Venue]()
    var venue: Venue!
    var placesTemp = [Place]()

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
        let api = APIController()
        api.getDataFromurl(AppDefine.url) { (success, result, error) -> Void in
            if !success {
                if let error = error {
                    print(error.localizedDescription)
                }
            } else {
                if let result = result {
                    self.venues = result
                    let venue = self.venues[0]
                    let annotations = self.getMapAnnotations()
                    self.mapView.showAnnotations(annotations, animated: true)
                    let url = AppDefine.urlImageEndPoint + venue.id + AppDefine.urlImageOauth_token
                    print(url)
                }
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), { () -> Void in
                    for i in 0 ..< self.venues.count {
                        let vn: Venue = self.venues[i]
                        let url = AppDefine.urlImageEndPoint + vn.id + AppDefine.urlImageOauth_token
                        api.getDataImageurl(url, index: i) { (success, index, imageListString, error) -> Void in
                            if success {
                                if let imageListString = imageListString {
                                    self.venues[index].photos = imageListString
                                }
                                if index == self.venues.count - 1 {
                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        self.mapView.reloadInputViews()
                                    })
                                }
                            } else {
                                if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                })
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("ok")
       
    }
    
    // MARK: Action
    
    func buttonClicked(sender: UIButton){
        print(sender.tag)
        let myshow = ShowVC(nibName: "ShowVC", bundle: nil)
        let item = venues[sender.tag]
        myshow.venue = item
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
        var venueIndex = -1
        for index in venues {
            venueIndex = venueIndex + 1
            let pin = Place(title: index.name , locationName: (index.location?.address)!, discipline: "", coordinate: CLLocationCoordinate2D(latitude:(index.location?.lat)! , longitude: (index.location?.long)!) , index: venueIndex)
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
            let buttionPin : UIButton = UIButton(type: UIButtonType.DetailDisclosure)
            buttionPin.tag = place.index
            buttionPin.setImage(UIImage(named: "next")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState:UIControlState.Normal)
            buttionPin.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            anView!.rightCalloutAccessoryView = buttionPin
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
