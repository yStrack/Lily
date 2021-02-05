//
//  ScreenState.swift
//  Lily
//
//  Created by Vitor Krau on 21/01/21.
//

import Foundation

class ScreenState: ObservableObject{
    static var instance : ScreenState = ScreenState()
    @Published var productID : Int = -1
}
