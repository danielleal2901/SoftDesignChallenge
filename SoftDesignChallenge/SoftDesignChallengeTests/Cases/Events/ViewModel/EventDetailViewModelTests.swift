//
//  EventDetailViewModelTests.swift
//  SoftDesignChallengeTests
//
//  Created by Daniel Leal on 24/02/22.
//

import Foundation
import XCTest
import RxBlocking
import RxTest
import RxSwift
@testable import SoftDesignChallenge

class EventDetailViewModelTests: XCTestCase {
  var sut: EventDetailViewModel!
  var scheduler: TestScheduler!
  var disposeBag: DisposeBag!
  
  override func setUpWithError() throws {
    let mockData = try JSONHelper.loadFromFile(name: "event-mock")
    let event = try JSONDecoder().decode(Event.self, from: mockData!)
    
    sut = EventDetailViewModel(event: event, network: EventNetworkMock())
    scheduler = TestScheduler(initialClock: 0)
    disposeBag = DisposeBag()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_EventDetailView_title() {
    let title = "Feira de adoção de animais na Redenção"
    XCTAssertEqual(sut.title, title)
  }
  
  func test_EventDetailView_description() {
    let description = "O Patas Dadas estarÃ¡ na RedenÃ§Ã£o, nesse domingo, com cÃ£es para adoÃ§Ã£o e produtos Ã  venda!\n\nNa ocasiÃ£o, teremos bottons, bloquinhos e camisetas!\n\nTraga seu Pet, os amigos e o chima, e venha aproveitar esse dia de sol com a gente e com alguns de nossos peludinhos - que estarÃ£o prontinhos para ganhar o â™¥ de um humano bem legal pra chamar de seu. \n\nAceitaremos todos os tipos de doaÃ§Ã£o:\n- guias e coleiras em bom estado\n- raÃ§Ã£o (as que mais precisamos no momento sÃ£o sÃªnior e filhote)\n- roupinhas \n- cobertas \n- remÃ©dios dentro do prazo de validade"
    
    XCTAssertEqual(sut.description, description)
  }
  
  func test_EventDetailViewModel_image() {
    let image = UIImage()
    sut.event.loadedImage = image
    
    XCTAssertEqual(sut.image, image)
  }
  
  func test_EventDetailViewModel_date() {
    let date = sut.event.getFormattedDate()
    
    XCTAssertEqual(sut.date.string, "Data: \(date)")
  }
  
  func test_EventDetailViewModel_imageUrl() {
    let imageUrl = "http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png"
    
    XCTAssertEqual(sut.event.imageURL, imageUrl)
  }
  
  func test_EventDetailViewModel_sendCheckIn_invalidParameters() throws {
    let expectedResult = CheckInResult(false, "Preencha os campos corretamente")
    let expectedResultObserver = scheduler.createObserver(CheckInResult.self)
    
    sut.checkInResponse
      .drive(expectedResultObserver)
      .disposed(by: disposeBag)
    sut.sendCheckin(name: "", email: "")
    
    XCTAssertEqual(expectedResultObserver.events.last?.value.element?.success, expectedResult.success)
    XCTAssertEqual(expectedResultObserver.events.last?.value.element?.message, expectedResult.message)
  }
  
  func test_EventDetailViewModel_sendCheckIn_success() throws {
    let name = "Test"
    let email = "Test@gmail.com"
    let expectedResult = CheckInResult(true, "Sucesso ao fazer checkIn")
    let expectedResultObserver = scheduler.createObserver(CheckInResult.self)
    
    sut.checkInResponse
      .drive(expectedResultObserver)
      .disposed(by: disposeBag)
    sut.sendCheckin(name: name, email: email)
    
    XCTAssertEqual(expectedResultObserver.events.last?.value.element?.success, expectedResult.success)
    XCTAssertEqual(expectedResultObserver.events.last?.value.element?.message, expectedResult.message)
  }
  
}
