//
//  SearchList.swift
//  Meetings
//
//  Created by Yu on 2022/09/21.
//

import SwiftUI

struct SearchList: View {
    
    // Environments
    @Environment(\.isSearching) var isSearching
    
    // States
    let keyword: String
    @Binding var isSubmited: Bool
        
    var body: some View {
        List {
            // Recommended Tags Section
            if !isSearching {
                RecommendedTagsSection()
            }
            
            // Search History Section
            else if isSearching && !isSubmited && keyword.isEmpty {
                SearchHistorySection()
            }
            
            // Search Suggestions Section
            else if isSearching && !isSubmited && !keyword.isEmpty {
                SearchSuggestionsSection()
            }
            
            // Search Results Section
            else if isSearching && isSubmited {
                SearchResultsSection(keyword: keyword)
            }
        }
        .listStyle(.plain)
        
        // isSearchingがfalseになったら、isSubmitedもfalseにする
        .onChange(of: isSearching) { newValue in
            if !newValue {
                isSubmited = false
            }
        }
        
        // keywordが変更されたら、isSubmitedをfalseにする
        .onChange(of: keyword) { _ in
            isSubmited = false
        }
    }
}