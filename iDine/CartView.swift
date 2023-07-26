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
