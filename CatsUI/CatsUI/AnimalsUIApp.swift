//
//  CatsUIApp.swift
//  CatsUI
//
//  Created by Zakhar Litvinchuk on 19.05.2024.
//

import SwiftUI

import FirebaseCore
import FirebaseCrashlytics
import CatsNetworking

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      if UserDefaults.standard.value(forKey: "CrashlyticsCollectionEnabled") != nil {
          Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(UserDefaults.standard.bool(forKey: "CrashlyticsCollectionEnabled"))
      }
      return true
  }
}


@main
struct CatsUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    static var animal: Animal {
        let typeOfAnimal = Bundle.main.object(forInfoDictionaryKey: "Animals") as! String
        return typeOfAnimal == "CATS" ? .cat : .dog
    }
    var body: some Scene {
        WindowGroup {
            AnimalsListView(animal: CatsUIApp.animal)
        }
    }
}
