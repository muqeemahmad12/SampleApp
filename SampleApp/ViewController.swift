//
//  ViewController.swift
//  DocereeiOSMain
//
//  Created by Muqeem.Ahmad on 15/04/22.
//

import UIKit
import DocereeAdSdk

class ViewController: UIViewController, DocereeAdViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func adsClicked(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            print(buttonTitle)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let adsVC = storyBoard.instantiateViewController(withIdentifier: "AdsViewController") as! AdsViewController
            adsVC.adSize = buttonTitle
            adsVC.adUnitId = getadId(adType: buttonTitle)
            self.present(adsVC, animated:true, completion:nil)
        }
    }
    
    @IBAction func multiple(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let listVC = storyBoard.instantiateViewController(withIdentifier: "MultipleAdsVC") as! MultipleAdsVC
        self.present(listVC, animated:true, completion:nil)
    }

    @IBAction func openList(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let listVC = storyBoard.instantiateViewController(withIdentifier: "TableViewViewController") as! TableViewViewController
        self.present(listVC, animated:true, completion:nil)
    }
  
    @IBAction func openScrollView(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let listVC = storyBoard.instantiateViewController(withIdentifier: "ScrollViewController") as! ScrollViewController
        self.present(listVC, animated:true, completion:nil)
    }
    @IBAction func openCollectionView(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let listVC = storyBoard.instantiateViewController(withIdentifier: "CollectionViewViewController") as! CollectionViewViewController
        self.present(listVC, animated:true, completion:nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        DocereeMobileAds.clearUserData()
        exit(0)
    }
    func getadId(adType: String) -> String {
        
        switch adType {
        case "320 x 50":
            return "DOC_fz2erpjkn5t3kws"
        case "320 x 100":
            return "DOC_kvy1jkmzyjpd3"
        case "300 x 250":
            return "DOC_kvy1jkmzykpav"
        case "468 x 60":
            return "DOC_fz2erpjkn5t7tar"
        case "728 x 90":
            return "DOC_kvy1jkmzym0u3"
        case "300 x 50":
            return "DOC_4kt10kl2u9g8ju"
        default:
            return ""
        }
        
    }
     
}

