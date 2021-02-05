//
//  Home.swift
//  Lily
//
//  Created by Vitor Krau on 19/01/21.
//

import SwiftUI

struct Home: View {
    
    @State var showSheet: Bool = false
    @State var displayStyle:Bool = true // How products are display: List style or Grid Style
    @ObservedObject var cart:Cart = Cart.instance
    
    
    private var columns: [GridItem] = [
        GridItem(.fixed(182), spacing: 16),
        GridItem(.fixed(182), spacing: 16),
    ]
    
    var body: some View {
            VStack{
                // Store Header
                HStack{
                    Text("Loja").font(.system(size: 24)).fontWeight(.bold)
                    Spacer()
                    
                    if UIScreen.main.nativeBounds.height >= 1334{
                        Button(action: {self.displayStyle.toggle()}){
                            Image(systemName: displayStyle ? "rectangle.grid.1x2":"rectangle.grid.2x2")
                        }.accentColor(.black).padding(.horizontal)
                    }
                    
                    Button(action: {showSheet.toggle()}){
                        ZStack{
                            Image(systemName: "cart").font(.system(size: 20))
                            if cart.products.count > 0{
                                Text("\(cart.products.count)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .fontWeight(.bold)
                                    .background(Circle().foregroundColor(.black).frame(width: 15, height: 15))
                                    .offset(x: 12, y: 8)
                            }
                        }
                    }.accentColor(.black)
                }.padding([.horizontal,.top], 24)
                
                //                Text("Mohammed Lucas Store").font(.system(size: 12)).foregroundColor(.secondary)
                
                // Horizontal gray line
                Divider().padding(.bottom)
                
                // Displaying products
                ScrollView(.vertical, showsIndicators: false){
                    // Grid Style
                    if(displayStyle && UIScreen.main.nativeBounds.height >= 1334){
                        LazyVGrid(
                            columns: columns,
                            alignment: .center,
                            spacing: 16
                        ){
                            storeItemsView()
                        }
                    }
                    // List Style
                    else{
                        storeItemsView()
                    }
                    
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSheet, content: {CartView(showSheet: $showSheet)})
    }
    
    fileprivate func storeItemsView() -> some View{
        ForEach(items, id: \.self){ item in
            NavigationLink(destination: ProductDetails(item: item).navigationBarTitleDisplayMode(.inline)){
                VStack{
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(item.name)
                        .font(.system(size: 15)).fontWeight(.regular)
                        .padding(.vertical, 2)
                        .padding(.horizontal, self.displayStyle == false ? 24:0)
                    Text(String(format: "R$ %.2f", item.price))
                        .font(.system(size: 15)).fontWeight(.bold)
                }
                .padding(.bottom, 32)
            }.accentColor(.black)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
