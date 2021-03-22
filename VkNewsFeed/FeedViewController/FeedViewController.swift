//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 21.03.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var fetcher: DataFetcherProtocol = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        fetcher.getFeed { (response) in
            print(response?.items)
        }
    }
}
