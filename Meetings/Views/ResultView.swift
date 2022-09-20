//
//  ResultView.swift
//  Meetings
//
//  Created by Yu on 2022/09/20.
//

import SwiftUI

struct ResultView: View {
    
    // States
    @State private var keyword = ""
    @State private var selection = 0
    @State private var isShowResultView = false
    
    @ObservedObject private var threadsViewModel = ThreadsByKeywordViewModel()
    
    init(keyword: String) {
        _keyword = State(initialValue: keyword)
        threadsViewModel.read(keyword: keyword)
    }
    
    var body: some View {
        List {
            // Tab Bar Row
            FluentTabBar(tabBarItems: [Text("threads"), Text("tag"), Text("comments"), Text("users")], selection: $selection)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            
            // Threads Row
            Group {
                // Progress
                if !keyword.isEmpty && !threadsViewModel.isLoaded {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowSeparator(.hidden)
                }

                // Failed
                if threadsViewModel.isLoaded && threadsViewModel.threads == nil {
                    Text("threads_reading_failed")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.secondary)
                        .listRowSeparator(.hidden)
                }

                // No content
                if threadsViewModel.isLoaded && threadsViewModel.threads != nil && threadsViewModel.threads!.count == 0 {
                    Text("no_threads")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.secondary)
                        .listRowSeparator(.hidden)
                }

                // Done
                if threadsViewModel.isLoaded && threadsViewModel.threads != nil {
                    ForEach(threadsViewModel.threads!) { thread in
                        ThreadRow(thread: thread)
                            .listRowSeparator(.hidden, edges: .top)
                            .listRowSeparator(.visible, edges: .bottom)
                    }
                }
            }
        }
        .listStyle(.plain)
        
        .background(
            NavigationLink(destination: ResultView(keyword: keyword), isActive: $isShowResultView) {
                EmptyView()
            }
            .hidden()
        )
        
        .searchable(text: $keyword, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("keyword"))
        .onSubmit(of: .search) {
            isShowResultView.toggle()
        }
        
        .navigationTitle("result")
        .navigationBarTitleDisplayMode(.inline)
    }
}