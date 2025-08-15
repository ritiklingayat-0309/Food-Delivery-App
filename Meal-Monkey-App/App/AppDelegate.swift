//
//  AppDelegate.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 31/07/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    //for cart as global array
    var arrCart: [ProductModel] = []
    var arrOrder : [[ProductModel]] = []
    var arrWishlist: [ProductModel] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadCart()
        loadOrders()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveCart()
        saveOrders()
    }
    
    func saveCart() {
           let encoder = JSONEncoder()
           if let encodedCart = try? encoder.encode(arrCart) {
               UserDefaults.standard.set(encodedCart, forKey: "savedCart")
           }
       }
       
       private func loadCart() {
           let decoder = JSONDecoder()
           if let savedCartData = UserDefaults.standard.data(forKey: "savedCart"),
              let decodedCart = try? decoder.decode([ProductModel].self, from: savedCartData) {
               arrCart = decodedCart
           }
       }
       
       // MARK: - Order Persistence Functions
       
       func saveOrders() {
           let encoder = JSONEncoder()
           if let encodedOrders = try? encoder.encode(arrOrder) {
               UserDefaults.standard.set(encodedOrders, forKey: "savedOrders")
           }
       }

       private func loadOrders() {
           let decoder = JSONDecoder()
           if let savedOrdersData = UserDefaults.standard.data(forKey: "savedOrders"),
              let decodedOrders = try? decoder.decode([[ProductModel]].self, from: savedOrdersData) {
               arrOrder = decodedOrders
           }
       }


}

