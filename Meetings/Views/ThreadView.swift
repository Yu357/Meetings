//
//  ThreadView.swift
//  Meetings
//
//  Created by Yu on 2022/07/21.
//

import SwiftUI

struct ThreadView: View {
    
    // Thread to show
    private let thread: Thread
    
    // States
    @ObservedObject private var commentsViewModel: CommentsViewModel
    @ObservedObject private var signInStateViewModel = SignInStateViewModel()
    @State private var isShowCreateCommentView = false
    
    init(thread: Thread) {
        self.thread = thread
        self.commentsViewModel = CommentsViewModel(threadId: thread.id)
    }

    var body: some View {
        
        List {
            // Progress view
            if !commentsViewModel.isLoaded {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowSeparator(.hidden)
            }
            
            // No content text
            if commentsViewModel.isLoaded && commentsViewModel.comments.count == 0 {
                Text("no_comments")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.secondary)
                    .listRowSeparator(.hidden)
            }
            
            // CommentRows
            ForEach(commentsViewModel.comments) { comment in
                CommentRow(comment: comment, isDisableShowingProfileView: false, isAbleShowingThreadView: false, isAbleShowingCommentView: true)
            }
            .listRowSeparator(.hidden, edges: .top)
            .listRowSeparator(.visible, edges: .bottom)
        }
        .listStyle(.plain)
        
        .sheet(isPresented: $isShowCreateCommentView) {
            CreateCommentView(threadId: thread.id)
        }
        
        .navigationTitle(thread.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isShowCreateCommentView.toggle()
                }) {
                    Image(systemName: "square.and.pencil")
                }
                .disabled(!signInStateViewModel.isSignedIn)
            }
        }
    }
}
