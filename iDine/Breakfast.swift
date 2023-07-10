//
//  Breakfast.swift
//  iDine
//
//  Created by Nick Thacke on 7/10/23.
//

import Foundation
import SwiftUI

private var breakfastItem : [MenuItem] = makeBreakfast()

struct Breakfast : View {
    
    @State var refresh : Bool = false;
    
    var body : some View {
        List {
            ForEach(breakfastItem) {item in
                
                Section(item.name) {
                    HStack {
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
                        
                        //this is used as a placeholder to ensure the view refreshes
                        if(refresh) {
                            
                        }
                        if(cart.contains(itemName:item.name)) {
                            
                            displayQuantity(item: item)
                            
                            displayRemoveButton(item: item)
                        }
                    }
                }
            }
        }
    }
    
    func update() {
        refresh.toggle()
    }
        
    func displayQuantity(item: MenuItem) -> some View {
        var items = cart.getItems()
        
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

private func makeBreakfast() -> [MenuItem] {
    var menuItems = [MenuItem]()
    
    let pancakes = MenuItem(name: "Pancakes", type : MenuType.Breakfast, image: "Breakfast", price: "5.00", description: "Our pancakes ... ")
    let waffles = MenuItem(name: "Waffles", type : MenuType.Breakfast, image : "Breakfast", price : "6.00", description: "Our waffles are the best!")
    
    menuItems.append(pancakes);
    menuItems.append(waffles);
    
    return menuItems;
}
