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
    
    @StateObject var viewModel : MenuViewModel = MenuViewModel(restaurantID : AppState.account?.id ?? RestaurantAccount.example().id, menu : "dinner")
    
    @State var refresh : Bool = false;
    
    private let manager : Manager
    
    var body : some View {
        List {
            ForEach(viewModel.myItems) {section in
                Section(section.name) {
                    ForEach(section.items) {item in
                        ItemRow(item : item, manager : manager)
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
    
    init(manager : Manager) {
        self.manager = manager;
    }
}

struct DinnerMenu_Previews: PreviewProvider {
    static var previews: some View {
        DinnerMenu(manager : Manager())
    }
}
