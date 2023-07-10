//
//  MenuItem.swift
//  iDine
//
//  Created by Nick Thacke on 7/10/23.
//

import Foundation
import SwiftUI

public enum MenuType {
    case Breakfast
    case Lunch
    case Dinner
}

struct MenuSection : Identifiable {
    var id : UUID
    var name : String
    var items : [MenuItem]
    
    init(name: String) {
        self.items = [MenuItem]()
        self.name = name
        self.id = UUID()
    }
    
    mutating func append(item : MenuItem) {
        items.append(item)
    }
}

struct MenuItem : Identifiable, Equatable {
    var id : UUID
    var name : String
    var type : MenuType
    var image : String
    var price : String
    var description : String
        // Equatable protocol implementation
       public static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
           return lhs.name == rhs.name
       }
    
    /**
            Name : the name of the menu item
            Type: The type of menu item (breakfast, lunch, or dinner)
            Image: the image (path) of the image that this menu item should refer to as
     */
    init(name: String, type: MenuType, image: String, price : String, description: String) {
        self.id = UUID()
        self.name = name;
        self.type = type;
        self.image = image;
        self.price = price;
        self.description = description;
    }
    
    static func example() -> MenuItem {
        return MenuItem(name : "Pancakes", type : MenuType.Breakfast, image : "pancakes", price : "5.00", description: "")
    }
}
