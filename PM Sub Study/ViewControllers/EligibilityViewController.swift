//
//  EligibilityViewController.swift
//  PM Sub Study
//
//  Created by Travis Allen on 12/12/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit
import ResearchKit
import ResearchSuiteTaskBuilder
import ResearchSuiteAppFramework

class EligibilityViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var eligibilityAssessmentItem: RSAFScheduleItem!
    var store: RSStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Eligibility"
        self.store = RSStore()
        self.navigationItem.hidesBackButton = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func checkEligibilityTapped(_ sender: UIButton) {
        //        self.eligibilityAssessmentItem = AppDelegate.loadScheduleItem(filename:"eligibility.json")
        //        self.launchActivity(forItem: (self.eligibilityAssessmentItem)!)
        
        let taskViewController = ORKTaskViewController(task: EligibilityTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
}

extension EligibilityViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        
        
        taskViewController.dismiss(animated: true, completion: nil)
        
        if reason == .completed {
            var allYes : Bool = true
            
            let taskResult = taskViewController.result
            
            let taskResultS = taskViewController.result.results
            
            for stepResults in taskResultS! as! [ORKStepResult]
            {
                for result in stepResults.results!
                {
                    print(result.identifier)
                    let eligAnswerResult = result as! ORKBooleanQuestionResult
                    let answer = eligAnswerResult.booleanAnswer!
                    
                    print(answer)
                    
                    if answer == 0 {
                        allYes = false
                    }
                    
                }
            }
            print("Eligibility Complete")
            if (allYes) {
                print("Is Eligible")
                self.store.set(value: true as NSSecureCoding, key: "isEligible")
                self.performSegue(withIdentifier: "isEligibleSegue", sender: nil)
            }
            else {
                print("Is Ineligible")
                self.performSegue(withIdentifier: "isIneligibleSegue", sender: nil)
            }
        }
    }
    
}
