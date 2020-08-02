//
//  GithubUserInfoApp.swift
//  GithubUserInfo
//
//  Created by ali on 8/2/20.
//

import SwiftUI


// no changes in your AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}



@available(iOS 14.0, macOS 10.16, *)
struct Testing_SwiftUI2AppHolder {
    @main
    struct GithubUserInfoApp: App {
        @Environment(\.scenePhase) private var scenePhase
        @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
        var body: some Scene {
            WindowGroup {
                let viewModel = MainViewModel(githubFetcher: APIFetcher())
                ContentView(viewModel: viewModel)
            }
        }
    }
}



