//
//  ViewController.swift
//  DemoApplication
//
//  Created by giginet on 12/11/15.
//  Copyright © 2015 giginet. All rights reserved.
//

import UIKit
import CoreFoundation
import UIKit
import WakaTimeAPIClient
import APIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let today = NSDate()
        let oneWeeksAgo = NSDate(timeIntervalSinceNow: -7 * 24 * 60 * 60)
        var request = LanguageRequest(startDate:oneWeeksAgo , endDate: today)
        request.apiKey = ""
        
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let response):
                print(response)
            case .Failure(let error):
                print("error: \(error)")
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

