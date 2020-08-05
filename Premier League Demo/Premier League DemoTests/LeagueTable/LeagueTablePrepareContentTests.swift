//
//  LeagueTablePrepareContentTests.swift
//  Premier League DemoTests
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import XCTest

class LeagueTablePrepareContentTests: XCTestCase {
    var gatewayMock: GatewayMock!
    var localStorageMock: LocalStorageMock!
    var viewControllerMock: LeagueTableDisplayLogicMock!

    var presenter: LeagueTablePresenter!
    var worker: LeagueTableWorker!
    var interactor: LeagueTableInteractor!

    override func setUp() {
        super.setUp()
        localStorageMock = LocalStorageMock()
        gatewayMock = GatewayMock()
        viewControllerMock = LeagueTableDisplayLogicMock()

        presenter = LeagueTablePresenter()
        presenter.viewController = viewControllerMock

        worker = LeagueTableWorker(localStorage: localStorageMock)

        interactor = LeagueTableInteractor(worker: worker)
        interactor.presenter = presenter
        interactor.gateway = gatewayMock
    }

    // MARK: - With some list response

    func testPrepareContent_withSomeListResponse_shouldDisplayTableWithData() {
        gatewayMock.getLeagueTableResponse = LeagueTableResponse.someListMock
        interactor.prepareContent(request: LeagueTable.Content.Request())

        let commonViewModel = viewControllerMock.displayContentViewModel?.commonViewModel
        XCTAssertEqual(commonViewModel?.cellViewModels.count, 2)
        XCTAssertEqual(commonViewModel?.shouldShowError, false)
        XCTAssertEqual(commonViewModel?.shouldHideRetryButton, false)
        XCTAssertEqual(commonViewModel?.errorMessage, nil)
    }

    func testPrepareContent_withSomeListResponse_shouldCreateTableModelInCorrectOrder() {
        gatewayMock.getLeagueTableResponse = LeagueTableResponse.someListMock
        interactor.prepareContent(request: LeagueTable.Content.Request())

        let commonViewModel = viewControllerMock.displayContentViewModel?.commonViewModel
        XCTAssertEqual(commonViewModel?.cellViewModels.first?.id, 1)
        XCTAssertEqual(commonViewModel?.cellViewModels.last?.id, 2)
    }

    func testPrepareContent_withSomeListResponse_shouldCreateCorrectTableCellsModels() {
        gatewayMock.getLeagueTableResponse = LeagueTableResponse.someListMock
        interactor.prepareContent(request: LeagueTable.Content.Request())

        let commonViewModel = viewControllerMock.displayContentViewModel?.commonViewModel

        let firstModel = commonViewModel?.cellViewModels.first
        XCTAssertEqual(firstModel?.id, 1)
        XCTAssertEqual(firstModel?.positon, "1.")
        XCTAssertEqual(firstModel?.name, "Liverpool")
        XCTAssertEqual(firstModel?.matchesPlayed, "38")
        XCTAssertEqual(firstModel?.goals, "85:33")
        XCTAssertEqual(firstModel?.points, "99")
        XCTAssertEqual(firstModel?.isFavourite, false)

        let secondModel = commonViewModel?.cellViewModels.last
        XCTAssertEqual(secondModel?.id, 2)
        XCTAssertEqual(secondModel?.positon, "2.")
        XCTAssertEqual(secondModel?.name, "Manchester City")
        XCTAssertEqual(secondModel?.matchesPlayed, "38")
        XCTAssertEqual(secondModel?.goals, "102:35")
        XCTAssertEqual(secondModel?.points, "81")
        XCTAssertEqual(secondModel?.isFavourite, false)
    }

    func testPrepareContent_withSomeListResponse_shouldCallDisplayContentOnce() {
        gatewayMock.getLeagueTableResponse = LeagueTableResponse.someListMock
        interactor.prepareContent(request: LeagueTable.Content.Request())
        XCTAssertEqual(viewControllerMock.displayContentCallsCount, 1)
    }

    func testPrepareContent_withSomeListResponse_shouldNotCallAnyOtherDisplayLogicMethod() {
        gatewayMock.getLeagueTableResponse = LeagueTableResponse.someListMock
        interactor.prepareContent(request: LeagueTable.Content.Request())
        XCTAssertEqual(viewControllerMock.displayTeamImageCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayToggledFavouriteTeamCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayTeamDetailsCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayRefreshedFavouriteTeamCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayToggledOnlyFavouritesCallsCount, 0)
    }

