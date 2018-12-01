//
//  QuestionViewController.swift
//
//
//  Created by Albert Zhang on 11/14/18.
//

import UIKit
import FirebaseDatabase

class QuestionViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var askQuestionLabel: UILabel!
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var submitQuestionButton: UIButton!
    
    var db: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.question.delegate = self
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn  range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier ==  "segueSubmitToAnswerVC" {
            if question.text.isEmpty {
                return false
            } else {
                return true
            }
            
        }else {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let answerVC = segue.destination as? AnswerViewController {
            if(segue.identifier == "segueSubmitToAnswerVC") {
                let ref = Database.database().reference()
                let questionText = question.text
                db = ref.child(Global.categories[Int(Float(Global.categoriesIndex.rawValue))]).childByAutoId()
                db?.setValue(["question": questionText])
                answerVC.db = db
                answerVC.receivedQuestion = questionText
            }else if(segue.identifier == "segueToAnswerVC") {
                // do nothing
            }
        }
    }
    
}
