//
//  AboutView.swift
//  Lily
//
//  Created by Yuri Strack on 29/01/21.
//

import SwiftUI

struct AboutView: View {
    
    let about:String = """
Olá, me chamo Mohamed Lucas, tenho 23 anos e essa coisa é meu site.
​
Sou ilustrador e designer freelancer com foco em projetos editoriais, de identidade visual e ilustração para todo tipo de suporte. Estudo Design de comunicação visual na PUC-Rio e atualmente participo do programa Apple Developer Academy como desenvolvedor iOS.
​
Me interesso muito por impressos, neste site estão à venda algumas produções autorais. Gosto de chamar minha loja de print shop, acho chique.
​
Meu contato está no final da página, contate-me para saber mais sobre as peças disponibilizadas na loja ou para conversarmos sobre seu projeto.
"""
    
    var body: some View {
        VStack{
            // Store Header
            HStack{
                Text("Sobre").font(.system(size: 24)).fontWeight(.bold)
                Spacer()
            }.padding([.horizontal,.top], 24)
            
            // Horizontal gray line
            Divider().padding(.bottom)
            
            // Displaying products
            ScrollView(.vertical, showsIndicators: false){
                Image("mohamed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                
                Text(about)
                    .padding(.horizontal)
                
                HStack{
                    Spacer()
                    Link(destination: URL(string: "https://www.behance.net/mohamedlucas")!){
                        Image("Behance").resizable().scaledToFit().frame(width: 35, height: 35)
                    }
                    Link(destination: URL(string: "https://dribbble.com/mohamedlucas")!){
                        Image("Dribble").resizable().scaledToFit().frame(width: 35, height: 35).padding()
                    }
                    Link(destination: URL(string: "https://www.instagram.com/mohamedsuspeito/")!){
                        Image("Instagram").resizable().scaledToFit().frame(width: 35, height: 35)
                    }
                    Spacer()
                }.padding(.horizontal)
                
                Text("Mohamed Lucas – 2021").padding(.horizontal)
                Text("(21) 99909-6654").padding(.horizontal)
                Text("cmohamedlucas@gmail.com").padding(.horizontal).padding(.bottom,5)
                
                
            }
        }
        .navigationBarHidden(true)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
