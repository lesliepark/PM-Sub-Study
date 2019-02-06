//
//  HomeViewController.swift
//  PM Sub Study
//
//  Created by Travis Allen on 12/12/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit
import ResearchKit
import ResearchSuiteResultsProcessor
import Gloss
import ReSwift

class HomeViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var sqMgr: SurveyQueueManager!
    
    @IBOutlet weak var tableView: UITableView!
    
    var surveyQueue: [Survey]!
    var outstandingSurveys: [Survey]!
    
    var store: RSStore!
    
    var curSurveyId: String!
    
    var curSurveyName: NSString! // HACKY WORK-AROUND WHICH ONLY WORKS IF THERE IS ONE OF EACH TYPE OF SURVEY
    
    @objc func settingsItemClicked()
    {
        self.performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.store = RSStore()
        self.sqMgr = SurveyQueueManager()
        
        self.title = "Home"
        self.navigationItem.hidesBackButton = true
        
        //This definition has to be in the viewDidLoad func to work, apparently.
        let rightBarButtonItem: UIBarButtonItem = {
            //programmatically make segue to the Settings ViewController
            let barButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(HomeViewController.settingsItemClicked))
            
            return barButtonItem
        }()
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //retrieve the surveys from the stored surveys
        self.sqMgr.updateSurveyQueue() //make sure it's up to date
        if (outstandingSurveys != nil) {
            outstandingSurveys.removeAll()
        }
        outstandingSurveys = self.sqMgr.getOutstandingSurveys()
        tableView.reloadData()
    }
    
    
    func markAsComplete(surveyName : NSString) {
        var curQ = self.store.valueInState(forKey: "surveyQueue") as! [Survey]
        var updatedSurveyQ : [Survey] = []
        
        for survey in curQ {
            if (survey.Name == surveyName) {
                survey.IsComplete = true
            }
            updatedSurveyQ.append(survey)
        }
        
        self.store.setValueInState(value: updatedSurveyQ as! NSSecureCoding, forKey: "surveyQueue")
        
    }
    
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
    func isOutstanding(surveyName: NSString) -> Bool {
        var isOutstanding = false
        for survey in outstandingSurveys {
            if (survey.Name == surveyName) {
                isOutstanding = true
                break
            }
        }
        return isOutstanding
    }
    
    //NOT USED NOW
//    @objc func surveyClicked(survey : Survey ){ //figure out how to pass survey parameter thru selector
//        curSurveyId = String(UInt(bitPattern: ObjectIdentifier(survey)))
//        var surveyTVC : ORKTaskViewController!
//
////        if var topController = UIApplication.shared.keyWindow?.rootViewController {
////            while let presentedViewController = topController.presentedViewController {
////                topController = presentedViewController
////            }
////
////            // topController should now be your topmost view controller
////        }
//
//        if (survey.Name == "Standardized Survey") {
//            surveyTVC = ORKTaskViewController(task: StandardSurveyTask, taskRun: nil)
//        }
//        else if (survey.Name == "Well-Being Survey") {
//            surveyTVC = ORKTaskViewController(task: WellBeingSurveyTask, taskRun: nil)
//        }
//        else if (survey.Name == "Side-Effects Survey") {
//            surveyTVC = ORKTaskViewController(task: SideEffectSurveyTask, taskRun: nil)
//        }
//        print("SELF")
//        print(self)
//        surveyTVC.delegate = self
//        present(surveyTVC, animated: true, completion: nil)
//    }
    
    @objc func standardSurveyClicked(sender: UIButton)
    {
        
        curSurveyName = "Standardized Survey"
        if (!isOutstanding(surveyName: "Standardized Survey")) {
            return
        }
        let topVC = topMostController()
        let taskViewController = ORKTaskViewController(task: StandardSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        topVC.present(taskViewController, animated: true, completion: nil)
    }
    
    @objc func wbSurveyClicked()
    {
        curSurveyName = "Well-Being Survey"
        if (!isOutstanding(surveyName: "Well-Being Survey")) {
            return
        }
        let topVC = topMostController()
        let taskViewController = ORKTaskViewController(task: WellBeingSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        topVC.present(taskViewController, animated: true, completion: nil)
    }
    
    @objc func seSurveyClicked()
    {
        curSurveyName = "Side-Effects Survey"
        if (!isOutstanding(surveyName: "Side-Effects Survey")) {
            return
        }
        let topVC = topMostController()
        let taskViewController = ORKTaskViewController(task: SideEffectSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        topVC.present(taskViewController, animated: true, completion: nil)
    }
    
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        print("Table View func1 executed")
        print(outstandingSurveys.count)
        return outstandingSurveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print("Table View func2 executed")
        print(outstandingSurveys[indexPath.row])
        let survey = outstandingSurveys[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let displayDate = dateFormatter.string(from: survey.OpenDate as Date)
        
        
        let surveyName = survey.Name as! String
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell") as! SurveyCell
        cell.surveyButton.setTitle(surveyName,for: .normal)
        cell.surveyButton.contentHorizontalAlignment = .left
        cell.surveyDate.text = displayDate
        cell.surveyID = String(UInt(bitPattern: ObjectIdentifier(survey)))
        
        //print("Unique String: ")
        //print(cell.surveyID)
        if(surveyName == "Standardized Survey") {
            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.standardSurveyClicked), for: .touchUpInside)
        }
        else if (surveyName == "Well-Being Survey") {
            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.wbSurveyClicked), for: .touchUpInside)
        }
        else if(surveyName == "Side-Effects Survey") {
            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.seSurveyClicked), for: .touchUpInside)
        }
        
        return cell
    }
}

extension HomeViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        taskViewController.dismiss(animated: true, completion: nil)
        
        if reason == .completed {
            //create results transform object
            let taskResult = taskViewController.result
            
            let surveyRT = AppDelegate.getSurveyMapping()
            
            appDelegate!.resultsProcessor.processResult(taskResult: taskResult, resultTransforms: surveyRT)
            
            //REMOVE THIS SURVEY FROM THE SURVEY QUEUE
            markAsComplete(surveyName: curSurveyName)
        }
    }
    
}
