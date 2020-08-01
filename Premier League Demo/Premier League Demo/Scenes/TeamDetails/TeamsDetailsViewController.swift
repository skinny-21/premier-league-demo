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
    }

    // MARK: - TeamDetailsDisplayLogic

    func displayContent(viewModel: TeamDetails.Content.ViewModel) {
        navigationItem.title = viewModel.title
    }
    
    // MARK: - View Controller Logic
    
    private func prepareContent() {
        startLoading()
        interactor?.prepareContent(request: TeamDetails.Content.Request())
    }
}
