//
//  KetchViewController.swift
//  DocereeiOSMainNew
//
//  Created by Muqeem Ahmad on 26/04/24.
//

import UIKit
import DocereeAdSdk
import SwiftUI
//import KetchSDK

class KetchViewController: UIViewController {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var parentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        setupSwiftUIView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupSwiftUIView() {
//        let swiftUIView = MyKetchView()
//        let hostingController = UIHostingController(rootView: swiftUIView)
//        addChild(hostingController)
//        view.addSubview(hostingController.view)
//
//        // Set constraints if needed
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
//            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
//        hostingController.didMove(toParent: self)
    }
}
