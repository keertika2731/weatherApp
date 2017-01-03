//
//  ViewController.swift
//  weatherApp
//
//  Created by Keertika Gupta on 29/12/16.
//  Copyright © 2016 Keertika Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func submitAction(_ sender: Any)
    {
        var message = String()
        super.viewDidLoad()
        let url = URL(string:"http://www.weather-forecast.com/locations/" + searchTextfield.text! + "/forecasts/latest")!
        let request = NSMutableURLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {
            data, response, error in
            if error != nil
            {
                print(error)
            }
            else
            {
                if let unwrappedData = data
                {
                    let dataString = NSString(data: unwrappedData , encoding: String.Encoding.utf8.rawValue)
                    //print (dataString)
                    var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    if let contentArray = dataString?.components(separatedBy: stringSeparator)
                    {
                        //print(dataString)
                        if contentArray.count > 0
                        {
                            stringSeparator = "</span>"
                            let newcontentArray = contentArray[1].components(separatedBy: stringSeparator)
                            if newcontentArray.count > 0
                            {
                                message = newcontentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                print(message)
                            }
                        }
                        
                        
                        
                    }
                }
            }
            
            if message == " "
            {
                message =  "The place couldn't be found . Please try again"
            }
            DispatchQueue.main.sync(execute:
                {
                    self.resultLabel.text = message
            })
            
            
        }
        
        task.resume()

    }
    
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
            }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

