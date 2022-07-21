//
//  FirstView.swift
//  Meetings
//
//  Created by Yu on 2022/07/21.
//

import SwiftUI

struct FirstView: View {
    
    @State private var isShowProfileView = false
    @State private var isShowCreateThreadView = false
    
    var body: some View {
        NavigationView {
            
            List {
                NavigationLink(destination: ThreadView()) {
                    Text("hello")
                }
            }
            
            .sheet(isPresented: $isShowProfileView) {
                ProfileView()
            }
            
            .sheet(isPresented: $isShowCreateThreadView) {
                CreateThreadView()
            }
            
            .navigationTitle("threads")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isShowProfileView.toggle()
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowCreateThreadView.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}