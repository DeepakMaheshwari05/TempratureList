//
//  CityWeatherDetailVC.swift
//  WhetherReport
//
//  Created by Deepak.Maheshwari on 08/05/19.
//  Copyright © 2019 Deepak.Maheshwari. All rights reserved.
//

import UIKit

class CityWeatherDetailVC: UIViewController {

    //MARK: - Properties
    
    var sendObj : CityTemp?
    
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    
    
     //MARK: - UIView methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpView()
    }
    //MARK: - Custom Methods
    func setUpView()  {
        ////// Setting value from database obj to labels
        if sendObj != nil {
            lblCityName.fadeTransition(1.0)
            lblCityName.text = sendObj?.cityName
            lblCountry.fadeTransition(1.0)
            lblCountry.text = sendObj?.country
            lblTemp.fadeTransition(1.0)
            lblTemp.text = "\(sendObj!.cityTemprature)"
            lblMin.fadeTransition(1.0)
            lblMin.text = "\(sendObj!.minTemp)"
            lblMax.fadeTransition(1.0)
            lblMax.text = "\(sendObj!.maxTemp)"
            lblHumidity.fadeTransition(1.0)
            lblHumidity.text = "\(sendObj!.humidity)"
        }
    }
    
    //MARK: - IBAction Methods
    @IBAction func closeView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
