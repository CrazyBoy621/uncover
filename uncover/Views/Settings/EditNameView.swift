//
//  EditNameView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 12/06/23.
//

import SwiftUI

struct EditNameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var nameValue: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("name".uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.lightGrey)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    TextField("Name", text: $nameValue)
                }
                Divider()
                Text("You can put here your full name or business name to help others to find your profile.")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.backgroundGrey)
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 16) {
                    Spacer()
                    Button {
                            presentationMode.wrappedValue.dismiss()
                    } label: {
                        CustomButton(title: "Cancel", foreground: .softBlue, background: .white)
                    }
                    Button {
                        
                    } label: {
                        CustomButton(title: "Done", foreground: .white, background: .mainColor)
                    }

                }
                .padding(.top, 24)
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 32)
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit name")
                        .font(.poppinsBold(size: 20))
                        .foregroundColor(.customBlack)
                }
            }
    }
}

struct EditNameView_Previews: PreviewProvider {
    static var previews: some View {
        EditNameView(nameValue: "Jojo")
    }
}
