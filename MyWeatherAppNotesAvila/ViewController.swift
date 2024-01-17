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
    
    @IBOutlet weak var winspeOutlet: UILabel!
    
    @IBOutlet weak var windirOutlet: UILabel!
    
    @IBOutlet weak var sunsetOutlet: UILabel!
    
    var s = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeather()
        // Example usage
        let timestamp: TimeInterval = 1705445170 // Replace this with your timestamp
        let formattedTime = convertTimestampToTime(timestamp: timestamp)
        print("Formatted Time: \(formattedTime)")
        sunsetOutlet.text = "Formatted Time: \(formattedTime)"
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
 if let wind = jsonObj.value(forKey: "wind") as? NSDictionary{
       if let speed = wind.value(forKey: "speed") as? Double{
       print(speed)
                                
        DispatchQueue.main.async {
            self.winspeOutlet.text = "Wind Speed: \(speed)"
                            }
                        }
     if let degree = wind.value(forKey: "deg") as? Double{
     print(degree)
                              
      DispatchQueue.main.async {
          if degree < 90 && degree > 0{
              self.windirOutlet.text = "Direction: Northeast"
          }else if degree == 90
          {
              self.windirOutlet.text = "Direction: North"
          }else if degree == 0
          {
              self.windirOutlet.text = "Direction: East"
          }else if degree < 180
          {
              self.windirOutlet.text = "Direction: Northwest"
          }else if degree == 180
          {
              self.windirOutlet.text = "Direction: West"
          }else if degree < 270
          {
              self.windirOutlet.text = "Direction: Southwest"
          }else if degree == 270
          {
              self.windirOutlet.text = "Direction: South"
          }else if degree < 360
          {
              self.windirOutlet.text = "Direction: Southeast"
          }else if degree == 360
          {
              self.windirOutlet.text = "Direction: East"
          }
         
                          }
                      }
                    }
                        
                        
                        
                        
                        
                    }
                }
                
            }
            
        }
        
        
        dataTask.resume()

        
        
        
    }
    
    func convertTimestampToTime(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .none
        
        return dateFormatter.string(from: date)
    }

    
    
}
