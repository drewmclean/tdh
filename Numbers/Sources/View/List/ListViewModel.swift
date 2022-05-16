//
//  ListViewModel.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import UIKit

enum ListViewState {
    case initializing
    case fetching
    case fetchComplete
    case fetchError(String)
}

class ListViewModel {
    
    fileprivate var numbersClient : NumbersClient
    
    private(set) var viewState: Box<ListViewState> = Box(.initializing)
    
    private(set) var items: [NumberItem] = []
    
    required init(numbersClient: NumbersClient) {
        self.numbersClient = numbersClient
    }
    
    func reloadData() {
        guard Reachability.shared.isConnectedToNetwork() else {
            self.viewState.value = .fetchError("A network is not available at this time.")
            return
        }
        
        viewState.value = .fetching
        numbersClient.getNumbers { [weak self] result in
            DispatchQueue.main.async {
                self?.getNumbersCompleted(with: result)
            }
        }
    }
    
    func loadImage() {
        
    }
    
    private func getNumbersCompleted(with result: GetNumbersResult) {
        switch result {
        case .success(let numberItems):
            items = numberItems
            viewState.value = .fetchComplete
        case .failure(let error):
            viewState.value = .fetchError(error.localizedDescription)
        }
    }
    
}
