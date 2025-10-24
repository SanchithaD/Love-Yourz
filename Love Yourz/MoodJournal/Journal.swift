//
//  Journal.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 7/29/24.
//

import SwiftUI

struct Journal: View {
    @State var show = false
    @State var txt = ""
    @State var docID = ""
    @ObservedObject var moodModelController = MoodModelController()

    var body: some View {
        VStack(spacing: -55) {
            ZStack {
                Image("journalbackground 1").resizable().frame(width: 1000,height: 350)

                HStack {
                    Text("Tell me about your day").font(.largeTitle).bold()
                        .foregroundColor(.black)
                    Spacer().frame(width: 50)
                    Button(action: {
                        
                        self.txt = ""
                        self.docID = ""
                        self.show.toggle()
                        
                    }) {
                        
                        Image(systemName: "plus").resizable().frame(width: 18, height: 18).foregroundColor(.black)
                        
                    }.padding()
                        .background(Color(red: 205/255, green: 240/255, blue: 213/255))
                        .clipShape(Circle())
                        .padding()
                        .sheet(isPresented: self.$show) {
                            AddMoodView(moodModelController: self.moodModelController)
                            
                        }
                    
                }
                .frame(width: 450,height: 350)
            }
//            ScrollView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 205/255, green: 240/255, blue: 213/255)]), startPoint: .top, endPoint: .bottom).frame(height: 250)
                    VStack {
                        HStack {
                            VStack {
                                Text("Today's Emotions").bold().foregroundColor(Color(red: 99/255, green: 115/255, blue: 106/255))
                                HStack {
                                    ForEach(showTodaysMoods(moods: self.moodModelController.moods)) { mood in
                                        moodImage(mood: mood)
                                        
                                    }
                                    
                                }
                                
                            }
                            .padding()
                            //                    Spacer().frame(width: 50)
                            NavigationLink(destination: CalendarView(start: Date(), monthsToShow: 1, daysSelectable: true, moodController: moodModelController), label: {
                                Image("calender").resizable().frame(width: 80, height: 80).foregroundColor(Color(red: 203/255, green:238/255, blue: 208/255))
                            }).padding()
                            
                        }
                        Spacer().frame(height: 150)
                    }
                }
            
                    List {
                        ForEach(self.moodModelController.moods, id: \.id) { mood in
                            NavigationLink(destination: JournalEntry(mood: mood)) {
                                Spacer()
                                MoodRowView(mood: mood)
                                Spacer()
                            }
                            
                        }.onDelete { (index) in
                            
                            self.moodModelController.deleteMood(at: index)
                        }.listRowBackground(Color(red: 205/255, green: 240/255, blue: 213/255))
                    }
                    .onAppear {
                        UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().backgroundColor = UIColor(red: 205/255, green: 240/255, blue: 213/255, alpha: 1)
                        UITableView.appearance().backgroundColor = UIColor(red: 205/255, green: 240/255, blue: 213/255, alpha: 1)
                    }
                    .scrollContentBackground(.hidden)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 244/255, green: 251/255, blue: 245/255), Color(red: 240/255, green: 249/255, blue: 241/255)]), startPoint: .top, endPoint: .bottom).frame(height: 380)
                    ).ignoresSafeArea()
                    
        }.ignoresSafeArea()

    }
    
    func showTodaysMoods(moods: [Mood]) -> [Mood] {
        var todaysMoods = [Mood]()
        var todaysDate = Date.now
        for mood in moods {
            if (Calendar.current.isDateInToday(mood.date)) {
                todaysMoods.append(mood)
                print(mood)
            }
            print(mood)

        }
        if todaysMoods.count > 3 {
            return Array(todaysMoods.suffix(3))
        }
        return todaysMoods
    }
    func moodImage(mood: Mood) -> some View {
        var imageName = "none"
        
        switch mood.emotion {
        case .happy:
            imageName = "happy"
        case .angry:
            imageName = "angry"
        case .sad:
            imageName = "sad"
        case .confused:
            imageName = "confused"
        case .loved:
            imageName = "loved"
        case .scared:
            imageName = "scared"
        }
        return Image(imageName).resizable().frame(width: 60, height: 50)
    }
}

#Preview {
    Journal()
}
