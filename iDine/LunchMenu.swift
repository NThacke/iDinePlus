//
//  LunchMenu.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation
import SwiftUI

struct LunchMenu : View {
    
    @StateObject var viewModel : MenuViewModel = MenuViewModel(menu : "lunch")
    
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

struct LunchMenu_Previews: PreviewProvider {
    static var previews: some View {
        LunchMenu(manager: Manager())
    }
}
