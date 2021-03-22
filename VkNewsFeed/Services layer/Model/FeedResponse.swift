//
//  FeedResponse.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 22.03.2021.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    let items: [FeedItem]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem
    let likes: CountableItem
    let reposts: CountableItem
    let views: CountableItem
    
    enum CodinKeys: String, CodingKey {
        case sourceId = "source_id"
        case postId = "post_id"
        case text
        case date
    }
}

struct CountableItem: Decodable {
    let count: Int
}
