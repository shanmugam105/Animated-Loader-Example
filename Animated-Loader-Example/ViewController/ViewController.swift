//
//  ViewController.swift
//  Animated-Loader-Example
//
//  Created by Sparkout on 03/05/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var locationIconImageView: UIImageView!
    
    @IBOutlet weak var toTitleLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addLoader(toIcon: locationIconImageView, toTitle: toLabel, toSubtitle: toTitleLabel)
        print(locationIconImageView.center)
    }
}

extension UIView {
    private static var stopAnimate: Bool = false
    private static var baseView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    private static var subTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We are finding your nearby restaurants"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private static var titleLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please wait"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private static var iconView: UIImageView = {
        let icon: UIImageView = .init()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "location_icon")
        return icon
    }()
    
    func addLoader(toIcon: UIImageView, toTitle: UILabel, toSubtitle: UILabel) {
        
        self.addSubview(UIView.baseView)
        
        NSLayoutConstraint.activate([
            UIView.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            UIView.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            UIView.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            UIView.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        UIView.baseView.addSubview(UIView.iconView)
        NSLayoutConstraint.activate([
            UIView.iconView.widthAnchor.constraint(equalToConstant: 30),
            UIView.iconView.heightAnchor.constraint(equalToConstant: 30),
            UIView.iconView.centerXAnchor.constraint(equalTo: UIView.baseView.centerXAnchor),
            UIView.iconView.centerYAnchor.constraint(equalTo: UIView.baseView.centerYAnchor, constant: -30),
        ])
        
        UIView.baseView.addSubview(UIView.titleLabel)
        
        NSLayoutConstraint.activate([
            UIView.titleLabel.topAnchor.constraint(equalTo: UIView.iconView.bottomAnchor, constant: 8),
            UIView.titleLabel.leadingAnchor.constraint(equalTo: UIView.baseView.leadingAnchor, constant: 30),
            UIView.titleLabel.centerXAnchor.constraint(equalTo: UIView.baseView.centerXAnchor)
        ])
        
        UIView.baseView.addSubview(UIView.subTitleLabel)
        
        NSLayoutConstraint.activate([
            UIView.subTitleLabel.topAnchor.constraint(equalTo: UIView.titleLabel.bottomAnchor, constant: 8),
            UIView.subTitleLabel.leadingAnchor.constraint(equalTo: UIView.titleLabel.leadingAnchor, constant: 30),
            UIView.subTitleLabel.centerXAnchor.constraint(equalTo: UIView.titleLabel.centerXAnchor)
        ])
        
        UIView.iconView.animateBounce()
        
    }
    
    func removeLoader() {
        UIView.stopAnimate = true
        UIView.animate(withDuration: 1) {
            UIView.baseView.backgroundColor = .clear
        }
        // UIView.iconView.moveItem(to: toIcon)
        // UIView.titleLabel.moveItem(to: toTitle)
        // UIView.subTitleLabel.moveItem(to: toSubtitle)
    }
    
    private func moveItem(to center: UIView) {
        UIView.animate(withDuration: 1.0) {
            self.center = center.center
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
