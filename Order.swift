//
//  Order.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation


class OrderItem : Identifiable {
    
    let item : MenuItem
    let comment : String
    let id : String
    
    init(item : MenuItem, comment : String) {
        self.item = item
        self.comment = comment
        self.id = UUID().uuidString
    }
    
    static func example() -> OrderItem {
        return OrderItem(item : MenuItem.example(), comment : "Example comment!")
    }
}

class Order {
    var items : [OrderItem]
    let id : UUID = UUID()
    
    
    func addItem(item : OrderItem) {
        items.append(item)
    }
    
    func removeItem(item : OrderItem) {
        for i in items {
            if i === item {
                
            }
        }
    }
    init() {
        items = [OrderItem]()
    }
    
    static func example() -> [OrderItem] {
        var list = [OrderItem]()
        list.append(OrderItem.example())
        return list
    }
    
    static func empty() -> [OrderItem] {
        return [OrderItem]()
    }
}
