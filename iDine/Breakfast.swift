//
//  Breakfast.swift
//  iDine
//
//  Created by Nick Thacke on 7/10/23.
//

import Foundation
import SwiftUI

struct Breakfast : View {
    
    private var myItems : [MenuSection] = makeBreakfastSection()
    
    @State var refresh : Bool = false;
    
    var body : some View {
        List {
            ForEach(myItems) {section in
                Section(section.name) {
                    ForEach(section.items) {item in
                        ItemRow(item : item)
                    }
                }
            }
        }
    }
    
    init(items: [MenuSection]) {
        self.myItems = items
    }
    
    
}

struct Breakfast_Previews: PreviewProvider {
    static var previews: some View {
        Breakfast(items: makeBreakfastSection())
    }
}

func makeBreakfastSection() -> [MenuSection] {
    var mySection = [MenuSection]();
    let classicBreakfast = makeClassicBreakfast();
    let grilledBreakfast = makeGrillBreakfast();
    
    mySection.append(classicBreakfast);
    mySection.append(grilledBreakfast);
    
    return mySection
}

func makeClassicBreakfast() -> MenuSection {
    var mySection = MenuSection(name: "classic breakfasts")
    let pancakes = MenuItem(name: "Pancakes", type : MenuType.Breakfast, image: "pancakes", price: "5.00", description: "Our pancakes ... ")
    
    let waffles = MenuItem(name: "Waffles", type : MenuType.Breakfast, image : "Breakfast", price : "6.00", description: "Our waffles are the best!")
    
    let eggsAndBacon = MenuItem(name: "Eggs & Bacon", type : MenuType.Breakfast, image : "Breakfast", price : "4.50", description : "")
    
    mySection.append(item: pancakes)
    mySection.append(item: waffles)
    mySection.append(item: eggsAndBacon)
    
    return mySection
    
    
}

func makeGrillBreakfast() -> MenuSection {
    var mySection = MenuSection(name: "From the Grill")
    
    let sausageEggAndCheese = MenuItem(name : "Sausage Egg & Cheese", type : MenuType.Breakfast, image : "sausageEgg&Cheese", price : "5.00", description: "")
    
    let omelete = MenuItem(name : "Omelet", type : MenuType.Breakfast, image : "omelete", price : "6.00", description: "")
    
    mySection.append(item:sausageEggAndCheese)
    mySection.append(item: omelete)
    
    return mySection
}

func makeLunchSection() -> [MenuSection] {
    
    var mySection = [MenuSection]()
    
    let classics = makeClassicLunch()
    
    mySection.append(classics)
    return mySection
}

func makeClassicLunch() -> MenuSection {
    var items = MenuSection(name: "Classics")
    let blt = MenuItem(name: "BLT", type : MenuType.Lunch, image : "Lunch", price: "5.00", description: "Bacon, lettuce, tomato");
    
    let burger = MenuItem(name: "Burger", type : MenuType.Lunch, image : "Burger", price : "5.50", description : "Burger");
    items.append(item:blt)
    items.append(item:burger)
    return items
}

func makeLunch() -> [MenuItem] {
    
    var menuItems = [MenuItem]()
    
    let blt = MenuItem(name: "BLT", type : MenuType.Lunch, image : "Lunch", price: "5.00", description: "Bacon, lettuce, tomato");
    
    let burger = MenuItem(name: "Burger", type : MenuType.Lunch, image : "Burger", price : "5.50", description : "Burger");
    
    menuItems.append(blt)
    menuItems.append(burger)
    
    return menuItems
}


