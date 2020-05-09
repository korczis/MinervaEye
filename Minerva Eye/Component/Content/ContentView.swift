//
//  SplashScreenView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/7/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Spacer()
                    
                    TitleView()
                    
                    InformationContainerView()
                    
                    Spacer(minLength: 30)
                }
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
        }
    }
}

extension ContentView {
    enum Tab: Hashable {
        case Library
        case Scan
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
