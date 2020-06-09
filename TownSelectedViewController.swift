//
//  TownSelectedViewController.swift
//  CovidTracker
//
//  Created by Rahul on 5/17/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

class TownSelectedViewController: UIViewController {
    @IBOutlet weak var lblfortest: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    @IBOutlet weak var passerGarLabel: UILabel!
    
    @IBAction func selectYourTown(_ sender: UIButton) {
        let vcthing = self.storyboard?.instantiateViewController(withIdentifier: "TownViewController") as? TownViewController
        vcthing?.key = "anotherKeyword"
        self.navigationController?.pushViewController(vcthing!, animated: true)
    }
    
    @IBOutlet weak var selectTownClicked: UIButton!
    
    var index: Int?
    var selectedTowners: [String] = [""]
    var chday: Int = 0
    var allTowns: [String] = [""]
    func loopTownsforPop(){
   
    


        let url = URL(string: "https://data.ct.gov/resource/spwv-a9en.json")!
                //starting new task
                URLSession.shared.dataTask(with: url){(data, response, error) in

                    //trying to decode from JSON
                    do {

                        let decoder = JSONDecoder()

                        let dataFromDates = try decoder.decode([selTowns].self, from: data!)

                        let sequence = stride(from: 0, to: 168, by: 1)



                        for x in sequence {
                            let trimmedString = dataFromDates[x].town!.trimmingCharacters(in: .whitespacesAndNewlines)

                            if self.passerStr.isEqual(trimmedString) {
                                DispatchQueue.main.async {
                                    let Intpop = Float(dataFromDates[x]._2020_total!)
                                    let numberFormatter3 = NumberFormatter()
                                    numberFormatter3.numberStyle = .decimal
                                    let Stringtotalpop = numberFormatter3.string(from: NSNumber(value:Intpop!))
                                    
                                    
                                    self.popLbl.text = Stringtotalpop
                                    self.lblTest.text = dataFromDates[x].town!
                                    self.passerGarLabel.text = self.passerGar



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
    func loopTownsforData(cday2: Int){

            //right.isHidden = true

               // let cday2 = 0

                let url = URL(string: "https://data.ct.gov/resource/28fr-iqnx.json")!
                        //starting new task
                        URLSession.shared.dataTask(with: url){(data, response, error) in

                            //trying to decode from JSON
                            do {

                                let decoder = JSONDecoder()

                                let odataFromDates = try decoder.decode([allTownsdata].self, from: data!)


                                let sequence = stride(from: 0, to: 168, by: 1)


                                for x in sequence {
                                    let trimmedString = odataFromDates[x+(169*cday2)].town!.trimmingCharacters(in: .whitespacesAndNewlines)

                                    if self.passerStr.isEqual(trimmedString) {
                                        DispatchQueue.main.async {
                                            let unformattedcDate = odataFromDates[x+(169*cday2)].lastupdatedate!

                                            let dateFormatter = DateFormatter()
                                            //original format
                                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                                            let dateFromStringstartDate : NSDate = dateFormatter.date(from: unformattedcDate)! as NSDate
                                            //new format
                                            dateFormatter.dateFormat = "MM/dd/yyyy"
                                            let formattedDate = dateFormatter.string(from: dateFromStringstartDate as Date)
                                            self.dateLbl.text = "Data as of " + formattedDate
                                            let Intcase = Float(odataFromDates[x+(169*cday2)].confirmedcases!)
                                            let IntcaseChange = Float(odataFromDates[x+(169*cday2)].confirmedcases!)! - Float(odataFromDates[x+(169*(cday2+1))].confirmedcases!)!
                                            let numberFormatter3 = NumberFormatter()
                                            numberFormatter3.numberStyle = .decimal
                                            let Stringtotalcase = numberFormatter3.string(from: NSNumber(value:Intcase!))
                                            let Intdeaths = Float(odataFromDates[x+(169*cday2)].deaths!)
                                            let IntdeathChange = Float(odataFromDates[x+(169*cday2)].deaths!)! - Float(odataFromDates[x+(169*(cday2+1))].deaths!)!
                                            self.totalCasesLbl.text = Stringtotalcase
                                            self.deaths.text =  numberFormatter3.string(from: NSNumber(value:Intdeaths!))
                                            let IntcaseRate = Float(odataFromDates[x+(169*cday2)].caserate)
                                            _ = Float(odataFromDates[x+(169*cday2)].caserate)! - Float(odataFromDates[x+(169*(cday2+1))].caserate)!
                                            self.caserate.text =  numberFormatter3.string(from: NSNumber(value:IntcaseRate!))
                                            let morRatio = (Intdeaths!/Intcase!)*100
                                            _ = Float(odataFromDates[x+(169*(cday2+1))].deaths!)


                                            self.morRat.text =  String(format: "%.1f", morRatio) + "%"


                                            if IntcaseChange >= 0 {
                                                self.caseChange.text = "(+" + String(format: "%.0f", IntcaseChange) + ")"
                                                self.caseChange.textColor = .systemGreen

                                            } else if IntcaseChange < 0{
                                                self.caseChange.text = "(" + String(format: "%.0f", IntcaseChange) + ")"
                                                self.caseChange.textColor = .systemRed

                                            }
                                            if IntdeathChange >= 0 {
                                                self.deathChange.text = "(+" + String(format: "%.0f", IntdeathChange) + ")"
                                                self.deathChange.textColor = .systemGreen

                                            } else if IntdeathChange < 0{
                                                self.deathChange.text = "(" + String(format: "%.0f", IntdeathChange) + ")"
                                                self.deathChange.textColor = .systemRed

                                            }




                                            }




                                    }




                                }

                            }
                            catch {

                                print(error)
                            }


                        }.resume()
                    }
    var passer: Int = 0
    var passerStr: String = ""
     var passerGar: String = ""

    
    @IBOutlet weak var lblTest: UILabel!
    @IBOutlet weak var popLbl: UILabel!
    @IBOutlet weak var totalCasesLbl: UILabel!
    @IBOutlet weak var deaths: UILabel!
    @IBOutlet weak var caserate: UILabel!
    @IBOutlet weak var morRat: UILabel!

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var caseChange: UILabel!
    @IBOutlet weak var deathChange: UILabel!
    @IBOutlet weak var caseRateChange: UILabel!
    @IBOutlet weak var morRatChange: UILabel!
    @IBOutlet weak var right: UIButton!
    @IBOutlet weak var left: UIButton!

    @IBOutlet weak var chDay: UILabel!


    @IBAction func rightButton(_ sender: UIButton) {
        
        //currentViewControllerIndex =
   
        chday = chday - 1

        if chday == 0 {
            right.isHidden = true
        } else {
            right.isHidden = false
        }
        if chday == 4 {
            left.isHidden = true
        } else {
            left.isHidden = false
        }

        loopTownsforData(cday2: chday)
loopTownsforPop()


    }

    @IBAction func leftButton(_ sender: UIButton) {
       // self.lblTest.text = "move func here in ibaction left"

         chday = chday + 1
        if chday == 0 {
            right.isHidden = true
        } else {
            right.isHidden = false
        }
        if chday == 4 {
            left.isHidden = true
        } else {
            left.isHidden = false
        }
         loopTownsforData(cday2: chday)
            loopTownsforPop()
    }


    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: true);
        self.navigationItem.leftBarButtonItem = nil

        

loopTownsforPop()
         self.loopTownsforData(cday2: 0)

        super.viewDidLoad()
 


        if chday == 0 {
            right.isHidden = true

        }



        // Do any additional setup after loading the view.
    }

}
class selTowns: Decodable {

let _2020_total: String?
    let town: String?





enum CodingKeys: String, CodingKey {


    case _2020_total = "_2020_total"
    case town = "town"




}
}
class allTownsdata: Decodable {
    let confirmedcases: String?
    let lastupdatedate: String?
    let deaths: String?
    let town: String?
    let caserate: String





enum CodingKeys: String, CodingKey {


    case confirmedcases = "confirmedcases"
    case town = "town"
    case deaths = "deaths"
    case caserate = "caserate"
    case lastupdatedate = "lastupdatedate"



}
}
