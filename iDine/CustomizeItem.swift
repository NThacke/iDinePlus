//
//  CustomizeItem.swift
//  iDine
//
//  Created by Nick Thacke on 7/17/23.
//

import Foundation
import SwiftUI


struct CustomizeItem : View {
    
    private let manager : Manager
    
    var body : some View {
        Text("Hello World!")
    }
    
    init(manager : Manager) {
        self.manager = manager
    }
}

struct CustomizeItem_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeItem(manager : Manager())
    }
}
