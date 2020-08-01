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
    func displayDetails(viewModel: TeamDetails.Details.ViewModel)
    func displayToggledFavouriteTeam(viewModel: TeamDetails.Favourite.ViewModel)
}

class TeamDetailsViewController: UIViewController, TeamDetailsDisplayLogic, Loadable {

    // MARK: - TeamDetailsViewController - Internal properties

    var interactor: TeamDetailsBusinessLogic?
    var router: (TeamDetailsRoutingLogic & TeamDetailsDataPassing)?

    // MARK: - Subviews

    private let backButton = UIBarButtonItem(image: UIImage(named: "back_button_icon"), style: .plain, target: nil, action: nil)
    private let favouritesButton = UIBarButtonItem(image: UIImage(), style: .plain, target: nil, action: nil)
    private let imageView = UIImageView()
    private let topContainer = UIStackView()
    private let rankStackView = UIStackView()
    private let summaryStackView = UIStackView()
    private let formTitleLabel = UILabel()
    private let formStackView = UIStackView()
    private let playersTitleLabel = UILabel()
    private let tableView = UITableView()

    // MARK: - Private

    private var playersCellViewModels = [PlayerTableCellViewModel]()

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
        backButton.target = self
        backButton.action = #selector(backButtonAction)
        navigationItem.leftBarButtonItem = backButton

        favouritesButton.target = self
        favouritesButton.action = #selector(favouritesButtonAction)
        navigationItem.rightBarButtonItem = favouritesButton
        view.backgroundColor = .background
        [imageView, topContainer, formTitleLabel, formStackView, playersTitleLabel, tableView].forEach {
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

        formTitleLabel.text = "LAST 10 MATCHES"
        formTitleLabel.setTextStyle(.text)
        formTitleLabel.isHidden = true
        formStackView.distribution = .equalCentering

        playersTitleLabel.text = "PLAYERS"
        playersTitleLabel.setTextStyle(.text)
        playersTitleLabel.isHidden = true

        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(PlayerTableCell.self, forCellReuseIdentifier: PlayerTableCell.reuseIdentifier)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 96),
            imageView.widthAnchor.constraint(equalToConstant: 96),
            
            topContainer.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            topContainer.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 32),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            topContainer.heightAnchor.constraint(lessThanOrEqualTo: imageView.heightAnchor),
            
            formTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            formTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            formStackView.topAnchor.constraint(equalTo: formTitleLabel.bottomAnchor, constant: 4),
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            playersTitleLabel.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 24),
            playersTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            tableView.topAnchor.constraint(equalTo: playersTitleLabel.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - TeamDetailsDisplayLogic

    func displayContent(viewModel: TeamDetails.Content.ViewModel) {
        navigationItem.title = viewModel.title
        favouritesButton.image = viewModel.favouriteButtonImage

        if let image = viewModel.image {
            imageView.image = image
        }

        addStatItems(viewModel.rankItems, to: rankStackView)
        addStatItems(viewModel.summaryItems, to: summaryStackView)

        interactor?.getDetails(requset: TeamDetails.Details.Request())
    }

    func displayDetails(viewModel: TeamDetails.Details.ViewModel) {
        DispatchQueue.main.async {
            self.addStatItems(viewModel.formItems, to: self.formStackView)
            self.formTitleLabel.isHidden = viewModel.formItems.isEmpty
            self.playersCellViewModels = viewModel.playersCellViewModels
            self.tableView.isHidden = viewModel.playersCellViewModels.isEmpty
            self.playersTitleLabel.isHidden = self.tableView.isHidden
            self.tableView.reloadData()
            self.stopLoading()
        }
    }

    func displayToggledFavouriteTeam(viewModel: TeamDetails.Favourite.ViewModel) {
        favouritesButton.image = viewModel.favouriteButtonImage
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

    @objc
    private func backButtonAction() {
        router?.routeBack()
    }

    @objc
    private func favouritesButtonAction() {
        interactor?.toggleFavouriteTeam(request: TeamDetails.Favourite.Request())
    }
}

extension TeamDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playersCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableCell.reuseIdentifier, for: indexPath)

        if let playerCell = cell as? PlayerTableCell {
            playerCell.setViewModel(playersCellViewModels[indexPath.row])
            if indexPath.row % 2 == 0 {
                playerCell.contentView.backgroundColor = .selection
            }
        }

        return cell
    }
}

extension TeamDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
}
