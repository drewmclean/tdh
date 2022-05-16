//
//  Reachability.swift
//  Numbers
//
//  Created by Andrew McLean on 5/12/22.
//

import Foundation
import SystemConfiguration

protocol ReachabilityProtocol {
    func isConnectedToNetwork() -> Bool
}

public class Reachability: ReachabilityProtocol {

    static let shared: Reachability = Reachability()
    
    func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
           $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
               SCNetworkReachabilityCreateWithAddress(nil, $0)
           }
        }) else {
           return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
