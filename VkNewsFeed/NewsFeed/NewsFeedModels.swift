//
//  NewsFeedModels.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 22.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum NewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feedResponse: FeedResponse)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
            }
        }
    }
}

struct FeedViewModel {
    struct Cell: NewsFeedCellViewModelProtocol {
        var profile: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
    }
    
    var cells = [Cell]()
    
    init(cell: [Cell]) {
        self.cells = cell
    }
}
