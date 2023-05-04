//
//  JumpingLoader.swift
//  Animated-Loader-Example
//
//  Created by Sparkout on 04/05/23.
//

import UIKit

protocol JumpingLoader where Self: UIViewController {
    func addLoader(icon: UIImage?, title: String, subtitle: String?)
    func finishLoader(to items: JumpingLoaderElements?)
    func finishLoader()
}

struct JumpingLoaderElements {
    let iconImageView: UIImageView?
    let titleLabel: UILabel?
    let subtitleLabel: UILabel?
}

extension JumpingLoader {
    private var baseViewId: String { String(describing: JumpingLoader.self) + "_BASE_VIEW_ID_1" }
    private var iconViewId: String { baseViewId + "_ICON_1" }
    private var titleViewId: String { baseViewId + "_TITLE_1" }
    private var subTitleViewId: String { baseViewId + "_SUBTITLE_1" }
    private var baseView: UIView? {
        self.view.subviews.first { $0.accessibilityIdentifier == baseViewId }
    }
    func finishLoader() {
        UIView.animate(withDuration: 0.25) {
            self.baseView?.alpha = 0
        } completion: { _ in
            self.baseView?.removeFromSuperview()
        }
    }
    
    func finishLoader(to items: JumpingLoaderElements?) {
        UIView.stopAnimate = true
        guard let items else { return }
        let iconView = baseView?.subviews.first { $0.accessibilityIdentifier == iconViewId }
        let titleView = baseView?.subviews.first { $0.accessibilityIdentifier == titleViewId }
        let subTitleView = baseView?.subviews.first { $0.accessibilityIdentifier == subTitleViewId }
        let dispatchGroup: DispatchGroup = .init()
        if let toIconView = items.iconImageView {
            dispatchGroup.enter()
            iconView?.moveItem(to: toIconView) {
                dispatchGroup.leave()
            }
        }
        
        if let toTitleView = items.titleLabel {
            dispatchGroup.enter()
            titleView?.moveItem(to: toTitleView) {
                dispatchGroup.leave()
            }
        }
        
        if let toSubtitleView = items.subtitleLabel {
            dispatchGroup.enter()
            subTitleView?.moveItem(to: toSubtitleView) {
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.finishLoader()
        }
    }
    
    func addLoader(icon: UIImage?, title: String, subtitle: String?) {
        self.baseView?.removeFromSuperview()
        UIView.stopAnimate = false
        lazy var baseView: UIView = {
            let view: UIView = .init()
            view.backgroundColor = .white
            view.accessibilityIdentifier = baseViewId
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        lazy var subTitleLabel: UILabel = {
            let label: UILabel = .init()
            label.text = subtitle
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14)
            label.accessibilityIdentifier = subTitleViewId
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        lazy var titleLabel: UILabel = {
            let label: UILabel = .init()
            label.text = title
            label.textAlignment = .center
            label.accessibilityIdentifier = titleViewId
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        lazy var iconView: UIImageView = {
            let iconImageView: UIImageView = .init()
            iconImageView.image = icon
            iconImageView.accessibilityIdentifier = iconViewId
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            return iconImageView
        }()

        
        self.view.addSubview(baseView)
        
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        baseView.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 30),
            iconView.heightAnchor.constraint(equalToConstant: 30),
            iconView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: -30),
        ])
        
        baseView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: baseView.leadingAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: baseView.centerXAnchor)
        ])
        
        baseView.addSubview(subTitleLabel)
        
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: baseView.leadingAnchor, constant: 30),
            subTitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor)
        ])
        
        iconView.animateBounce()
    }
}

fileprivate extension UIView {
    static var stopAnimate: Bool = false
    
    func moveItem(to center: UIView, finished: @escaping () -> Void) {
        UIView.animate(withDuration: 1.0) {
            self.frame.origin = center.frame.origin // CGPoint(x: 0, y: center.frame.origin.y)
        } completion: { _ in
            finished()
        }
    }
    
    func animateBounce() {
        if UIView.stopAnimate { self.transform = CGAffineTransform(translationX: 0, y: 0); return }
        let duration: CGFloat = 0.4
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(translationX: 0, y: -10)
        } completion: { _ in
            UIView.animate(withDuration: duration) {
                self.transform = CGAffineTransform(translationX: 0, y: 0)
                self.layoutIfNeeded()
            } completion: { _ in
                self.animateBounce()
            }
        }
    }
}
