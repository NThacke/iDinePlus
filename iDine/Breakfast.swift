//
//  Breakfast.swift
//  iDine
//
//  Created by Nick Thacke on 7/10/23.
//

import Foundation
import SwiftUI

struct Breakfast : View {
    
    private var items : [MenuItem] = makeBreakfast()
    
    @State var refresh : Bool = false;
    
    var body : some View {
        List {
            ForEach(items) {item in
                ItemRow(item: item)
            }
        }
    }
    
    init(items: [MenuItem]) {
        self.items = items
    }
    
    
}

struct Breakfast_Previews: PreviewProvider {
    static var previews: some View {
        Breakfast(items: makeBreakfast())
    }
}

func makeBreakfast() -> [MenuItem] {
    var menuItems = [MenuItem]()
    
    let pancakes = MenuItem(name: "Pancakes", type : MenuType.Breakfast, image: "pancakes", price: "5.00", description: "Our pancakes ... ")
    
    let waffles = MenuItem(name: "Waffles", type : MenuType.Breakfast, image : "Breakfast", price : "6.00", description: "Our waffles are the best!")
    
    let eggsAndBacon = MenuItem(name: "Eggs & Bacon", type : MenuType.Breakfast, image : "Breakfast", price : "4.50", description : "")
    
//    var classics : MenuSection = MenuSection(name: "Classic Breakfast Items");
//
//    classics.append(item: pancakes)
//    classics.append(item: waffles)
//    classics.append(item: eggsAndBacon)
//
//    menuItems.append(classics)
    menuItems.append(pancakes);
    menuItems.append(waffles);
    menuItems.append(eggsAndBacon)
    
    return menuItems;
}

func makeLunch() -> [MenuItem] {
    
    var menuItems = [MenuItem]()
    
    let blt = MenuItem(name: "BLT", type : MenuType.Lunch, image : "Lunch", price: "5.00", description: "Bacon, lettuce, tomato");
    
    let burger = MenuItem(name: "Burger", type : MenuType.Lunch, image : "Burger", price : "5.50", description : "Burger");
    
    menuItems.append(blt)
    menuItems.append(burger)
    
    return menuItems
}


