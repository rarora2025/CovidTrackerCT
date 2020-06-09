//
//  StateViewController.swift
//  CovidTracker
//
//  Created by Rahul on 5/13/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

//
//  ViewController.swift
//  covidTrackerStateTemplate
//
//  Created by Rahul on 5/13/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
import UserNotifications

class CellClass: UITableViewCell {
    
    
}

var comparingDay: Int = 1
var cday: Int = 0
var dataSource = [String]()
var x: Int = 0



class StateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    var index: String = ""
    
    func notification(hour: Int, minute: Int, weekday: Int, text: String){

        let content = UNMutableNotificationContent()
        content.title = "Live CT Covid Update"
        content.body = text
        content.sound = UNNotificationSound.default

        let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: hour, minute: minute, weekday: weekday), repeats: true)

        let request = UNNotificationRequest(identifier: text, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }

 

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  index = dataSource[indexPath.row]
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        index = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        index = dataSource[indexPath.row]
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = dataSource[indexPath.row]
        selectedButton.setTitle("Comparing to " + dataSource[indexPath.row], for: .normal)
        removeTransparentView()
        if dataSource[indexPath.row] == "Previous Day" {
            if cday != x-8 {
                self.left.isHidden = false
                
            }
            comparingDay = 1
            
        } else if dataSource[indexPath.row] == "Previous Week" {
            if cday != x-15 {
                self.left.isHidden = false
                
            }
            if cday >= x-15 {
                cday = x-15
                
                
            }
               
            comparingDay = 7
           
        } else if dataSource[indexPath.row] == "Previous Month" {
            if cday >= x-38 {
                cday = x-38


            }
            comparingDay = 31
           
        }
        
        Main(currentDay: cday, compDay: comparingDay, cIndex: dataSource[indexPath.row])
            
        }
    
    
    
    

    @IBAction func nextDay(_ sender: UIButton) {
       
       
        
        
                   
                   
       
        
        cday -= 1
        if cday == 0{
                   
            right.isHidden = true
               }
        if cday != x-8{
           
            left.isHidden = false
        }
               
        
        
        Main(currentDay: cday, compDay: comparingDay, cIndex: index)
        
        
        
    }
    
    @IBAction func prevDay(_ sender: UIButton) {
        
      
        
        cday += 1
        if cday == x-8{
            
            left.isHidden = true
        }
        if cday != 0{
           
            right.isHidden = false
        }
        

   
        Main(currentDay: cday, compDay: comparingDay, cIndex: index)
        
    }
    
    
    
    
    //define IBOutlets
    @IBOutlet weak var testRatioLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var posRatioLbl: UILabel!
    @IBOutlet weak var hsptlRatioLbl: UILabel!
    @IBOutlet weak var totalCases_MakeThisBold: UILabel!
    @IBOutlet weak var totalCasesLbl: UILabel!
    @IBOutlet weak var casesChange: UILabel!
    @IBOutlet weak var zerotonineLbl: UILabel!
    @IBOutlet weak var tentonineteenLbl: UILabel!
    @IBOutlet weak var twentytotwentynineLbl: UILabel!
    @IBOutlet weak var thirties: UILabel!
    @IBOutlet weak var fourties: UILabel!
    @IBOutlet weak var fifties: UILabel!
    @IBOutlet weak var sixties: UILabel!
    @IBOutlet weak var seventies: UILabel!
    @IBOutlet weak var eightyandaboveLbl: UILabel!
    @IBOutlet weak var stateLookup: UILabel!
    
    @IBOutlet weak var zerotoNineChange: UILabel!
    @IBOutlet weak var tensChange: UILabel!
    @IBOutlet weak var twentiesChange: UILabel!
    @IBOutlet weak var thirtiesChange: UILabel!
    @IBOutlet weak var fourtiesChange: UILabel!
    @IBOutlet weak var fiftiesChange: UILabel!
    @IBOutlet weak var sixtiesChange: UILabel!
    @IBOutlet weak var seventiesChange: UILabel!
    @IBOutlet weak var eightandAboveChange: UILabel!
    
    @IBOutlet weak var DeathLbl: UILabel!
    @IBOutlet weak var deathChange: UILabel!
    @IBOutlet weak var mortalityRatioLbl: UILabel!
    @IBOutlet weak var mortalityRatioChange: UILabel!
    @IBOutlet weak var testLblChange: UILabel!
    
    
    @IBOutlet weak var daylbl: UILabel!
    @IBOutlet weak var right: UIButton!
    @IBOutlet weak var left: UIButton!
    
    
    @IBOutlet weak var compareTOBtn: UIButton!
    
    
   
    override func viewDidLoad() {
        
        //x = self.getX()
        Main(currentDay: 0, compDay: 1, cIndex: "Previous Day")
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
       // let x  = indexPath
        
        
       
        
        
        
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in

        }
       
        
        notification(hour: 18, minute: 00, weekday: 1, text: "The Covid Tracker has been refreshed with the newest data")
        notification(hour: 18, minute: 00, weekday: 2, text: "The Covid Tracker has been refreshed with the newest data")
        notification(hour: 18, minute: 00, weekday: 3, text: "The Covid Tracker has been refreshed with the newest data")
        notification(hour: 18, minute: 00, weekday: 4, text: "The Covid Tracker has been refreshed with the newest data")
        notification(hour: 18, minute: 00, weekday: 5, text: "The Covid Tracker has been refreshed with the newest data")
        notification(hour: 18, minute: 00, weekday: 6, text: "The Covid Tracker has been refreshed with the newest data")
        notification(hour: 18, minute: 00, weekday: 7, text: "The Covid Tracker has been refreshed with the newest data")
        
        
        
        
        
       
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
    
    
    
    
//    @IBAction func shareButton(_ sender: Any) {
//        let activityVC = UIActivityViewController(activityItems: ["Check out Rahul's CT Covid Tracking App on the app store to view Corona Virus statistics live!"], applicationActivities: nil)
//        activityVC.popoverPresentationController?.sourceView = self.view
//        present(activityVC, animated: true, completion: nil)
//        activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
//
//            if completed  {
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
//
//
//    }
  
  
    
    //dropdown code
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    
    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5

        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(dataSource.count * 50))
        }, completion: nil)


    }
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)

   }
    @IBAction func compareBtnPressed(_ sender: UIButton) {
        dataSource = ["Previous Day", "Previous Week", "Previous Month"]
        selectedButton = compareTOBtn
        addTransparentView(frames: compareTOBtn.frame)
    }
    

    
 
    
    //Main is the function that does everything
    
 
    func Main(currentDay: Int, compDay: Int, cIndex: String){
        
        
        
        
            
           
                         
                         
                    
        
       
        if currentDay == 0 && (cIndex == "Previous Day" || cIndex == "Previous Week" || cIndex == "Previous Month"){
            
            right.isHidden = true
        }

        
        
        
        
        
        
        //defining URL link
        let url = URL(string: "https://data.ct.gov/resource/rf3k-f8fg.json")!
        //starting new task
        URLSession.shared.dataTask(with: url){(data, response, error) in
        
            //trying to decode from JSON
            do {
                
                let decoder = JSONDecoder()

                let dataFromDates = try decoder.decode([Dates].self, from: data!)
                x = dataFromDates.count
                if currentDay == (dataFromDates.count-8) && (cIndex == "Previous Day"){
                    
                    self.left.isHidden = true
                }
                if currentDay == (dataFromDates.count-8)-7 && (cIndex == "Previous Week"){
                    
                    self.left.isHidden = true
                }
                if currentDay == (dataFromDates.count-8)-30 && (cIndex == "Previous Month"){
                    
                    self.left.isHidden = true
                }
                
                
                //tests
                let TotalnumberOfTests = Float(dataFromDates[currentDay].covid19TestsReported!)
                
                let tstRatio = (TotalnumberOfTests!/3565287)*100 //deviding it by CT population and making it a percent
                let prevDate = Float(dataFromDates[currentDay + compDay].covid19TestsReported!)
                let testChange: Float = TotalnumberOfTests! - prevDate!
                let testRatioString = String(format: "%.1f", tstRatio) //converting the number to a String so I can display it as text
                
                //date
                let unformattedDate = dataFromDates[currentDay].date
                //reformatting the date
                let dateFormatter = DateFormatter()
                //original format
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                let dateFromStringstartDate : NSDate = dateFormatter.date(from: unformattedDate!)! as NSDate
                //new format
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let formattedDate = dateFormatter.string(from: dateFromStringstartDate as Date)
                
                
                //definingTotalCases
                let FloatTotalCases = Float(dataFromDates[currentDay].cases!)
                let FloatYesterdayTotalCases = Float(dataFromDates[currentDay + compDay].cases!)
                let FloatTotalTwoDayDifference = FloatTotalCases! - FloatYesterdayTotalCases!
               
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let StringtotalCases = numberFormatter.string(from: NSNumber(value:FloatTotalCases!))
                
                //totalDeaths
                let FloatTotalDeaths = Float(dataFromDates[currentDay].deaths!)
                let StringTotalDeaths = numberFormatter.string(from: NSNumber(value:FloatTotalDeaths!))
                let FloatYesterdayDeaths = Float(dataFromDates[currentDay + compDay].deaths!)
                let FloatTotalDeathTwoDayDifference = FloatTotalDeaths! - FloatYesterdayDeaths!
                
                //positivityRatio
                let positivityRatioFloat = (FloatTotalCases!/TotalnumberOfTests!)*100
                let positivityRatioString = String(format: "%.1f", positivityRatioFloat)
                
                //updatingBreakdownLbls
                
                //0-9
                let Floatzeros = Float(dataFromDates[currentDay].cases_age0_9!)
                let Stringtotalzeros = numberFormatter.string(from: NSNumber(value:Floatzeros!))
                let zerosChange = Floatzeros! - Float(dataFromDates[currentDay + compDay].cases_age0_9!)!
                
                //10-19
                let Floattens = Float(dataFromDates[currentDay].cases_age10_19!)
                let Stringtotaltens = numberFormatter.string(from: NSNumber(value:Floattens!))
                let tensChange = Floattens! - Float(dataFromDates[currentDay + compDay].cases_age10_19!)!
                
                //20-29
                let Floattwenties = Float(dataFromDates[currentDay].cases_age20_29!)
                let Stringtotaltwenties = numberFormatter.string(from: NSNumber(value:Floattwenties!))
                let twentiesChange = Floattwenties! - Float(dataFromDates[currentDay + compDay].cases_age20_29!)!
                
                //30-39
                let Floatthirties = Float(dataFromDates[currentDay].cases_age30_39!)
                let Stringtotalthirties = numberFormatter.string(from: NSNumber(value:Floatthirties!))
                let thirtiesChange = Floatthirties! - Float(dataFromDates[currentDay + compDay].cases_age30_39!)!
                
                //40-49
                let Floatfourties = Float(dataFromDates[currentDay].cases_age40_49!)
                let Stringtotalfourties = numberFormatter.string(from: NSNumber(value:Floatfourties!))
                let fourtiesChange = Floatfourties! - Float(dataFromDates[currentDay + compDay].cases_age40_49!)!
                
                
                //50-59
                let Floatfifties = Float(dataFromDates[currentDay].cases_age50_59!)
                let Stringtotalfifties = numberFormatter.string(from: NSNumber(value:Floatfifties!))
                let fiftiesChange = Floatfifties! - Float(dataFromDates[currentDay + compDay].cases_age50_59!)!
                
                
                //60-69
                let Floatsixties = Float(dataFromDates[currentDay].cases_age60_69!)
                let Stringtotalsixties = numberFormatter.string(from: NSNumber(value:Floatsixties!))
                let sixtiesChange = Floatsixties! - Float(dataFromDates[currentDay + compDay].cases_age60_69!)!
                
                
                //70-79
                let Floatseventies = Float(dataFromDates[currentDay].cases_age70_79!)
                let Stringtotalseventies = numberFormatter.string(from: NSNumber(value:Floatseventies!))
                let seventiesChange = Floatseventies! - Float(dataFromDates[currentDay + compDay].cases_age70_79!)!
                
                
                //80+
                let Floatoldies = Float(dataFromDates[currentDay].cases_age80_older!)
                let Stringtotaleighties = numberFormatter.string(from: NSNumber(value:Floatoldies!))
                let oldiesChange = Floatoldies! - Float(dataFromDates[currentDay + compDay].cases_age80_older!)!
                
                
                
                //tests
        //
                let hospitalityRatioString = numberFormatter.string(from: NSNumber(value:TotalnumberOfTests!))

                
                
                //mortality ratio
                let mortalityRatioFloat = (FloatTotalDeaths!/FloatTotalCases!)*100
                let mortalityRatioString = String(format: "%.1f", mortalityRatioFloat)
                
                
                //updating the UI VIEW
                self.didUpdatePrice(tests: testRatioString, date: formattedDate, posRatio: positivityRatioString, hosRatio: hospitalityRatioString!, cases: StringtotalCases!, twoDayDiff: FloatTotalTwoDayDifference, zeros: Stringtotalzeros!, tens: Stringtotaltens!, twenties: Stringtotaltwenties!, thirties: Stringtotalthirties!, fourties: Stringtotalfourties!, fifties: Stringtotalfifties!, sixties: Stringtotalsixties!, seventies: Stringtotalseventies!, oldies: Stringtotaleighties!, zerosc: zerosChange, tensc: tensChange, twentiesc: twentiesChange, thirtiesc: thirtiesChange, fourtiesc: fourtiesChange, fiftiesc: fiftiesChange, sixtiesc: sixtiesChange, seventiesc: seventiesChange, oldiesc: oldiesChange, deaths: StringTotalDeaths!, deathsc: FloatTotalDeathTwoDayDifference, morRatio: mortalityRatioString, testsc: testChange)
                
                

                
            

                
            
                
            }
            catch {
                
                print(error)
            }
            
            
        }.resume()
        
    }
    
    func didUpdatePrice(tests: String, date: String, posRatio: String, hosRatio: String, cases: String, twoDayDiff: Float, zeros: String, tens: String, twenties: String, thirties: String, fourties: String, fifties: String, sixties: String, seventies: String, oldies: String, zerosc: Float, tensc: Float, twentiesc: Float, thirtiesc: Float, fourtiesc: Float, fiftiesc: Float, sixtiesc: Float, seventiesc: Float, oldiesc: Float, deaths: String, deathsc: Float, morRatio: String, testsc: Float) {
        
        //Remember that we need to get hold of the main thread to update the UI, otherwise our app will crash if we
        //try to do this from a background thread (URLSession works in the background).
        DispatchQueue.main.async {
        self.testRatioLbl.text = tests + "%"
            //i dont know if this looks good maybe uncomment next line to make cases bold
    //    self.totalCases_MakeThisBold.font = UIFont.boldSystemFont(ofSize: 18.0)
        self.daylbl.text = "Data as of " + date
//        self.dateLbl.font = UIFont.italicSystemFont(ofSize: 12.0)
        self.posRatioLbl.text = posRatio + "%"
        self.hsptlRatioLbl.text = hosRatio 
        self.totalCasesLbl.text = cases + " cases"
        //checking to see wether or not positive or negative change since yesterday so i know wether or not to make the text green or red
        let numberFormatterc = NumberFormatter()
        numberFormatterc.numberStyle = .decimal
            
        let twoDayDifference = numberFormatterc.string(from: NSNumber(value:twoDayDiff))
        if twoDayDiff > 0 {
            self.casesChange.text = "(+" + twoDayDifference! + ")"
            self.casesChange.textColor = .systemGreen
                
        } else {
            self.casesChange.text = "(" + twoDayDifference! + ")"
            self.casesChange.textColor = .systemRed
            
            }
        let twoDayDeathDifference = numberFormatterc.string(from: NSNumber(value:deathsc))
        if deathsc > 0 {
            self.deathChange.text = "(+" + twoDayDeathDifference! + ")"
            self.deathChange.textColor = .systemGreen
                
        } else {
            self.deathChange.text = "(" + twoDayDeathDifference! + ")"
            self.deathChange.textColor = .systemRed
            
            }

            
            
            let testsDayDifference = numberFormatterc.string(from: NSNumber(value:testsc))
            if testsc > 0 {
                self.testLblChange.text = "(+" + testsDayDifference! + ")"
                self.testLblChange.textColor = .systemGreen
                    
            } else {
                self.testLblChange.text = "(" + testsDayDifference! + ")"
                self.testLblChange.textColor = .systemRed
                
                }
            
            
            
        self.zerotonineLbl.text = zeros + " cases"
        self.tentonineteenLbl.text = tens + " cases"
        self.twentytotwentynineLbl.text = twenties + " cases"
        self.thirties.text = thirties + " cases"
        self.fourties.text = fourties + " cases"
        self.fifties.text = fifties + " cases"
        self.sixties.text = sixties + " cases"
        self.seventies.text = seventies + " cases"
        self.eightyandaboveLbl.text = oldies + " cases"
        self.DeathLbl.text = deaths + " deaths"
        self.mortalityRatioLbl.text = morRatio + "%"
            
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
            
        let zerosChangeStr = numberFormatter.string(from: NSNumber(value:zerosc))
        let tensChangeStr = numberFormatter.string(from: NSNumber(value:tensc))
        let twentiesChangeStr = numberFormatter.string(from: NSNumber(value:twentiesc))
        let thirtiesChangeStr = numberFormatter.string(from: NSNumber(value:thirtiesc))
        let seventiesChangeStr = numberFormatter.string(from: NSNumber(value:seventiesc))
        let sixtiesChangeStr = numberFormatter.string(from: NSNumber(value:sixtiesc))
        let fiftiesChangeStr = numberFormatter.string(from: NSNumber(value:fiftiesc))
        let fourtiesChangeStr = numberFormatter.string(from: NSNumber(value:fourtiesc))
        let oldiesChangeStr = numberFormatter.string(from: NSNumber(value:oldiesc))
        
        if zerosc > 0 {
            self.zerotoNineChange.text = "(+" + zerosChangeStr! + ")"
            self.zerotoNineChange.textColor = .systemGreen
            
        } else {
            self.zerotoNineChange.text = "(" + zerosChangeStr! + ")"
            self.zerotoNineChange.textColor = .systemRed
            
        }
        if tensc > 0 {
            self.tensChange.text = "(+" + tensChangeStr! + ")"
            self.tensChange.textColor = .systemGreen
            
        } else {
            self.tensChange.text = "(" + tensChangeStr! + ")"
            self.tensChange.textColor = .systemRed
            
        }
        if twentiesc > 0 {
            self.twentiesChange.text = "(+" + twentiesChangeStr! + ")"
            self.twentiesChange.textColor = .systemGreen
            
        } else {
            self.twentiesChange.text = "(" + twentiesChangeStr! + ")"
            self.twentiesChange.textColor = .systemRed
            
        }
        if thirtiesc > 0 {
            self.thirtiesChange.text = "(+" + thirtiesChangeStr! + ")"
            self.thirtiesChange.textColor = .systemGreen
            
        } else {
            self.thirtiesChange.text = "(" + thirtiesChangeStr! + ")"
            self.thirtiesChange.textColor = .systemRed
            
        }
        if fourtiesc > 0 {
            self.fourtiesChange.text = "(+" + fourtiesChangeStr! + ")"
            self.fourtiesChange.textColor = .systemGreen
            
        } else {
            self.fourtiesChange.text = "(" + fourtiesChangeStr! + ")"
            self.fourtiesChange.textColor = .systemRed
            
        }
        if fiftiesc > 0 {
            self.fiftiesChange.text = "(+" + fiftiesChangeStr! + ")"
            self.fiftiesChange.textColor = .systemGreen
            
        } else {
            self.fiftiesChange.text = "(" + fiftiesChangeStr! + ")"
            self.fiftiesChange.textColor = .systemRed
            
        }
        if sixtiesc > 0 {
            self.sixtiesChange.text = "(+" + sixtiesChangeStr! + ")"
            self.sixtiesChange.textColor = .systemGreen
            
        } else {
            self.sixtiesChange.text = "(" + sixtiesChangeStr! + ")"
            self.sixtiesChange.textColor = .systemRed
            
        }
        if seventiesc > 0 {
            self.seventiesChange.text = "(+" + seventiesChangeStr! + ")"
            self.seventiesChange.textColor = .systemGreen
            
        } else {
            self.seventiesChange.text = "(" + seventiesChangeStr! + ")"
            self.seventiesChange.textColor = .systemRed
            
        }
        if oldiesc > 0 {
            self.eightandAboveChange.text = "(+" + oldiesChangeStr! + ")"
            self.eightandAboveChange.textColor = .systemGreen
            
        } else {
            self.seventiesChange.text = "(" + oldiesChangeStr! + ")"
            self.seventiesChange.textColor = .systemRed
            
        }
            

            
        
            

            
            
            
        }
    }
    

    func didFailWithError(error: Error) {
        print(error)
    }

}


class Dates: Decodable {
    
let date: String?
let covid19TestsReported: String?
let cases: String?
let hospitalizations: String?
    
let cases_age0_9: String?
let cases_age10_19: String?
let cases_age20_29: String?
let cases_age30_39: String?
let cases_age40_49: String?
let cases_age50_59: String?
let cases_age60_69: String?
let cases_age70_79: String?
let cases_age80_older: String?
let deaths: String?
   
    
    
enum CodingKeys: String, CodingKey {
    
    case covid19TestsReported = "covid_19_pcr_tests_reported"
    case date = "date"
    case cases = "cases"
    case hospitalizations = "hospitalizations"
    
    case cases_age0_9 = "cases_age0_9"
    case cases_age10_19 = "cases_age10_19"
    case cases_age20_29 = "cases_age20_29"
    case cases_age30_39 = "cases_age30_39"
    case cases_age40_49 = "cases_age40_49"
    case cases_age50_59 = "cases_age50_59"
    case cases_age60_69 = "cases_age60_69"
    case cases_age70_79 = "cases_age70_79"
    case cases_age80_older = "cases_age80_older"
    case deaths = "deaths"
    
    

}
}



//continuing the dropdown menu




