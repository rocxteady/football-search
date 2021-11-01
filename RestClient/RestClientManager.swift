//
//  RestClientManager.swift
//  RestClient
//
//  Created by Ulaş Sancak on 17.02.2020.
//  Copyright © 2020 Ulaş Sancak. All rights reserved.
//

import Foundation

/// Manager which use RestEntpoint instance to start the request with URLSession. It controls the session. It can start and end the request.
internal class RestClientManager {
    
    //MARK: Private properties
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    /// The state of current request.
    internal var state: RestClientState = .idle
    
    /// The URLSessionTask instance of current request.
//    internal var task: URLSessionTask?
    
    internal var task: Task<(Data, URLResponse), Error>?
    
}

//MARK: Control The Manager
extension RestClientManager {
    /// Start the manager with RestEndpoint instance which includes URL etc.
    /// - Parameters:
    ///   - endpoint: RestEndPoint instance
    ///   - completion: Comploetion block which has data and/or error
    /// - Returns: Result
    func start(endpoint: RestEndpoint) async -> Result<Data, RestError> {
        var request: URLRequest?
        do {
            request = try endpoint.createRequest()
        } catch let error {
            state = .suspended
            return .failure(RestError.urlSession(error: error))
        }
        guard let realRequest = request else {
            state = .suspended
            return .failure(RestError.unknown)
        }
        state = .running
        task = Task {
            return try await session.data(for: realRequest)
        }
        do {
            let sessionResponse = try await task?.value
            if let data = sessionResponse?.0 {
                state = .completed
                return .success(data)
            } else {
                state = .suspended
                return .failure(RestError.unknown)
            }
        } catch {
            state = .suspended
            let error = error as NSError
            if error.code == NSURLErrorCancelled {
                return .failure(RestError.cancelled)
            } else {
                return .failure(RestError.urlSession(error: error))
            }
        }
    }
    
    /// End the manager
    func end() {
        task?.cancel()
        task = nil
    }
}
