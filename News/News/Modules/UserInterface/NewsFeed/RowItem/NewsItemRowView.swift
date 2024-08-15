//
//  NewsItemRowView.swift
//  News
//
//  Created by Someshubhra Karmakar on 11/08/24.
//

import SwiftUI

struct NewsItemRowView: View {
    @ObservedObject var rowItemViewModel: NewsItemRowViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(rowItemViewModel.tileLineText)
            Spacer(minLength: 2)
            Text(rowItemViewModel.descriptionLineText)
            Spacer(minLength: 2)
            Text(rowItemViewModel.sourceLineText).frame(alignment: .leading)
            Spacer(minLength: 5)

            // Image View
            HStack {
                if !rowItemViewModel.newsFeedItem.imageUrl.isEmpty {
                    AsyncImage(url: URL(string: rowItemViewModel.newsFeedItem.imageUrl))
                    { result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                        
                    }
                    .frame(width: 50, height: 50)
                }
            }
            .padding(.leading, 20)

            Spacer(minLength: 5)
            Text(rowItemViewModel.bookMarkButtonTitle)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .onTapGesture {
                    rowItemViewModel.bookMarkTapAction?()
                }
            Spacer(minLength: 10)
            NavigationLink("Full News") {
                NewsItemDetailView(viewModel: NewsItemDetailViewModel(newsItem: rowItemViewModel.newsFeedItem))
            }
            Spacer(minLength: 10)
        }
    }
}
