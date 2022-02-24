//
//  EventDetailViewTests.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
import XCTest
import RxBlocking

@testable import SoftDesignChallenge

class EventDetailViewTests: XCTestCase {
  var sut: EventDetailView!
  
  override func setUpWithError() throws {
    let mockData = try JSONHelper.loadFromFile(name: "event-mock")
    let event = try JSONDecoder().decode(Event.self, from: mockData!)

    let viewModel = EventDetailViewModel(event: event)
    sut = EventDetailView(viewModel: viewModel)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_EventDetailView_layoutElementsCreated() {
    XCTAssertTrue(sut.subviews.contains(sut.scrollView))
    XCTAssertTrue(sut.subviews.contains(sut.contentView))
    XCTAssertTrue(sut.subviews.contains(sut.verticalStack))
    XCTAssertTrue(sut.subviews.contains(sut.titleLabel))
    XCTAssertTrue(sut.subviews.contains(sut.descriptionLabel))
    XCTAssertTrue(sut.subviews.contains(sut.dateLabel))
    XCTAssertTrue(sut.subviews.contains(sut.eventImage))
    XCTAssertTrue(sut.subviews.contains(sut.mapView))
  }
  
  func test_EventDetailView_layoutConfiguration(){
    XCTAssertTrue(sut.backgroundColor == .white)
  }
  
  func test_EventDetailView_viewModelTitleInput() {
    XCTAssertEqual(sut.viewModel.title, "Feira de adoção de animais na Redenção")
  }
  
  func test_EventDetailView_viewModelDescriptionInput() {
    XCTAssertEqual(sut.viewModel.description, "O Patas Dadas estarÃ¡ na RedenÃ§Ã£o, nesse domingo, com cÃ£es para adoÃ§Ã£o e produtos Ã  venda!\n\nNa ocasiÃ£o, teremos bottons, bloquinhos e camisetas!\n\nTraga seu Pet, os amigos e o chima, e venha aproveitar esse dia de sol com a gente e com alguns de nossos peludinhos - que estarÃ£o prontinhos para ganhar o â™¥ de um humano bem legal pra chamar de seu. \n\nAceitaremos todos os tipos de doaÃ§Ã£o:\n- guias e coleiras em bom estado\n- raÃ§Ã£o (as que mais precisamos no momento sÃ£o sÃªnior e filhote)\n- roupinhas \n- cobertas \n- remÃ©dios dentro do prazo de validade")
  }
  
  func test_EventDetailView_viewModelDateInput() {
    let date = sut.viewModel.event.getFormattedDate()
    
    XCTAssertEqual(sut.viewModel.date.string, "Data: \(date)")
  }
}
