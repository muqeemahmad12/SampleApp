//
//  MySwiftObject.swift
//  SampleApp
//
//  Created by Muqeem.Ahmad on 12/09/23.
//

import UIKit
import DocereeAdSdk

@objc(MySwiftObject)
class SampleClass : UIView, DocereeAdViewDelegate {
    
    var adView: DocereeAdView!
    var adSize: String = "320 x 50"
    var adUnitId: String = "DOC-445-1"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func testAd() -> UIView {
        
        adView = DocereeAdView(with: adSize, and: CGPoint(x: 50, y: 50), adPosition: .custom)
        adView.docereeAdUnitId = adUnitId
        adView.delegate = self
        adView.frame = CGRect(x: 20, y: 350, width: adView.frame.width, height: adView.frame.height) //These two lines are required in case of custom position
//        adView.center.x = self.center.x
        adView.load(DocereeAdRequest())
        return adView
    }
    
}

extension SampleClass {
    func docereeAdViewDidReceiveAd(_ docereeAdView: DocereeAdView) {
        print("ad received")
    }
    
    func docereeAdView(_ docereeAdView: DocereeAdView, didFailToReceiveAdWithError error: DocereeAdRequestError) {
        print("ad \(error)")
    }
    
    func docereeAdViewWillPresentScreen(_ docereeAdView: DocereeAdView) {
        print("ad will present screen")
    }
    
    func docereeAdViewWillDismissScreen(_ docereeAdView: DocereeAdView) {
        print("ad will dismiss")
    }
    
    func docereeAdViewDidDismissScreen(_ docereeAdView: DocereeAdView) {
        print("ad did dismiss")
    }
    
    func docereeAdViewWillLeaveApplication(_ docereeAdView: DocereeAdView) {
        print("ad will leave application")
    }
}
