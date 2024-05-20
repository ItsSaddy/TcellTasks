//
//  FinalScreenController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 16/05/24.
//

import Foundation
import UIKit

class CompleteTaskViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var objectLabel: UILabel!
    @IBOutlet weak var numberIdLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    let placeholderText = "Ваш комментарий..."
    var task: TaskResponse?
    
    static func storyboardInstance() -> CompleteTaskViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! CompleteTaskViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
    }
    
    func setupData() {
        guard let task = task else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        objectLabel.text = task.obj
        dateLabel.text = dateFormatter.string(from: task.date)
        numberIdLabel.text = task.id.description
    }
    
}

extension CompleteTaskViewController {
    func setupViews(){
        textView.delegate = self
        textView.text = placeholderText
        textView.textColor = UIColor.lightGray
    }
}

//MARK: Placeholder Text
extension CompleteTaskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
    
}
