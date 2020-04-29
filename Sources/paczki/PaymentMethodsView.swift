//
//  PaymentMethodsView.swift
//  Pods
//
//  Created by Arkadiusz Wochniak on 25/03/2020.
//
public class PaymentMethodsView: UITableView {
    
    let paymentMethodsViewDelegate: PaymentMethodDelegate?
    let methods: [PaymentMethod]
    
    init(paymentMethodViewDelegate: PaymentMethodDelegate, methods: [PaymentMethod]){
        self.methods = methods
        self.paymentMethodsViewDelegate = paymentMethodViewDelegate
        super.init(frame: CGRect.zero, style: .plain)
        self.delegate = self
        self.dataSource = self
        register(PaymentMethodRowView.self, forCellReuseIdentifier: "paymentCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PaymentMethodsView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return methods.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentMethodRowView
        
        cell.paymentMethodTitle = methods[indexPath.row].name
        cell.paymentMethodDescription = String(methods[indexPath.row].id)
        cell.paymentMethodImageView.downloadImageFrom(url: methods[indexPath.row].img)
        
        return cell
    }
}

extension PaymentMethodsView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        paymentMethodsViewDelegate?.onPaymentMethodClicked(paymentMethod: methods[indexPath.row])
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;//Choose your custom row height
    }
}


extension UIImageView {
    func downloadImageFrom(url: String) {
        URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    return }
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}

