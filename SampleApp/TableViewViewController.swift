//
//  TableViewViewController.swift
//  DocereeiOSMain
//
//  Created by Muqeem.Ahmad on 17/05/22.
//

import UIKit
import DocereeAdSdk

class TableViewViewController: UIViewController, DocereeAdViewDelegate, UITableViewDelegate,  UITableViewDataSource {
    
    var adView1: DocereeAdView!
    var adView2: DocereeAdView!
    var array: [DocereeAdView] = []
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginSetup()
        addCreation()
        setupTableView()
    }
    
    func loginSetup() {
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
    }
    
    func addCreation() {
        
        // Comment these lines for list of elements and uncomment below commented code
        
        adView1 = DocereeAdView(with: "300 x 50", and: CGPoint(x: 0, y: 0), adPosition: AdPosition.custom)
        adView1.docereeAdUnitId = "DOC_4kt10kl2u9g8ju"
        adView1.rootViewController = self
        adView1.delegate = self
        adView1.frame = CGRect(x: 20, y: 25, width: adView1.frame.width, height: adView1.frame.height) //These two lines are required only for custom position
        adView1.center.x = self.view.center.x
        adView1.load(DocereeAdRequest())

        adView2 = DocereeAdView(with: "300 x 50", and: CGPoint(x: 0, y: 0), adPosition: AdPosition.custom)
        adView2.docereeAdUnitId = "DOC_4kt10kl2u9g8ju"
        adView2.rootViewController = self
        adView2.delegate = self
        adView2.frame = CGRect(x: 20, y: 25, width: adView2.frame.width, height: adView2.frame.height) //These two lines are required only for custom position
        adView2.center.x = self.view.center.x
        adView2.load(DocereeAdRequest())
        
        // comment above lines and uncomment these line for list items
//        for _ in 0..<5 {
//            adView1 = DocereeAdView(with: "300 x 50", and: CGPoint(x: 0, y: 0), adPosition: .custom)
//            adView1.docereeAdUnitId = "DOC_4kt10kl2u9g8ju"
//            adView1.rootViewController = self
//            adView1.delegate = self
//            adView1.frame = CGRect(x: 20, y: 25, width: adView1.frame.width, height: adView1.frame.height) //These two lines are required only for custom position
//            adView1.center.x = self.view.center.x
//            adView1.load(DocereeAdRequest())
//
//            array.append(adView1)
//        }
    }
    
    func setupTableView() {
        tableview.register(ThirtyDayCell.self, forCellReuseIdentifier: "cellId")
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ThirtyDayCell
        cell.backgroundColor = UIColor.white
        cell.dayLabel.text = "Item \(indexPath.row+1)"
        
        // Comment this out for list of elements and uncomment below commented code
        if indexPath.row == 0 {
            cell.addSubview(adView1)
        } else if indexPath.row == 1 {
            cell.addSubview(adView2)
        }
        
        // comment above lines and uncomment this line for list items
//        cell.addSubview(array[indexPath.row])
        
        return cell
    }
    
}
