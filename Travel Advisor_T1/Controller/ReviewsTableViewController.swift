//
//  ReviewsTableViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/29/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import Firebase

class ReviewsTableViewController: UITableViewController, refreshReviews {
    
    @IBOutlet var reviewsTableView: UITableView!
    
    var placeId : String = ""
    var reviews : [Review] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Review", style: .plain, target: self, action: #selector(addReview))
        
        readReviews(pid: placeId, completion: {(reviews) in
            self.reviews = reviews
            self.reviewsTableView.reloadData()
        })
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! reviewCell
        let review = reviews[indexPath.row]
        
        cell.roundedCornerImage()
        
        readUserData(uid: review.userId, completion: {(user) in
            let user: User = user
            cell.setReviewData(review: review, user: user)
        })
        
        return cell
    }
    
    func readReviews(pid: String,completion: @escaping (_ data : [Review]) -> ()){
        var reviews : [Review] = []
        let db = Firestore.firestore()
        db.collection("reviews").whereField("pid", isEqualTo: pid)
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                for document in querySnapshot!.documents {
                    let docData = document.data()
                    reviews.append(Review(userId: docData["uid"]! as! String, placeId: docData["pid"]! as! String, textReview: docData["review"]! as! String, rate: docData["rate"]! as! NSNumber ))
                }
                completion(reviews)
            }
        }
    }

    func readUserData(uid: String, completion: @escaping (_ data : User) -> ()){
        var user : User = User(firstName: "", lastName: "", email: "")
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { (document, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                let docData = document?.data()
                user = User(firstName: docData!["firstname"] as! String, lastName: docData!["lastname"] as! String, email: docData!["email"] as! String)
                completion(user)
            }
        }
        
    }
    
    @objc func addReview(sender: UIBarButtonItem) {
        let addReviewVC = self.storyboard?.instantiateViewController(withIdentifier: "addReviewVC") as! addReviewViewController
        addReviewVC.placeId = placeId
        addReviewVC.delegate = self
        self.navigationController?.pushViewController(addReviewVC, animated: true)
    }
    
    func refresh(placeId: String) {
        readReviews(pid: placeId, completion: {(reviews) in
            self.reviews = reviews
            self.reviewsTableView.reloadData()
        })
    }
}
