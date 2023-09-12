//
//  CollectionViewViewController.swift
//  DocereeiOSMainNew
//
//  Created by Muqeem.Ahmad on 10/08/22.
//

import UIKit
import DocereeAdSdk

class CollectionViewViewController: UIViewController, DocereeAdViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var parentView: UIView!
    var adView1: DocereeAdView!
    var adView2: DocereeAdView!
    var array: [DocereeAdView] = []
    var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        addCreation()
        setupCollectionView()
        
    }

    func addCreation() {
        
        // Comment these lines for list of elements and uncomment below commented code
        
//        adView1 = DocereeAdView(with: "300 x 50", and: CGPoint(x: 0, y: 0), adPosition: AdPosition.custom)
//        adView1.docereeAdUnitId = "DOC_3198xll778mhtn"
//        adView1.rootViewController = self
//        adView1.delegate = self
//        adView1.frame = CGRect(x: 20, y: 25, width: adView1.frame.width, height: adView1.frame.height) //These two lines are required only for custom position
//        adView1.center.x = self.view.center.x
//        adView1.load(DocereeAdRequest())
//
//        adView2 = DocereeAdView(with: "300 x 50", and: CGPoint(x: 0, y: 0), adPosition: AdPosition.custom)
//        adView2.docereeAdUnitId = "DOC_3198xll778mhtn"
//        adView2.rootViewController = self
//        adView2.delegate = self
//        adView2.frame = CGRect(x: 20, y: 25, width: adView2.frame.width, height: adView2.frame.height) //These two lines are required only for custom position
//        adView2.center.x = self.view.center.x
//        adView2.load(DocereeAdRequest())
        
        // comment above lines and uncomment these line for list items
        for _ in 0..<10 {
            adView1 = DocereeAdView(with: "300 x 50", and: CGPoint(x: 0, y: 0), adPosition: .custom)
            if DocereeMobileAds.shared().getEnvironment() == .Qa {
                adView1.docereeAdUnitId = "DOC_3198xll778mhtn" //QA
            } else {
                adView1.docereeAdUnitId = "DOC_4kt10kl2u9g8ju" //Dev
            }
//            adView1.rootViewController = self
            adView1.delegate = self
            adView1.frame = CGRect(x: 20, y: 25, width: adView1.frame.width, height: adView1.frame.height) //These two lines are required only for custom position
//            adView1.center.x = self.view.center.x
            adView1.load(DocereeAdRequest())

            array.append(adView1)
        }
    }
    
    func setupCollectionView() {
 
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 400)
        layout.scrollDirection = .horizontal

        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
//        collectionview.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        parentView.addSubview(collectionview)
        
        for i in 0..<10 {
            collectionview.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellId-\(i)")
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "cellId-\(indexPath.row)", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.dayLabel.text = "Item \(indexPath.row+1)"
        cell.dayView.addSubview(array[indexPath.row])
        return cell
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
