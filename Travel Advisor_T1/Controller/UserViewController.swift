//
//  UserViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/22/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UserViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var hiMessage: UILabel!
    @IBOutlet weak var userMail: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        userImage.layer.cornerRadius = userImage.frame.height/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.clipsToBounds = true
        
        if Auth.auth().currentUser?.uid == nil {
            // if User is Not Logged in Show Alert
            setUpAlert()
            Utilities.hideButton(signOutButton)
            
        }else{
            // if User is Logged in Read His Data From FireBase
            readUserData(uid: Auth.auth().currentUser!.uid, completion: {(user) in
                self.hiMessage.text = "Hi, \(user.firstName)"
                self.userMail.text = user.email
            })
            Utilities.styleCancelButton(signOutButton)
        }
    }
    
    func readUserData(uid: String,completion: @escaping (_ data : User) -> ()){
        var user : User = User(firstName: "", lastName: "", email: "")
        let uid = uid
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
    
    func setUpAlert(){
        self.userImage.image = UIImage(named:"")
        let notRegisteredAlert = UIAlertController(title: "Login Required", message: "you are not logged in. Please Login First", preferredStyle: .alert)
        notRegisteredAlert.addAction(UIAlertAction(title: "Login", style: .default , handler: transitionToSigningOptions))
        notRegisteredAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: transitionToHome))
        self.present(notRegisteredAlert, animated: true, completion: nil)
    }

    func transitionToHome(alert: UIAlertAction) {
        let tabBarViewController = storyboard?.instantiateViewController(withIdentifier: "tabBarRootView") as? UITabBarController
        view.window?.rootViewController = tabBarViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToSigningOptions(alert: UIAlertAction) {
        let signingOptionsView = storyboard?.instantiateViewController(withIdentifier: "signingOptionsView") as? UINavigationController
        view.window?.rootViewController = signingOptionsView
        view.window?.makeKeyAndVisible()
    }
    
    func signOut(alert: UIAlertAction) {
        do{ try Auth.auth().signOut() }
        catch {print("Signed Out")}
        let tabBarViewController = storyboard?.instantiateViewController(withIdentifier: "tabBarRootView") as? UITabBarController
        view.window?.rootViewController = tabBarViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        
        let signOutAlert = UIAlertController(title: "Signing Out", message: "are you sure you wanna sign out?", preferredStyle: .alert)
        signOutAlert.addAction(UIAlertAction(title: "Sign Out", style: .default , handler: signOut))
        signOutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
        self.present(signOutAlert, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
