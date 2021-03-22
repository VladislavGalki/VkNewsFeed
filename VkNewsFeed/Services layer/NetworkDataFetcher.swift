//
//  NetworkDataFetcher.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 22.03.2021.
//

import Foundation

protocol DataFetcherProtocol {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcherProtocol {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters":"post, photo"]
        networking.request(path: Api.path, params: params) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            guard let data = data else { return }
            let decoded = self.decodeJson(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = from , let result = try? decoder.decode(type.self, from: data) else { return nil }
        return result
    }
}
