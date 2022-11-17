//
//  NetworkClientBuilder.swift
//  NetworkLayerPOC
//
//  Created by Ramy Nasser on 18/11/2022.
//

import Foundation
class NetworkClientBuilder {
    static var network: NetworkClient!
    
    static func build() -> NetworkClient {
        let wafErrorHandler = WafErrorHandler()
        let generalErrorHandler = GeneralErrorHandler()
        let authTokenProvider = AuthProvider()
        let appErrorProvider = AppErrorProvider(wafError: wafErrorHandler,
                                                generalError: generalErrorHandler)
        network = NetworkClient(authProvider: authTokenProvider,
                                errorProvider: appErrorProvider)
        return network
    }
}
