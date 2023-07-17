//
//  Manager.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation
import SwiftUI


class Manager : ObservableObject {
    
    private var itemInQueue : Bool = false
    
    private let cart = Cart()
    
    /**
            The item that is to potentially be added to the cart.
     
     When a user clicks on an item to add to their cart, this field is populated with that item. Then, a popover appears asking the user to confirm that they want to add it (along with customizaiton options). Once it has been confirmed by the user, the item gets removed from the queue, and it is put into the cart.
     
     */
    private var queue : MenuItem?
    
    func addToCart(item : MenuItem) {
        cart.add(item : item)
    }
    
    func removeFromCart(item : MenuItem) {
        cart.remove(item : item)
    }
    
    func addToQueue(item : MenuItem) {
        print("Adding an item to the queue!")
        self.queue = item
        itemInQueue = true
        print(itemInQueue)
    }
    func flushQueue() {
        self.queue = nil
        itemInQueue.toggle()
    }
    
    // Computed property to access itemInQueue as a Binding. This is useful for referencing the itemInQueue as a field to show Views. Specifically, if the field is true, then a popover allowing the user to customize the item and add it to their cart appears.
    var itemInQueueBinding: Binding<Bool> {
        Binding(
            get: { self.itemInQueue },
            set: { newValue in
                // Add any additional logic if needed before setting the value
                self.itemInQueue = newValue
            }
        )
    }
}
