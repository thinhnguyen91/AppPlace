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
    
    var venue: Venue!
    var place: Place!
    var venues = [Venue]()
    var places = [Place]()
    var photoVenues = [PhotoVenue]()
    var photo: PhotoVenue!
    var mymapvc: MapVC!
    var myfovaritlevc: FovariteVC!
    var btn = UIButton()
    var btn1 = UIButton()
  
    @IBOutlet weak var buttonLift: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    @IBOutlet weak var Viewscrollimage: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var lableAdd: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    
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
        
        if venue.isFovarite {
            btn1.setImage(UIImage(named: "Star_50"), forState: .Normal)
        }  else {
            btn1.setImage(UIImage(named: "star50"), forState: .Normal)
        }
        
        self.title = "SHOW"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        self.labelName.text = venue.name
        self.lableAdd.text = venue.location?.address ?? ""
        
        let nib = UINib(nibName:"CustomCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "CustomCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollEnabled = true
        
        for i in self.photoVenues {
            print("Image image ", i.getURLOriginal())
        }
   
        getmap()
        self.collectionView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("ok")
        self.navigationItem.hidesBackButton = true
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    //MARK: action
    @IBAction func ckickmap(sender: AnyObject) {
        
        let mymapdetailVC = MapdetailVC(nibName: "MapdetailVC", bundle: nil)
        mymapdetailVC.venue = self.venue
        self.navigationController?.pushViewController(mymapdetailVC, animated: true)
        
    }
    @IBAction func ckichLift(sender: AnyObject) {
        if (self.pageControl.currentPage - 1 >= 0) {
            self.pageControl.currentPage = self.pageControl.currentPage - 1
            let newOffset = CGPointMake(CGFloat(self.pageControl.currentPage*Int(collectionView.frame.size.width)), collectionView.contentOffset.y)
            collectionView.setContentOffset(newOffset, animated: true)
        }

    }
    @IBAction func ckichRight(sender: AnyObject) {
        print("pagecurrnet" , self.pageControl.currentPage)
       
        if (self.pageControl.currentPage + 1 < photoVenues.count) {
            self.pageControl.currentPage = self.pageControl.currentPage + 1
            let newOffset = CGPointMake(CGFloat(self.pageControl.currentPage*Int(collectionView.frame.size.width)), collectionView.contentOffset.y)
            collectionView.setContentOffset(newOffset, animated: true)
        }
    }
    
    func back(sender: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func action1(sender: UIBarButtonItem){
        
        print("ckick star")
        venue.isFovarite = !venue.isFovarite
        if venue.isFovarite {
            btn1.setImage(UIImage(named: "Star_50"), forState: .Normal)
        }  else {
            btn1.setImage(UIImage(named: "star50"), forState: .Normal)
        }
        
    }
    
    // pagecontrol
    func configurePageControl() {
        
        self.pageControl.numberOfPages = photoVenues.count
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ShowVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    // MARK: Collection
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoVenues.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
        let photo = photoVenues[indexPath.row]
        cell.imageCell.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "\(photo.getURLPath(300, sizeH: 200))")!)!)
        
        return cell
    }
 
}

extension ShowVC: MKMapViewDelegate{
    
    // MARK: map
    func getmap(){
        let location = CLLocationCoordinate2D( latitude: (venue.location?.lat)!, longitude: (venue.location?.long)!)
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
            
            if (annotation is MKUserLocation) {
                return nil
            }
            let reuseID = "Restaurant30"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
            if anView != nil {
                anView!.annotation = annotation
            } else {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
                anView!.image = UIImage(named:"Marker-25")
            }
            return anView
    }

}