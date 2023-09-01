//
//  Welcome.swift
//  iDine
//
//  Created by Nick Thacke on 9/1/23.
//

import Foundation
import SwiftUI

/**
 A Welcome View which is used to display a welcome message to the user. This is the first thing the user will see after loading into the app.
 */
struct Welcome : View {
    var body : some View {
        VStack {
            Spacer()
            Text("Welcome to our app!")
            Spacer()
        }
    }
}
