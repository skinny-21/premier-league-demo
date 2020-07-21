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
}

class LeagueTableViewController: UIViewController, LeagueTableDisplayLogic, Loadable {

    // MARK: - LeagueTableViewController - Internal properties

    var interactor: LeagueTableBusinessLogic?
    var router: (LeagueTableRoutingLogic & LeagueTableDataPassing)?

    // MARK: - Subviews

    private let tableView = UITableView()

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

    }

    // MARK: - Subviews setup

    private func setup() {
        navigationItem.title = "Premier League"
        view.backgroundColor = .background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(LeagueTeamTableCell.self, forCellReuseIdentifier: LeagueTeamTableCell.reuseIdentifier)
        tableView.register(LeagueTableHeader.self, forHeaderFooterViewReuseIdentifier: LeagueTableHeader.reuseIdentifier)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - LeagueTableDisplayLogic

    func displayContent(viewModel: LeagueTable.Content.ViewModel) {
        DispatchQueue.main.async {
            self.stopLoading()
            self.cellViewModels = viewModel.cellViewModels
            self.tableView.isHidden = viewModel.cellViewModels.isEmpty
            self.tableView.reloadData()
        }
    }

    // MARK: - View Controller Logic

    private func prepareContent() {
        startLoading()
        interactor?.prepareContent(request: LeagueTable.Content.Request())
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
            if indexPath.row % 2 != 0 {
                leagueTeamCell.contentView.backgroundColor = .selection
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: LeagueTableHeader.reuseIdentifier)
    }
}

extension LeagueTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        32
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32
    }
}
