//
//  TabBarViewController.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol TabBarDisplayLogic: class {

}

class TabBarViewController: UITabBarController, TabBarDisplayLogic {

    private var gateway: Gateway?

    // MARK: - TabBarViewController - Internal properties

    var interactor: TabBarBusinessLogic?
    var router: (TabBarRoutingLogic & TabBarDataPassing)?

    // MARK: - Subviews

    // MARK: - Initialization

    convenience init(gateway: Gateway) {
        self.init(nibName: nil, bundle: nil)
        self.gateway = gateway
        self.setupViewControllers()
    }

    override private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    private func attach() {
        let viewController = self
        let interactor = TabBarInteractor()
        let presenter = TabBarPresenter()
        let router = TabBarRouter()
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
        attach()
        setup()
    }

    // MARK: - Subviews setup

    private func setup() {
        view.backgroundColor = .background
    }

    private func setupViewControllers() {
        let leagueTableTabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        let leagueTableViewController = LeagueTableViewController()
        leagueTableViewController.router?.dataStore?.gateway = gateway
        leagueTableViewController.tabBarItem = leagueTableTabBarItem

        let favouriteTeamsTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let favouriteTeamsViewController = FavouriteTeamsViewController()
        favouriteTeamsViewController.tabBarItem = favouriteTeamsTabBarItem

        viewControllers = [leagueTableViewController, favouriteTeamsViewController].map {
            UINavigationController(rootViewController: $0)
        }
    }

    // MARK: - TabBarDisplayLogic

    // MARK: - View Controller Logic

}
