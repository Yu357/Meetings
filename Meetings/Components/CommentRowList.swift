//
//  CommentsPage.swift
//  Meetings
//
//  Created by Yu on 2022/07/25.
//

import SwiftUI

struct CommentRowList: View {
    
    let comments: [Comment]?
    
    var body: some View {
        List {
            // Progress view
            if comments == nil {
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.circular)
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
            
            // No content text
            if comments?.count == 0 {
                Text("no_comments")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.secondary)
                    .listRowSeparator(.hidden)
            }
            
            // CommentRows
            if comments != nil {
                ForEach(comments!) { comment in
                    CommentRow(comment: comment, isDisableShowingProfileView: true, isAbleShowingThreadView: true)
                }
                .listRowSeparator(.hidden)
            }            
        }
        .listStyle(.plain)
    }
}