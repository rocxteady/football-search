//
//  SearchViewModel.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation
import Combine
import SwiftUI
import API

class FootballListViewModel<T: BaseResult>: ObservableObject {
    
    @Published var data: [APIIdentifiable] = []
    private var searchCancellable: AnyCancellable? {
        willSet {
            searchCancellable?.cancel()
        }
    }
    
    var isSearchResultEmpty: Bool {
        data.isEmpty
    }
    
    var isDataEmpty: Bool {
        data.isEmpty
    }
    
    func search(searchText: String) {
        guard !searchText.isEmpty else {
            data = []
            return
        }
        let searchAPI = try! SearchAPI<T>(requestModel: SearchRequestModel(searchString: searchText, searchType: .players, offset: 0))
        searchCancellable = searchAPI.publish_start().sink { completion in
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                print("Fisined")
            }
        } receiveValue: { [weak self] (response) in
            self?.data = response.result.data
        }
    }
    
}
