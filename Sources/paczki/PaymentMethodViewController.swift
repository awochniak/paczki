//
//  PaymentMethodViewController.swift
//  Pods
//
//  Created by Arkadiusz Wochniak on 24/03/2020.
//

public class PaymentMethodViewController : UITableViewController {
    
    var merchantId: Int? = nil
    var apiKey: String? = nil
    var downloader: PaymentMethodsDownloader? = nil
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(merchantId: Int, apiKey: String){
        self.merchantId = merchantId
        self.apiKey = apiKey
        super.init(nibName: nil, bundle: nil)
    }

    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = .clear;
        self.view.backgroundColor = .white
        downloader = PaymentMethodsDownloader(merchantId: merchantId!, apiKey: apiKey!, delegate: self)
        downloader?.execute()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        downloader?.cancel()
    }
    
}

extension PaymentMethodViewController : MethodsDownloaderDelegate, PaymentMethodDelegate {
    
    func onPaymentMethodClicked(paymentMethod: PaymentMethod) {
        navigationController?.popViewController(animated: false)
    }
    
    func onPaymentMethodsListDownloaded(paymentMethods: [PaymentMethod]) {
        DispatchQueue.main.async { [weak self] in
            if let vc = self {
                let paymentView = PaymentMethodsView(paymentMethodViewDelegate: vc, methods: paymentMethods)
                    paymentView.frame = vc.view.frame
                    vc.view.addSubview(paymentView)
            }
        }
    }
    
    func onConnectionError() {
         DispatchQueue.main.async { [weak self] in
            self?.showAlertDialog()
         }
    }
    
    private func showAlertDialog(){
        let alert = UIAlertController(title: "Wystąpił problem z połączeniem", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Anuluj", style: .default, handler: { _ in
                self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Ponów", style: .default, handler: { _ in self.downloader?.execute()}))
        self.present(alert, animated: true)
    }
}

