//
//  CoinImageService.swift
//  Crypto
//
//  Created by Jha, Aditya on 25/11/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage?
    var imageSubscription: AnyCancellable?
    let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String

    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            print("Retrieving image")
            image = savedImage
        } else {
            print("Downloading Image")
            downloadCoinImage()
        }
    }

    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription =
            NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let _self = self, let downloadedImage = returnedImage else { return }

                _self.image = downloadedImage
                _self.imageSubscription?.cancel()
                _self.fileManager.saveImage(image: downloadedImage, imageName: _self.imageName, folderName: _self.folderName)
            })
    }
}
