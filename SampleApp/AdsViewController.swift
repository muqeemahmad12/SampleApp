
import UIKit
import DocereeAdsSdk

class AdsViewController: UIViewController, DocereeAdViewDelegate {
    
    var adView: DocereeAdView!
    var adSize: String = ""
    var adUnitId: String = ""
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

        adView = DocereeAdView(with: adSize, and: CGPoint(x: 50, y: 50))
        adView.docereeAdUnitId = adUnitId
        adView.rootViewController = self
        adView.delegate = self
        adView.frame = CGRect(x: 0, y: 150, width: adView.frame.width, height: adView.frame.height)
        adView.center.x = self.view.center.x
        adView.load(DocereeAdRequest())
        self.view.addSubview(adView)
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
}

