//
//  SearchView.swift
//  iDine
//
//  Created by Nick Thacke on 7/24/23.
//

import Foundation
import SwiftUI


var manny = Manager()

struct SearchView : View {
    
    @State var restaurants = Manager.restaurants ?? Manager.exampleRestaurants()
    
    @State var refresh = false
    
    var body : some View {
        VStack {
            List {
                ForEach(restaurants) { restaurant in
                    Text(restaurant.restaurantName)
                }
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
