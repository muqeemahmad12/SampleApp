
import UIKit
import DocereeAdSdk

class SingleViewController: UIViewController, DocereeAdViewDelegate {
    
    var adView: DocereeAdView!
    var adSize: String = "320 x 50"
    var adUnitId: String = "DOC_fz2erpjkn5t3kws"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // You can pass adPosition .top, .bottom or .custom
        // If you set position as .custom position then you have to add adView positoin as per your requirement
        adView = DocereeAdView(with: adSize, and: CGPoint(x: 50, y: 50), adPosition: .custom)
        adView.docereeAdUnitId = adUnitId
        adView.delegate = self
        adView.frame = CGRect(x: 20, y: 350, width: adView.frame.width, height: adView.frame.height) //These two lines are required in case of custom position
        adView.center.x = self.view.center.x
        adView.load(DocereeAdRequest())
        addBannerViewtoView(adView)
        
    }
    
    private func addBannerViewtoView(_ bannerAdView: DocereeAdView) {
        view.addSubview(adView)
        
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
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

