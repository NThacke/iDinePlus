//
//  Cart.swft.swift
//  iDine
//
//  Created by Nick Thacke on 7/10/23.
//

import Foundation
import SwiftUI

public class Cart {
    
    var items : [MenuItem]
    
    /**
                Appends the given menu item to the cart's list of items.
     */
    func add(item: MenuItem) {
        print("Adding item : \(item.name)")
        print("Size of cart before : \(items.count)")
        items.append(item)
        print("Size of cart after : \(items.count)")
    }
    
    /**
            Returns true if an item in this cart's list of items has the same name as the given String in the parameter.
            If no item satisfies the given name, this method returns false.
     */
    func contains(itemName : String) -> Bool {
        for item in items {
            if(item.name == itemName) {
                return true
            }
        }
        return false
    }
    
    func getItems() -> [MenuItem] {
        return items
    }
    
    /**
        Removes the first occurence of an item in this cart's list of items that has the same name as the given parameter.
     */
    func remove(item: MenuItem) {
        print("removing item \(item.name)")
        print("Size of cart before: \(items.count)")
        if let index = items.firstIndex(of:item) {
            items.remove(at:index)
        }
        print("Size of cart after: \(items.count)")
    }
    
    func size() -> Int {
        return items.count
    }
    
    init() {
        items = [MenuItem]()
    }
}
