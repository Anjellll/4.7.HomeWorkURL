//
//  PhoneController.swift
//  4.7.HomeWork
//
//  Created by anjella on 17/1/23.
//


import UIKit

class PhoneController {
    
    private var view: MainViewController!
    private var model: PhoneModel?
    var productsTableView: UITableView?

    init(view: MainViewController!) {
        self.view = view
        model = PhoneModel(controller: self)
    }
    
    var phones: [ProductDataModel]?
    
    func getPhonesData () {
        model?.getPhoneData()
        print("get phones data in controller")
        phones = model?.phones
    }
    
    func returnToViewPhones() -> [ProductDataModel]? {
        return phones
    }
    //парсить данные
}
