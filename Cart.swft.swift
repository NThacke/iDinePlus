//
//  Cart.swft.swift
//  iDine
//
//  Created by Nick Thacke on 7/10/23.
//

import Foundation
import SwiftUI

public class Cart {
    
    var order : Order
    
    func add(item : OrderItem) {
        order.addItem(item : item)
    }
    
    func remove(item : OrderItem) {
        order.removeItem(item : item)
    }
    init() {
        order = Order()
    }
}
