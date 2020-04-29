//
//  PaymentMethodsDownloader.swift
//  Pods-sdk_Example
//
//  Created by Arkadiusz Wochniak on 24/03/2020.
//

class PaymentMethodsDownloader {
    
    let merchantId: Int
    let apiKey: String
    private weak var delegate: MethodsDownloaderDelegate?
    private var task: URLSessionDataTask? = nil
    
    public init(merchantId: Int, apiKey: String, delegate: MethodsDownloaderDelegate){
        self.merchantId = merchantId
        self.apiKey = apiKey
        self.delegate = delegate
    }

    public func execute(){
        let url = URL(string: "https://secure.przelewy24.pl/api/v1/payment/methods/pl")!
        var request = URLRequest(url: url)
        
        setHeaders(request: &request)
            
        task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let responseData = data {
                let methods = self?.buildPaymentMethodList(data: responseData)
                self?.delegate?.onPaymentMethodsListDownloaded(paymentMethods: methods!)
            }
            if let _ = error { self?.delegate?.onConnectionError()}
        }
        task?.resume()
    }
    
    public func cancel(){
        task?.cancel()
    }
    
    private func setHeaders(request: inout URLRequest) {
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic \(calculateBearer())", forHTTPHeaderField: "Authorization")
    }
    
    
    private func buildPaymentMethodList(data: Data) -> [PaymentMethod]{
        var paymentMethods = [PaymentMethod]()
        let dictionary = self.parseServerResponse(data: data)
        dictionary?.forEach { [weak self] item in
            if let downloader = self {
                paymentMethods.append(downloader.buildPaymentMethod(paymentMethodObject: item)!)
            }
        }
        return paymentMethods
    }
    
    private func parseServerResponse(data: Data) -> [[String: Any]]? {
        let jsonObject = try? JSONSerialization.jsonObject(with: data)
        if let jsonArray = jsonObject as? [String: Any]{
            if let paymentMethodDictionary = jsonArray["data"] as? [[String: Any]] {
                return paymentMethodDictionary
            }
        }
        return nil
    }
    
    private func buildPaymentMethod(paymentMethodObject: [String: Any]) -> PaymentMethod? {
        if let name = paymentMethodObject["name"] as? String,
            let id = paymentMethodObject["id"] as? Int
            //let img = paymentMethodObject["mobileImgUrl"] as? String
            {
                /* solution with SVG
                return PaymentMethod(name: name, id: id, img: img)
                */
                return PaymentMethod(name: name, id: id, img: "https://static.przelewy24.pl/img/form/png/\(id).png")
        } else {
            return nil
        }
    }
    
    private func calculateBearer() -> String {
        return Data("\(merchantId):\(apiKey)".utf8).base64EncodedString()
    }

}
