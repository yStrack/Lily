//
//  Cart.swift
//  Lily
//
//  Created by Yuri Strack on 22/01/21.
//

import Foundation

class Cart: ObservableObject{
    public static var instance = Cart()
    @Published var products:[Item] = []
    @Published var amounts:[Int] = []
    
    func checkItemInCart(item: Item){
        if let pos = products.firstIndex(where: {$0.name == item.name}){
            amounts[pos] = amounts[pos] + 1
        }
        else{
            addToCart(item: item)
        }
    }
    
    private func addToCart(item: Item){
        products.append(item)
        amounts.append(1)
    }
    
    private func removeFromCart(pos: Int){
        products.remove(at: pos)
        amounts.remove(at: pos)
    }
    
    func decreaseAmount(item: Item){
        if let pos = products.firstIndex(where: {$0.name == item.name}), amounts[pos] > 0{
            amounts[pos] = amounts[pos] - 1
            if amounts[pos] == 0{
                removeFromCart(pos: pos)
            }
        }
    }
    
    func totalCost() -> Double{
        var total:Double = 0.0
        for i in 0..<products.count{
            total += products[i].price * Double(amounts[i])
        }
        return total
    }
    
    func getAmount(item: Item) -> Int{
        if let pos = products.firstIndex(where: {$0.name == item.name}){
            return amounts[pos]
        }
        return 0
    }
    
    func clearCart(){
        products = []
        amounts = []
    }
}
