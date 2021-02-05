//
//  Item.swift
//  Lily
//
//  Created by Vitor Krau on 19/01/21.
//

import Foundation


struct Item: Hashable{
    var name: String
    var description: String
    var price: Double
    var image: String
    
    init(name: String, description: String, price: Double, image: String){
        self.name = name
        self.description = description
        self.price = price
        self.image = image
    }
}


let items : [Item] = [Item(name: "Zine + Marcadores | Sussurro Vol.1", description: """
zine sussurro vol.1 {collab mohamed lucas & carlos maciel}

32 páginas a5, papel pólen soft 80g, impressão digital.
                                              +
pack 4 marcadores de página 180x50mm, papel cartão, impressão digital.
                                              =
SUSSURRO VOL.1, minha coleção de estréia, é uma publicação independente que apresenta, em diferentes suportes, representações visuais do diálogo em suas múltiplas facetas. O zine conta com texto escrito por Carlos Maciel, generoso amigo e colaborador. Todas as peças possuem tiragem limitada, aproveitem.
""", price: 15.00, image: "item3"),
                      Item(name: "Ecobag | Sussurro Vol.1", description: """
ecobag sussurro vol.1
40x30cm, algodão cru 220g, duas impressões em serigrafia (frente e verso).

a SUSSURRO VOL.1, minha coleção de estréia, é uma publicação independente que apresenta, em diferentes suportes, representações visuais do diálogo em suas múltiplas facetas. Todas as peças possuem tiragem limitada, aproveitem.
""", price: 25.00, image: "item0"),
                      Item(name: "Serigrafia \"Barbárie\" A3 | Sussurro Vol.1 - Collab Porta Preta Print Shop", description: """
serigrafia "barbárie" sussurro vol.1 {collab mohamed lucas & porta preta print shop
print a3 (420x297mm), tiragem limitada de 30 unidades enumeradas e assinadas, papel especial Markatto Concetto Naturale 250g. não acompanha moldura.
 
a SUSSURRO VOL.1, minha coleção de estréia, é uma publicação independente que apresenta, em diferentes suportes, representações visuais do diálogo em suas múltiplas facetas. Todas as peças possuem tiragem limitada, aproveitem.
""", price: 50.00, image: "item1"),
                      Item(name: "Figurinhas de Zapzap | Sussurro Vol.1", description: """
pacote com 8 figurinhas arrassantes da coleção SUSSURRO VOL.1 para dialogar da melhor forma no zapzap.
o download é gratuito e é realizado através do link abaixo, espero que gostem ✨✨
""", price: 0.00, image: "item2")
                    ]
