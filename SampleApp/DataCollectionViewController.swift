//
//  DataCollectionViewController.swift
//  DocereeiOSMainNew
//
//  Created by Muqeem.Ahmad on 04/11/22.
//

import UIKit
import DocereeAdSdk
import CommonCrypto
import CoreLocation

class DataCollectionViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tfRX: UITextField!
    @IBOutlet weak var dxRT: UITextField!
    @IBOutlet weak var rxErrorMsg: UILabel!
    @IBOutlet weak var dxErrorMsg: UILabel!

    
    var locationManager: CLLocationManager!
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initLocationManager()
        
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        self.tfRX.delegate = self
        self.dxRT.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        let tags = ["Health", "Medicine"]
        let json: [String : Any] = ["editorialTags" : tags as Any,
                    "screenPath" : "Home Screen/Data Collection Screen"
        ]
//        DocereeMobileAds.shared().sendData(data: json)
//        DocereeMobileAds.shared().sendData(data: ["hcpId" : "ABCDE12345"])
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // Location Manager helper stuff
    func initLocationManager() {
        locationManager = CLLocationManager()
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyBest
         locationManager.distanceFilter = 200
         locationManager.requestWhenInUseAuthorization()
         locationManager.startUpdatingLocation()
    }

    // Location Manager Delegate stuff

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        print("location error is = \(error.localizedDescription)")

    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {

        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!


        print("Current Locations = \(locValue.latitude) \(locValue.longitude)")
        if locationFixAchieved == false {
            locationFixAchieved = true
            let gps = "lat:\(locValue.latitude),lon:\(locValue.longitude)"
            let gpsDict = ["gps" : gps]
//            DocereeMobileAds.shared().sendData(data: gpsDict)
        }
    }
    
    
    @IBAction func dataCollectionClicked(_ sender: Any) {
        guard let rxStr = tfRX.text else {
            return
        }
        if rxStr == "" || rxStr == "Please enter rx(Drug Code)" {
            rxErrorMsg.isHidden = false
            return
        } else {
            rxErrorMsg.isHidden = true
        }
        
        guard let dxStr = dxRT.text else {
            return
        }
        if dxStr == "" || dxStr == "Please enter dx(Test Code)" {
            dxErrorMsg.isHidden = false
            return
        } else {
            dxErrorMsg.isHidden = true
        }

        let rxStrNew = rxStr.replacingOccurrences(of: " ", with: "")
        let dxStrNew = dxStr.replacingOccurrences(of: " ", with: "")
        
        let rxList = rxStrNew.components(separatedBy: ",")
        let dxList = dxStrNew.components(separatedBy: ",")
        
        let codesDict = ["rxList" : rxList,
                    "dxList" : dxList
        ]
//        DocereeMobileAds.shared().sendData(data: codesDict)

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let listVC = storyBoard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        self.present(listVC, animated:true, completion:nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension String {
    func sha256() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        let hash = data.withUnsafeBytes{(bytes: UnsafePointer<Data>) -> [UInt8] in
            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            CC_SHA256(bytes, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map{ String(format: "%02x", $0) }.joined()
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
