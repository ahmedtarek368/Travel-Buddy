//
//  addReviewViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/30/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftyStarRatingView

class addReviewViewController: UIViewController {

    var delegate:refreshReviews?
    var placeId : String = ""
    
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var rateView: SwiftyStarRatingView!
    @IBOutlet weak var addReview: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyBoardWhenTappedAround()
        Utilities.styleFilledButton(addReview)
        errorMessage.alpha = 0
        reviewTextView.layer.cornerRadius = 8
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reviewTextView.becomeFirstResponder()
    }
    
    
    @IBAction func addReviewTapped(_ sender: Any) {
        if reviewTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            showError(error: "review field is empty")
        }
        else if Auth.auth().currentUser?.uid == nil{
            setUpAlert()
        }
        else{
            let db = Firestore.firestore()
            db.collection("reviews").document().setData(["pid":placeId, "review":reviewTextView.text, "rate":rateView.value, "uid": Auth.auth().currentUser!.uid ]) { (error) in
                
                if error != nil {
                    self.showError(error: "Error saving user data")
                }
            }
            delegate?.refresh(placeId: placeId)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func hideKeyBoardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (dismissKeyBoardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoardView(){
        view.endEditing(true)
    }
    
    func setUpAlert(){
        let notRegisteredAlert = UIAlertController(title: "Login Required", message: "you are not logged in. Please Login First", preferredStyle: .alert)
        notRegisteredAlert.addAction(UIAlertAction(title: "Login", style: .default , handler: transitionToSigningOptions))
        notRegisteredAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
        self.present(notRegisteredAlert, animated: true, completion: nil)
    }
    
    func transitionToSigningOptions(alert: UIAlertAction) {
        let signingOptionsView = storyboard?.instantiateViewController(withIdentifier: "signingOptionsView") as? UINavigationController
        view.window?.rootViewController = signingOptionsView
        view.window?.makeKeyAndVisible()
    }
    
    func showError(error: String){
        errorMessage.text = error
        errorMessage.alpha = 1
    }
}
