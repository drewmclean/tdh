//
//  MainViewController.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import UIKit

class MainViewController: UISplitViewController {

    private let container: AppContainer
    
    required init(container: AppContainer) {
        self.container = container
        
        super.init(style: .doubleColumn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Numbers"
        delegate = self
        
        setupView()
    }
    
    private func setupView() {
        preferredSplitBehavior = .tile
        preferredDisplayMode = .oneBesideSecondary
        preferredPrimaryColumnWidthFraction = 1/2
        maximumPrimaryColumnWidth = 1000
        
        let primaryVC = container.makeListViewController(delegate: self)
        let detailVC = container.makeDetailViewController()
        let compactVC = container.makeListViewController(delegate: self)
        
        setViewController(UINavigationController(rootViewController: primaryVC), for: .primary)
        setViewController(UINavigationController(rootViewController: detailVC), for: .secondary)
        setViewController(UINavigationController(rootViewController: compactVC), for: .compact)
    }

}

extension MainViewController : UISplitViewControllerDelegate {
  
    func splitViewController(_ svc: UISplitViewController,
                             topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
    
}

extension MainViewController : ListViewControllerDelegate {
    
    func didSelectItem(item: NumberItem, viewController: ListViewController) {
        if isCollapsed {
            let detailVC = container.makeDetailViewController()
            detailVC.load(item: item)
            guard let navVC = self.viewController(for: .primary) as? UINavigationController else { return }
            navVC.pushViewController(detailVC, animated: true)
        } else {
            guard let navVC = self.viewController(for: .secondary) as? UINavigationController else { return }
            guard let detailVC = navVC.topViewController as? DetailViewController else { return }
            detailVC.load(item: item)
        }
    }
    
}
