//
//  FeedCell.swift
//  DocereeiOSMainNew
//
//  Created by Muqeem.Ahmad on 11/10/22.
//

import UIKit

class FeedCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    var isLiked = false
    var placeholder = "Add a comment..."
    @IBOutlet weak var commentMainView: UIView!
    @IBOutlet weak var commentTV: UITextView!
    
    var delegate: FeedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
                self.commentTV.delegate = self
                self.commentTV.textColor = .lightGray
        
                self.commentMainView.layer.borderColor = UIColor.purple.cgColor
                self.commentMainView.layer.borderWidth = 2
                self.commentMainView.layer.cornerRadius = self.commentMainView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.commentTV.delegate = self
        // Configure the view for the selected state
    }

    required init?(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @IBAction func likeClicked(_ sender: Any) {
        self.delegate?.getLikeClicked(index: self.tag)
    }
    
    @IBAction func commentClicked(_ sender: Any) {
//        self.delegate?.getCommentClicked(index: self.tag)
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        self.delegate?.getShareClicked(index: self.tag)
    }
    
    @IBAction func sendClicked(_ sender: Any) {
        if !(placeholder.isEmpty || placeholder == "Add a comment...") {
            self.delegate?.getSendClicked(index: self.tag, text: placeholder)
            commentTV.text = "Add a comment..."
            commentTV.textColor = UIColor.lightGray
            placeholder = ""
        }
        print("Data:", placeholder)
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty {
            textView.text = "Add a comment..."
            textView.textColor = UIColor.lightGray
            placeholder = ""
        } else {
            placeholder = textView.text
        }
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        placeholder = textView.text
    }
}

protocol FeedCellDelegate {
    func getLikeClicked(index: Int)
    func getShareClicked(index: Int)
    func getSendClicked(index: Int, text: String)
}
