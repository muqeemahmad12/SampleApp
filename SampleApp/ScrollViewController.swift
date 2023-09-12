import UIKit
import DocereeAdSdk

class ScrollViewController: UIViewController, DocereeAdViewDelegate {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var superParentView: UIView!
    var parentView: UIView!
    var adView1: DocereeAdView!
    var adView2: DocereeAdView!
    var adSize: String = ""
    var adUnitId: String = ""
    

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        parentView = UIView(frame: CGRect(x: 0, y: 60, width: self.view.frame.width - 80, height: self.view.frame.height - 200))
        self.view.addSubview(parentView)
        
        imageView = UIImageView(image: UIImage(named: "image.png"))
        imageView.frame = self.view.frame
            
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize.width = imageView.bounds.size.width * 2
        scrollView.contentSize.height = imageView.bounds.size.height * 3
        scrollView.autoresizingMask = .flexibleHeight//UIViewAutoresizing.FlexibleWidth || UIViewAutoresizing.FlexibleHeight
            
        scrollView.addSubview(imageView)
        parentView.addSubview(scrollView)

        
        // You can pass adPosition .top, .bottom or .custom
        // If you set position as .custom position then you have to add adView positoin as per your requirement
        adView1 = DocereeAdView(with: "300 x 50", and: CGPoint(x: 50, y: 50), adPosition: AdPosition.custom)
        if DocereeMobileAds.shared().getEnvironment() == .Qa {
            adView1.docereeAdUnitId = "DOC_3198xll778mhtn" //QA
        } else {
            adView1.docereeAdUnitId = "DOC_4kt10kl2u9g8ju" //Dev
        }
        adView1.rootViewController = self
        adView1.delegate = self
        adView1.frame = CGRect(x: 200, y: 550, width: adView1.frame.width, height: adView1.frame.height) //These two lines are required only for custom position
//        adView1.center.x = self.view.center.x
        adView1.backgroundColor = .red
        addBannerViewtoView(adView1)
        adView1.load(DocereeAdRequest())
        
        
        adView2 = DocereeAdView(with: "300 x 250", and: CGPoint(x: 50, y: 50), adPosition: AdPosition.custom)
        if DocereeMobileAds.shared().getEnvironment() == .Qa {
            adView1.docereeAdUnitId = "DOC_3198xll778lhix" //QA
        } else {
            adView1.docereeAdUnitId = "DOC_kvy1jkmzykpav" //Dev
        }
        adView2.rootViewController = self
        adView2.delegate = self
        adView2.frame = CGRect(x: 200, y: 750, width: adView2.frame.width, height: adView2.frame.height) //These two lines are required only for custom position
//        adView2.center.x = self.view.center.x
        adView2.backgroundColor = .blue
        addBannerViewtoView(adView2)
        adView2.load(DocereeAdRequest())
        
    }
    
    private func addBannerViewtoView(_ bannerAdView: DocereeAdView){
        scrollView.addSubview(bannerAdView)
        
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
        } else {
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

