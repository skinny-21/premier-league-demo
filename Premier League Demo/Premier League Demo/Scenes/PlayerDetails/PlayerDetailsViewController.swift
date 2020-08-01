//
//  PlayerDetailsViewController.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol PlayerDetailsDisplayLogic: class {
    func displayContent(viewModel: PlayerDetails.Content.ViewModel)
}

class PlayerDetailsViewController: UIViewController, PlayerDetailsDisplayLogic {

    // MARK: - PlayerDetailsViewController - Internal properties

    var interactor: PlayerDetailsBusinessLogic?
    var router: (PlayerDetailsRoutingLogic & PlayerDetailsDataPassing)?

    // MARK: - Subviews

    private let playerNameLabel = UILabel()
    private let stackView = UIStackView()
    private let closeButton = UIButton.commonButton()

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
        let interactor = PlayerDetailsInteractor()
        let presenter = PlayerDetailsPresenter()
        let router = PlayerDetailsRouter()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Subviews setup

    func setup() {
        view.backgroundColor = .background

        [playerNameLabel, stackView, closeButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        stackView.axis = .vertical
        stackView.spacing = 16
        playerNameLabel.setTextStyle(.header)
        playerNameLabel.textAlignment = .center
        playerNameLabel.numberOfLines = 0
        playerNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        playerNameLabel.setContentHuggingPriority(.required, for: .vertical)

        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            playerNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            playerNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            playerNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            stackView.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 64),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64)
        ])
    }

    // MARK: - PlayerDetailsDisplayLogic

    func displayContent(viewModel: PlayerDetails.Content.ViewModel) {
        playerNameLabel.text = viewModel.name
        stackView.addStatItems(viewModel.stats)
    }

    // MARK: - View Controller Logic

    private func prepareContent() {
        interactor?.prepareContent(request: PlayerDetails.Content.Request())
    }

    @objc
    private func closeButtonAction() {
        router?.close()
    }
}
