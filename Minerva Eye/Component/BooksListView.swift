//
//  ManageView.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/27/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import SwiftUI

struct BooksListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
        ]
    ) var data: FetchedResults<Book>
    
    var handleScan: () -> ()
    
    var body: some View {
        VStack {
            NavigationView {
               List {
                    ForEach(data, id: \.self.isbn) { book in
                        NavigationLink(destination: BookDetailView(data: book)) {
                            BooksListRowView(data: book)
                        }
                    }
                    .onDelete(perform: delete)
                }
                .navigationBarTitle(Text("Books"))
                .navigationBarItems(leading:
                    HStack {
                        Button("Minerva Eye") {
                            print("Minerva Eye - tapped!")
                        }
                        .disabled(true)
                    }, trailing:
                    HStack {
                        Button("Settings") {
                            print("Settings - tapped!")
                        }
                        .disabled(true)

                        Button("Profile") {
                            print("Profile - tapped!")
                        }
                        .disabled(true)
                    }
                )
                .id(UUID())
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        DispatchQueue.main.async {
            offsets.forEach() { idx in
                // Saving the Delete operation
                do {
                    self.managedObjectContext.delete(self.data[idx])
                    try self.managedObjectContext.save()
                } catch {
                    print("Failed saving")
                }
            }
        }
    }
}

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView(handleScan: {})
    }
}
