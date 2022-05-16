//
//  AppContainer.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import Foundation

struct AppContainer {
    let numbersClient: NumbersClient
    
    // These methods should go into a Factory class, or different factories.
    func makeMainViewController() -> MainViewController {
        return MainViewController(container: self)
    }
    
    func makeListViewController(delegate: ListViewControllerDelegate) -> ListViewController {
        let viewModel = ListViewModel(numbersClient: numbersClient)
        let listVC = ListViewController(viewModel: viewModel, delegate: delegate)
        return listVC
    }
    
    func makeDetailViewController() -> DetailViewController {
        let viewModel = DetailViewModel(numbersClient: numbersClient)
        let detailVC = DetailViewController(viewModel: viewModel)
        return detailVC
    }
    
}
