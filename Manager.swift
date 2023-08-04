//
//  Manager.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation
import SwiftUI


class Manager : ObservableObject {
    
    static var restaurants : [RestaurantAccount]?
    
    static var coordinates : (lat : Double, lon : Double) = (0,0)
    
    /**
            Every restaurant has its own cart associated with it. We have a [RestaurantID, Cart] as a [Key, Value] pair.
     */
    var cartMap : [String : Cart]
    
    
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
    
    /**
            The item that is to potentially be added to the cart.
     
     When a user clicks on an item to add to their cart, this field is populated with that item. Then, a popover appears asking the user to confirm that they want to add it (along with customizaiton options). Once it has been confirmed by the user, the item gets removed from the queue, and it is put into the cart.
     
     */
    private var queue : MenuItem?
    
    func addToCart(restaurantID : String, item : OrderItem) {
        if let cart = cartMap[restaurantID] {
            cart.add(item: item)
        }
        else {
            let cart = Cart()
            cart.add(item: item)
            cartMap[restaurantID] = cart
        }
    }
    
    func removeFromCart(restaurantID : String, item : OrderItem) {
        if let cart = cartMap[restaurantID] {
            cart.remove(item : item)
        }
    }
    
    func addToQueue(item : MenuItem) {
        print("Adding an item to the queue!")
        self.queue = item
        itemInQueue = true
        print(itemInQueueBinding)
    }
    func flushQueue() {
        self.queue = nil
        itemInQueue = false
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
    
    func getItemInQueue() -> MenuItem? {
        return queue
    }
    
    func restoreImageFromBase64String(string : String) -> UIImage? {
        if let imageData = Data(base64Encoded: string) {
            let image = UIImage(data: imageData)
            return image
        }
        return nil
    }
    
    func defaultImage() -> UIImage {
        return UIImage(systemName : "fork.knife.circle.fill")!
    }
    
    static func loadRestaurantAccounts(completion : @escaping () -> Void) {
        print("Inside load restaurants")
        APIHelper.getRestaurants() {item in
            Manager.restaurants = item
            completion()
        }
    }
    
    static func exampleRestaurants() -> [RestaurantAccount] {
        let example = RestaurantAccount.example()
        
        return [example]
    }
    
    
    
    
    init() {
        Manager.loadRestaurantAccounts {}
        cartMap = [String : Cart]()
    }
}
