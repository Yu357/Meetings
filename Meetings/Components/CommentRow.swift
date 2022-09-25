//
//  CommentRow.swift
//  Meetings
//
//  Created by Yu on 2022/07/23.
//

import SwiftUI

struct CommentRow: View {
    
    // Comment to show
    let comment: Comment
    
    // States
    @State private var isCommentDeleted = false
    
    // Navigations
    let isAbleShowingProfileView: Bool
    let isShowThread: Bool
                
    var body: some View {
        
        Group {
            if !isCommentDeleted {
                HStack(alignment: .top, spacing: 8) {
                    
                    // Icon Column
                    UserIconButton(userId: comment.userId, iconSizeFamily: .medium)
                        .disabled(!isAbleShowingProfileView)
                    
                    // Content Column
                    VStack(alignment: .leading) {
                        // Header Row
                        HStack {
                            // Display Name Column
                            UserDisplayNameText(userId: comment.userId)
                            
                            // User Tag Column
                            UserUserTagText(userId: comment.userId)
                            
                            // Date Column
                            EditDate.howManyAgoText(from: comment.createdAt)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            // Menu Column
                            CommentMenu(comment: comment, isCommentDeleted: $isCommentDeleted)
                        }
                        
                        // Text Row
                        Text(comment.text)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        // Images Row
                        CommentImagesRow(comment: comment)
                        
                        // Reaction Row
                        CommentReactionRow(comment: comment)
                            .padding(.top, 4)
                        
                        // Thread Title Row
                        if isShowThread {
                            CommentThreadTitleRow(comment: comment)
                        }
                    }
                }
                .background(NavigationLink("", destination: CommentView(comment: comment)).opacity(0))
            }
        }
    }
}
