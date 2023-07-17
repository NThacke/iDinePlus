//
//  Order.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation


class OrderItem {
    
    let item : MenuItem
    let comment : String
    
    init(item : MenuItem, comment : String) {
        self.item = item
        self.comment = comment
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
}
