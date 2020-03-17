//
//  HomeTableViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 2/3/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView
class HomeTableViewController: UITableViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,selectCity {
    
    @IBOutlet weak var whereToBtnOutlet: UIButton!
    @IBOutlet weak var categoryCollView: UICollectionView!
    @IBOutlet weak var recommendCollView: UICollectionView!
    @IBOutlet weak var nearbyCollView: UICollectionView!
    let categoryImgArr = ["Ticket2-2.png","Mountain.png","Hotel2-1.png","Restaurant-1.png"]
    let categoryArr = ["Things to Do","Attractions","Hotels","Restaurants"]
    let recommendImgArr = ["Quad Biking.jpg","Diving.jpg","Old Market.jpg","concorde-el-salam-hotel.jpg","hotel-lagona-village.jpg","Tirana Dahab Resort.jpg","Daniela Village.jpg"]
    let recommendArr = ["Quad Biking","Diving","Visit Old Market","Concord El Salam Hotel","Lagona Village Hotel","Tirana Dahab Resort","Daniela Village"]
    let recommendRateArr = [4.5,5,3.5,4.5,3.5,4,4.5]
    let nearbyImgArr = ["Mercure.jpg","Tolip Elforsan.jpg"]
    let nearbyArr = ["Mercure Elforsan Hotel","Tolip Elforsan Hotel"]
    let nearbyRateArr = [4.5,3.5]
    let locArr = ["Sharm El Shiekh","Sharm El Shiekh","Sharm El Shiekh","Sharm El Shiekh","Dahab","Dahab","Dahab"]
    let recCategory = ["Things to Do in","Things to Do in","Things to Do in","Hotels in","Hotels in","Hotels in","Hotels in"]
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(title: "HOME", style: .plain, target: nil, action:nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whereToBtnOutlet.layer.cornerRadius = whereToBtnOutlet.frame.width/5.8
        //whereToBtnOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
        //whereToBtnOutlet.titleLabel?.minimumScaleFactor = 0.3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == recommendCollView){
            return recommendArr.count
        }else if(collectionView == nearbyCollView){
            return nearbyArr.count
        }
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == recommendCollView){
            let cell = recommendCollView.dequeueReusableCell(withReuseIdentifier: "recCell", for: indexPath)
            let recImg :UIImageView = cell.viewWithTag(1) as! UIImageView
            recImg.image = UIImage(named: recommendImgArr[indexPath.row])
            recImg.layer.cornerRadius = 8
            let recTextView :UITextView = cell.viewWithTag(2) as! UITextView
            recTextView.text = recommendArr[indexPath.row]
            let recStarRate : SwiftyStarRatingView = cell.viewWithTag(3) as! SwiftyStarRatingView
            recStarRate.value = CGFloat(recommendRateArr[indexPath.row])
            let recLocation : UITextField = cell.viewWithTag(4) as! UITextField
            recLocation.text = locArr[indexPath.row]
            let recCat : UITextField = cell.viewWithTag(5) as! UITextField
            recCat.text = recCategory[indexPath.row]
            
            return cell
            }
        else if(collectionView == nearbyCollView){
            let cell = nearbyCollView.dequeueReusableCell(withReuseIdentifier: "nearbyCell", for: indexPath)
            let nearbyImg :UIImageView = cell.viewWithTag(1) as! UIImageView
            nearbyImg.image = UIImage(named: nearbyImgArr[indexPath.row])
            nearbyImg.layer.cornerRadius = 8
            let nearbyTextView :UITextView = cell.viewWithTag(2) as! UITextView
            nearbyTextView.text = nearbyArr[indexPath.row]
            let nearbyStarRate : SwiftyStarRatingView = cell.viewWithTag(3) as! SwiftyStarRatingView
            nearbyStarRate.value = CGFloat(nearbyRateArr[indexPath.row])
            let recLocation : UITextField = cell.viewWithTag(4) as! UITextField
            recLocation.text = "Ismailia"
            
            return cell
        }
        let cell = categoryCollView.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath)
        let catImg :UIImageView = cell.viewWithTag(1) as! UIImageView
        catImg.image = UIImage(named:categoryImgArr[indexPath.row])
        let catTextView :UITextView = cell.viewWithTag(2) as! UITextView
        catTextView.textContainer.maximumNumberOfLines = 2
        catTextView.textContainer.lineBreakMode = .byClipping
        catTextView.text = categoryArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == categoryCollView){
            let ResListTVC : ResultListTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "RLTVC") as! ResultListTableViewController
            if indexPath.row==2{
                ResListTVC.title="Hotels"
                self.navigationController?.pushViewController(ResListTVC, animated: true)
            }
            if indexPath.row==0{
                ResListTVC.title="Things to do"
                self.navigationController?.pushViewController(ResListTVC, animated: true)
            }
            if indexPath.row==1{
                ResListTVC.title="Attractions"
                self.navigationController?.pushViewController(ResListTVC, animated: true)
            }
            if indexPath.row==3{
                ResListTVC.title="Resturants"
                self.navigationController?.pushViewController(ResListTVC, animated: true)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if(collectionView == recommendCollView) || (collectionView == nearbyCollView){
            return 9.0
        }
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == categoryCollView){
            let height : CGFloat = self.categoryCollView.frame.size.height
            let width : CGFloat = self.categoryCollView.frame.size.width
            //return CGSize(width: width * 0.2475 , height: height * 0.9 )
            //return CGSize(width: width * 0.248 , height: height * 0.98 )
            return CGSize(width: width * 0.2475 , height: height * 0.92 )
        }else if(collectionView == nearbyCollView){
            let height : CGFloat = self.recommendCollView.frame.size.height
            let width : CGFloat = self.recommendCollView.frame.size.width
            return CGSize(width: width * 0.89 , height: height )
        }
        let height : CGFloat = self.recommendCollView.frame.size.height
        let width : CGFloat = self.recommendCollView.frame.size.width
        return CGSize(width: width * 0.89 , height: height )
    }
    
    func selectCity(city: String) {
        //whereToBtnOutlet.titleLabel?.text = city
        whereToBtnOutlet.setTitle(city, for: .normal)
        
    }
    
    @IBAction func whereToBtnAction(_ sender: Any) {
        let citiesTVC : CitiesTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "citiesTVC") as! CitiesTableViewController
        citiesTVC.delegate = self
        //self.navigationController?.pushViewController(citiesTVC, animated: true)
        self.present(citiesTVC, animated: true, completion: nil)
    }
    @IBAction func deselectCityBtn(_ sender: Any) {
        whereToBtnOutlet.setTitle("Where to?", for: .normal)
    }
    
    
    // MARK: - Table view data source
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
}

