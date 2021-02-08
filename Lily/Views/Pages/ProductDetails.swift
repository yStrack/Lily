//
//  NewProductDetails.swift
//  Lily
//
//  Created by Vitor Krau on 23/01/21.
//

import SwiftUI

struct ProductDetails: View {
    
    @ObservedObject var cart = Cart.instance
    let paymentHandler = PaymentHandler()
    
    var item: Item
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(Color(red: 231/255, green: 227/255, blue: 218/255))
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 24)
            }
            .frame(height: UIScreen.main.bounds.height/2.1)
            
            ScrollView{
                HStack{
                    VStack(alignment: .leading, spacing: 0){
                        Text(String(format: "R$ %.2f", item.price))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        Text(item.name[item.name.startIndex..<(item.name.firstIndex(of: "|") ?? item.name.endIndex)])
                            .font(.system(size: 25, weight: .black, design: .rounded))
                            .padding(.top, 10)
                        Text("Descrição")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.top)
                    }.padding(.leading)
                    Spacer()
                }
                .padding(.top, 32)
                VStack(spacing: 0){
                    Text(item.description)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.top)
                }.padding(.horizontal)
                Spacer()
            }
            #if APPCLIP
            PaymentButton(action: {
                self.paymentHandler.startClipPayment(item: item){
                    success in
                    if success{
                        print("Success")
                    }
                    else{
                        print("Failed")
                    }
                }
            })
            .cornerRadius(25)
            .frame(width: UIScreen.main.bounds.width - 32)
            #else
            if item.name.lowercased().contains("zapzap"){
                Link(destination: URL(string: "http://sticker.ly/s/EHHPP8")!){
                    Text("BAIXAR")
                        .font(.system(size: 17, weight: .heavy, design: .monospaced))
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 25).frame(width: UIScreen.main.bounds.width - 32, height: 50).foregroundColor(.init(red: 23/255, green: 24/255, blue: 26/255)))
                }.padding(.bottom).padding(.bottom)
            }
            else{
                Button(action: {cart.checkItemInCart(item: self.item)}){
                    AddToCartButton()
                }.padding(.bottom).padding(.bottom)
            }
            #endif
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct NewProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(item: items[0])
    }
}
