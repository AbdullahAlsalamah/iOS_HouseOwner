//
//  ViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/16/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit
import iOSDropDown



class ViewController: UIViewController{
    @IBOutlet weak var SignUpLabel: UILabel!
    
    @IBOutlet weak var NextButton: UIButton!
 
    @IBOutlet weak var countryCodeTextField: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        countryCodeTextField.delegate = self
        
        // adding specific styles for the UI
        styleUI()
        
        // using iOS dropDown pod, for dropdown menue (for countries)
        // for more information about the pod go to: https://github.com/jriosdev/iOSDropDown
        addCountryDropDownMenue()
        
    
    }
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
//        //countryCodeTextField.showList()  // To show the Drop Down Menu
//        return true
//    }

    /**
     This fuction updates the UI look and feel. Reason: hard to do using options
     // reads json file, and returns country codes dictionary, ex: Saudi Arabia -> +966
     */
    func styleUI(){
        SignUpLabel.textColor = UIColor(rgb: Colors.gray)
        NextButton.backgroundColor = UIColor(rgb: Colors.darkBlue)
        NextButton.layer.cornerRadius = K.cornerRadius
    }
    
    
//MARK: - DropDown & country Codes
    
    func addCountryDropDownMenue (){
        
        let countryCodes = getCountryCodes()! // this is a dictionary
        
        // here we take the (Dictionary<Key, Value>.Values) type
        // and convert it to array so we can manipulate it
        // the array will contain the contry codes as [String]
        let  countryCodesArr: [String] = Array(countryCodes.values)
        
        
        // casting country code string to int, ex: "966" -> 966
        // here we cast any string that can't be convert to Int to -1
        // from our json that never happens, but swift requires this type of handling
       let countryCodesArrInt  = countryCodesArr.map { (stringCode) -> Int in
            (Int(stringCode) ?? -1)
        }
        
        
        // This is the acutal list of options that is displayed to the user
        countryCodeTextField.optionArray = countryCodesArrInt.map({ (code) -> String in
            let countryName = (countryCodes.someKey(forValue: String(code)) ?? "--")
            return "\(countryName)   (+\(code))"
        })
        
        countryCodeTextField.optionIds = countryCodesArrInt
        
        // the color that shows up after the user chooses an option
        countryCodeTextField.selectedRowColor = .white
        countryCodeTextField.showList()  // To show the Drop Down Menu
        
        // just printing what the user clicked (not important)
        countryCodeTextField.didSelect{(selectedText , index ,id) in
        let selected = "Selected String: \(selectedText) \n index: \(index) \n \(id)"
            print(selected)
            
        }
    }
    
    /**
        This method reads country codes in countryCodes.json
            Returns: a dictionary, mapping country -> code
                ex: "saudi arabia" -> "966"
     
     */
    func getCountryCodes() -> [String:String]? {
        // this instance is going to parse json
        let decoder = JSONDecoder()
        // this path is String? and is the easiest wasy to locate a file
        let path = Bundle.main.path(forResource: "countryCodes", ofType: "json")
        // this url object is required to genrate Data object
        let url = URL(fileURLWithPath: path!)
        
        do{
            // this data object is needed for JSONDecoder object
            let data = try Data(contentsOf: url)
            // this is the result of the decoded json
            let decoded = try decoder.decode(codes.self, from: data )
            // this is the way it should be accessed -> decoded.countryCodes[0].name
           
            
            //FIXME: -This is hardcoded, find a better way
            let coutryCount = 248
            var countryCodes :[String:String] = [:]
            
            for index in (0..<coutryCount) {
                let countryName = decoded.countryCodes[index].name
                let countryCode = decoded.countryCodes[index].callingCode
                
                // adding to dictionary
                countryCodes[countryName] = countryCode
            }
            
            return countryCodes
            
        }catch {
            print(" could not parse json \n")
            print(error)
            return nil
        }
        
    
    }
    
    


}

//MARK: - Swift Extenstions

/**
        returns a UIColor after getting an rgb value
 */
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

/** This extenstion adds the ability of getting a key from value in a ditionary
        ex: suppose we have this dict ['a' -> 1] and it is called myDict
             to get 'a', we do myDict.someKey(1)
 */
extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
