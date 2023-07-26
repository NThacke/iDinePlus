//
//  BreakfastMenu.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation
import SwiftUI

enum Type {
    case breakfast
    case lunch
    case dinner
}

struct BreakfastMenu : View {
    
    @StateObject var viewModel : MenuViewModel = MenuViewModel(restaurantID : AppState.account?.id ?? RestaurantAccount.example().id , menu : "breakfast")
    
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
        self.manager = manager
    }
}

/**
 This class is used to store menu items. This is used to have dynamic content 
 */
class MenuViewModel: ObservableObject {
    @Published var myItems: [MenuSection] = []
    
    @Published var menu : String = ""
    
    var restaurantID : String
    
    func loadData() {
        APIHelper.retrieveMenuItems(restaurantID : restaurantID, menu : menu) { [weak self] items in
            DispatchQueue.main.async {
                self?.myItems.removeAll()
                self?.myItems = items
            }
        }
    }
    func getSection(name : String) -> MenuSection? {
        for item in myItems {
            if(item.name == name) {
                return item
            }
        }
        return nil
    }
    
    init(restaurantID : String, menu : String) {
        self.menu = menu
        self.restaurantID = restaurantID
    }
}

struct Breakfast_Previews: PreviewProvider {
    static var previews: some View {
        BreakfastMenu(manager : Manager()).environmentObject(AppState())
    }
}
