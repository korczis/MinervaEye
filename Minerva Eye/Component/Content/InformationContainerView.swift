//
//  InformationContainerView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 5/9/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct InformationContainerView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
    
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: Help
            Group {
                Divider()
                
                HStack(alignment: .center) {
                    Image(systemName: "questionmark.circle")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .padding()
                    // .accessibility(hidden: true)
                    
                    VStack(alignment: .leading) {
                        Text("Getting Started")
                            .font(.headline)
                            .foregroundColor(.primary)
                        // .accessibility(addTraits: .isHeader)
                        
                        Group {
                            Text("Scan book")
                            Text("Visit library")
                            Text("See book details")
                        }
                        .font(.body)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    
                }
                .padding(.top)
            }
            
            // MARK: Books
            Group {
                Divider()
                
                NavigationLink(
                    destination: ScanView()
                        .navigationBarTitle(Text("Scan (\(self.data.count))"), displayMode: .inline)) {
                            InformationDetailView(
                                title: "Scan",
                                subTitle: "Manage your books using ISBN/Barcodes",
                                imageName: "camera"
                            )
                            
                }
                
                NavigationLink(
                    destination: BooksView()
                        .navigationBarTitle(Text("Library (\(self.data.count))"), displayMode: .inline)) {
                            InformationDetailView(
                                title: "Library",
                                subTitle: "Keep your books organized",
                                imageName: "book"
                            )
                }
            }
            
            // MARK: Experimental
            Group {
                Divider()
                
                NavigationLink(
                    destination: LogView()
                        .navigationBarTitle(Text("Logs"), displayMode: .inline)) {
                            InformationDetailView(
                                title: "Logs",
                                subTitle: "Application log messages",
                                imageName: "list.dash"
                            )
                }
            }.disabled(true)
        }
        .padding(.horizontal)
    }
}
