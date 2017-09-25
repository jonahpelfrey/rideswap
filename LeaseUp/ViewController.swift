//
//  ViewController.swift
//  LeaseUp
//
//  Created by Jonah Pelfrey on 9/20/17.
//  Copyright © 2017 Jonah Pelfrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var makePicker: UIPickerView!
    @IBOutlet weak var modelPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBOutlet weak var chosenCarText: UITextField!
    @IBOutlet weak var addCar: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeLogo: UIImageView!
    
    //Objects
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //Lists
    var makeList = [
        "Acura",
        "Alfa Romeo",
        "Aston Martin",
        "Audi",
        "Bentley",
        "BMW",
        "Buick",
        "Cadillac",
        "Chevrolet",
        "Chrylser",
        "Dodge",
        "Fiat",
        "Ford",
        "GMC",
        "Honda",
        "Hyundai",
        "Infiniti",
        "Jaguar",
        "Jeep",
        "Kia",
        "Land Rover",
        "Lexus",
        "Lincoln",
        "Maserati",
        "Mazda",
        "McLaren",
        "Mercedes Benz",
        "MINI",
        "Mitsubishi",
        "Nissan",
        "Porsche",
        "Rolls Royce",
        "Scion",
        "Subaru",
        "Tesla",
        "Toyota",
        "Volkswagon",
        "Volvo"
    ]

    
    let modelList = ["S8", "M3", "458 Italia", "Cayman R"]
    
    let yearList = ["2018", "2017", "2016", "2015", "2014"]
    

    //Variables for selected car
    var chosenMake = "" {
        
        didSet{
            chosenCarText.text = chosenYear + " " + chosenMake + " " + chosenModel
        }
    }
    var chosenModel = "" {
        
        didSet{
            chosenCarText.text = chosenYear + " " + chosenMake + " " + chosenModel
        }
    }
    
    var chosenYear = "" {
        
        didSet{
            chosenCarText.text = chosenYear + " " + chosenMake + " " + chosenModel
        }
    }
    
    var savedCars: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chosenMake = makeList[0]
        chosenModel = modelList[0]
        chosenYear = yearList[0]
        chosenCarText.text = chosenYear + " " + chosenMake + " " + chosenModel
        
        makePicker.delegate = self
        modelPicker.delegate = self
        yearPicker.delegate = self
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bgblurry.jpg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        startIndicator()
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.stopIndicator()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Custom Functions
    @IBAction func addButtonTouched(_ sender: UIButton) {
        
        let newSavedCar = chosenMake + " " + chosenModel
       
        modelPicker.selectRow(0, inComponent: 0, animated: true)
        makePicker.selectRow(0, inComponent: 0, animated: true)
        
        chosenMake = makeList[0]
        chosenModel = modelList[0]
        
        savedCars.append(newSavedCar)
        tableView.reloadData()
        
    }
    
    func startIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopIndicator() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }


}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == makePicker {
            return makeList.count
        }
        
        else if pickerView == modelPicker{
            return modelList.count
        }
        
        else {
            return yearList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == makePicker {
            return makeList[row]
        }
        
        else if pickerView == modelPicker{
            return modelList[row]
        }
        
        else {
            return yearList[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == makePicker {
            chosenMake = makeList[row]
        }
        
        else if pickerView == modelPicker{
            chosenModel = modelList[row]
        }
        
        else {
            chosenYear = yearList[row]
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = savedCars[indexPath.row]
        
        return cell
    }
    
}












