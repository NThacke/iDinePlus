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

struct LunchMenu_Previews: PreviewProvider {
    static var previews: some View {
        LunchMenu()
    }
}
