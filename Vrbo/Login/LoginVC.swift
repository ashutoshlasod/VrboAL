//
//  LoginVC.swift
//  Vrbo
//
//  Created by Ashutosh Lasod on 09/11/20.
//  Copyright © 2020 Ashutosh Lasod. All rights reserved.
//

import UIKit

//MARK:- Implementation of Login ViewController
final class LoginVC: UIViewController {
    
    /**
     This method is responsible for getting the instance of Login Controller
     */
    class func getController() -> LoginVC {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController: LoginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        return viewController
    }
    
    //MARK:- LoginVC Life cycle Methods Implementation begins
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
