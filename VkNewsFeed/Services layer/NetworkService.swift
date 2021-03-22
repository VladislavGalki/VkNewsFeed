//
//  NetworkService.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 21.03.2021.
//

import Foundation

protocol NetworkingProtocol: class {
    func request (path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: NetworkingProtocol {
    
    private let authService: AuthSevice?
    
    init(authService: AuthSevice = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService?.token else { return }
        
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = Api.version
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest ,completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, params: [String : String]) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = Api.scheme
        urlComponents.host = Api.host
        urlComponents.path = path
       
        urlComponents.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
        return urlComponents.url!
    }
    
}
