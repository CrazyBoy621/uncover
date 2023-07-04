//
//  UserBooksView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 05/07/23.
//

import SwiftUI

struct UserBooksView: View {
    
    @State private var selectedTab: Tab = .all
    
    enum Tab {
        case all
        case wantToRead
        case started
        case finished
        case stopped
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderSearchView()
            
            Divider()
            
            TabView(selection: $selectedTab) {
                Group {
                    All()
                        .tag(Tab.all)
                    WantToRead()
                        .tag(Tab.wantToRead)
                    Started()
                        .tag(Tab.started)
                    Finished()
                        .tag(Tab.finished)
                    Stopped()
                        .tag(Tab.stopped)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("books".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                    Text("books".localized)
                        .font(.poppinsExtraBold(size: 20))
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    HStack(spacing: 8) {
                        Text("Sort")
                        Image(systemName: "arrow.up.arrow.down")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.customBlack)
                }

            }
        }
    }
    
    @ViewBuilder func HeaderSearchView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                Button {
                    withAnimation {
                        selectedTab = .all
                    }
                } label: {
                    Text("All")
                        .font(selectedTab == .all ? .poppinsBold(size: 16) : .poppinsMedium(size: 16))
                        .frame(height: 36, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .fill(selectedTab == .all ? Color.customBlack : Color.clear)
                                .frame(height: 2)
                            , alignment: .bottom
                        )
                }
                
                Button {
                    withAnimation {
                        selectedTab = .wantToRead
                    }
                } label: {
                    Text("Want to read")
                        .font(selectedTab == .wantToRead ? .poppinsBold(size: 16) : .poppinsMedium(size: 16))
                        .frame(height: 36, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .fill(selectedTab == .wantToRead ? Color.customBlack : Color.clear)
                                .frame(height: 2)
                            , alignment: .bottom
                        )
                }
                
                Button {
                    withAnimation {
                        selectedTab = .started
                    }
                } label: {
                    Text("Started")
                        .font(selectedTab == .started ? .poppinsBold(size: 16) : .poppinsMedium(size: 16))
                        .frame(height: 36, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .fill(selectedTab == .started ? Color.customBlack : Color.clear)
                                .frame(height: 2)
                            , alignment: .bottom
                        )
                }
                
                Button {
                    withAnimation {
                        selectedTab = .finished
                    }
                } label: {
                    Text("Finished")
                        .font(selectedTab == .finished ? .poppinsBold(size: 16) : .poppinsMedium(size: 16))
                        .frame(height: 36, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .fill(selectedTab == .finished ? Color.customBlack : Color.clear)
                                .frame(height: 2)
                            , alignment: .bottom
                        )
                }
                
                Button {
                    withAnimation {
                        selectedTab = .stopped
                    }
                } label: {
                    Text("Stopped")
                        .font(selectedTab == .stopped ? .poppinsBold(size: 16) : .poppinsMedium(size: 16))
                        .frame(height: 36, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .fill(selectedTab == .stopped ? Color.customBlack : Color.clear)
                                .frame(height: 2)
                            , alignment: .bottom
                        )
                }
            }
            .padding(.horizontal, 16)
        }
        .font(.poppinsMedium(size: 16))
        .foregroundColor(.customBlack)
        .padding(.top, 16)
    }
    
    @ViewBuilder func All() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns:
                        [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 10) {
                            ForEach(1...20, id: \.self) { index in
                                BookCard(title: "Pet Sematary", imgUrl: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSq5Y1xYI2e_Ww5z3Z0BN0dSQxKRSbiETs-rRrJKTzZ3WWFSHl7")
                            }
                        }
                        .padding(.bottom, 106)
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
        }
    }
    
    @ViewBuilder func WantToRead() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns:
                        [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 10) {
                            ForEach(1...20, id: \.self) { index in
                                BookCard(title: "Pet Sematary", imgUrl: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSq5Y1xYI2e_Ww5z3Z0BN0dSQxKRSbiETs-rRrJKTzZ3WWFSHl7")
                            }
                        }
                        .padding(.bottom, 106)
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
        }
    }
    
    @ViewBuilder func Started() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns:
                        [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 10) {
                            ForEach(1...20, id: \.self) { index in
                                BookCard(title: "Pet Sematary", imgUrl: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSq5Y1xYI2e_Ww5z3Z0BN0dSQxKRSbiETs-rRrJKTzZ3WWFSHl7")
                            }
                        }
                        .padding(.bottom, 106)
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
        }
    }
    
    @ViewBuilder func Finished() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns:
                        [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 10) {
                            ForEach(1...20, id: \.self) { index in
                                BookCard(title: "Pet Sematary", imgUrl: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSq5Y1xYI2e_Ww5z3Z0BN0dSQxKRSbiETs-rRrJKTzZ3WWFSHl7")
                            }
                        }
                        .padding(.bottom, 106)
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
        }
    }
    
    @ViewBuilder func Stopped() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns:
                        [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 10) {
                            ForEach(1...20, id: \.self) { index in
                                BookCard(title: "Pet Sematary", imgUrl: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSq5Y1xYI2e_Ww5z3Z0BN0dSQxKRSbiETs-rRrJKTzZ3WWFSHl7")
                            }
                        }
                        .padding(.bottom, 106)
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
        }
    }
    
    @ViewBuilder func BookCard(title: String, imgUrl: String) -> some View {
        VStack{
            WebImageView(url: URL(string: imgUrl), defaultImage: "square.fill")
                .aspectRatio(contentMode: .fill)
                .frame(width: 104, height: 166)
                .cornerRadius(8)
        }
    }
}

struct UserBooksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserBooksView()
        }
    }
}
