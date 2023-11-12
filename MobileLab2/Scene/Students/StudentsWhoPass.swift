//
//  StudentsWhoPass.swift
//  MobileLab2
//
//  Created by Даниил Крымлов on 12.11.2023.
//

import SwiftUI

struct StudentsWhoPass: View {
    let all: Int
    let students: [Student]
    
    var body: some View {
        VStack{
            Text("Відібрано: \(getPercentage()) % студентів")
                .font(.headline)
            List {
                Section(header: Text("ПІБ Студента")) {
                    ForEach(students) { student in
                        HStack {
                            Text(student.creds)
                            Spacer()
                            Text("\((student.firstSubjectPoints + student.secondSubjectPoints)/2)")
                        }
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.green)
                            .opacity(0.2)
                    )
                }
            }
            .listRowSeparator(.hidden)
            .listRowSpacing(5)
        }.navigationTitle("Успішність")
    }
    
    func getPercentage() -> Int {
        if all != 0 {
            return Int((students.count * 100)/all)
        }
        else {
            return 0
        }
    }
}
