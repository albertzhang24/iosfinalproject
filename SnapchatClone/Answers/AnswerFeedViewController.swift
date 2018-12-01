//
//  AnswerFeedViewController.swift
//  FinalProject
//
//  Created by Albert Zhang on 11/28/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AnswerFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var answers: [String] = []
    
    @IBOutlet weak var answerFeedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerFeedTableView.dataSource = self
        self.answerFeedTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as? AnswerFeedTableViewCell
        cell?.answer.text = answers[indexPath.row]
        return cell!
    }
    

}