    func testPrepareContent_withSomeListResponse_shouldOnlyCallGetLeagueTableOnce() {
        gatewayMock.getLeagueTableResponse = LeagueTableResponse.someListMock
        interactor.prepareContent(request: LeagueTable.Content.Request())
        XCTAssertEqual(gatewayMock.getLeagueTableCallsCount, 1)
        XCTAssertEqual(gatewayMock.getImageCallsCount, 0)
        XCTAssertEqual(gatewayMock.getTeamStatsCallsCount, 0)
        XCTAssertEqual(gatewayMock.getLeaguePlayersCallsCount, 0)
    }

    // MARK: - With no Gateway provided

    func testPrepareContent_withNoGatewayProvided_shouldDisplayEmptyTable() {
        interactor.gateway = nil
        interactor.prepareContent(request: LeagueTable.Content.Request())

        let commonViewModel = viewControllerMock.displayContentViewModel?.commonViewModel
        XCTAssertEqual(commonViewModel?.cellViewModels.count, 0)
        XCTAssertEqual(commonViewModel?.shouldShowError, true)
        XCTAssertEqual(commonViewModel?.shouldHideRetryButton, false)
        XCTAssertEqual(commonViewModel?.errorMessage, "Data could not be retrieved")
    }

    func testPrepareContent_withNoGatewayProvided_shouldCallDisplayContentOnce() {
        interactor.gateway = nil
        interactor.prepareContent(request: LeagueTable.Content.Request())
        XCTAssertEqual(viewControllerMock.displayContentCallsCount, 1)
    }

    func testPrepareContent_withNoGatewayProvided_shouldNotCallAnyOtherDisplayLogicMethod() {
        interactor.gateway = nil
        interactor.prepareContent(request: LeagueTable.Content.Request())
        XCTAssertEqual(viewControllerMock.displayTeamImageCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayToggledFavouriteTeamCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayTeamDetailsCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayRefreshedFavouriteTeamCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayToggledOnlyFavouritesCallsCount, 0)
    }

    func testPrepareContent_withNoGatewayProvided_shouldNotCallGetLeagueTable() {
        interactor.gateway = nil
        interactor.prepareContent(request: LeagueTable.Content.Request())
        XCTAssertEqual(gatewayMock.getLeagueTableCallsCount, 0)
        XCTAssertEqual(gatewayMock.getImageCallsCount, 0)
        XCTAssertEqual(gatewayMock.getTeamStatsCallsCount, 0)
        XCTAssertEqual(gatewayMock.getLeaguePlayersCallsCount, 0)
    }

    // MARK: - With empty list response

    func testPrepareContent_withEmptyListResponse_shouldDisplayEmptyTable() {
        gatewayMock.getLeagueTableResponse = LeagueTableResponse.emptyListMock
        interactor.prepareContent(request: LeagueTable.Content.Request())
        XCTAssertEqual(viewControllerMock.displayContentCallsCount, 1)

        let commonViewModel = viewControllerMock.displayContentViewModel?.commonViewModel
        XCTAssertEqual(commonViewModel?.cellViewModels.count, 0)
        XCTAssertEqual(commonViewModel?.shouldShowError, true)
        XCTAssertEqual(commonViewModel?.shouldHideRetryButton, false)
        XCTAssertEqual(commonViewModel?.errorMessage, "Data could not be retrieved")
    }

    func testPrepareContent_withEmptyListResponse_shouldCallDisplayContentOnce() {
        gatewayMock.getLeagueTableResponse = LeagueTableResponse.emptyListMock
        interactor.prepareContent(request: LeagueTable.Content.Request())
        XCTAssertEqual(viewControllerMock.displayContentCallsCount, 1)
    }

    func testPrepareContent_withEmptyListResponse_shouldNotCallAnyOtherDisplayLogicMethod() {
        gatewayMock.getLeagueTableResponse = LeagueTableResponse.emptyListMock
        interactor.prepareContent(request: LeagueTable.Content.Request())
        XCTAssertEqual(viewControllerMock.displayTeamImageCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayToggledFavouriteTeamCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayTeamDetailsCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayRefreshedFavouriteTeamCallsCount, 0)
        XCTAssertEqual(viewControllerMock.displayToggledOnlyFavouritesCallsCount, 0)
    }

    func testPrepareContent_withEmptyListResponse_shouldOnlyCallGetLeagueTableOnce() {
        gatewayMock.getLeagueTableResponse = LeagueTableResponse.emptyListMock
        interactor.prepareContent(request: LeagueTable.Content.Request())
        XCTAssertEqual(gatewayMock.getLeagueTableCallsCount, 1)
        XCTAssertEqual(gatewayMock.getImageCallsCount, 0)
        XCTAssertEqual(gatewayMock.getTeamStatsCallsCount, 0)
        XCTAssertEqual(gatewayMock.getLeaguePlayersCallsCount, 0)
    }
}
