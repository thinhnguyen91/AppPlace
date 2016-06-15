//
//  ShowVC.swift
//  Baitaplon
//
//  Created by ThinhNX on 4/27/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit
import MapKit
class ShowVC: UIViewController {
    var imageArray = [UIImage(named: "nhahang0"), UIImage(named: "nhahang1"), UIImage(named: "nhahang2"),UIImage(named: "nhahang3"),UIImage(named: "nhahang4"),UIImage(named: "nhahang5")]
    var imageViews:[UIImageView] = []
    var place: Place!
    var mymapvc: MapVC!
    var myfovaritlevc: FovariteVC!
    var btn = UIButton()
    var btn1 = UIButton()
    
    @IBOutlet weak var buttonR: UIButton!
    @IBOutlet weak var buttonL: UIButton!
    @IBOutlet weak var Viewscrollimage: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollImage: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var lableAdd: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    
    //MARK: action
    @IBAction func ckickR(sender: AnyObject) {
        
        if (self.pageControl.currentPage + 1 < imageArray.count) {
            self.pageControl.currentPage = self.pageControl.currentPage + 1
            let newOffset = CGPointMake(CGFloat(self.pageControl.currentPage*Int(scrollImage.frame.size.width)), scrollImage.contentOffset.y)
            scrollImage.setContentOffset(newOffset, animated: true)
        }
    }
    @IBAction func ckickL(sender: AnyObject) {
        
        if (self.pageControl.currentPage - 1 >= 0) {
            self.pageControl.currentPage = self.pageControl.currentPage - 1
            let newOffset = CGPointMake(CGFloat(self.pageControl.currentPage*Int(scrollImage.frame.size.width)), scrollImage.contentOffset.y)
            scrollImage.setContentOffset(newOffset, animated: true)
        }
    }
    
    @IBAction func ckickmap(sender: AnyObject) {
        
        let mymapdetailVC = MapdetailVC(nibName: "MapdetailVC", bundle: nil)
        mymapdetailVC.place = self.place
        self.navigationController?.pushViewController(mymapdetailVC, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageControl()
        
        //custom button
        btn1.setImage(UIImage(named: "star50"), forState: .Normal)
        btn1.frame = CGRectMake(0, 0, 25, 25)
        btn1.addTarget(self, action: Selector("action1:"), forControlEvents: .TouchUpInside)
        let item1 = UIBarButtonItem()
        item1.customView = btn1
        self.navigationItem.rightBarButtonItem = item1
        
        btn.setImage(UIImage(named: "Back-25"), forState: .Normal)
        btn.frame = CGRectMake(0, 0, 25, 25)
        btn.setTitle("", forState: UIControlState.Normal)
        btn.addTarget(self, action: Selector("back:"), forControlEvents: .TouchUpInside)
        let item = UIBarButtonItem()
        item.customView = btn
        self.navigationItem.leftBarButtonItem = item
        
        if place.isFovarite {
            btn1.setImage(UIImage(named: "Star_50"), forState: .Normal)
        }  else {
            btn1.setImage(UIImage(named: "star50"), forState: .Normal)
        }

        self.title = "SHOW"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //scrollimage
        scrollImage.showsHorizontalScrollIndicator = false
        scrollImage.pagingEnabled = true
        scrollImage.scrollEnabled = true
        scrollImage.delegate = self
        for (index, image) in imageArray.enumerate() {
            let imageView = UIImageView(image: image)
            scrollImage.addSubview(imageView)
            imageViews.append(imageView)
            imageView.frame = CGRectMake(CGFloat(index)*scrollImage.frame.size.width, 0,scrollImage.frame.size.width,scrollImage.frame.size.height)
        }
        scrollImage.contentSize = CGSizeMake(scrollImage.frame.size.width*CGFloat(imageArray.count),scrollImage.frame.size.height)
        
        self.labelName.text = place.title
        self.lableAdd.text = place.locationName
        
        //mapview
        getmap()
        
    }
    
    func back(sender: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func action1(sender: UIBarButtonItem){
        
        print("ckick star")
        place.isFovarite = !place.isFovarite
        
        if place.isFovarite {
            btn1.setImage(UIImage(named: "Star_50"), forState: .Normal)
        }  else {
            btn1.setImage(UIImage(named: "star50"), forState: .Normal)
        }
        
    }
    // pagecontrol
    func configurePageControl() {
        
        self.pageControl.numberOfPages = imageArray.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.grayColor()
        self.pageControl.pageIndicatorTintColor = UIColor.grayColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
        self.Viewscrollimage.addSubview(pageControl)
        
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
  
    
    //map
    func getmap(){
        let location = CLLocationCoordinate2D(
            latitude: 16.071685,
            longitude: 108.219485)
        let span = MKCoordinateSpanMake(0.009, 0.009)
        let region = MKCoordinateRegion(center: location, span: span)
        mapview.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapview.addAnnotation(annotation)
        mapview.delegate = self
    }
    func mapView(mapView: MKMapView,
        viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            
            if (annotation is MKUserLocation) { return nil }
            
            let reuseID = "Restaurant30"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
            
            if anView != nil {
                anView!.annotation = annotation
            } else {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
                
                anView!.image = UIImage(named:"Restaurant30")
            }
            
            return anView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ShowVC: UIScrollViewDelegate,MKMapViewDelegate {
    
}