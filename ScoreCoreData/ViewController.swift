//
//  ViewController.swift
//  ScoreCoreData
//
//  Created by ashi on 5/12/20.
//  Copyright © 2020 Ashika Palacharla. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score = Int() //variable for score set as integer

    // Loads at initialization
    override func viewDidLoad() {
        getData() //calls to get data method to get scores that are stored
        scoreLabel.text = "\(score)"
        super.viewDidLoad()
    }
    
    @IBAction func increaseScore(sender: UIButton) {
        score += 1
        scoreLabel.text = "\(score)"
    }
    
    @IBAction func saveScore(sender: UIButton) {
        //method sends data up to core data storage
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ScoreData", in: context)
        //renaming ScoreData as entity
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        //data will be saved up to replace base entity
        
        newEntity.setValue(score, forKey: "number")
        
        do {
            try context.save()
            print("saved + ur vibing")
        } catch {
            
            print("failed to save + u messed up lol")
        }

    }
    
    func getData() {
        //brings the data back down from the storage
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ScoreData")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            //fetches all the data in the array where you are storing
            for data in result as! [NSManagedObject]
            //setting the score to be the last item in the array
            {
                score = data.value(forKey: "number") as! Int
            }
        } catch {
                print("data fetch failed")
        }
    }
    
}

