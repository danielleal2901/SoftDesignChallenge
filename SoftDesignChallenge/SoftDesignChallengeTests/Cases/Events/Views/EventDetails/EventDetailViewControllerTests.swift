//
//  EventDetailViewControllerTests.swift
//  SoftDesignChallengeTests
//
//  Created by Daniel Leal on 24/02/22.
//

import Foundation
import XCTest
@testable import SoftDesignChallenge

class EventDetailViewControllerTests: XCTestCase {
  var sut: EventDetailViewController!
  
  override func setUpWithError() throws {
    let mockData = try JSONHelper.loadFromFile(name: "event-mock")
    let event = try JSONDecoder().decode(Event.self, from: mockData!)
    
    sut = EventDetailViewController(viewModel: EventDetailViewModel(event: event))
    sut.loadView()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_EventsDetailViewController_layoutConfiguration() {
    XCTAssertTrue(sut.view.subviews.contains(sut.scrollView))
    XCTAssertTrue(sut.scrollView.subviews.contains(sut.contentView))
    XCTAssertTrue(sut.contentView.subviews.contains(sut.verticalStack))
    XCTAssertTrue(sut.verticalStack.subviews.contains(sut.titleLabel))
    XCTAssertTrue(sut.verticalStack.subviews.contains(sut.descriptionLabel))
    XCTAssertTrue(sut.verticalStack.subviews.contains(sut.dateLabel))
    XCTAssertTrue(sut.contentView.subviews.contains(sut.eventImage))
    XCTAssertTrue(sut.contentView.subviews.contains(sut.mapView))
    XCTAssertTrue(sut.contentView.subviews.contains(sut.checkInView))
    XCTAssertTrue(sut.view.backgroundColor == .white)
    XCTAssertNotNil(sut.navigationItem.leftBarButtonItem)
  }
  
  func test_EventsDetailViewController_coordinatorDelegate() throws {
    let coordinator = EventsCoordinatorMock()
    
    sut.coordinator = coordinator
    
    XCTAssertFalse(coordinator.calledDidFinishDetail)
    XCTAssertNoThrow(sut.leftButtonAction(nil))
    XCTAssertTrue(coordinator.calledDidFinishDetail)
  }
  
  func test_EventsDetailViewController_viewModelTitleInput() {
    XCTAssertEqual(sut.viewModel.title, "Feira de adoção de animais na Redenção")
  }
  
  func test_EventsDetailViewController_viewModelDescriptionInput() {
    XCTAssertEqual(sut.viewModel.description, "O Patas Dadas estarÃ¡ na RedenÃ§Ã£o, nesse domingo, com cÃ£es para adoÃ§Ã£o e produtos Ã  venda!\n\nNa ocasiÃ£o, teremos bottons, bloquinhos e camisetas!\n\nTraga seu Pet, os amigos e o chima, e venha aproveitar esse dia de sol com a gente e com alguns de nossos peludinhos - que estarÃ£o prontinhos para ganhar o â™¥ de um humano bem legal pra chamar de seu. \n\nAceitaremos todos os tipos de doaÃ§Ã£o:\n- guias e coleiras em bom estado\n- raÃ§Ã£o (as que mais precisamos no momento sÃ£o sÃªnior e filhote)\n- roupinhas \n- cobertas \n- remÃ©dios dentro do prazo de validade")
  }
  
  func test_EventsDetailViewController_viewModelDateInput() {
    let date = sut.viewModel.event.getFormattedDate()
    
    XCTAssertEqual(sut.viewModel.date.string, "Data: \(date)")
  }
  
  func test_EventsDetailViewController_mapViewFullscreen() {
    sut.showMapInFullscreen()
    
    XCTAssertEqual(sut.mapNormalHeightConstraint?.isActive, false)
    XCTAssertEqual(sut.mapNormalTopConstraint?.isActive, false)
    XCTAssertEqual(sut.mapFullscreenTopConstraint?.isActive, true)
  }
  
  func test_EventsDetailViewController_removeMapViewFullscreen() {
    sut.removeMapFullscreen()
    
    XCTAssertEqual(sut.mapNormalHeightConstraint?.isActive, true)
    XCTAssertEqual(sut.mapNormalTopConstraint?.isActive, true)
    XCTAssertEqual(sut.mapFullscreenTopConstraint?.isActive, false)
  }
  
  func test_EventsDetailViewController_showCheckIn() {
    sut.rightButtonAction(nil)

    XCTAssertFalse(sut.checkInView.isHidden)
  }
  
  func test_EventsDetailViewController_removeCheckIn() {
    sut.rightButtonAction(nil)
    XCTAssertFalse(sut.checkInView.isHidden)
    
    sut.checkInView.tappedClose(nil)
    
    XCTAssertTrue(sut.checkInView.isHidden)
  }
}
