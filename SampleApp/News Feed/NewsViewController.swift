//
//  NewsViewController.swift
//  DocereeiOSMainNew
//
//  Created by Muqeem.Ahmad on 11/10/22.
//

import UIKit
import DocereeAdSdk

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FeedCellDelegate, UITextViewDelegate {

    var animalsImgNamse = ["black_pug", "blue_bird", "brown_dear", "brown_fox", "brown_turtle", "flamingo", "giraffe", "kar_ming_moo", "orange_parrot", "tiger"]
    var animalsTitles = ["Black Pug", "Blue Bird", "Brown Dear", "Brown Fox", "Brown Turtle", "Flamingo", "Giraffe", "Kar Ming Moo", "Orange Parrot", "Tiger"]
    var animalsDesc = ["The Pug is a breed of dog originally from China, with physically distinctive features of a wrinkly, short-muzzled face and curled tail.", "The bluebirds are a North American[1] group of medium-sized, mostly insectivorous or omnivorous birds in the order of Passerines in the genus Sialia of the thrush family (Turdidae).", "Brown Deer is a village in Milwaukee County, Wisconsin, United States. As a suburb of Milwaukee, it is part of the Milwaukee metropolitan area.", "Foxes are small to medium-sized, omnivorous mammals belonging to several genera of the family Canidae.", "The brown roofed turtle (Pangshura smithii) is a species of turtle in the family Geoemydidae. The species is endemic to South Asia.", "Flamingos or flamingoes[a] /fləˈmɪŋɡoʊz/ are a type of wading bird in the family Phoenicopteridae, which is the only extant family in the order Phoenicopteriformes.", "The giraffe is a large African hoofed mammal belonging to the genus Giraffa. It is the tallest living terrestrial animal and the largest ruminant on Earth.", "Kar Ming Moo is on Facebook. Join Facebook to connect with Kar Ming Moo and others you may know. Facebook gives people the power to share and makes the", "The orange-bellied parrot is a small parrot endemic to southern Australia, and one of only three species of parrot that migrate.", "The tiger is the largest living cat species and a member of the genus Panthera. It is most recognisable for its dark vertical stripes on orange fur with a white underside. "]

    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        self.hideKeyboardWhenTappedAround()
        let screenPathDict: [String : Any] = ["screenPath" : "Home Screen/Data Collection Screen/Feed Screen"]
//        DocereeMobileAds.shared().sendData(data: screenPathDict)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupTableView() {
        for i in 0..<10 {
            tableview.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "cellId-\(i)")
        }
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)

        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 85),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId-\(indexPath.row)", for: indexPath) as! FeedCell

        cell.delegate = self
        cell.tag = indexPath.row
        cell.nameTitle.text = animalsTitles[indexPath.row]
        cell.imageV.image = UIImage(named: animalsImgNamse[indexPath.row])
        cell.descriptionLabel.text = animalsDesc[indexPath.row]
        cell.commentTV.delegate = self
        return cell
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }

    func getLikeClicked(index: Int) {
        print("Index: ", index)
        let event = "liked: " + animalsTitles[index]
        sendEvent(key: "lik", event: event)
    }
    
    func getCommentClicked(index: Int) {
        print("Index: ", index)
    }
    
    func getShareClicked(index: Int) {
 
        let alertController = UIAlertController(title: "Alert!", message: "Do you really want to share this article?", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) {
            UIAlertAction in
            let event = "shared: " + self.animalsTitles[index]
            self.sendEvent(key: "shr", event: event)
            print("Index: ", index)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func getSendClicked(index: Int, text: String) {
        let event = "commented: " + animalsTitles[index]
        sendEvent(key: "cmt", event: event)
        print("Index: ", index)
    }

    func sendEvent(key: String, event: String) {
        let eventDict: [String : String] = [key : event,
                                       "pid" : "909090",
                                       "oif" : "jh998989",
                                       "pro" : "98098", 
                                       "enc" : "0980908",
                                       "enx" : "enx",
                                       "scd" : "60"
                                       ]
        let json: [String : Any] = ["event" : eventDict]
//        DocereeMobileAds.shared().sendData(data: json)
    }
}
