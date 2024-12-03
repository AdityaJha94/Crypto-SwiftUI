//
//  CoinImageViewModel.swift
//  Crypto
//
//  Created by Jha, Aditya on 25/11/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private var cancellable = Set<AnyCancellable>()
    
    private let coin: CoinModel
    private var imageService: CoinImageService

    init(coin: CoinModel) {
        self.coin = coin
        self.imageService = CoinImageService(coin: coin)
        addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        imageService.$image.sink { [weak self] (_) in
            self?.isLoading = false
        } receiveValue: {[weak self] (returnedImage) in
            self?.image = returnedImage
        }
        .store(in: &cancellable)
    }
}
