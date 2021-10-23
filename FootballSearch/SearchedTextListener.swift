//
//  SearchedTextListener.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation
import Combine

class SearchedTextListener: ObservableObject {
    
    @Published var searchedText: String = ""
    @Published var debouncedText: String = ""
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $searchedText.debounce(for: .milliseconds(400),
                                  scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.debouncedText = text
            }
            .store(in: &cancellables)
    }
    
}
