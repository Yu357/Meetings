//
//  ThreadRow.swift
//  Meetings
//
//  Created by Yu on 2022/07/21.
//

import SwiftUI

struct ThreadRow: View {
    
    // Thread to show
    let thread: Thread
    
    // States
    @State private var comments: [Comment]? = []
    @State private var isLoadedComments = false
    
    // Dialogs, Navigations
    @State private var isShowDialog = false
    @State private var isShowCreateReportView = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 1) {
            
            // Header Row
            HStack(alignment: .top) {
                
                // Title Column
                Text(thread.title)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                // Menu Column
                Menu {
                    // 削除ボタン
                    if FireAuth.uid() == thread.userId {
                        Button(role: .destructive) {
                            isShowDialog.toggle()
                        } label: {
                            Label("delete_thread", systemImage: "trash")
                        }
                    }
                    
                    // 報告ボタン
                    if FireAuth.uid() != thread.userId {
                        Button(action: {
                            isShowCreateReportView.toggle()
                        }) {
                            Label("report_thread", systemImage: "flag")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.secondary)
                        .padding(.vertical, 6)
                }
            }
            
            // Tags Row
            UserUserTagText(userId: thread.userId)
        }
        .background(NavigationLink("", destination: ThreadView(thread: thread)).opacity(0))
        
        .confirmationDialog("", isPresented: $isShowDialog, titleVisibility: .hidden) {
            Button("delete_thread", role: .destructive) {
                FireThread.deleteThread(threadId: thread.id)
            }
        } message: {
            Text("are_you_sure_you_want_to_delete_this_thread")
        }
        
        .sheet(isPresented: $isShowCreateReportView) {
            CreateReportView(target: .thread)
        }
        
        .onAppear(perform: load)
    }
    
    private func load() {
        // このスレッド上のコメントを読み取り
        FireComment.readComments(threadId: thread.id) { comments in
            self.comments = comments
            self.isLoadedComments = true
        }
    }
}
