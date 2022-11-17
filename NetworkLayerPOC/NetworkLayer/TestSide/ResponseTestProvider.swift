//
//  ResponseTestProvider.swift
//  NetworkLayerPOC
//
//  Created by Ramy Nasser on 17/11/2022.
//

import Foundation
class ResponseTestProvider {
    static var isMocked: Bool = true
    static func getValidationErrorDto() -> Data {
        let encoder = JSONEncoder()
        let issues = ValidationIssueDto(code: "code",
                                        expected: "expected",
                                        received: "received",
                                        path: ["path1"],
                                        message: "message")
        let errorDto = ValidationErrorDto(issues: [issues])
        if let encoded = try? encoder.encode(errorDto) {
            // save `encoded` somewhere
            return encoded
        } else {
            return Data()
        }
    }
    
    static func getErrorDto() -> Data {
        let encoder = JSONEncoder()
        let error = ErrorDto(code: "code")
        if let encoded = try? encoder.encode(error) {
            // save `encoded` somewhere
            return encoded
        } else {
            return Data()
        }
    }
    
    static func getWafErrorDto() -> Data {
        let encoder = JSONEncoder()
        let error = WAFErrorDTO(status: "status",
                                message: "message",
                                referenceID: "referenceID")
        if let encoded = try? encoder.encode(error) {
            return encoded
        } else {
            return Data()
        }
    }
}
