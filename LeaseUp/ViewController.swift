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
    @IBOutlet weak var chosenCarText: UITextField!
    @IBOutlet weak var addCar: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeLogo: UIImageView!
    
    //Objects
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //Lists
    let makeList = ["Audi", "BMW", "Ferrari", "Porsche"]
    
    let modelList = ["S8", "M3", "458 Italia", "Cayman R"]
    
    //Cars
    let db = Dictionary<String,Dictionary<String,Dictionary<String,String>>>()
    
    
    
    var chosenMake = "" {
        
        didSet{
            chosenCarText.text = chosenMake + " " + chosenModel
        }
    }
    var chosenModel = "" {
        
        didSet{
            chosenCarText.text = chosenMake + " " + chosenModel
        }
    }
    
    var savedCars: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chosenMake = makeList[0]
        chosenModel = modelList[0]
        chosenCarText.text = chosenMake + " " + chosenModel
        
        makePicker.delegate = self
        modelPicker.delegate = self
        
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
        
        else {
            return modelList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == makePicker {
            return makeList[row]
        }
        
        else {
            return modelList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == makePicker {
            chosenMake = makeList[row]
        }
        
        else {
            chosenModel = modelList[row]
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












