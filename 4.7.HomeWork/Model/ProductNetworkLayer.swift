//
//  ProductNetworkLayer.swift
//  4.7.HomeWork
//
//  Created by anjella on 16/1/23.
//

import Foundation

class ProductNetworkLayer {
    func fetchData (completion: @escaping (Result<Products, Error>) -> Void) {

        //Ссылка на api типа String
        let urlPath: String = "https://dummyjson.com/products"

        //Безопасное вскрытие url
        guard let url = URL(string: urlPath) else {
            print("nil while creating a url!")
            return
        }

        //Запрос на сервер по url-ке
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in

            guard let data = data else {
                print("Data is nil!!")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("Success. Status code: 200")
                } else {
                    print("Got unexpected status code. Status code: \(httpResponse.statusCode)")
                }
            }

            guard error == nil else {
                print("Error occured! Description: \(error!.localizedDescription)")
                return
            }

            let decoder = JSONDecoder()
            do {
                let phonesData = try decoder.decode(Products.self, from: data)
                completion(.success(phonesData))
            } catch {
                print("Error occured while trying to fetch data: \(error.localizedDescription).")
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
}

