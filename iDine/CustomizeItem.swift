//
//  CustomizeItem.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation
import SwiftUI

/**
 This struct is used whenever the user decides to add an item to their cart. This View is used to customize the item (adding comments) and to then add it to their cart.
 */
struct CustomizeItem : View {
    
    @EnvironmentObject var current : AppState
    
    @EnvironmentObject private var manager : Manager
    
    private let item : MenuItem
    
    @State private var comments : String
    
    var body : some View {
        VStack {
            Text("Add to Order").bold()
            List {
                Section("Item") {
                    DisplayItem(item : item)
                }
                Section("Comments") {
                    TextField("Include ... Exclude ...", text: $comments).italic(true)
                }
                Section("I'm ready") {
                    Button("Add to Order") {
                        let orderItem = OrderItem(item : item, comment : comments)
                        
                        manager.addToCart(restaurantID : AppState.account!.id, item:orderItem)
                        manager.flushQueue()
                    }
                }
                Section("Changed your mind?") {
                    Button("Cancel") {
                        manager.flushQueue()
                    }.foregroundColor(Color.red)
                }
            }
        }
    }
    init(item : MenuItem) {
        self.item = item
        self.comments = ""
    }
}

struct DisplayItem : View {
    
    let item : MenuItem
    
    @EnvironmentObject private var manager : Manager
    
    var body : some View {
        VStack {
            HStack {
                Image(uiImage : manager.restoreImageFromBase64String(string : item.image) ?? manager.defaultImage()).resizable().frame(width: 50, height:50).cornerRadius(100)
                
                VStack(alignment : .leading) {
                    if(item.description.isEmpty) {
                        Text(item.name)
                        RestrictionView(item : item)
                    }
                    else {
                        VStack (alignment : .leading) {
                            Text(item.name)
                            Text(item.description).foregroundColor(Color.gray).italic()
                        }
                        RestrictionView(item : item)
                    }
                }
            }
        }
    }
    
    init(item : MenuItem) {
        self.item = item
    }
}

struct CustomizeItem_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeItem( item : MenuItem.example()).environmentObject(Manager())
    }
}
