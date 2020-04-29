//
//  PaymentMethodRowView.swift
//  Pods
//
//  Created by Arkadiusz Wochniak on 25/03/2020.
//


class PaymentMethodRowView: UITableViewCell {
    var paymentMethodTitle: String?
    var paymentMethodDescription: String?
    
    var paymentMethodImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }()
    
    var paymentMethodRowTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var paymentMethodRowDescription: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var paymentMethodRowText: UIView = {
        var uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        paymentMethodRowText.addSubviews([paymentMethodRowTitle, paymentMethodRowDescription])
        self.addSubviews([paymentMethodRowText, paymentMethodImageView])
    }

    private func setupConstraints() {
        paymentMethodImageView.anchorsFromLRTB(parent: self, left: 20, isAnchoredToRight: false)
        paymentMethodImageView.anchorsForHW(parent: self, isWidthAnchorPresent: true, widthMultiplier: 1/4)
        paymentMethodRowText.anchorsFromLRTB(parent: self, left: 20, leftEqualTo: paymentMethodImageView.rightAnchor, top: 16, bottom: -16)
        paymentMethodRowTitle.anchorsFromLRTB(parent: paymentMethodRowText, bottomEqualTo: paymentMethodRowText.centerYAnchor)
        paymentMethodRowDescription.anchorsFromLRTB(parent: paymentMethodRowText, topEqualTo: paymentMethodRowText.centerYAnchor)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let title = paymentMethodTitle {
            paymentMethodRowTitle.text = title
            paymentMethodRowTitle.font = UIFont.boldSystemFont(ofSize: 16)
            
        }
        
        if let description = paymentMethodDescription {
            paymentMethodRowDescription.text = description
            paymentMethodRowDescription.font = UIFont.systemFont(ofSize: 14)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
