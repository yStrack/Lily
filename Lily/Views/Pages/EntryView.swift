//
//  EntryView.swift
//  Lily
//
//  Created by Yuri Strack on 21/01/21.
//

import SwiftUI

struct EntryView: View {
    
    init(){
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        NavigationView{
            TabView{
                Home().tabItem {
                    Image(systemName: "house")
                    Text("Início")
                }
                
                PortfolioView().tabItem(){
                    Image(systemName: "briefcase")
                    Text("Portfolio")
                }
                
                AboutView().tabItem(){
                    Image(systemName: "person")
                    Text("Sobre")
                }
            }
            .accentColor(.black)
            .navigationTitle("Loja")
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
