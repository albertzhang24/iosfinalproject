//
//  AnswerViewController.swift
//  FinalProject
//
//  Created by Albert Zhang on 11/25/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AnswerViewController: UIViewController {
    
    let currentUser = CurrentUser()
    var receivedQuestion: String?
    var db: DatabaseReference?
    @IBOutlet weak var randomQuestion: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let unwrappedQuestion = receivedQuestion {
            randomQuestion.text = unwrappedQuestion
        }else {
            retrieveRandomQuestion()
        }
        
    }
    
    func retrieveRandomQuestion() {
        let ref = Database.database().reference()
        self.randomQuestion.text = ""
        self.answer.text = ""
        ref.child(Global.categories[Int(Float(Global.categoriesIndex.rawValue))]).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            if let value = snapshot.value as? [String: [String:String]] {
                let totalNumberOfQuestions = value.keys.count
                var randomIndex = arc4random_uniform(UInt32(totalNumberOfQuestions)) + 1;
                var randomKey:String?
                for key in value.keys {
                    randomKey = key
                    randomIndex -= 1
                    if(randomIndex <= 0) {
                        break
                    }
                }
                
                self!.db = ref.child(Global.categories[Int(Float(Global.categoriesIndex.rawValue))]).child(randomKey ?? "")
                self!.receivedQuestion = value[randomKey!]!["question"]
                DispatchQueue.main.async {[weak self] in
                    self?.randomQuestion.text = self!.receivedQuestion
                }
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func anotherQuestionPressed(_ sender: Any) {
        retrieveRandomQuestion()
    }
    
    @IBOutlet weak var answer: UITextView!
    @IBOutlet weak var anotherQuestion: UIButton!
    
    @IBAction func submitAnswer(_ sender: Any) {
        if let dbUnwrapped = db {
            if !answer.text.isEmpty {
                dbUnwrapped.updateChildValues(["Answer " + Global.categories[Int(Float(Global.categoriesIndex.rawValue))] +  currentUser.username: answer.text])
                
            }
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
    
}
