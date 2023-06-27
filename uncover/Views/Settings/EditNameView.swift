//
//  EditNameView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/06/23.
//

import SwiftUI

struct EditNameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var nameValue: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("name".localized.uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.lightGrey)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    TextField("name".localized, text: $nameValue)
                }
                Divider()
                Text("name_field_alert".localized)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.backgroundGrey)
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 16) {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        CustomButton(title: "cancel".localized, foreground: .softBlue, background: .white)
                    }
                    Button {
                        
                    } label: {
                        CustomButton(title: "done".localized, foreground: .white, background: .mainColor)
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
                Text("edit_name".localized)
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
