//
//  MethodsDownloadersDelegate.swift
//  Pods
//
//  Created by Arkadiusz Wochniak on 24/03/2020.
//

protocol MethodsDownloaderDelegate: AnyObject {
    func onPaymentMethodsListDownloaded(paymentMethods: [PaymentMethod])
    func onConnectionError()
}
