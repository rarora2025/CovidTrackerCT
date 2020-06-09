//
//  TownViewController.swift
//  CovidTracker
//
//  Created by Rahul on 5/17/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import SystemConfiguration

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

import UIKit
import StoreKit
import CoreLocation


class TownViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate {
    
 
    
    
    //var n: Int = 0
    var key: String = "firstL"
    @IBOutlet weak var locationPressed: UIBarButtonItem!
    
    @IBAction func locationPressed(_ sender: UIBarButtonItem) {

        
        
        if didLiveinCT == false {
            let alert = UIAlertController(title: "Location", message: "It doesn't seem like you are in Connecticut at the moment", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
            
            self.present(alert, animated: true)
            
        } else {
            let vcthing = self.storyboard?.instantiateViewController(withIdentifier: "TownSelectedViewController") as? TownSelectedViewController
            vcthing?.passerStr = currentcity
            self.navigationController?.pushViewController(vcthing!, animated: true)
        }
        
        
    }
    
    //defining variables
    let defaults = UserDefaults.standard
    var selectedValues: [String] = []
    var thingsSelectionStatuses: [Bool]! = Array(repeating: false, count: 169)
   let locationManager = CLLocationManager()
    var currentcity: String = "Greenwich"
   
    var didLiveinCT: Bool = true
    
    @IBOutlet weak var toolbar: UIToolbar!


     //this feature will be released next update so keep it here for now (it doesn't do anything right now)
    @IBAction func ComparePressed(_ sender: UIBarButtonItem) {
       
         let valsWDups = selectedValues.removingDuplicates()
        if valsWDups.count != 1 {
            if valsWDups.count == 2 {
              
                let vcthing = storyboard?.instantiateViewController(withIdentifier: "TwoTownSelectedViewController") as? TwoTownSelectedViewController
                
                vcthing?.passerStr = valsWDups[0]
            
                vcthing?.passerStr2 = valsWDups[1]
            
                        //        //   vcthing?.selectedTowners = selectedValues
                self.navigationController?.pushViewController(vcthing!, animated: true)
                self.navigationItem.title = ""
                mmode = .view
                
            } else if valsWDups.count > 2 {
                self.navigationItem.title = ""
                mmode = .view
                let alert = UIAlertController(title: "Coming Soon", message: "This feature is in beta mode, and comparing more than two towns won't be possible until the next update", preferredStyle: .alert)
                alert.view.layoutIfNeeded()
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
              

                self.present(alert, animated: true)
                self.navigationItem.title = ""
                mmode = .view
   
                
            }
           
                    
        } else {
            selectedValues = []
            self.navigationItem.title = ""
            mmode = .view
            
        }
        
        
    }
    //will be used later on- a quick way to switch between view and select mode
    enum Mode {
        case view
        case select
    }
    
    //more variables being defined
    var towns: [String] = []
  

    var searchingTowns = [String()]
    
    var searching = false
    //defining what I should do for each view- doesn't work yet
    
    var mmode: Mode = .view {
        didSet {
            switch mmode {
                
            case .view:
                
         
            self.navigationItem.title = ""
               thingsSelectionStatuses = Array(repeating: false, count: 169)
               tblView.reloadData()
            
                
                selectedValues = []
              
                toolbar.isHidden = true
                selectBarButton.title = "Select"
                if let selectedIndexPaths = tblView.indexPathsForSelectedRows {
                     for indexPath in selectedIndexPaths {
                        tblView.deselectRow(at: indexPath, animated: true)
                        let currentCell = tblView.cellForRow(at: indexPath)! as UITableViewCell
                 
                        currentCell.accessoryType = .none
                     }
                }
            
                self.tblView.allowsMultipleSelection = false
                self.tblView.allowsMultipleSelectionDuringEditing = false
                

            case .select:
                let valsWDups2 = selectedValues.removingDuplicates()
                if valsWDups2.count >= 1 {
                    self.navigationItem.title = "\(valsWDups2.count) items selected"
                    
                } else {
                    self.navigationItem.title = ""
                }
                
             
      
                selectedValues = []
                selectBarButton.title = "Reset"
                
               // navigationItem.leftBarButtonItem = deleteBarButton
                self.tblView.allowsMultipleSelection = true
                self.tblView.allowsMultipleSelectionDuringEditing = true
                
            
                
            }
        }
    }
    
    lazy var selectBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(didSelectButtonClicked(_:)))
        return barButtonItem
    }()

    
    
    @objc func didSelectButtonClicked(_ sender: UIBarButtonItem) {
        
        mmode = mmode == .view ? .select : .view
        if mmode == .view {
            self.navigationItem.title = ""
        }
        
    }
 
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    
    
    @objc func getLocation() {
        //automatically go to vc based on users current location
        //- this function will only be triggered if the user is currently in Connecticut
        
          let vcthing = self.storyboard?.instantiateViewController(withIdentifier: "TownSelectedViewController") as? TownSelectedViewController
          vcthing?.passerStr = self.currentcity
        self.navigationController?.pushViewController(vcthing!, animated: true)
       
    
        
    }
    
   
    
    override func viewDidLoad() {
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            print("Internet Connection not Available!")
        }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        if defaults.bool(forKey: "First Launch") == true{
            //comment dispatch at end
            
              
            defaults.set(true, forKey: "First Launch")
            
        } else {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 60.0) {
                if #available(iOS 13.0, *) {
                    SKStoreReviewController.requestReview()
                    
                    
                }
                
            }

            
            DispatchQueue.main.asyncAfter(deadline: .now() + 180.0) {
                let alert = UIAlertController(title: "Share this App", message: "Please consider sharing this App with your friends and family if you enjoy it.", preferredStyle: .alert)
                
                let shareAction = UIAlertAction(title: "Share",
                          style: .default) { (action) in
                            
                 

                 let shareText = "Check out this app on the App Store called CovidTrackerCT, its a great app and I encourage you to download it when you have time."
                     let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
                            self.present(vc, animated: true)
                 
                }
                alert.view.layoutIfNeeded()
                  alert.addAction(shareAction)
                 alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                
                

                  self.present(alert, animated: true)
                
                
            }
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "WhatsNew", sender: self)
               // self.dismiss(animated: true, completion: nil)
            })
            
            defaults.set(true, forKey: "First Launch")
        }
       
        
       
        
       
        


     toolbar.isHidden = true
    
  
   
        
        
        
        
        super.viewDidLoad()
        getTowns()
        view.endEditing(true)
        searching = false
        searchBar.text = ""
        
        tblView.reloadData()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: lat, longitude: lon)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]

            // City
            if let city = placeMark.locality {
             
                self.currentcity = city
            
                if lat > 40.958166 && lat < 42.052394 && -71.767054 > lon && lon > -73.772059  {
                  
                    self.didLiveinCT = true
                    self.currentcity = city
                    
                    
                    
//                    let vcthing = self.storyboard?.instantiateViewController(withIdentifier: "TownSelectedViewController") as? TownSelectedViewController
//                    vcthing?.passerStr = city
//                    self.navigationController?.pushViewController(vcthing!, animated: true)
                    
                } else {
                  
                    self.didLiveinCT = false
                    self.currentcity = "Greenwich"
                  //  getLocation()
                }
                
                
               
                
             
            }
          
           
                
            })
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
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
    

 
    
    override func viewDidAppear(_ animated: Bool) {
        
        
     
        if key == "firstL" {
            let vcthing = self.storyboard?.instantiateViewController(withIdentifier: "TownSelectedViewController") as? TownSelectedViewController
                   vcthing?.passerStr = "Greenwich"

                   self.navigationController?.pushViewController(vcthing!, animated: true)

            animateTable()
            
            
        } else {
            
        }
        
        super.viewDidAppear(animated)
        navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = self.locationPressed
 
      
    }
    
    
    func animateTable(){
        tblView.reloadData()
        let cells = tblView.visibleCells
        let tblViewHeight = tblView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tblViewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
    }

  
  
   
    @objc func callMethod() {
       
    }
    
    
    func getTowns(){
        tblView.reloadData()
        towns = {
              var temp = ["Andover"]
                temp.sort(by: <)
              return temp
            }()
            
        let url = URL(string: "https://data.ct.gov/resource/28fr-iqnx.json")!
        //starting new task
        URLSession.shared.dataTask(with: url){(data, response, error) in
        
            //trying to decode from JSON
            do {
                
                let decoder = JSONDecoder()

                let dataFromD = try decoder.decode([Towns].self, from: data!)
             
                var i: Int = 1
                //andover is being done in temp
                while i < 169 {
                    self.towns.append(dataFromD[i].town!)
                    i = i + 1
                   
                }
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                    
                }
                 
                
                
                
                
           
                
            }
            catch {
                
                print(error)
            }
            
           
        }.resume()
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching == true {
            return searchingTowns.count
        } else {
        return towns.count
        }
      }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text == "" {
            searchBar.placeholder = "Enter Town Name"
            return true
        } else {
            return true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
      
            searchBar.endEditing(true)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell!.accessoryType = thingsSelectionStatuses[indexPath.row] ? .checkmark : .none
        let valsWDups2 = selectedValues.removingDuplicates()
        if valsWDups2.count >= 1 {
            self.navigationItem.title = "\(valsWDups2.count) items selected"
            
        } else {
            self.navigationItem.title = ""
        }
        
        if searching == true {
            cell?.textLabel?.text = searchingTowns[indexPath.row]
        } else {
            cell?.textLabel?.text = towns[indexPath.row]
            
        }
        
        return cell!
      }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if mmode == .select {
            searchBar.endEditing(true)
            searchBar.searchTextField.text = ""
             mmode = .view
            let alert = UIAlertController(title: "Connection interrupted", message: "Please do not use the keyboard while in selection mode!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            alert.view.layoutIfNeeded()
           
            self.present(alert, animated: true)
           
            
        }
        searchingTowns = towns.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tblView.reloadData()
    }
  

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searching = false
        searchBar.text = ""
        
        tblView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        
        let selectedIndexes = tblView.indexPathsForSelectedRows

        
        let sequence2 = stride(from: 0, to: selectedIndexes!.count, by: 1)
       
        
        for i in sequence2{
            
            let currentCel = tblView.cellForRow(at: selectedIndexes![i])!.textLabel!.text!
            if selectedValues.contains(currentCel) {
          
            selectedValues = selectedValues.filter { $0 != currentCel }
                
            } else {
                selectedValues.append(currentCel)
                
            }
          
        
            //use currentCel to access the things user selected
           
            
        }
      

        if selectedValues.count > 8 {
            tblView.allowsSelection = false
        } else {
            tblView.allowsSelection = true
        }
        
        
        
        
        if mmode == .view {
            self.navigationItem.title = ""
            let vcthing = storyboard?.instantiateViewController(withIdentifier: "TownSelectedViewController") as? TownSelectedViewController
                vcthing?.passerStr = selectedValues[0]
                selectedValues = []
   
            self.navigationController?.pushViewController(vcthing!, animated: true)
            
           toolbar.isHidden = true
            
            tblView.deselectRow(at: indexPath, animated: true)

            
        }
        if mmode == .select {
            let valsWDups2 = selectedValues.removingDuplicates()
            if valsWDups2.count >= 1 {
                self.navigationItem.title = "\(valsWDups2.count) items selected"
                
            } else {
                self.navigationItem.title = ""
            }
            
            thingsSelectionStatuses[indexPath.row].toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        
          
           toolbar.isHidden = false
            
      
          
        }
        
        
        
        
    }
     

}
   

class Towns: Decodable {
    
let town: String?

   
    
    
enum CodingKeys: String, CodingKey {
    
    case town = "town"
}
    
}


