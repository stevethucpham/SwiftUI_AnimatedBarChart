//
//  TestingUIView.swift
//  AnimatedChart
//
//  Created by Thuc Pham on 16/4/20.
//  Copyright © 2020 Thuc Pham. All rights reserved.
//

import SwiftUI

struct Student {
//    let id = UUID()
    let name: String
    let type: String
}

struct TestingUIView: View {
    
    @State var students: [Student] = [
        Student(name: "Adam" , type: "Good"),
        Student(name: "Peter", type: "Average"),
        Student(name: "Peter" , type: "Good")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(students, id: \.name) { student in
                    HStack {
                        Text("\(student.name)")
                        Text("\(student.type)")
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationBarTitle("Test", displayMode: .inline)
        }
        
    }
}

// MARK: Actions
extension TestingUIView {
    private func deleteItem(at indexSet: IndexSet) {
        print("DEBUG: value at \(indexSet)")
        students.remove(atOffsets: indexSet)
    }
}

struct TestingUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestingUIView()
    }
}
