//
//  DetailViewModel.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import Foundation
import UIKit

final class DetailViewModel {
    
    let numbersClient: NumbersClient
    
    private(set) var image: Box<UIImage> = Box(UIImage())
    private(set) var detail: Box<NumberDetail> = Box(NumberDetail())
    
    init(numbersClient: NumbersClient) {
        self.numbersClient = numbersClient
    }
    
    func loadDetails(name: String) {
        numbersClient.getNumberDetail(name) { [weak self] result in
            DispatchQueue.main.async {
                self?.getNumberDetailCompleted(with: result)
            }
        }
    }
    
    private func getNumberDetailCompleted(with result: GetNumberDetailResult) {
        switch result {
        case .success(let numberDetail):
            detail.value = numberDetail
            loadImage(imageURL: numberDetail.image)
        case .failure:
            detail.value = NumberDetail()
            image.value = UIImage()
        }
    }
    
    private func loadImage(imageURL: String) {
        DispatchQueue.global().async {
            let url = URL(string: imageURL)!
            guard let data = try? Data(contentsOf: url) else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image.value = image
                }
            }
        }
    }
}

