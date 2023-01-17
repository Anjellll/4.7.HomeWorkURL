//
//  ProductTableViewCell.swift
//  4.7.HomeWork
//
//  Created by anjella on 16/1/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    public static let reuseID = String(describing: ProductTableViewCell.self)
    
    @IBOutlet  weak var productIconView: UIImageView!
    @IBOutlet  weak var productNameLabel: UILabel!
    @IBOutlet  weak var descriptionLabel: UILabel!
    @IBOutlet  weak var priceLabel: UILabel!
    @IBOutlet  weak var discountLabel: UILabel!
    @IBOutlet  weak var ratingLabel: UILabel!
    @IBOutlet  weak var brandNameLabel: UILabel!
    @IBOutlet  weak var stockLabel: UILabel!
    
    
    func configureCellBeforeShowing(phone: ProductDataModel) {
        guard let imageURLPath = URL(string: phone.thumbnail) else {
            print("Incorrect url for image url path")
            return
        }
        downloadImage(from: imageURLPath, to: self.productIconView)
        productNameLabel.text = phone.title
        descriptionLabel.text = phone.description
        ratingLabel.text = "\(phone.rating)"
        brandNameLabel.text = phone.brand
//        productCategoryLabel.text = phone.category
        priceLabel.text = "\(phone.price) $"
    }
}

extension ProductTableViewCell {
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    private func downloadImage(from url: URL, to imageView: UIImageView) {
      
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
    }
}
