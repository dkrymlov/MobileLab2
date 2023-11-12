//
//  Author.swift
//  MobileLab2
//
//  Created by Даниил Крымлов on 12.11.2023.
//

import SwiftUI

struct Author: View {
    var body: some View{
        NavigationStack {
            VStack{
                Image("avatar")
                    .resizable()
                    .frame(width: 200, height: 250, alignment: .center)
                    .clipped()
                    .cornerRadius(20)
                
                Text("Данило Кримлов")
                    .font(.title)
                    .bold()
                Text("ТТП-42").font(.headline)
                Text("Варіант №1")
                Text("Лабораторна робота №2")
                Spacer()
            }
            .padding(.vertical)
            .navigationTitle("Автор роботи")
        }
    }
}

#Preview {
    Author()
}
