//
//  NumbersClient.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import Foundation

typealias GetNumbersResult = Result<[NumberItem], NumbersClientError>
typealias GetNumbersCompletion =  (GetNumbersResult) -> Void

typealias GetNumberDetailResult = Result<NumberDetail, NumbersClientError>
typealias GetNumberDetailCompletion =  (GetNumberDetailResult) -> Void

/// This uses a functional design as supposed to protocol oriented. This allows you to inject a different function for each method in the NumbersClient, making for more flexible mocks. Its a bit strange to read at first, as with a lot of functional programming, but this allows for a cleaner mock setup.  See NumbersClientLive & NumbersClientMock for an example.
struct NumbersClient {
    var getNumbers: (_ completion: @escaping GetNumbersCompletion) -> Void
    var getNumberDetail: (_ name: String, _ completion: @escaping GetNumberDetailCompletion) -> Void
}
