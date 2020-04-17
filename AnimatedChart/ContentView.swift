//
//  ContentView.swift
//  AnimatedChart
//
//  Created by Thuc Pham on 14/4/20.
//  Copyright © 2020 Thuc Pham. All rights reserved.
//

import SwiftUI

enum DayParts: Int, CaseIterable, Identifiable {
    case morning = 0
    case afternoon
    case evening
    
    var name: String {
        return "\(self)".capitalized
    }
    
    var id: DayParts { self }
}

enum Days: CaseIterable, Identifiable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var shortname: String {
        return String("\(self)".prefix(2).capitalized)
    }
    
    var id: Days { self }
}

struct Calorie {
    var dayPart: DayParts
    var caloriesByDay: [(day: Days, calories: CGFloat)]
}

struct ContentView: View {
    
    @State private var pickerSelectedSystem = 0
    
    @State var data: [Calorie] =
        [
            Calorie(dayPart: .morning, caloriesByDay: [
                (Days.sunday, 10),
                (Days.monday, 20),
                (Days.tuesday, 30),
                (Days.wednesday, 40),
                (Days.thursday, 50),
                (Days.friday, 60),
                (Days.saturday, 70)
            ]),
            Calorie(dayPart: .afternoon, caloriesByDay: [
                (Days.sunday, 110),
                (Days.monday, 120),
                (Days.tuesday, 130),
                (Days.wednesday, 140),
                (Days.thursday, 150),
                (Days.friday, 60),
                (Days.saturday, 70)
            ]),
            Calorie(dayPart: .evening, caloriesByDay: [
                (Days.sunday, 140),
                (Days.monday, 120),
                (Days.tuesday, 130),
                (Days.wednesday, 140),
                (Days.thursday, 75),
                (Days.friday, 89),
                (Days.saturday, 45)
            ])
    ]
    
    var body: some View {
        ZStack {
            // How to use Color Literal
            // #colorLiteral()
            Color("appbackground").edgesIgnoringSafeArea(.all)
            
            VStack {
                // Title
                Text("Calory Intake")
                    .font(.system(size: 34))
                    .fontWeight(.heavy)
                // Picker View
                
                pickerView
                
                HStack (spacing: 20) {
                    ForEach(0..<self.data[pickerSelectedSystem].caloriesByDay.count, id: \.self) { i in
                        BarChart(value: self.data[self.pickerSelectedSystem].caloriesByDay[i].calories,
                                 title: self.data[self.pickerSelectedSystem].caloriesByDay[i].day.shortname)
                    }
                    
                } // hstack
                    .padding(.top, 24)
            } // vstack
        } // zstack
    }
}

private extension ContentView {
    var pickerView: some View {
        Picker(selection: $pickerSelectedSystem.animation(), label: Text("")) {
            ForEach(DayParts.allCases) { day in
                Text(day.name).tag(day.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 24)
    }
}

struct BarChart: View {
    
    var value: CGFloat = 0
    var title: String = ""
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule().frame(width: 30, height: 200)
                    .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                Capsule().frame(width: 30, height: value)
                    .foregroundColor(.white)
            }
            Text(title)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
