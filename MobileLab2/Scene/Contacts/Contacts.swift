//
//  Contacts.swift
//  MobileLab2
//
//  Created by Даниил Крымлов on 12.11.2023.
//

import SwiftUI
import Contacts

struct Contacts: View {
    @State var contacts = [CNContact]()
    @State var isLoading: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading){
                    ForEach(contacts, id: \.identifier) { contactDetail in
                        HStack {
                            if contactDetail.imageDataAvailable {
                                Image(uiImage: UIImage(data: contactDetail.imageData ?? Data()) ?? UIImage())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                                    .padding()
                                
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                                    .padding()
                            }
                            VStack(alignment: .leading) {
                                Text("\(contactDetail.givenName)")
                                    .font(.headline)
                                if contactDetail.phoneNumbers.count > 0 {
                                    Text("\(contactDetail.phoneNumbers[0].value.stringValue)")
                                        .font(.caption)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                                .opacity(0.2)
                        )
                        .padding(.vertical, 3)
                        
                    }
                }
            }
            .onAppear (perform: getContactList)
            .navigationTitle("Контакти")
            .navigationBarItems(leading:
                                    Button(action: {
                                        contacts = contacts.filter {
                                            $0.givenName.contains("Іван") || $0.givenName.contains("Ivan")
                                        }
                                    }, label: {
                                        Image(systemName: "arrow.up.arrow.down")
                                    })
            )
        }
    }
    
    func getContactList() {
        let CNStore = CNContactStore()
        isLoading = true
        contacts = []
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            do {
                let keys = [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor,
                    CNContactImageDataAvailableKey as CNKeyDescriptor,
                            CNContactPhoneNumbersKey as CNKeyDescriptor
                ]
                let request = CNContactFetchRequest (keysToFetch: keys)
                try CNStore.enumerateContacts (with: request, usingBlock: { contact, _ in
                    contacts .append (contact)
                    }
                )
                isLoading = false
            } catch {
                print("Error on contact fetching\(error)")
            }
        case .denied:
            print ("denied" )
        case .notDetermined:
            print ("notDetermined" )
            CNStore.requestAccess (for: .contacts) { granted, error in
                if granted {
                    getContactList()
                } else if let error = error {
                    print("Error requesting contact access: \(error)")
                }
            }
        case .restricted:
            print ("restricted")
        @unknown default:
            print ("")
            
        }
    }
        
}

#Preview {
    Contacts()
}
