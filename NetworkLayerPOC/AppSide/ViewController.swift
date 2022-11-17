//
//  ViewController.swift
//  NetworkLayerPOC
//
//  Created by Ahmed Ramzy on 15/11/2022.
//

import Alamofire
import UIKit
import Toast_Swift
struct Joke: Codable {
    var value: String
}


enum Jokes: Endpoint {
    case random

    var baseURL: String {
        switch self {
        case .random:
            return "https://api.chucknorris"
        }
    }

    var path: String {
        switch self {
        case .random:
            return "/random"
        }
    }

//    var headers: HTTPHeaders {
//        var requestHeaders = HTTPHeaders()
//        switch self {
//        case .random:
//            requestHeaders.add(HTTPHeader(name: "Content-Type", value: "application/json"))
//        }
//        return requestHeaders
//    }

    var parameters: Parameters? {
        switch self {
        case .random:
            return nil
        }
    }

    var authorizationType: AuthorizationTypes {
        switch self {
        case .random:
            return .none
        }
    }

    var method: HTTPMethod {
        switch self {
        case .random:
            return .get
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .random:
            return JSONEncoding.default
        }
    }
}


class ViewController: UIViewController {
    var network: NetworkClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.makeToastActivity(.center)
        network = NetworkClientBuilder.build()
        network?.executeData(endpoint: Jokes.random, Joke.self) { response in
            switch response {
            case .success(let value):
                self.view.makeToast("😂 \(value?.value) 😂")
            case .failure(let sdkError):
                self.view.hideToastActivity()
                self.view.makeToast("serviceError: \(sdkError.error.debugDescription)")
            }
        }
    }
}




