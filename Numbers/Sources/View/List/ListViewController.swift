//
//  ListViewController.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import UIKit

protocol ListViewControllerDelegate {
    func didSelectItem(item: NumberItem, viewController: ListViewController)
}

class ListViewController: ViewController {
    
    private let viewModel: ListViewModel
    private let delegate: ListViewControllerDelegate
    
    public let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    public let tableView: UITableView = UITableView()
    public let errorLabel: UILabel = UILabel()
    
    init(viewModel: ListViewModel, delegate: ListViewControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindToViewModel()
        viewModel.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: Add some logic to only do this when split view is compact.
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            let selectedCell = tableView.cellForRow(at: selectedIndexPath)
            selectedCell?.setSelected(false, animated: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupViews() {
        edgesForExtendedLayout = []
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Numbers"
        setupTableView()
        setupActivityIndicatorView()
        setupErrorLabel()
    }
    
    private func setupTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.cellID)
        
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupActivityIndicatorView() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupErrorLabel() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .black
        errorLabel.backgroundColor = .red
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        view.addSubview(errorLabel)
        errorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        errorLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func bindToViewModel() {
        viewModel.viewState.bind { [weak self] state in
            self?.viewStateDidChange(state: state)
        }
    }
    
    func viewStateDidChange(state: ListViewState) {
        print("View state changed to \(state)")
        switch state {
        case .initializing:
            tableView.isHidden = true
            errorLabel.isHidden = true
        case .fetching:
            activityIndicatorView.startAnimating()
            tableView.isHidden = true
            errorLabel.isHidden = true
        case .fetchComplete:
            activityIndicatorView.stopAnimating()
            tableView.isHidden = false
            errorLabel.isHidden = true
            tableView.reloadData()
        case .fetchError(let errorMessage):
            activityIndicatorView.stopAnimating()
            tableView.isHidden = true
            errorLabel.isHidden = false
            errorLabel.text = errorMessage
        }
    }
    
    private func configureCell(cell: ListViewCell, item: NumberItem) {
        let backgroundView = UIView()
        cell.selectedBackgroundView = backgroundView
        cell.textLabel?.text = item.name
    }
}

extension ListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return 0 }
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.cellID, for: indexPath) as! ListViewCell
        let item = viewModel.items[indexPath.row]
        configureCell(cell: cell, item: item)
        return cell
    }
    
}

extension ListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
        delegate.didSelectItem(item: item, viewController: self)
    }
    
}
