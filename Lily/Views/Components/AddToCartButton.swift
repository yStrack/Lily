//
//  AddToCartButton.swift
//  Lily
//
//  Created by Vitor Krau on 23/01/21.
//

import SwiftUI

struct AddToCartButton: View {
    var body: some View {
        Text("ADICIONAR AO CARRINHO")
            .font(.system(size: 17, weight: .heavy, design: .monospaced))
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 25).frame(width: UIScreen.main.bounds.width - 32, height: 50).foregroundColor(.init(red: 23/255, green: 24/255, blue: 26/255)))
    }
}

struct AddToCartButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToCartButton()
    }
}
