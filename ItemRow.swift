//
//  ItemRow.swift
//  iDine
//
//  Created by Nick Thacke on 7/10/23.
//

import Foundation
import SwiftUI

struct ItemRow : View {
    @State var refresh : Bool = false;
    var item : MenuItem
    
    var body : some View {
        HStack {
            
            Image(item.image).resizable().frame(width: 50, height:50).cornerRadius(100)
            VStack {
                Text(item.name);
                Text(item.description)
            }
            Spacer()
            Text("$\(item.price)");
            
            Button(action : {
                cart.add(item: item)
                update()
            }) {
                Image(systemName : "plus.app")
            }
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(Color.blue)
            
            //this is used as a placeholder to ensure the view refreshes
            if(refresh) {}
            
            if(cart.contains(itemName:item.name)) {
                
                displayQuantity(item: item)
                
                displayRemoveButton(item: item)
            }
        }
    }
    init(item: MenuItem) {
        self.item = item
    }
    
    func update() {
        refresh.toggle()
    }
    
    func displayQuantity(item: MenuItem) -> some View {
        let items = cart.getItems()
        var count : Int = 0;
        for i in items {
            if(item.name == i.name) {
                count = count + 1
            }
        }
        
        return Text("\(count)")
    }
    func displayRemoveButton(item: MenuItem) -> some View {
        Button(action : {
            cart.remove(item: item)
            update()
        }) {
            Image(systemName : "minus.square")
        }
        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to prevent additional button actions
        .foregroundColor(Color.red)
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item : MenuItem.example())
    }
}
