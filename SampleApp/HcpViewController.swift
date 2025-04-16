//
//  HcpViewController.swift
//  DocereeiOSMainNew
//
//  Created by Muqeem Ahmad on 26/04/24.
//

import UIKit
import DocereeAdSdk

class HcpViewController: UIViewController, DocereeAdViewDelegate {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var parentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        
        
        let hcpValidationView = HcpValidationView()
        hcpValidationView.loadData(hcpValidationRequest: HcpValidationRequest())
        hcpValidationView.delegate = self
        self.view.addSubview(hcpValidationView)
        
    }
}


extension HcpViewController: HcpValidationViewDelegate {
    func hcpValidationViewSuccess(_ hcpValidationView: HcpValidationView) {
        print("Hcp Popup Success")
    }
    func hcpValidationView(_ hcpValidationView: HcpValidationView,
                       didFailToReceiveHcpWithError error: HcpRequestError) {
        print("\(error.rawValue)")
    }
    func hcpPopupAction(_ popupAction: PopupAction) {
        print("popup action: \(popupAction)")
    }
}
