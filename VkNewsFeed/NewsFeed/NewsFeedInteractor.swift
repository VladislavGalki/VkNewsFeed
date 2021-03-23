//
//  NewsFeedInteractor.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 22.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    private var fetcher: DataFetcherProtocol = NetworkDataFetcher.init(networking: NetworkService())
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        switch request {
        case .getNewsFeed:
            fetcher.getFeed { [weak self] (feedResponse) in
                guard let feedResponse = feedResponse else { return }
                self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feedResponse: feedResponse))
            }
        }
    }
}
