//
//  DinnerMenu.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation
import SwiftUI

/**
 This struct serves as the View for when a user is viewing the Dinner menu
 */

struct DinnerMenu : View {
    
    @StateObject var viewModel : MenuViewModel = MenuViewModel(menu : "dinner")
    
    @State var refresh : Bool = false;
    
    var body : some View {
        List {
            ForEach(viewModel.myItems) {section in
                Section(section.name) {
                    ForEach(section.items) {item in
                        ItemRow(item : item)
                    }
                }
            }
        }.onAppear(perform: {
            viewModel.loadData()
        })
        .refreshable {
            viewModel.loadData()
        }
        
    }
}

struct DinnerMenu_Previews: PreviewProvider {
    static var previews: some View {
        DinnerMenu()
    }
}
