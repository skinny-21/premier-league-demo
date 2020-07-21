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

    // MARK: - TabBarViewController - Internal properties

    var interactor: TabBarBusinessLogic?
    var router: (TabBarRoutingLogic & TabBarDataPassing)?

    // MARK: - Subviews

    // MARK: - Initialization

    convenience init() {
        self.init(nibName: nil, bundle: nil)
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

    func setup() {
        let leagueTableTabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        let leagueTableViewController = LeagueTableViewController()
        leagueTableViewController.tabBarItem = leagueTableTabBarItem

        let favouriteTeamsTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let favouriteTeamsViewController = FavouriteTeamsViewController()
        favouriteTeamsViewController.tabBarItem = favouriteTeamsTabBarItem

        viewControllers = [leagueTableViewController, favouriteTeamsViewController]
    }

    // MARK: - TabBarDisplayLogic

    // MARK: - View Controller Logic

}
