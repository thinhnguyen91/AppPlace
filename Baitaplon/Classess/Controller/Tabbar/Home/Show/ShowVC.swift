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
    
    var place: Place!
    var places = [Place]()
    var mymapvc: MapVC!
    var myfovaritlevc: FovariteVC!
    var btn = UIButton()
    var btn1 = UIButton()
    var photoVenues = [PhotoVenue]()

    

   
    @IBOutlet weak var buttonLift: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
   
    @IBOutlet weak var Viewscrollimage: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var lableAdd: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    

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
        
        
        
        self.labelName.text = place.name
        self.lableAdd.text = place.location?.address ?? ""
        
        let nib = UINib(nibName:"CustomCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "CustomCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollEnabled = true
        for i in self.photoVenues {
            print("Image image ", i.getURLOriginal())
        }
        
        //mapview
        getmap()
        
        
        //API
        
//        let api = APIController()
//        api.getDataImageurl(AppDefine.urlImage) { (success, imageListString, error) -> Void in
//            if let imageListString = imageListString {
//                self.photoVenues = imageListString
//
//                print("total: \(self.photoVenues.count)")
//                for item in self.photoVenues {
//                    item.img = UIImage(data: NSData(contentsOfURL: NSURL(string: "\(item.getURLPath(300, sizeH: 200))")!)!)!
//                }
//                self.configurePageControl()
//                self.collectionView.reloadData()
//            }
//        }
        self.collectionView.reloadData()
        
    }
    
    
    //MARK: action
 
    @IBAction func ckichLift(sender: AnyObject) {
        if (self.pageControl.currentPage - 1 >= 0) {
            self.pageControl.currentPage = self.pageControl.currentPage - 1
            let newOffset = CGPointMake(CGFloat(self.pageControl.currentPage*Int(collectionView.frame.size.width)), collectionView.contentOffset.y)
            collectionView.setContentOffset(newOffset, animated: true)
        }

    }
    
    @IBAction func ckichRight(sender: AnyObject) {
        print("pagecurrnet" , self.pageControl.currentPage)
        print("Image count", imageArray.count)
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
        place.isFovarite = !place.isFovarite
        
        if place.isFovarite {
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
    
    // MARK: Collection
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoVenues.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
        
        let photo = photoVenues[indexPath.row]
        
        cell.imageCell.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "\(photo.getURLPath(300, sizeH: 200))")!)!)
        
//        cell.imageCell.image = UIImage()
       
        return cell
    }
    
    
    // MARK: map
    func getmap(){
//        let location = CLLocationCoordinate2D(
//            latitude: 16.071685,
//            longitude: 108.219485)
        let location = CLLocationCoordinate2D( latitude: (place.location?.lat)!, longitude: (place.location?.long)!)
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
extension ShowVC: UICollectionViewDelegate,MKMapViewDelegate , UICollectionViewDataSource{
    
}