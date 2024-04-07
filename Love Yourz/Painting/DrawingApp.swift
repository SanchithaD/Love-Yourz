//
//  ContentView.swift
//  Drawing Pencil Kit
//
//  Created by Haaris Iqubal on 5/7/21.
//

import SwiftUI
import CoreData

struct DrawingApp: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Drawing.entity(), sortDescriptors: []) var drawings: FetchedResults<Drawing>
    
    @State private var showSheet = false

    var body: some View {
        NavigationView{
            ZStack {
            VStack{
                if #available(iOS 16.0, *) {
                    List {
                        ForEach(drawings){drawing in
                            NavigationLink(destination: DrawingView(id: drawing.id, data: drawing.canvasData, title: drawing.title), label: {
                                Text(drawing.title ?? "Untitled")
                            })
                        }
                        .onDelete(perform: deleteItem)
                        .foregroundColor(.purple)
                        
                        Button(action: {
                            self.showSheet.toggle()
                        }, label: {
                            HStack{
                                Image(systemName: "plus")
                                Text("Add Canvas")
                            }.foregroundColor(.purple)
                        })
                        .sheet(isPresented: $showSheet, content: {
                            AddNewCanvasView().environment(\.managedObjectContext, viewContext)
                        })
                    }
                    .navigationTitle(Text("Drawing Book"))
                    .navigationBarTitleTextColor(.purple)
                    .toolbar {
                        EditButton().foregroundColor(.purple)
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
//                Color(hue: 0.75, saturation: 0.4, brightness: 1.4).edgesIgnoringSafeArea(.all)
        }
            VStack{
                Image(systemName: "scribble.variable")
                    .font(.largeTitle)
                Text("No canvas has been selected")
                    .font(.title)
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        
    }
    
    func deleteItem(at offset: IndexSet) {
        for index in offset{
            let itemToDelete = drawings[index]
            viewContext.delete(itemToDelete)
            do{
                try viewContext.save()
            }
            catch{
                print(error)
            }
        }
    }

}



extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}
