//
//  TagRow.swift
//  Meetings
//
//  Created by Yu on 2022/09/20.
//

import SwiftUI

struct TagRow: View {
    
    let name: String
    
    var body: some View {
        VStack(alignment: .leading) {
            // Header Row
            HStack {
                // Name Column
                Text(name)
                
                Spacer()
                
                // Menu Column
                Menu {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.secondary)
                        .padding(.vertical, 6)
                }
            }
            
            // Thread Count Row
            Text("\(Int.random(in: 0...10))件のスレッド")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
    }
}
