//
//  iDineApp.swift
//  iDine
//
//  Created by Nick Thacke on 7/8/23.
//

import SwiftUI

@main
struct iDineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AppState()).environmentObject(Manager())
        }
    }
}
