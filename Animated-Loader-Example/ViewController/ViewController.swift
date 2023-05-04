//
//  ViewController.swift
//  Animated-Loader-Example
//
//  Created by Sparkout on 03/05/23.
//

import UIKit

class ViewController: UIViewController, JumpingLoader {
    @IBOutlet weak var locationIconImageView: UIImageView!
    @IBOutlet weak var toTitleLabel: UILabel!
    @IBOutlet weak var toAddressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view.backgroundColor = .lightGray
    }
    
    @IBAction func updateRestaurantAndAnimateTapped(_ sender: UIButton) {
        self.addLoader(
            icon: UIImage(named: "location_icon"),
            title: "Office",
            subtitle: "C.M.Nagar, 2, Main Rd, Ramakrishnapuram, Ganapathi"
        )
        let destinationItems: JumpingLoaderElements = .init(iconImageView: locationIconImageView,
                                                            titleLabel: toTitleLabel,
                                                            subtitleLabel: toAddressLabel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.finishLoader(to: destinationItems)
        }
    }
    
    @IBAction func updateRestaurantTapped(_ sender: UIButton) {
        self.addLoader(
            icon: UIImage(named: "location_icon"),
            title: "Please wait",
            subtitle: "We are finding your nearby restaurants"
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.finishLoader()
        }
    }
}
