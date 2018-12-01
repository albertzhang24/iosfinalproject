//
//  QuestionFeedViewController.swift

//  Created by Albert Zhang on 11/7/18.
//  Copyright © 2018 Albert Zhang. All rights reserved.
//

import UIKit
import FirebaseDatabase

class QuestionFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var questions: [String] = []
    var answers: [String: [String]] = [:]
//    var previousCategory: String = ""
//    var IDs: [String] = []
    @IBOutlet weak var feedTableView: UITableView!
    var selectedIndexPath: IndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currentUser = CurrentUser()
        var db: DatabaseReference!
        db = Database.database().reference()
        //if Global.categories[Int(Float(Global.categoriesIndex.rawValue))] != previousCategory {
            questions = []
//            previousCategory = Global.categories[Int(Float(Global.categoriesIndex.rawValue))]
            db.child(Global.categories[Int(Float(Global.categoriesIndex.rawValue))]).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                if let snapshotDict = snapshot.value as? [String: [String:String]] {
                    for value in snapshotDict.values {
                        if let unwrappedQuestion = value["question"] {
                            self?.questions.append(unwrappedQuestion)
                            self?.answers[unwrappedQuestion] = []
                            for questionAnswers in value {
                                if(questionAnswers.key != "question") {
                                    self?.answers[unwrappedQuestion]?.append(questionAnswers.value)
                                }
                            }
                        }
                        
                    }
                    DispatchQueue.main.async
                        {[weak self] in
                            self?.feedTableView.reloadData();
                    }
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        //}
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? QuestionFeedTableViewCell
        cell?.question.text = self.questions[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "segueToAnswerFeedVC", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vcAnswerFeed = segue.destination as? AnswerFeedViewController {
            vcAnswerFeed.answers = self.answers[questions[selectedIndexPath!.item]] ?? []
        }
    }

    
    
}
