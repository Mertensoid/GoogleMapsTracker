//
//  AppDelegate.swift
//  GoogleMapsTracker
//
//  Created by admin on 21.11.2022.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBZSEn_Da-P7keWqD5AQDhZR6efleU0aBE")
        return true
    }
}

