# SoftDesignChallenge

## Projeto desenvolvido para o desafio do SICREDI
Consiste em um aplicativo para listagem, visualização detalhada e checkIn de eventos.

## Definições de Arquitetura
Para este projeto foi utilizada a arquitetura MVVM-C e programação reativa através de RxSwift e RxCocoa, utilizando também de view code para criação do layout em si. 
Para integração com back-end foi utilizado URLSession através da biblioteca nativa Foundation.
Para desenvolvimento de testes unitários em geral foi utilizado a biblioteca nativa XCTest.
Para o mapa também é utilizado biblioteca nativa, o MapKit.
Para gerenciamento de frameworks externas como o RxSwift, foi utilizado o cocoaPods. 

O aplicativo fornece suporte tanto a iPhone quanto iPad.

## Backend - API's utilizadas
API para listagem de eventos: http://5f5a8f24d44d640016169133.mockapi.io/api/events
API para detalhes de evento: http://5f5a8f24d44d640016169133.mockapi.io/api/events/(idEvento)
API para checkIn de eventos: http://5f5a8f24d44d640016169133.mockapi.io/api/checkin


## Observações:
Não foram desenvolvidos testes unitários para todas as views apenas para economizar tempo, pois no geral os testes unitários seriam muito parecidos com os que foram desenvolvidos para as views EventDetailViewController e EventsViewController.
