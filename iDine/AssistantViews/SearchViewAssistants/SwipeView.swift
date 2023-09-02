//
//  SwipeView.swift
//  iDine
//
//  Created by Nick Thacke on 9/1/23.
//

import Foundation
import SwiftUI

struct SwipeView: View {
enum ScrollDirection {
    case up
    case down
    case none
}
@State var scrollDirection: ScrollDirection = .none

var body: some View {
    VStack {
        ScrollViewReader { reader in
            List {
                ForEach(0...20, id:\.self) { index in
                    ZStack {
                        Color((index % 2 == 0) ? .red : .green)
                        VStack {
                            Text("Index \(index)")
                                .font(.title)
                        }
                        .frame(height: UIScreen.main.bounds.height/2)
                    }
                    .clipShape(Rectangle())
                    .id(index)
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0.0)
                            .onChanged({ dragValue in
                                let isScrollDown = 0 > dragValue.translation.height
                                self.scrollDirection = isScrollDown ? .down : .up
                            })
                            .onEnded { value in
                                let velocity = CGSize(
                                    width:  value.predictedEndLocation.x - value.location.x,
                                    height: value.predictedEndLocation.y - value.location.y
                                )
                                if abs(velocity.height) > 100 {
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        let next = index + (scrollDirection == .down ? 1 : -1)
                                        reader.scrollTo(next, anchor: .top)
                                    }
                                }
                            }
                    )
                    
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
            
        }
    }
  }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SwipeView()
                .navigationTitle("Snapping list")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
