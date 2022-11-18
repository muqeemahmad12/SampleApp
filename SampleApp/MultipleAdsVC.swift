//
//  MultipleAdsVC.swift
//  DocereeiOSMain
//
//  Created by Muqeem.Ahmad on 16/05/22.
//

import UIKit
import DocereeAdSdk
class MultipleAdsVC: UIViewController, DocereeAdViewDelegate {
    
    var adSize: String = ""
    var adUnitId: String = ""
    
    // MARK: Variables/Properties
    var adView1: DocereeAdView!
    var adView2: DocereeAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let email: String = "john.doe@exmaple.com"
        
        //Passing hcp peofile
        let hcp = Hcp.HcpBuilder()
            .setFirstName(firstName: "John")
            .setLastName(lastName: "Doe")
            .setSpecialization(specialization: "Anesthesiology")
            .setCity(city: "Mumbai")
            .setZipCode(zipCode: "400004")
            .setGender(gender: "Male")
            .setMciRegistrationNumber(mciRegistrationNumber: "ABCDE12345")
            .setEmail(email: email)
            .setMobile(mobile: "9999999999")
            .build()
        
        DocereeMobileAds.login(with: hcp)

        // You can pass adPosition .top, .bottom or .custom
        // If you set position as .custom position then you have to add adView positoin as per your requirement
        adView1 = DocereeAdView(with: "300 x 50", and: CGPoint(x: 50, y: 50), adPosition: AdPosition.bottom)
        //        adView1.docereeAdUnitId = "DOC_3198xll778mhtn" //QA
                adView1.docereeAdUnitId = "DOC_4kt10kl2u9g8ju" //Dev
//        adView1.rootViewController = self
        adView1.delegate = self
        adView1.frame = CGRect(x: 20, y: 150, width: adView1.frame.width, height: adView1.frame.height) //These two lines are required only for custom position
        adView1.center.x = self.view.center.x
        addBannerViewtoView(adView1)
        adView1.load(DocereeAdRequest())
        
        
        adView2 = DocereeAdView(with: "300 x 250", and: CGPoint(x: 50, y: 50), adPosition: AdPosition.top)
        adView2.docereeAdUnitId = "DOC_fz2erpjkn5t79t4"
//        adView2.rootViewController = self
        adView2.delegate = self
        adView2.frame = CGRect(x: 20, y: 350, width: adView2.frame.width, height: adView2.frame.height) //These two lines are required only for custom position
        adView2.center.x = self.view.center.x
        addBannerViewtoView(adView2)
        adView2.load(DocereeAdRequest())
        
    }
    
    private func addBannerViewtoView(_ bannerAdView: DocereeAdView){
        view.addSubview(bannerAdView)
        
        if bannerAdView.position == .top {
            view.addConstraints([
                NSLayoutConstraint(item: bannerAdView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: topLayoutGuide,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: bannerAdView,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: view,
                                   attribute: .centerX,
                                   multiplier: 1,
                                   constant: 0)
            ])
        } else if bannerAdView.position == .bottom {
            view.addConstraints([
                NSLayoutConstraint(item: bannerAdView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: bottomLayoutGuide,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: bannerAdView,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: view,
                                   attribute: .centerX,
                                   multiplier: 1,
                                   constant: 0)
            ])
        }
    }
}
