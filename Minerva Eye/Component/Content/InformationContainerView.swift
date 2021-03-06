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
    
    @Binding var clicks: Int
    @Binding var messages: [String]
    
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
                                subTitle: [
                                    "Scan the ISBN",
                                    "Scan the Barcode"
                                ].joined(separator: "\n"),
                                imageName: "camera"
                            )
                            
                }
                
                NavigationLink(
                    destination: BooksView()
                        .navigationBarTitle(Text("Library (\(self.data.count))"), displayMode: .inline)) {
                            InformationDetailView(
                                title: "Library",
                                subTitle: [
                                    "See your books",
                                    "See the details"
                                ].joined(separator: "\n"),
                                imageName: "book"
                            )
                }
            }
            
            // Mark: Beta
            Group {
                Divider()
                
                NavigationLink(
                    destination: EyeViewOld()
                        .navigationBarTitle(Text("Eye"), displayMode: .inline)) {
                            InformationDetailView(
                                title: "Eye",
                                subTitle: "Scan anything", // (beta)
                                imageName: "eye"
                            )
                }
            }
            
            // MARK: Experimental
            if self.clicks >= TitleView.HiddenClicks {
                Group {
                    Divider()
                    
                    NavigationLink(
                        destination: LogView(messages: $messages)
                            .navigationBarItems(trailing:
                                Button(action: {
                                    self.messages = []
                                }) 
                                {
                                    Text("Flush")
                                        .foregroundColor(.red)
                            })
                            .navigationBarTitle(Text("Logs"), displayMode: .inline)) {
                                InformationDetailView(
                                    title: "Logs",
                                    subTitle: "Application log messages",
                                    imageName: "list.dash"
                                )
                    }
                    
                    NavigationLink(
                        destination: EyeView(completion: { msg in
                            print(msg!)
                        })
                            .navigationBarTitle(Text("Eye"), displayMode: .inline)) {
                                InformationDetailView(
                                    title: "Eye",
                                    subTitle: "Minerva Eye at its finest",
                                    imageName: "eye"
                                )
                    }
                }
            }
            
//            // MARK: Settings
//            Group {
//                Divider()
//                
//                NavigationLink(
//                    destination: SettingsView()
//                        .navigationBarTitle(Text("Settings"), displayMode: .inline)) {
//                            InformationDetailView(
//                                title: "Settings",
//                                subTitle: "Customize application settings",
//                                imageName: "gear"
//                            )
//                }
//            }
        }
        .padding(.horizontal)
    }
}

