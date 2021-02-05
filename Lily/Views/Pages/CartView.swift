//
//  CartView.swift
//  Lily
//
//  Created by Yuri Strack on 22/01/21.
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var cart:Cart = Cart.instance
    let paymentHandler = PaymentHandler()
    @State var showAlert:Bool = false
    
    @Binding var showSheet : Bool
    
    var body: some View {
        NavigationView{
            VStack {
                Divider()
                
                if cart.products.count > 0{
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(cart.products, id: \.self){ item in
                            HStack{
                                Image(item.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width/3)
                                VStack(alignment: .leading){
                                    Text(item.name).font(.system(size: 14)).fontWeight(.bold)
                                    Spacer()
                                    HStack{
                                        Text(String(format: "R$ %.2f",item.price)).font(.system(size: 16)).fontWeight(.bold)
                                        Spacer()
                                        Button(action: {cart.decreaseAmount(item: item)}){
                                            Image(systemName: "minus.circle").foregroundColor(.secondary)
                                        }
                                        
                                        Text("\(cart.getAmount(item: item))").foregroundColor(.secondary)
                                        
                                        Button(action: {cart.checkItemInCart(item: item)}){
                                            Image(systemName: "plus.circle").foregroundColor(.secondary)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                            .animation(.easeInOut)
                            
                            if cart.products.count > 1{
                                Divider().padding(.horizontal,24)
                            }
                        }
                        
                        Divider()
                    }
                }
                else{
                    Spacer()
                    Text("Carrinho vazio")
                        .fontWeight(.bold)
                        .animation(.easeInOut)
                    Spacer()
                }
                VStack{
                    Text(String(format: "Total R$ %.2f", cart.totalCost())).fontWeight(.bold)
                    PaymentButton(action: {
                        self.paymentHandler.startCartPayment(items: cart.products){
                            success in
                            if success{
                                cart.clearCart()
                            }
                            else{
                                self.showAlert.toggle()
                            }
                        }
                    })
                    .disabled(cart.products.count > 0 ? false:true)
                    .cornerRadius(25)
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .padding(.bottom).padding(.bottom)
                }
                .navigationTitle("Carrinho")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {self.showSheet.toggle()}){Image(systemName: "xmark")})
                .alert(isPresented: $showAlert, content: {Alert(title: Text("Falha no pagamento"), message: Text("Ocorreu um erro ao processar o pagamento"), dismissButton: .default(Text("OK")))})
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(showSheet: .constant(true))
    }
}
