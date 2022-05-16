//
//  NumbersClientConfig.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import Foundation

extension NumbersClient {
    
    struct Config {
        static let shared = Config()
        
        private static let hostURL: String = "http://dev.tapptic.com/"
        
        static func getNumbersURL() -> URL {
            return URL(string: hostURL + "test/json.php")!
        }
        
        static func getNumberDetailURL(forName name: String) -> URL {
            return URL(string: hostURL + "test/json.php?name=\(name)")!
        }
    }
    
}


