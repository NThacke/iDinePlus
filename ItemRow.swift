//
//  ItemRow.swift
//  iDine
//
//  Created by Nick Thacke on 7/10/23.
//

import Foundation
import SwiftUI

/**
 This struct serves as the View for displaying any particular Item in the menus.
 */

struct ItemRow : View {
    var item : MenuItem
    
    var body : some View {
        HStack {
            
            Image(uiImage : restoreImageFromBase64String(string : item.image) ?? defaultImage()).resizable().frame(width: 50, height:50).cornerRadius(100)
            
            VStack(alignment : .leading) {
                if(item.description.isEmpty) {
                    Text(item.name)
                    RestrictionView(item : item)
                }
                else {
                    VStack (alignment : .leading) {
                        Text(item.name)
                        Text(item.description).foregroundColor(Color.gray).italic()
                    }
                    RestrictionView(item : item)
                }
            }
            Spacer()
            Text("$\(item.price)");
            
            Button(action : {
                
            }) {
                Image(systemName : "plus.app")
            }
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(Color.blue)
            
        }
    }
    init(item: MenuItem) {
        self.item = item
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
}
/**
 This struct is used to create a restriction view. This will create 
 */
struct RestrictionView : View {
    
    let item : MenuItem
    
    var body : some View {
        HStack (alignment : .center) {
            if(item.restrictions.contains(MenuItem.GLUTEN_FREE)) {
                ZStack {
                    Circle().fill(Color.orange).frame(width : 20, height : 20)
                    Text("G")
                }
            }
            if(item.restrictions.contains(MenuItem.VEGAN)) {
                ZStack {
                    Circle().fill(Color.red).frame(width : 20, height : 20)
                    Text("V")
                }
            }
            if(item.restrictions.contains(MenuItem.VEGETARIAN)) {
                ZStack {
                    Circle().fill(Color.green).frame(width : 20, height : 20)
                    Text("V")
                }
            }
            Spacer()
        }
        EmptyView()
    }
    
    init(item : MenuItem) {
        self.item = item
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item : MenuItem.example())
    }
}
