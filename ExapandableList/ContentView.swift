//
//  ContentView.swift
//  ExapandableList
//
//  Created by mac on 19/10/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var items = itemArray
    @State var showAnimation = false
    
    var themeColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(.indigo.gradient)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    ForEach(items, id: \.self) { item in
                        itemRow(item)
                            .onTapGesture {
                                changeState(item: item)
                                withAnimation {
                                    self.showAnimation.toggle()
                                }
//                                withAnimation {
//                                    self.showAnimation.toggle()
//                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
    
    func itemRow(_ item: RowItem) -> some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: item.image)
                Text(item.title)
                Spacer()
                Image(systemName: item.isExpanded ? "chevron.down": "chevron.right")
            }
            .padding(8)
            .padding(.horizontal, 4)
            .background(Color(themeColor))
            .clipShape(
                .rect(
                    topLeadingRadius: 8,
                    bottomLeadingRadius: item.isExpanded ? 0 : 8,
                    bottomTrailingRadius: item.isExpanded ? 0 : 8,
                    topTrailingRadius: 8
                )
            )
            
           // if item.isExpanded {
                Text(item.description)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(Color(themeColor.opacity(0.7)))
                    .frame(height: item.isExpanded ? .infinity : 0)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 8,
                            bottomTrailingRadius: 8,
                            topTrailingRadius: 0
                        )
                    )
                    .animation(.bouncy, value: showAnimation)
                    .transition(.slide)
          //  }
        }
    }
    
    func changeState(item: RowItem) {
        items.indices.forEach {
            if items[$0] == item {
                items[$0].changeState()
            } else {
                items[$0].isExpanded = false
            }
        }
    }
}

#Preview {
    ContentView()
}


struct RowItem: Hashable {
    let title: String
    let description: String
    let image: String
    var isExpanded: Bool
    
    init(title: String, description: String, image: String, isExpanded: Bool) {
        self.title = title
        self.description = description
        self.image = image
        self.isExpanded = isExpanded
    }
    
    mutating func changeState() {
        self.isExpanded.toggle()
    }
}


let itemArray = [
    RowItem(title: "Is there a free trial available?", description: descr1, image: "tennisball.circle", isExpanded: false),
    RowItem(title: "Can i change my plan later?", description: descr2, image: "creditcard.fill", isExpanded: false),
    RowItem(title: "How does billing work?", description: descr3, image: "wifi.circle", isExpanded: false),
    RowItem(title: "How does support work?", description: descr4, image: "headphones", isExpanded: false),
    RowItem(title: "Do you provide tutorials?", description: descr5, image: "play.circle", isExpanded: false)
]


let descr1 = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, making it look like readable English."
let descr2 = "2 It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is"
let descr3 = "3 It is a long established fact that a reader will be distracted by the readable content of"
let descr4 = "4 It is a long established fact that a reader will be distracted by"
let descr5 = "5 It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, making it look like readable English."


struct ContentView2: View {
    @State private var isAnimating = false
    @State private var showLabel = true
    
    var body: some View {
        
        VStack {
            Button("Press here") {
                withAnimation {
                    self.isAnimating.toggle()
                }
            }
            
            Button("shoiw label") {
                showLabel.toggle()
                self.isAnimating = true
            }
            //.scaleEffect(scale)
           // .animation(.linear(duration: 1), value: scale)
            
           // if showLabel {
                Text("Hello, World!")
                    .offset(x: isAnimating ? 200 : 0)
                    .animation(.easeInOut)
          //  }
        }
    }
}
