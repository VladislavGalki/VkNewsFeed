//
//  NewsFeedPresenter.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 22.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
  weak var viewController: NewsFeedDisplayLogic?
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
    switch response {

    case .presentNewsFeed(feedResponse: let feedResponse):
        let cell = feedResponse.items.map { feed in
            self.cellViewModel(from: feed)
        }
        
        let feedViewModels = FeedViewModel.init(cell: cell)
        viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModels))
    }
  }
  
    private func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
        return FeedViewModel.Cell.init(profile: "",
                                       name: "Comming soon",
                                       date: "Comming soon",
                                       text: feedItem.text,
                                       likes: String(feedItem.likes.count),
                                       comments: String(feedItem.comments.count),
                                       shares: String(feedItem.reposts.count),
                                       views: String(feedItem.views.count))
    }
}
