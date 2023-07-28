//
//  LunchMenu.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation
import SwiftUI

struct LunchMenu : View {
    
    @StateObject var viewModel : MenuViewModel = MenuViewModel(restaurantID : AppState.account?.id ?? RestaurantAccount.example().id, menu : "lunch")
    
    @State var refresh : Bool = false;
    
    @EnvironmentObject private var manager : Manager
    
    var body : some View {
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

struct LunchMenu_Previews: PreviewProvider {
    static var previews: some View {
        LunchMenu().environmentObject(Manager())
    }
}
