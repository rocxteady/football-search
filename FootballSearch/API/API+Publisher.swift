//
//  API+Publisher.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 24.10.2021.
//

import Combine
import API
import RestClient

extension Publishers {
    
    struct APISubscription<S: Subscriber, T: API>: Subscription where S.Input == T.ResponseModel, S.Failure == Error {
        
        let combineIdentifier = CombineIdentifier()
        private let api: T
        private let subscriber: S?
        
        init(api: T, subscriber: S) {
            self.api = api
            self.subscriber = subscriber
            start()
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            api.end()
            subscriber?.receive(completion: .finished)
        }
                
        private func start() {
            guard let subscriber = subscriber else { return }
            Task {
                let response = await api.start()
                if let error = response.error {
                    subscriber.receive(completion: .failure(error))
                } else if let responseModel = response.responseModel {
                    _ = subscriber.receive(responseModel)
                    subscriber.receive(completion: .finished)
                } else {
                    subscriber.receive(completion: .failure(RestError.unknown))
                }
            }
        }
        
    }
    
    struct APIPublisher<T: API>: Publisher {
        
        typealias Output = T.ResponseModel
        
        typealias Failure = Error
        
        let api: T
        
        func receive<S>(subscriber: S) where S : Subscriber, Error == S.Failure, T.ResponseModel == S.Input {
            let subscription = Publishers.APISubscription(api:api, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
        
    }
    
}



extension API {
    
    func publish_start() -> Publishers.APIPublisher<Self> {
        Publishers.APIPublisher(api: self)
    }
    
}
