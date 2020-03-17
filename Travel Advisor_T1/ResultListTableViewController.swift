//
//  ResultListTableViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 3/12/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit

class ResultListTableViewController: UITableViewController {
    
    let resultsImgArr = ["jaz dahabeya.jpg","hotel-lagona-village.jpg","Tirana Dahab Resort.jpg","Daniela Village.jpg"]
    let resultsArr = ["Jaz Dahabeya","Lagona Village Hotel","Tirana Dahab Resort","Daniela Village"]
    //let thingsARRimg = ["jaz dahabeya.jpg","hotel-lagona-village.jpg","Tirana Dahab Resort.jpg"]
    //let thingsName = ["Jaz Dahabeya","Lagona Village Hotel","Tirana Dahab Resort"]
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 35)!]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return resultsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hotelCell", for: indexPath)
        
        let resultImg : UIImageView = cell.viewWithTag(1) as! UIImageView
        resultImg.image = UIImage(named: resultsImgArr[indexPath.row])
        resultImg.layer.cornerRadius = 8
        let resultName : UITextView = cell.viewWithTag(2) as! UITextView
        resultName.text = resultsArr[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2{
        let HDTVC : HotelDetailsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "HDTVC") as! HotelDetailsTableViewController
        self.navigationController?.pushViewController(HDTVC, animated: true)
        
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
