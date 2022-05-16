//
//  NumbersClientMock.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import Foundation

extension NumbersClient {
    
    static let mockHappy: NumbersClient = {
        return Self(
            getNumbers: { completion in
                let items = [NumberItem(name: "1", image: "1.png"),
                             NumberItem(name: "2", image: "2.png"),
                             NumberItem(name: "3", image: "3.png")]
                completion(.success(items))
            },
            getNumberDetail: { name, completion in
                let detail = NumberDetail(name: "1", text: "One", image: "1.png")
                completion(.success(detail))
            }
        )
    }()
    
    static let mockFail: NumbersClient = {
        return Self(
            getNumbers: { completion in
                completion(.failure(.networkError("Error")))
            },
            getNumberDetail: { name, completion in
                completion(.failure(.networkError("Error")))
            }
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
