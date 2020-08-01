//
//  TeamDetailsViewController.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 31/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol TeamDetailsDisplayLogic: class {
    func displayContent(viewModel: TeamDetails.Content.ViewModel)
}

class TeamDetailsViewController: UIViewController, TeamDetailsDisplayLogic, Loadable {

    // MARK: - TeamDetailsViewController - Internal properties

    var interactor: TeamDetailsBusinessLogic?
    var router: (TeamDetailsRoutingLogic & TeamDetailsDataPassing)?

    // MARK: - Subviews

    private let imageView = UIImageView()
    private let topContainer = UIStackView()
    private let rankStackView = UIStackView()
    private let summaryStackView = UIStackView()
    private let formStackView = UIStackView()
    
    // MARK: - Initialization

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.attach()
    }

    public required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    private func attach() {
        let viewController = self
        let interactor = TeamDetailsInteractor()
        let presenter = TeamDetailsPresenter()
        let router = TeamDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareContent()
    }

    // MARK: - Subviews setup

    func setup() {
        view.backgroundColor = .background
        [imageView, topContainer, formStackView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        imageView.image = .placeholder

        topContainer.axis = .vertical
        topContainer.spacing = 24
        [rankStackView, summaryStackView].forEach {
            topContainer.addArrangedSubview($0)
            $0.distribution = .equalCentering
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 96),
            imageView.widthAnchor.constraint(equalToConstant: 96),
            
            topContainer.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            topContainer.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 32),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            topContainer.heightAnchor.constraint(lessThanOrEqualTo: imageView.heightAnchor),
            
            formStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - TeamDetailsDisplayLogic

    func displayContent(viewModel: TeamDetails.Content.ViewModel) {
        navigationItem.title = viewModel.title
        
        if let image = viewModel.image {
            imageView.image = image
        }

        addStatItems(viewModel.rankItems, to: rankStackView)
        addStatItems(viewModel.summaryItems, to: summaryStackView)

        interactor?.getDetails(requset: TeamDetails.Details.Request())
    }
    
    // MARK: - View Controller Logic
    
    private func prepareContent() {
        startLoading()
        interactor?.prepareContent(request: TeamDetails.Content.Request())
    }

    private func addStatItems(_ items: [StatViewModel], to stackView: UIStackView) {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        items.forEach {
            let statView = StatView()
            statView.setViewModel($0)
            stackView.addArrangedSubview(statView)
        }
    }
}
