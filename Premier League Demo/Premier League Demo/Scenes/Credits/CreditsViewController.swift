//
//  CreditsViewController.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol CreditsDisplayLogic: class {}

class CreditsViewController: UIViewController, CreditsDisplayLogic {

    // MARK: - CreditsViewController - Internal properties

    var interactor: CreditsBusinessLogic?
    var router: (CreditsRoutingLogic & CreditsDataPassing)?

    // MARK: - Subviews

    private let stackView = UIStackView()

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
        let interactor = CreditsInteractor()
        let presenter = CreditsPresenter()
        let router = CreditsRouter()
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
        setCredits()
    }

    // MARK: - Subviews setup

    func setup() {
        navigationItem.title = "Credits"

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 32

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }

    private func setCredits() {
        let author = StatViewModel(title: "Created by", value: "Wojciech Woźniak", titleStyle: .statTitleSmall, valueStyle: .statValueSmall)
        let images = StatViewModel(title: "Images downloaded from", value: "www.flaticon.com", titleStyle: .statTitleSmall, valueStyle: .statValueSmall)

        stackView.addStatItems([author, images])
    }
}
