//
//  NetworkReqeustFactory.swift
//  NetworkLayerPOC
//
//  Created by Ramy Nasser on 17/11/2022.
//

import Foundation
import Alamofire

final class NetworkReqeustFactory {
    private static func generateURL(outOf endpoint: Endpoint) -> URL {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            fatalError("☢️ You proabably passed a wrong URL, check \(endpoint.baseURL) or \(endpoint.path) ☢️")
        }
        return url
    }
    
    private static func encodeParameters(_ request: inout URLRequest, outOf endpoint: Endpoint) {
        do {
            _ = try endpoint.encoding.encode(request, with: endpoint.parameters)
        } catch {
            debugPrint("⚠️ Failed to encode parameters ⚠️")
        }
    }
    
    private static func setAuthorizationType(_ request: inout URLRequest, outOf endpoint: Endpoint) {
        switch endpoint.authorizationType {
        case .none:
            break
        case .token:
            request.setValue("", forHTTPHeaderField: "")
        case .operationToken:
            request.setValue("", forHTTPHeaderField: "")
        }
    }
    
    static func generateRequest(outOf endpoint: Endpoint) -> URLRequest {
        let url = generateURL(outOf: endpoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.timeoutInterval = endpoint.timeoutInterval
        buildHeaders(&urlRequest, outOf: endpoint)
        
        setAuthorizationType(&urlRequest, outOf: endpoint)
        encodeParameters(&urlRequest, outOf: endpoint)
        
        return urlRequest
    }
    
    
    private static func buildHeaders(_ request: inout URLRequest, outOf endpoint: Endpoint) {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        headers.add(name: "Accept", value: "application/json")
        headers.add(name: "device-id", value: UIDevice.current.identifierForVendor?.uuidString ?? "")
        
        request.headers = headers
        
        endpoint.headers.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.name)
        }
        
    }
}
