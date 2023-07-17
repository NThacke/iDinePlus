//
//  Manager.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation
import SwiftUI


class Manager : ObservableObject {
    
    /**
            This field is used to denote whether or not an item is in the queue. The @Published keyword denotes that this field can be observed in an external View -- when the value changes, the View will reflect that change.
     
                However, many instances of the aforementioned require the field to be a Binding. In that case, the variable "itemInQueueBinding" is used. Because this is a published field, any references to it become reflected automatically.
                
     This allows us to reference manager.itemInQueueBinding as a binding value.
     
     For example, imagine we want to display popover whenever an item is in the queue. This can be accomplished with the following :
     
     //
     manager = Manager()
     
     List {
     //some stuff
     }
     .popover(isPresented : manager.itemInQueueBinding) {}
     
     This will display a popover whenever the itemInQueue field is true.
     */
    @Published public var itemInQueue : Bool = false
    
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
        print(itemInQueueBinding)
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
