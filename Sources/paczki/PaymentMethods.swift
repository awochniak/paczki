//
//  PaymentMethods.swift
//  Pods
//
//  Created by Arkadiusz Wochniak on 25/03/2020.
//


public struct PaymentMethods {
    public static func start(_ rootViewController: UIViewController, _ merchantId: Int, apiKey: String) {
        let paymentMethodViewController = PaymentMethodViewController(merchantId: merchantId, apiKey: apiKey)
        rootViewController.navigationController?.pushViewController(paymentMethodViewController, animated: false)
    }
}
