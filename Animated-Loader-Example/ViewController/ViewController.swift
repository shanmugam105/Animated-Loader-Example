//
//  ViewController.swift
//  Animated-Loader-Example
//
//  Created by Sparkout on 03/05/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var locationIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addLoader(move: locationIconImageView)
        print(locationIconImageView.center)
    }
}

extension UIView {
    private static var stopAnimate: Bool = false
    func addLoader(move icon: UIImageView) {
        lazy var baseView: UIView = {
            let view: UIView = .init()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            return view
        }()
        
        self.addSubview(baseView)
        
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        lazy var containerStackView: UIStackView = {
            let stackView: UIStackView = .init()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.spacing = 4.0
            stackView.axis = .vertical
            return stackView
        }()
        
        lazy var iconView: UIImageView = {
            let icon: UIImageView = .init()
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.backgroundColor = .white
            icon.image = UIImage(named: "location_icon")
            return icon
        }()
        
        containerStackView.addArrangedSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 30),
            iconView.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        baseView.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 30),
            containerStackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -30),
            containerStackView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: -15),
        ])
        
        lazy var titleLabel: UILabel = {
            let label: UILabel = .init()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Please wait"
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            label.textAlignment = .center
            return label
        }()
        
        lazy var subTitleLabel: UILabel = {
            let label: UILabel = .init()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "We are finding your nearby restaurants"
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(subTitleLabel)
        iconView.animateBounce()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.stopAnimate = true
            baseView.backgroundColor = .clear
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                iconView.moveItem(to: icon)
            }
        }
    }
    
    private func moveItem(to latestView: UIView) {
        UIView.animate(withDuration: 1.0) {
            // let point =
            print(latestView.center)
            // self.center = latestView.center
            // self.layoutSubviews()
        }
    }
    
    private func animateBounce() {
        if UIView.stopAnimate { self.transform = .identity; return }
        UIView.animate(withDuration: 0.4) {
            self.transform = CGAffineTransform(translationX: 0, y: -10)
        } completion: { _ in
            UIView.animate(withDuration: 0.4) {
                self.transform = CGAffineTransform(translationX: 0, y: 0)
                self.layoutIfNeeded()
            } completion: { _ in
                self.animateBounce()
            }
        }
    }
}
