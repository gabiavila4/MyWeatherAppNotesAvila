//
//  ViewController.swift
//  MyWeatherAppNotesAvila
//
//  Created by GABRIELA AVILA on 1/8/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var weatherLabel1: UILabel!
    
    @IBOutlet weak var maxOutlet: UILabel!
    
    @IBOutlet weak var minOutlet: UILabel!
    
    @IBOutlet weak var humOutlet: UILabel!
    
    
    
    var s = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeather()
        
    }
    
    func getWeather(){
        //creating an object of the URL session
        let session = URLSession.shared
        //creating URL for api call (you need your apikey)
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=42.24&lon=-88.31&units=imperial&appid=bbf2ff1df6a3c1363350af2c8d5a85f1")!
        
        // Making an api call and creating data in the completion handler
        let dataTask = session.dataTask(with: weatherURL) {
            // completion handler: happens on a different thread, could take time to get data
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let e = error {
                print("Error:\n\(e)")
            } else {
                // if there is data
                if let d = data {
                    // convert data to json Object
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? NSDictionary {
                        // print the jsonObj to see structure
                        print(jsonObj)
                        if let main = jsonObj.value(forKey: "main") as? NSDictionary{
                            if let temp = main.value(forKey: "temp") as? Double{
                                print(temp)
                                
                                //making it happen on the main thread, waiting for data before it shows up on screen
                                DispatchQueue.main.async {
                                    self.weatherLabel1.text = "\(temp)"
                                }
                                
                            }
                            if let maxtemp = main.value(forKey: "temp_max") as? Double{
                                print (maxtemp)
                                DispatchQueue.main.async {
                                    self.maxOutlet.text = "Max: \(maxtemp)"
                                }
                            }
                            if let mintemp = main.value(forKey: "temp_min") as? Double{
                                print(mintemp)
                                DispatchQueue.main.async {
                                    self.minOutlet.text = "Min: \(mintemp)"
                                }
                            }
                            if let humlevel = main.value(forKey: "humidity") as? Double{
                                print(humlevel)
                                DispatchQueue.main.async {
                                    self.humOutlet.text = "Humidity Level: \(humlevel)"
                                }
                            }
                            
                            
                            
                        }
                    }
                }
                
            }
            
        }
        
        
        dataTask.resume()

        
        
        
    }
    func convertUnixTimestampToDateTime(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "CST") // Set the desired time zone
        
        return dateFormatter.string(from: date) + "CST"
    }

    let timestamp: TimeInterval = 1705012831 // Replace this with your Unix timestamp
    let formattedDateTime = convertUnixTimestampToDateTime(timestamp: timestamp)

    print(formattedDateTime)
    
}
