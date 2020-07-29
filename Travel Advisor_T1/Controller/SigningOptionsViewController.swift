//
//  SigningOptionsViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/21/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit

class SigningOptionsViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupElements()
    }
    
    func setupElements(){
        Utilities.styleFilledButton(loginButton)
        Utilities.styleFilledButton(signupButton)
        Utilities.styleSkipButton(skipButton)
    }

    @IBAction func skipTapped(_ sender: Any) {
        transitionToHome()
    }
    
    func transitionToHome() {
        let tabBarViewController = storyboard?.instantiateViewController(withIdentifier: "tabBarRootView") as? UITabBarController
        view.window?.rootViewController = tabBarViewController
        view.window?.makeKeyAndVisible()
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
