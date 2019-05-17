//
//  AppDelegate.swift
//  Lunchie
//
//  Created by Amy Cheong on 15/4/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    override init() {
        super.init()
        //  It makes sure the configure code gets executed when AppDelegate is initialised 
        FirebaseApp.configure()
    }

}

