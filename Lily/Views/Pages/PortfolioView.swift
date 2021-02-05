//
//  PortfolioView.swift
//  Lily
//
//  Created by Yuri Strack on 29/01/21.
//

import SwiftUI

struct PortfolioView: View {
    
    let links:[String] = ["https://www.behance.net/gallery/111305915/PLOOW-letras-ilustradas", "https://www.behance.net/gallery/102294395/pra-quem-achou-que-eu-estava-na-pior", "https://www.behance.net/gallery/107801683/Saida-de-Emergencia", ""]
    let descriptions:[String] = ["Ilustração: Plooow, alfabeto ilustrado.","Editorial: Pra quem achou que eu estava na pior.", "Capa e projeto gráfico: Saído de Emergência, Del Toro", ""]
    
    var body: some View {
            VStack{
                // Store Header
                HStack{
                    Text("Portfólio").font(.system(size: 24)).fontWeight(.bold)
                    Spacer()
                }.padding([.horizontal,.top], 24)
                
                // Horizontal gray line
                Divider().padding(.bottom)
                
                // Displaying products
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(0..<4, id: \.self){ i in
                        Group{
                            if i < 3{
                                Link(destination: URL(string: links[i])!){
                                    content(i: i)
                                }.accentColor(.black)
                            }
                            else{
                                content(i: i).accentColor(.black)
                            }
                        }.padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
    }
    
    fileprivate func content(i: Int) -> some View{
        VStack{
            Image("portfolio\(i)")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(descriptions[i])
                .font(.system(size: 15)).fontWeight(.regular)
                .padding(.vertical, 2)
        }
        .padding(.bottom, 32)
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
