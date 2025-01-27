//
//  TourKsa_SweApp.swift
//  TourKsa_Swe
//
//  Created by Khalid R on 26/07/1446 AH.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}


@main
struct TourKsa_SweApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var vm = PlaceViewModel()
//    @StateObject var weatherService = WeatherService()
    var body: some Scene {
        WindowGroup {
            ContainerView()
                .preferredColorScheme(.light)
                .environmentObject(vm)
        }
    }
}
