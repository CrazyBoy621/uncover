//
//  EditInfoView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 12/06/23.
//

import SwiftUI

struct EditInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var start: Bool = false
    @State var infoValue: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("info".uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.lightGrey)
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(spacing: -12) {
                    TextEditorView(string: $infoValue, placeholder: "Info", minHeight: 40, placeholderColor: .darkGrey)
                        .padding(.top, -14)
                        .padding(.horizontal, -12)
                        .offset(x: start ? 8 : 0)
                        .onChange(of: infoValue) { newValue in
                            let count = newValue.count - 150
                            if count > 0 {
                                infoValue.removeLast(count)
                                start = true
                                withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                                    start = false
                                }
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.error)
                            }
                        }
                    Divider()
                    Text("\(infoValue.count)/150")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.backgroundGrey)
                        .padding(.top, 16)
                }
                
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
                    Text("Edit info")
                        .font(.poppinsBold(size: 20))
                        .foregroundColor(.customBlack)
                }
            }
    }
}

struct EditInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditInfoView(infoValue: "info")
    }
}
