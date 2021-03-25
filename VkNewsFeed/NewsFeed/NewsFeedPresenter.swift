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
    let dateFormatter: DateFormatter = {
        
    let df = DateFormatter()
        df.locale = Locale.init(identifier: "ru_RU")
        df.dateFormat = "d MMM 'в' HH:mm"
        return df
    }()
    
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
    switch response {

    case .presentNewsFeed(feedResponse: let feedResponse):
        let cell = feedResponse.items.map { feed in
            self.cellViewModel(from: feed, profile: feedResponse.profiles, group: feedResponse.groups)
        }
        
        let feedViewModels = FeedViewModel.init(cell: cell)
        viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModels))
    }
  }
  
    private func cellViewModel(from feedItem: FeedItem, profile: [Profile], group: [Group]) -> FeedViewModel.Cell {
        
        let profile = self.setProfile(for: feedItem.sourceId, profile: profile, group: group)
        let photoAtachment = self.photoAttachment(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        return FeedViewModel.Cell.init(profile: profile.photo,
                                       name: profile.nameHeader,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes.count),
                                       comments: String(feedItem.comments.count),
                                       shares: String(feedItem.reposts.count),
                                       views: String(feedItem.views.count),
                                       photoAtachment: photoAtachment)
        
    }
    
    
    private func setProfile(for soureId: Int, profile: [Profile], group: [Group]) -> ProfileRepresentable {
        
        let profileOrGroup: [ProfileRepresentable] = soureId >= 0 ? profile : group
        let normalSourceId = soureId >= 0 ? soureId : -soureId
        let profileRepresentable = profileOrGroup.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        
        return profileRepresentable!
    }
    
    private func photoAttachment(feedItem: FeedItem) -> PhotoAtachmentViewModelProtocol? {
        
        guard let photo = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photo.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAtachment.init(imageStringUrl: firstPhoto.src, height: firstPhoto.height, width: firstPhoto.width)
    }
}
