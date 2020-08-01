//
//  LeagueTableViewController.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol LeagueTableDisplayLogic: class {
    func displayContent(viewModel: LeagueTable.Content.ViewModel)
    func displayTeamImage(viewModel: LeagueTable.TeamImage.ViewModel)
    func displayToggledFavouriteTeam(viewModel: LeagueTable.Favourite.ViewModel)
    func displayTeamDetails(viewModel: LeagueTable.Details.ViewModel)
    func displayRefreshedFavouriteTeam(viewModel: LeagueTable.RefreshFavourite.ViewModel)
    func displayToggledOnlyFavourites(viewModel: LeagueTable.ToggleFavourites.ViewModel)
}

class LeagueTableViewController: UIViewController, LeagueTableDisplayLogic, Loadable {

    // MARK: - LeagueTableViewController - Internal properties

    var interactor: LeagueTableBusinessLogic?
    var router: (LeagueTableRoutingLogic & LeagueTableDataPassing)?

    // MARK: - Subviews

    private let filterFavouritesButton = UIBarButtonItem(image: UIImage(named: "fav_deselected"), style: .plain, target: nil, action: nil)
    private let tableView = UITableView()
    private let errorView = ErrorView()

    // MARK: - Private properties

    private var cellViewModels = [LeagueTeamTableCellViewModel]()

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
        let interactor = LeagueTableInteractor()
        let presenter = LeagueTablePresenter()
        let router = LeagueTableRouter()
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
        navigationController?.setNavigationBarHidden(false, animated: true)
        interactor?.refreshFavourite(request: LeagueTable.RefreshFavourite.Request())
    }

    // MARK: - Subviews setup

    private func setup() {
        navigationItem.title = "Premier League"

        filterFavouritesButton.isEnabled = false
        filterFavouritesButton.target = self
        filterFavouritesButton.action = #selector(filterFavouritesButtonAction)
        navigationItem.rightBarButtonItem = filterFavouritesButton

        view.backgroundColor = .background
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(LeagueTeamTableCell.self, forCellReuseIdentifier: LeagueTeamTableCell.reuseIdentifier)
        tableView.register(LeagueTableHeader.self, forHeaderFooterViewReuseIdentifier: LeagueTableHeader.reuseIdentifier)
        
        errorView.isHidden = true
        errorView.delegate = self
        
        [tableView, errorView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // MARK: - LeagueTableDisplayLogic

    func displayContent(viewModel: LeagueTable.Content.ViewModel) {
        DispatchQueue.main.async {
            self.stopLoading()
            self.reloadScene(viewModel.commonViewModel)
            self.filterFavouritesButton.isEnabled = !viewModel.commonViewModel.shouldShowError
        }
    }

    func displayTeamImage(viewModel: LeagueTable.TeamImage.ViewModel) {
        DispatchQueue.main.async {
            let cell = self.tableView.cellForRow(at: IndexPath(row: viewModel.index, section: 0))
            if let leagueTeamCell = cell as? LeagueTeamTableCell {
                leagueTeamCell.setImage(viewModel.image)
            }
        }
    }

    func displayToggledFavouriteTeam(viewModel: LeagueTable.Favourite.ViewModel) {
        refreshCellViewModel(viewModel.cellViewModel, at: viewModel.index)
    }
    
    func displayTeamDetails(viewModel: LeagueTable.Details.ViewModel) {
        router?.routeToTeamDetails()
    }

    func displayRefreshedFavouriteTeam(viewModel: LeagueTable.RefreshFavourite.ViewModel) {
        refreshCellViewModel(viewModel.cellViewModel, at: viewModel.index)
    }

    func displayToggledOnlyFavourites(viewModel: LeagueTable.ToggleFavourites.ViewModel) {
        reloadScene(viewModel.commonViewModel)
    }

    // MARK: - View Controller Logic

    private func prepareContent() {
        startLoading()
        tableView.isHidden = true
        errorView.isHidden = true
        interactor?.prepareContent(request: LeagueTable.Content.Request())
    }

    private func reloadScene(_ viewModel: LeagueTable.CommonViewModel) {
        cellViewModels = viewModel.cellViewModels
        tableView.isHidden = viewModel.cellViewModels.isEmpty
        tableView.reloadData()
        errorView.isHidden = !viewModel.shouldShowError
        errorView.errorMessage = viewModel.errorMessage
        errorView.isRetryButtonHidden = viewModel.shouldHideRetryButton
    }

    private func refreshCellViewModel(_ cellViewModel: LeagueTeamTableCellViewModel, at index: Int) {
        cellViewModels[index] = cellViewModel
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }

    @objc
    private func filterFavouritesButtonAction() {
        interactor?.toggleOnlyFavourites(request: LeagueTable.ToggleFavourites.Request())
    }
}

extension LeagueTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTeamTableCell.reuseIdentifier, for: indexPath)

        if let leagueTeamCell = cell as? LeagueTeamTableCell {
            leagueTeamCell.setViewModel(cellViewModels[indexPath.row])
            leagueTeamCell.delegate = self
            if indexPath.row % 2 != 0 {
                leagueTeamCell.contentView.backgroundColor = .selection
            }
        }

        interactor?.getTeamImage(request: LeagueTable.TeamImage.Request(index: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: LeagueTableHeader.reuseIdentifier)
    }
}

extension LeagueTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.teamDetails(request: LeagueTable.Details.Request(index: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32
    }
}

extension LeagueTableViewController: LeagueTeamTableCellDelegate {
    func leagueTeamTableCell(_ cell: LeagueTeamTableCell, toggleFavourite id: Int, isFavourite: Bool) {
        let request = LeagueTable.Favourite.Request(teamId: id, isFavourite: isFavourite)
        interactor?.toggleFavouriteTeam(request: request)
    }
}

extension LeagueTableViewController: ErrorViewDelegate {
    func errorViewRequestedRetryAction(_ errorView: ErrorView) {
        startLoading()
        errorView.isHidden = true
        interactor?.prepareContent(request: LeagueTable.Content.Request())
    }
}
