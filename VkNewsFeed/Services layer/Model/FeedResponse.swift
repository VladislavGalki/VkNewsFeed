//
//  FeedResponse.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 22.03.2021.
//

import Foundation

protocol ProfileRepresentable {
    var id: Int { get }
    var nameHeader: String { get }
    var photo: String { get }
}

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    let items: [FeedItem]
    let groups: [Group]
    let profiles: [Profile]
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

struct Group: Decodable, ProfileRepresentable {
    
    let id: Int
    let name: String
    let photo100: String
    
    var nameHeader: String {
        return name
    }
    var photo: String {
        return photo100
    }
    
    enum CodinKeys: String, CodingKey {
        case id
        case name
        case photo100 = "photo_100"
    }
}

struct Profile: Decodable, ProfileRepresentable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var nameHeader: String {
        return firstName + " " + lastName
    }
    var photo: String {
        return photo100
    }
    
    enum CodinKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"
    }
}
