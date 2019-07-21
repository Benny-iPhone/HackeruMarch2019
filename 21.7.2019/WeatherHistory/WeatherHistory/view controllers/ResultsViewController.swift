//
//  ResultsViewController.swift
//  WeatherHistory
//
//  Created by hackeru on 21/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import Alamofire

class ResultsViewController: UIViewController {
    
    struct Params{
        let from : Date
        let to : Date
        let cityId : String = "281184"
    }
    
    var params : Params!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData()
    }
    
    func fetchData(){
        guard let params = self.params else { return }
        
        //https://samples.openweathermap.org/data/2.5/history/city?id=293397&type=hour&appid=b1b15e88fa797225412429c1c50c122a1
        
        let url = "https://api.openweathermap.org/data/2.5/history/city"
        let queryParams : [String:Any] = [
            "id":params.cityId,
            "type":"hour",
            "appid":"3562a136251c60df090d91bb5048b42a",
            "start":Int(params.from.timeIntervalSince1970),
            "end":Int(params.to.timeIntervalSince1970)
        ]
        
        Alamofire.request(url, method: .get, parameters: queryParams).responseJSON { (response) in
            guard let json = response.value as? [String:Any] else{
                return
            }
            
            print(json)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
