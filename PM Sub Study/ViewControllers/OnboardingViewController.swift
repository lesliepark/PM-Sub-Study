//
//  OnboardingViewController.swift
//  PM Sub Study
//
//  Created by Travis Allen on 12/12/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit
import ResearchKit
import Foundation

class OnboardingViewController: UIViewController {
    var store: RSStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.store = RSStore()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        var isEligible = true
        var isConsented = false
        var hasSetGeofence = false
        var hasSetSurvey = false
        
        
        if (self.store.valueInState(forKey: "isEligible") != nil) {
            isEligible = self.store.valueInState(forKey: "isEligible") as! Bool
        }
        if (self.store.valueInState(forKey: "isConsented") != nil) {
            isConsented = self.store.valueInState(forKey: "isConsented") as! Bool
        }
        if (self.store.valueInState(forKey: "hasSetGeofence") != nil) {
            hasSetGeofence = self.store.valueInState(forKey: "hasSetGeofence") as! Bool
        }
        if (self.store.valueInState(forKey: "hasSetSurvey") != nil) {
            hasSetSurvey = self.store.valueInState(forKey: "hasSetSurvey") as! Bool
        }
        
        if (!isEligible) {
            self.performSegue(withIdentifier: "doEligibilitySegue", sender: nil)
        }
        else if (!isConsented) {
            //self.prepareForSegue(segueIdentifier: "doConsentSegue", sender: nil: , sender: )
            self.performSegue(withIdentifier: "doConsentSegue", sender: nil)
        }
        else if (!hasSetGeofence) {
            self.performSegue(withIdentifier: "doGeofenceSegue", sender: nil)
        }
        else if (!hasSetSurvey) {
            self.performSegue(withIdentifier: "doSurveyTimeSetSegue", sender: nil)
        }
        else {
            print("User is already onboarded")
            let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            let vc = storyboard.instantiateInitialViewController()
            appDelegate?.transition(toRootViewController: vc!, animated: true)
        }
        // Do any additional setup after loading the view, typically from a nib.
        //        var isConsented : Bool = false
        //        self.store = RSStore()
        //        if (self.store.valueInState(forKey: "isConsented") != nil) {
        //            isConsented = self.store.valueInState(forKey: "isConsented") as! Bool
        //        }
        //        if(isConsented){
        //            self.performSegue(withIdentifier: "consentCompleteSegue", sender: nil)
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if you've navigated directly from home screen, and not from the previous onboarding task, you shouldn't be able to go back
        if (segue.identifier == "doConsentSegue" ) {
            let consentVC = segue.destination as? ConsentViewController
            consentVC?.navigationItem.hidesBackButton = true
        }
        else if (segue.identifier == "doGeofenceSegue") {
            let geofenceVC = segue.destination as? GeofenceSetViewController
            geofenceVC?.navigationItem.hidesBackButton = true
        }
        else if (segue.identifier == "doSurveyTimeSetSegue") {
            let surveyTimeVC = segue.destination as? SurveyTimesViewController
            surveyTimeVC?.navigationItem.hidesBackButton = true
        }
    }
    
}
