//
//  CryptoApp.swift
//  Crypto
//
//  Created by Jha, Aditya on 15/11/24.
//

import SwiftUI

@main
struct CryptoApp: App {
    @StateObject var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
