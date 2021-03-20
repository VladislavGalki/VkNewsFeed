//
//  ViewController.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 19.03.2021.
//

import UIKit

class AuthViewController: UIViewController {

    var authService: AuthSevice!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = AuthSevice()
        authService.wakeUpSession()
    }
}

