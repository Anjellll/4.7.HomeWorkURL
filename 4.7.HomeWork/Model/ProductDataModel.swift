//
//  ProductDataModel.swift
//  4.7.HomeWork
//
//  Created by anjella on 16/1/23.
//

import UIKit

struct Products: Codable {
    var products: [ProductDataModel]
}


struct ProductDataModel: Codable {
    let title, description, brand, category, thumbnail: String
    let price, stock: Int
    let discountPercentage, rating: Double
}


class PhoneModel {
    
    private weak var controller: PhoneController?
    
    init(controller: PhoneController?) {
        self.controller = controller
    }
    
    var phones: [ProductDataModel]?
    private let networkManager = ProductNetworkLayer()
    
    func getPhoneData() {
        networkManager.fetchData { result in
            print("completion handler in model nm")
            switch result {
            case .success(let phonesData):
                print(phonesData)
                self.phones = phonesData.products
                print("Got \(self.phones?.count ?? 0) data")
            case .failure(let error):
                print("Error in completion handler in model: \(error.localizedDescription).")
            }
        }
        
        print("Model print")
    }
}

