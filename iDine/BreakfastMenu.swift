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
    
    @EnvironmentObject var manager : Manager
    
    var body : some View {
        VStack {
            if(!viewModel.myItems.isEmpty) {
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
            else {
                    Text("There aren't any items!")
            }
        }
    }
}

/**
 This class is used to store menu items. This is used to have dynamic content
 
 This class is used as a @StateObject inside each BreakfastMenu, LunchMenu, or DinnerMenu View.
 
 By having the @StateObject modifier, we are telling SwiftUI to update the views whenever a @Published variable is modified inside the @StateObject.
 
 As such, this allows us to store dynamic content. We can invoke .loadData() which will refresh the data, and when SwiftUI noticies that the data has been modified, it refreshes it's views which use that data.
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
        BreakfastMenu().environmentObject(AppState()).environmentObject(Manager())
    }
}
