//
//  ViewController.swift
//  DocereeiOSMain
//
//  Created by Muqeem.Ahmad on 15/04/22.
//

import UIKit
import DocereeAdSdk

class SlotListViewController: UIViewController, DocereeAdViewDelegate {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
    }
    
    @IBAction func adsClicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            print(buttonTitle)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let adsVC = storyBoard.instantiateViewController(withIdentifier: "AdsViewController") as! SingleViewController
            adsVC.adSize = buttonTitle
            adsVC.adUnitId = getadId(adType: buttonTitle)
            self.present(adsVC, animated:true, completion:nil)
        }
    }

    func getadId(adType: String) -> String {
        let environment = DocereeMobileAds.shared().getEnvironment()
       
        switch adType {
        case "320 x 50":
            if environment == .Qa {
                return "DOC-445-1" // QA
//                return "DOC_3198xll778ncs9" // QA
            } else {
                return "DOC-1252-1" // Prod
//                return "DOC-18-1" // QA
//                return "DOC_fz2erpjkn5t3kws" // Dev
            }
        case "320 x 100":
            if environment == .Qa {
                return "DOC-447-1" // QA
//                return "DOC_3198xll778puay" // QA
            } else if environment == .Dev {
                return "DOC_kvy1jkmzyjpd3" // Dev
            } else {
                return "DOC-15-1" // QA
//                return "DOC_ddio9klbg5wzd2" // Practo API key
            }
        case "300 x 250":
            if environment == .Qa {
                return "DOC-449-1" // QA
//                return "DOC_3198xll778lhix" // QA
            } else if environment == .Dev {
                return "DOC_kvy1jkmzykpav" // Dev
            } else {
                return "DOC-13-1" // QA
//                return "DOC_3y65rkl8vn21z2" // Locum Nest Test API key
            }
        case "468 x 60":
            if environment == .Qa {
                return "DOC-446-1" // QA
//                return "DOC_3198xll778r0t9" // QA
            } else {
                return "DOC-11-1" // QA
//                return "DOC_fz2erpjkn5t7tar" // Dev
            }
        case "728 x 90":
            if environment == .Qa {
                return "DOC-448-1" // QA
//                return "DOC_3198xll778s0p6" // QA
            } else {
                return "DOC-12-1" // QA
//                return "DOC_kvy1jkmzym0u3" // Dev
            }
        case "300 x 50":
            if environment == .Qa {
                return "DOC-445-1" // QA
//                return "DOC_3198xll778mhtn" //QA
            } else {
                return "DOC_4kt10kl2u9g8ju" // Dev
            }
        default:
            return ""
        }
    }
     
}

