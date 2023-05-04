//
//  ViewController.swift
//  Animated-Loader-Example
//
//  Created by Sparkout on 03/05/23.
//

import UIKit
import JumpingLoader

class ViewController: UIViewController, JumpingLoader {
    @IBOutlet weak var locationIconImageView: UIImageView!
    @IBOutlet weak var toTitleLabel: UILabel!
    @IBOutlet weak var toAddressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view.backgroundColor = .lightGray
    }
    
    @IBAction func updateTitleSubtitleIconTapped(_ sender: UIButton) {
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
    
    @IBAction func startAndDismissTapped(_ sender: UIButton) {
        self.addLoader(
            icon: UIImage(named: "salad_icon"),
            title: "Please wait",
            subtitle: "We are finding your nearby restaurants"
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.finishLoader()
            // self.finishLoader(with: UIImage(named: "success_icon"))
        }
    }
    
    @IBAction func showStatusTapped(_ sender: UIButton) {
        self.addLoader(
            icon: UIImage(named: "food_preparing_icon"),
            title: "Please wait",
            subtitle: "We are placing your order"
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let success: Bool = Bool.random()
            self.finishLoader(with: UIImage(named: success ? "success_icon" : "sad_icon"))
        }
    }
}
