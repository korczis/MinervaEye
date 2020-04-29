//
//  ScanView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ScanView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var logMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ScanViewController(logMessage: $logMessage, managedObjectContext: self.managedObjectContext)
                        .navigationBarTitle(Text("Scan"))
                }
                Text(logMessage)
                    .padding(.bottom, 3)
//                    .animate(withDuration: 1.0, delay: 0, options: .easyOut, animations: {
//                        self.opacity = 0.0
//                    })
                    // .opacity(withAnimation(.easeOut(duration: 10.0)) { return 0 } )
                    
            }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
