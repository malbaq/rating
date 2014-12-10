//
//  ViewController.swift
//  Rating
//
//  Created by Tom Malary on 11/17/14.
//  Copyright (c) 2014 ProFreX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var votingStatus: Bool?
    
    var controlDate = NSUserDefaults.standardUserDefaults().objectForKey("controlDate") as? NSDate
    
    @IBOutlet var evkurov: UIImageView!
    
    @IBAction func yesButtonPressed(sender: AnyObject) {
        
        //Check if votingStatus is true
        if votingStatus == true {
        
            var score = PFObject(className: "score")
            score.setObject(1, forKey: "vote")
            score.saveInBackgroundWithBlock{
                (succes: Bool!, error: NSError!) -> Void in
                if succes == true {
                    println("Done with ID \(score.objectId)")
                    //update NSUserdefaults
                    NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "controlDate")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    self.votingStatus = false
                } else {
                    println(error)
                }
            }
        } else {
            //alert
            var alert = UIAlertController(title: "Превышен лимит голосования", message: "Вы можете проголосовать только 1(один) раз в сутки. Последний раз Вы голосовали \(self.controlDate!) (Гринвич).", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
            println("Status is \(votingStatus)")
        }
    }

    @IBAction func noButtonPressed(sender: AnyObject) {
        
        //Check if votingStatus is true
        if votingStatus == true {
        
            var score = PFObject(className: "score")
            score.setObject(0, forKey: "vote")
            score.saveInBackgroundWithBlock{
                (succes: Bool!, error: NSError!) -> Void in
                if succes == true {
                    println("Done with ID \(score.objectId)")
                    //update NSUserdefaults
                    NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "controlDate")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    self.votingStatus = false
                } else {
                    println(error)
                }
            }
        } else {
            //alert
            var alert = UIAlertController(title: "Превышен лимит голосования", message: "Вы можете проголосовать только 1(один) раз в сутки. Последний раз Вы голосовали \(self.controlDate!) (Гринвич).", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)

            println("Status is \(votingStatus)")
        }
    }
    
    @IBOutlet var currentRating: UILabel!
    
    @IBOutlet var numberOfVotes: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // Find if user haven't already voted within 1 day so if his/her voting status true
        
        var timeInterval = controlDate?.timeIntervalSinceNow
        var dayInSeconds = 24.0 * -3600
        
        //debug
        println(votingStatus)

        if controlDate == nil {
            votingStatus = true
        } else {
            if timeInterval > dayInSeconds {
                votingStatus = false
            } else {
                votingStatus = true
            }
        }
        
        //debug
        println(votingStatus)
        println(controlDate)
        println(timeInterval)
        
        // image loading code

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