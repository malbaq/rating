//
//  ViewController.swift
//  Rating
//
//  Created by Tom Malary on 11/17/14.
//  Copyright (c) 2014 ProFreX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /* Set up var to save timestamp. Initial == 0 */
    
    /* Add link to y/n buttons and code to submit when yesButtonpressed then if timervar > 1 day then ask for confirmation on action and store click */
    
    /* Confidence rating query for special db class build with corrections */
    
    /* Query for number of the votes for another special db class */

    @IBOutlet var evkurov: UIImageView!
    
    @IBAction func yesButtonPressed(sender: AnyObject) {
        
        var score = PFObject(className: "score")
        score.setObject(1, forKey: "vote")
        score.saveInBackgroundWithBlock{
            (succes: Bool!, error: NSError!) -> Void in
            if succes == true {
                println("Done with ID \(score.objectId)")
            } else {
                println(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        let url = NSURL(string: "http://www.ingushetia.ru/images/president3.jpg")
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            if error != nil {
            
                println("fuck off")
                
            } else {
            
                let image = UIImage(data: data)
                
                self.evkurov.image = image
            
            }
        
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

