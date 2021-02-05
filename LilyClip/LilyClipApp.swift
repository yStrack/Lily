//
//  LilyClipApp.swift
//  LilyClip
//
//  Created by Yuri Strack on 21/01/21.
//

import SwiftUI

@main
struct LilyClipApp: App {
    @ObservedObject var screenState = ScreenState.instance
    
    var body: some Scene {
        WindowGroup {
            Group{
                if screenState.productID == -1{
                    ProgressView()
                }
                else{
                    ProductDetails(item: items[screenState.productID])
                }
            }
            .onContinueUserActivity(
                NSUserActivityTypeBrowsingWeb,
                perform: handleUserActivity
            )
        }
    }
}

func handleUserActivity(_ userActivity: NSUserActivity) {
    guard let incomingURL = userActivity.webpageURL,
          let components = URLComponents(url: incomingURL,resolvingAgainstBaseURL: true),
          let queryItems = components.queryItems
    else {
        return
    }
    
    if let idValue = queryItems.first(where: { $0.name == "id" })?.value{
        let id = Int(idValue)
        ScreenState.instance.productID = id ?? -1
    }
    else {
        return
    }
}
