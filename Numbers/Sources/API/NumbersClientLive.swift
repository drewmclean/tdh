//
//  NumbersClientLive.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import Foundation

extension NumbersClient {
    
    /// TODO: Consolidate the duplicated boilerplate code in each of these methods.
    /// TODO: Add dependency injection of the URL session and reachability for unit testing.
    
    static let live: NumbersClient = {
        
        let getNumbersLive: (_ completion: @escaping GetNumbersCompletion) -> Void = { completion in
            let request = URLRequest(url: NumbersClient.Config.getNumbersURL())
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                do {
                    let json = try processResponse(data: data, response: response, error: error)
                    let numbers: [NumberItem] = try jsonDecoder.decode([NumberItem].self, from: json)
                    completion(.success(numbers))
                } catch let e {
                    completion(.failure(.invalidResponse("Error fetching numbers: \(e)")))
                }
            }.resume()
        }
        
        let getNumberDetailsLive: (_ name: String, _ completion: @escaping GetNumberDetailCompletion) -> Void = { name, completion in
            let request = URLRequest(url: NumbersClient.Config.getNumberDetailURL(forName: name))
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                do {
                    let json = try processResponse(data: data, response: response, error: error)
                    let number: NumberDetail = try jsonDecoder.decode(NumberDetail.self, from: json)
                    completion(.success(number))
                } catch let e {
                    completion(.failure(.invalidResponse("Error fetching number details for \(name): \(e)")))
                }
            }.resume()
        }
        
        return Self(
            getNumbers: getNumbersLive,
            getNumberDetail: getNumberDetailsLive
        )
    }()

}

private func processResponse(data: Data?, response: URLResponse?, error: Error?) throws -> Data {
    if let e = error {
        throw NumbersClientError.networkError("Data task error encountered: \(e.localizedDescription)")
    }
    guard let json = data else {
        throw NumbersClientError.invalidResponse("Data task response body is nil.")
    }
    return json
}

private let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    return jsonDecoder
}()
