//
//  DetailViewController.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import UIKit

final class DetailViewController: ViewController {
    private let viewModel: DetailViewModel
    
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let textLabel = UILabel()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    func load(item: NumberItem) {
        title = item.name
        viewModel.loadDetails(name: item.name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        
        setupViews()
        bindToViewModel()
    }
    
    // TODO: Figure out why the view will not render correctly when using autolayout. Could be something strange about being a secondary VC of splitview (iOS14+ wonk?), but doesn't really make sense.  Its probably just something silly I didn't see.
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        stackView.frame = view.bounds
    }
    
    private func setupViews() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(stackView)
        
        // TODO: Requirement is to display a larger image, but we need a higher res image than what is provided by api. We can scale the image up but it will look ugly.
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        textLabel.textAlignment = .center
        textLabel.text = "This is some text"
        
        let innerStackView = UIStackView()
        innerStackView.alignment = .center
        innerStackView.axis = .vertical
        innerStackView.spacing = 12
        innerStackView.addArrangedSubview(imageView)
        innerStackView.addArrangedSubview(textLabel)
        
        stackView.addArrangedSubview(innerStackView)
    }
    
    func bindToViewModel() {
        viewModel.detail.bind { [weak self] detail in
            self?.updateDetails(detail: detail)
        }
        viewModel.image.bind { [weak self] image in
            self?.updateImageView(image: image)
        }
    }
    
    func updateDetails(detail: NumberDetail) {
        textLabel.text = detail.text
    }
    
    func updateImageView(image: UIImage) {
        guard image.size != .zero else { return }
        imageView.image = image
    }
}
