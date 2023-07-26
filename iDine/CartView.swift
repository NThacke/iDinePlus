//
//  CartView.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation
import SwiftUI


struct CartView : View {
    
    let manager : Manager
    
    @State var refresh = false
    
    var body : some View {
        VStack {
            Group { //Header
                HStack {
                    Text("My Cart").bold()
                    Spacer()
                }.padding()
                Rectangle().stroke(lineWidth: 1).frame(width : .infinity, height : 1)
            }
            if let cart = manager.cartMap[AppState.account?.id ?? ""] {
                if(cart.order.items.count > 0) {
                    List {
                        ForEach(manager.cartMap[AppState.account?.id ?? RestaurantAccount.example().id]?.order.items ?? Order.empty()) {item in
                            Section(item.item.name) {
                                DisplayOrder(order : item)
                            }
                        }
                        .onDelete(perform : {item in
                            if let index = item.first {
                                manager.cartMap[AppState.account!.id]!.order.items.remove(at : index)
                            }
                            refresh.toggle()
                        })
                        if refresh {}
                    }
                    Button("Place Order") {
                        
                    }
                }
                else {
                    VStack {
                        Text("Your cart is empty!")
                    }
                }
            }
            else {
                VStack {
                    Text("Your cart is empty!")
                }
            }
            Spacer()
        }
    }
    
    
    init(manager : Manager) {
        self.manager = manager
    }
    
}

struct DisplayOrder : View {
    
    let order : OrderItem
    
    var body : some View {
        VStack {
            DisplayItem(item : order.item)
            if(!order.comment.isEmpty) {
                Divider()
                Text(order.comment)
            }
        }
    }
    
    init(order : OrderItem) {
        self.order = order
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(manager : Manager())
    }
}
