//
//  ErrorProvider.swift
//  NetworkLayerPOC
//
//  Created by Ramy Nasser on 17/11/2022.
//

import UIKit
import Toast_Swift

struct AppErrorProvider: ErrorProviderProtocol {
    var wafError: WafErrorHandlerProtocol
    var generalError: GeneralErrorHandlerProtocol
}

struct GeneralErrorHandler: GeneralErrorHandlerProtocol {
    func handle(sdkError: SDKError) {
        UIApplication.topViewController()?.view.hideToastActivity()
        UIApplication.topViewController()?.view.makeToast("GeneralError \(sdkError.error.debugDescription)")
    }
}
struct WafErrorHandler: WafErrorHandlerProtocol {
    func handle(wafError: WAFErrorDTO) {
        UIApplication.topViewController()?.view.hideToastActivity()
        UIApplication.topViewController()?.view.makeToast("wafError \(wafError.message)")
    }
}
