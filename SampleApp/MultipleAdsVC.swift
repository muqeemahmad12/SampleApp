//
//  MultipleAdsVC.swift
//  DocereeiOSMain
//
//  Created by Muqeem.Ahmad on 16/05/22.
//

import UIKit
import DocereeAdsSdk
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

        
        adView1 = DocereeAdView(with: "300 x 50", and: CGPoint(x: 50, y: 50))
        adView1.docereeAdUnitId = "DOC_4kt10kl2u9g8ju"
        adView1.rootViewController = self
        adView1.delegate = self
        adView1.load(DocereeAdRequest())
        adView1.frame = CGRect(x: 0, y: 50, width: adView1.frame.width, height: adView1.frame.height)
        adView1.center.x = self.view.center.x
        view.addSubview(adView1)
        
        
        adView2 = DocereeAdView(with: "300 x 250", and: CGPoint(x: 50, y: 50))
        adView2.docereeAdUnitId = "DOC_fz2erpjkn5t79t4"
        adView2.rootViewController = self
        adView2.delegate = self
        adView2.load(DocereeAdRequest())
        adView2.frame = CGRect(x: 0, y: 150, width: adView2.frame.width, height: adView2.frame.height)
        adView2.center.x = self.view.center.x
        view.addSubview(adView2)
        
    }
    
}
