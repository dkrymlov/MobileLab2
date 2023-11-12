//
//  StudentView.swift
//  MobileLab2
//
//  Created by Даниил Крымлов on 12.11.2023.
//

import SwiftUI

struct StudentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var isShowingSheet: Bool = false
    @State var creds: String = ""
    @State var firstSubjectPoints: String = ""
    @State var secondSubjectPoints: String = ""
    @State var address: String = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StudentEntity.creds, ascending: true)],
        animation: .default)
    private var items: FetchedResults<StudentEntity>
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(items, id: \.self) { item in
                        HStack{
                            VStack(alignment: .leading) {
                                Text(item.creds ?? "")
                                    .font(.headline)
                                Text(item.address ?? "")
                                    .font(.caption)
                                    .padding(.top, 4)
                            }
                            .padding(4)
                            Spacer()
                            VStack {
                                Text("Оцінки")
                                    .font(.headline)
                                HStack {
                                    Text("\(item.firstSubjectPoints)")
                                        .padding(.trailing, 4)
                                    Text("\(item.secondSubjectPoints)")
                                }
                                .font(.caption)
                                .padding(.top, 4)
                            }
                            .padding(4)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.brown)
                            .opacity(0.2)
                            .padding(.vertical, 3)
                    )
                    .listRowSeparator(.hidden)
                    
                }
                .navigationTitle("Студенти")
                .navigationBarItems(
                    leading:
                        Button(action: {
                            fetchStudents()
                        }, label: {
                            Image(systemName: "arrow.down")
                        }),
                    trailing:
                        HStack {
                            NavigationLink(destination: StudentsWhoPass(all: items.count, students: getStudentsWhoPass()), label: {
                                Image(systemName: "arrow.up.arrow.down")
                            })
                            Button(action: {
                                isShowingSheet = true
                            }, label: {
                                Image(systemName: "plus")
                            })
                        }
                )
            }
            
            .sheet(isPresented: $isShowingSheet) {
                Text("Додати нового студента")
                    .font(.title)
                    .bold()
                    .padding()
                Form {
                    TextField(
                        "ПІБ Студента",
                        text: $creds
                    )
                    TextField(
                        "Адреса Студента",
                        text: $address
                    )
                    TextField(
                        "Бали за перший предмет",
                        text: $firstSubjectPoints
                    )
                    .keyboardType(.decimalPad)
                    TextField(
                        "Бали за другий предмет",
                        text: $secondSubjectPoints
                    )
                    .keyboardType(.decimalPad)
                    Button(action: {
                        let student = Student(creds: creds, firstSubjectPoints: Int64(firstSubjectPoints) ?? 0, secondSubjectPoints: Int64(secondSubjectPoints) ?? 0, address: address)
                        addStudent(student: student)
                        
                        creds = ""
                        firstSubjectPoints = ""
                        secondSubjectPoints = ""
                        address = ""
                        
                        isShowingSheet = false
                    }, label: {
                        Text("Зберегти")
                    })
                }
            }
        }
    }
    
    func getStudentsWhoPass() -> [Student] {
        var result: [Student] = []
        for item in items {
            if getAvarageScore(points1: item.firstSubjectPoints, points2: item.secondSubjectPoints) > 60 {
                result.append(Student(creds: item.creds ?? "", firstSubjectPoints: item.firstSubjectPoints, secondSubjectPoints: item.secondSubjectPoints, address: item.address ?? ""))
            }
        }
        return result
    }
    
    func getAvarageScore(points1: Int64, points2: Int64) -> Int {
        return Int((points1 + points2)/2)
    }
    
    private func deleteItems(offsets: IndexSet) {
        offsets.map { items[$0] }.forEach(viewContext.delete)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fetchStudents()  {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json")
        else {
            print("Json file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let students = try? JSONDecoder().decode([Student].self, from: data!)
        
        if let students = students {
            for student in students {
                addStudent(student: student)
            }
        }
        
    }
    
    func addStudent(student: Student) {
        let newItem = StudentEntity(context: viewContext)
        newItem.creds = student.creds
        newItem.firstSubjectPoints = student.firstSubjectPoints
        newItem.secondSubjectPoints = student.secondSubjectPoints
        newItem.address = student.address
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
}

#Preview {
    StudentView()
}
