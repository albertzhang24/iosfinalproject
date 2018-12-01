//
//  TopicViewController.swift
//
//  Created by Albert Zhang on 11/7/18.
//  Copyright © 2018 Albert Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth

class TopicViewController: UIViewController {
    
    
    @IBOutlet weak var entertainment: UIButton!
    @IBOutlet weak var music: UIButton!
    @IBOutlet weak var health: UIButton!
    @IBOutlet weak var travel: UIButton!
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var fashion: UIButton!
    @IBOutlet weak var politics: UIButton!
    @IBOutlet weak var misc: UIButton!
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(withIdentifier: "loginVC")
        self.tabBarController?.present(loginVC, animated: true, completion: nil)
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]; 
//Company100ViewController * vc = (Company100ViewController *)[sb instantiateViewControllerWithIdentifier:@"vc-identifier"];
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIButton {
            Global.categoriesIndex = TopicCategories(rawValue: button.tag)!
        }
    }

    
}

