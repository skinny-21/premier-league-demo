//
//  FavouriteTeamsViewController.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol FavouriteTeamsDisplayLogic: class {

}

class FavouriteTeamsViewController: UIViewController, FavouriteTeamsDisplayLogic {

    // MARK: - FavouriteTeamsViewController - Internal properties

    var interactor: FavouriteTeamsBusinessLogic?
    var router: (FavouriteTeamsRoutingLogic & FavouriteTeamsDataPassing)?

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
        let interactor = FavouriteTeamsInteractor()
        let presenter = FavouriteTeamsPresenter()
        let router = FavouriteTeamsRouter()
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
    }

    // MARK: - Subviews setup

    func setup() {

    }

    // MARK: - FavouriteTeamsDisplayLogic

    // MARK: - View Controller Logic

}
