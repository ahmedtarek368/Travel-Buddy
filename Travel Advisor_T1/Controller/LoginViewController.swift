//
//  LoginViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/21/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        
        // Do any additional setup after loading the view.
    }
    
    func setupElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(email)
        Utilities.styleTextField(password)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleCancelButton(cancelButton)
    }

    @IBAction func loginTapped(_ sender: Any) {
        
        // Create cleaned versions of the text field
        let email = self.email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = self.password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            // Couldn't sign in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                self.transitionToHome()
            }
        }
    }
    
    func transitionToHome() {
        let tabBarViewController = storyboard?.instantiateViewController(withIdentifier: "tabBarRootView") as? UITabBarController
        view.window?.rootViewController = tabBarViewController
        view.window?.makeKeyAndVisible()
    }
    
    func hideKeyBoardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (dismissKeyBoardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoardView(){
        view.endEditing(true)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
