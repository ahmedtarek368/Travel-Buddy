//
//  FavouritesTableViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 6/2/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class FavouritesTableViewController: UITableViewController,refreshFavourites {
    
    @IBOutlet var favTableView: UITableView!
    var data : Array<Dictionary<String,Any>>=[]
    let favourite = true
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshFav(_:)), name: Notification.Name(rawValue: "refreshFav"), object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.data = CDFetching()
        favTableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)

        let dic = data[indexPath.row]
        
        let favImage : UIImageView = cell.viewWithTag(1) as! UIImageView
        favImage.image = UIImage(data: dic["image"] as! Data)
        favImage.layer.cornerRadius = 8
        
        let favName : UITextView = cell.viewWithTag(2) as! UITextView
        favName.text = dic["name"] as? String
        
        let favRate : SwiftyStarRatingView = cell.viewWithTag(3) as! SwiftyStarRatingView
        favRate.value = dic["rate"] as! CGFloat
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DTVC : DetailsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "DTVC") as! DetailsTableViewController
        let dic = data[indexPath.row]
        DTVC.dic = dic
        DTVC.delegate = self
        DTVC.favourite = self.favourite
        self.navigationController?.pushViewController(DTVC, animated: true)
    }
    
    func refresh(data: Array<Dictionary<String, Any>>) {
        self.data = data
        favTableView.reloadData()
    }
    
    @objc func refreshFav(_ notification: Notification) {
        self.data = CDFetching()
        favTableView.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
