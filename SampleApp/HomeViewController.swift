//
//  HomeViewController.swift
//  DocereeiOSMainNew
//
//  Created by Muqeem.Ahmad on 10/10/22.
//

import UIKit
import DocereeAdSdk
import CommonCrypto

class HomeViewController: UIViewController {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    @IBOutlet weak var devCheckBoxBtnOutlet: CheckBox!
    @IBOutlet weak var qaCheckBoxBtnOutlet: CheckBox!
    @IBOutlet weak var prodCheckBoxBtnOutlet: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        prodCheckBoxBtnOutlet.isChecked = true
        
        let email: String = "john.doe@example.com"
        let hcpId: String = "ABCDE12345"
        
        //Passing hcp peofile
        let hcp = Hcp.HcpBuilder()
            .setFirstName(firstName: "John")
            .setLastName(lastName: "Doe")
            .setSpecialization(specialization: "Pediatrics")
            .setOrganisation(organisation: "Apollo")
            .setCity(city: "Mumbai")
            .setZipCode(zipCode: "400004")
            .setGender(gender: "Male")
            .setGmc(gmc: hcpId)
            .setHashedGMC(hashedGMC: hcpId.sha256())
            .setMciRegistrationNumber(mciRegistrationNumber: hcpId)
            .setNpi(npi: nil)
            .setHashedNPI(hashedNPI: nil)
            .setEmail(email: email)
            .setHashedEmail(hashedEmail: email.sha256())
            .setMobile(mobile: "9999999999")
            .setState(state: "Delhi")
            .setCountry(country: "India")
            .setHcpId(hcpId: hcpId)
            .setHashedHcpId(hashedHcpId: hcpId.sha256())
            .build()
        
        DocereeMobileAds.login(with: hcp)

    }
    

    @IBAction func devCheckCliked(_ sender: Any) {
        qaCheckBoxBtnOutlet.isChecked = false
        prodCheckBoxBtnOutlet.isChecked = false
        
        DocereeMobileAds.shared().setEnvironment(type: .Dev)
        DocereeMobileAds.setApplicationKey("80332546-6312-4394-a5b9-0b1029ee4789") // dev env live //for video ads
//        DocereeMobileAds.setApplicationKey("89bb8238-498e-42ed-846f-a3b0b24b79fb") // dev env test
    }
    
    @IBAction func qaCheckCliked(_ sender: Any) {
        devCheckBoxBtnOutlet.isChecked = false
        prodCheckBoxBtnOutlet.isChecked = false
        
        DocereeMobileAds.shared().setEnvironment(type: .Qa)
        DocereeMobileAds.setApplicationKey("22de535e-c6d3-442a-a816-2c4a3e6a484a") // QA env
    }
    
    @IBAction func prodCheckCliked(_ sender: Any) {
        devCheckBoxBtnOutlet.isChecked = false
        qaCheckBoxBtnOutlet.isChecked = false
        
        DocereeMobileAds.shared().setEnvironment(type: .Prod)
//        DocereeMobileAds.setApplicationKey("d2ef7838-2ee7-41b4-a993-463ed03894f1") // Locum Nest Test API key
//        DocereeMobileAds.setApplicationKey("7d982015-31bf-4c37-b7ad-1311d4e05664") // Locum Nest API key
        DocereeMobileAds.setApplicationKey("1fb90762-b216-47f9-a92f-8db45fd5c088") // Practo API key
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
