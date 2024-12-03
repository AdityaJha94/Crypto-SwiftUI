//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Jha, Aditya on 22/11/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins.sink { [weak self] (returnedCoins) in
            self?.allCoins = returnedCoins
        }
        .store(in: &cancellable)
    }
}
