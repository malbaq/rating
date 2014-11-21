//
//  ViewController.swift
//  Rating
//
//  Created by Tom Malary on 11/17/14.
//  Copyright (c) 2014 ProFreX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var evkurov: UIImageView!
    
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

