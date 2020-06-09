//
//  CountyViewController.swift
//  CovidTracker
//
//  Created by Rahul on 5/21/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit

class CountyViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    @IBOutlet weak var deathLabel: UILabel!
    
    @IBOutlet weak var caserLabel: UILabel!
    @IBOutlet weak var hosLabel: UILabel!
    @IBOutlet weak var morLabel: UILabel!
    @IBOutlet weak var caseCLabel: UILabel!
    @IBOutlet weak var deathCLabel: UILabel!
    @IBOutlet weak var caserCLabel: UILabel!
    @IBOutlet weak var hosCLabel: UILabel!
    @IBOutlet weak var countyLookup: UILabel!
    @IBOutlet weak var selectacounty: UILabel!
    
    
    
    
    var counties: [String] = ["Fairfield", "Hartford", "Litchfield", "Middlesex", "New Haven", "New London", "Tolland", "Windham"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    override func viewDidAppear(_ animated: Bool) {
        
        countyLookup.center.x -= view.bounds.width
        selectacounty.center.x += view.bounds.width
        
    
        
            super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0, delay: 0.5,
                                   usingSpringWithDamping: 0.3,
                                   initialSpringVelocity: 0.5,
                                   options: [], animations: {
            self.selectacounty.center.x -= self.view.bounds.width
            self.countyLookup.center.x += self.view.bounds.width
            }, completion: nil)
        countyPicker.alpha = 0.0
        UIView.animate(withDuration: 1.0, delay: 1.0,
                               options: [],
                               animations: {
        self.countyPicker.alpha = 1.0
            }, completion: nil)
        
        


  
          
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        counties.count
    }
    
    @IBOutlet weak var countyPicker: UIPickerView!
    @IBOutlet weak var countyName: UILabel!
    
    var curDay: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getData(county: "Fairfield")
        countyPicker.selectRow(4, inComponent:0, animated:true)
        countyPicker.dataSource = self
        countyPicker.delegate = self

        // Do any additional setup after loading the view.
    }
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
       
       switch traitCollection.userInterfaceStyle {
           case .light, .unspecified:
               UIApplication.shared.windows.forEach { window in
                   window.overrideUserInterfaceStyle = .dark
                 
               }
           case .dark:
               UIApplication.shared.windows.forEach { window in
                   window.overrideUserInterfaceStyle = .light
               }
       @unknown default:
           UIApplication.shared.windows.forEach { window in
               window.overrideUserInterfaceStyle = .dark
           }
           
       }
       
       
         
              
          }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return counties[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCounty = counties[row]
        countyName.text = "Displaying Results for \(selectedCounty)"
        getData(county: selectedCounty)
    }
    
    func getData(county: String){

               //right.isHidden = true

                  // let cday2 = 0

                   let url = URL(string: "https://data.ct.gov/resource/bfnu-rgqt.json")!
                           //starting new task
                           URLSession.shared.dataTask(with: url){(data, response, error) in

                               //trying to decode from JSON
                               do {

                                   let decoder = JSONDecoder()
                                let odataFromDates = try decoder.decode([countiesData].self, from: data!)
                                //let odataFromDates = try decoder.decode([countyData.self], from: data!)
                   //                let firstpop = dataFromDates[self.passer]._2020_total!


                                   let sequence = stride(from: 0, to: 7, by: 1)


                                   for x in sequence {
                                       let trimmedString = odataFromDates[x].county!.trimmingCharacters(in: .whitespacesAndNewlines)

                                       if county.isEqual(trimmedString) {
                                        DispatchQueue.main.async {
                                            var currentPopulation: String
                                            switch county {
                                            case "Fairfield":
                                                currentPopulation = "944,348"
                                                break
                                            case "Hartford":
                                                currentPopulation = "894,730"
                                                break
                                                
                                            case "Litchfield":
                                                currentPopulation = "183,031"
                                                break
                                            case "Windham":
                                                currentPopulation = "116,538"
                                                break
                                            case "Middlesex":
                                                currentPopulation = "163,368"
                                                break
                                            case "New Haven":
                                                currentPopulation = "859,339"
                                                break
                                            case "New London":
                                                currentPopulation = "268,881"
                                                break
                                            case "Tolland":
                                                currentPopulation = "151,269"
                                                break
                                            
                                            default:
                                                currentPopulation = "n/a"
                                            }
                                            self.populationLabel.text = currentPopulation
                                            
//
                                             let Intcase = Float(odataFromDates[x].cases!)
//                                               let IntcaseChange = Float(odataFromDates[x+(169*cday2)].confirmedcases!)! - Float(odataFromDates[x+(169*(cday2+1))].confirmedcases!)!
                                              let numberFormatter3 = NumberFormatter()
                                              numberFormatter3.numberStyle = .decimal
                                              let totalcase = numberFormatter3.string(from: NSNumber(value:Intcase!))
//                                               let Intdeaths = Float(odataFromDates[x+(169*cday2)].deaths!)
                                               let IntdeathChange = Float(odataFromDates[x].deaths!)! - Float(odataFromDates[x+8].deaths!)!
                                               let IntcaseChange = Float(odataFromDates[x].cases!)! - Float(odataFromDates[x+8].cases!)!
                                            self.totalCasesLabel.text = totalcase
                                            
                                            let IntDeaths = Float(odataFromDates[x].deaths!)
                                            let totaldeaths = numberFormatter3.string(from: NSNumber(value:IntDeaths!))
                                            let stringdc = numberFormatter3.string(from: NSNumber(value:IntdeathChange))
                                            let casedc = numberFormatter3.string(from: NSNumber(value:IntcaseChange))
                                            self.deathLabel.text = totaldeaths
                                            let IntcaseRate = Float(odataFromDates[x].caserates!)
                                            let totalcaser = numberFormatter3.string(from: NSNumber(value:IntcaseRate!))
                                            self.caserLabel.text = totalcaser
                                            
                                            let inthos = Float(odataFromDates[x].hospitalization!)
                                            let totalhoser = numberFormatter3.string(from: NSNumber(value:inthos!))
                                            self.hosLabel.text = totalhoser
                                            let mortalityRatioF = (IntDeaths!/Intcase!)*100
                                            let mortalityRatioS = String(format: "%.1f", mortalityRatioF)
                                            self.morLabel.text = mortalityRatioS + "%"
                                           
                                            if IntcaseChange >= 0 {
                                                self.caseCLabel.text = "(+" + casedc! + ")"
                                                self.caseCLabel.textColor = .systemGreen
                                                
                                            } else if IntcaseChange < 0{
                                                self.caseCLabel.text = "(" + casedc! + ")"
                                                self.caseCLabel.textColor = .systemRed
                                                
                                            }
                                            if IntdeathChange >= 0 {
                                                self.deathCLabel.text = "(+" + stringdc! + ")"
                                                self.deathCLabel.textColor = .systemGreen
                                                
                                            } else if IntdeathChange < 0{
                                                self.deathCLabel.text = "(" + stringdc! + ")"
                                                self.deathCLabel.textColor = .systemRed
                                                
                                            }
                                            
//                                            self.deathCLabel.text = stringdc
//                                            self.caseCLabel.text = casedc
                                            
                                            
                                            
//                                               self.deaths.text =  numberFormatter3.string(from: NSNumber(value:Intdeaths!))
//                                               let IntcaseRate = Float(odataFromDates[x+(169*cday2)].caserate)
//                                               let IntcaserateChange = Float(odataFromDates[x+(169*cday2)].caserate)! - Float(odataFromDates[x+(169*(cday2+1))].caserate)!
//                                               self.caserate.text =  numberFormatter3.string(from: NSNumber(value:IntcaseRate!))
//                                               let morRatio = (Intdeaths!/Intcase!)*100
//                                               _ = Float(odataFromDates[x+(169*(cday2+1))].deaths!)



                                              




                                               }




                                       }
           //


                                   }

                        

                               }
                               catch {

                                   print(error)
                               }


                           }.resume()
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
//class countyData: Decodable {
//
//    let cases: String?
//    let county: String?
//
//
//
//
//
//enum CodingKeys: String, CodingKey {
//
//
//    case cases = "cases"
//    case county = "county"
//
//
//
//
//}
//}
class countiesData: Decodable {
    
let county: String?
let cases: String?
    let deaths: String?
    let caserates: String?
    let hospitalization: String?
    
enum CodingKeys: String, CodingKey {
    
    case county = "county"
    case cases = "cases"
    case deaths = "deaths"
    case caserates = "caserates"
    case hospitalization = "hospitalization"
}
    
}
