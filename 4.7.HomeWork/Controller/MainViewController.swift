//
//  ViewController.swift
//  4.7.HomeWork
//
//  Created by anjella on 16/1/23.


import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private weak var storeCollectionView: UICollectionView!
    @IBOutlet private weak var productsTableView: UITableView!
    
    private var phones: [ProductDataModel]?
    private var controller: PhoneController?
   
    @IBAction func refreshDataButtonTapped(_ sender: Any) {
        controller?.getPhonesData()
        phones = controller?.returnToViewPhones()
        print(phones?.count)
        productsTableView.reloadData()
    }
    
    
    private let categoryDataArray: [CategoryDataModel] = [
        .init(imageView: UIImage(named: "delivery")!, dataHorizantally: "Delivery"),
        .init(imageView: UIImage(named: "pickup")!, dataHorizantally: "Pickup"),
        .init(imageView: UIImage(named: "catering")!, dataHorizantally: "Catering"),
        .init(imageView: UIImage(named: "curbside")!, dataHorizantally: "Curbside")
        ]
    
    private let storesDatArray: [StoreDataModel] = [
        .init(imageView: UIImage(named: "image1")!, storesName: "Takeaways"),
        .init(imageView: UIImage(named: "image2")!, storesName: "Grocery"),
        .init(imageView: UIImage(named: "image3")!, storesName: "Convenience"),
        .init(imageView: UIImage(named: "image4")!, storesName: "Pharmacy")
    ]

    private let products: [ProductDataModel]? = nil
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureTableView()
        
        controller = PhoneController(view: self)
        controller?.getPhonesData()
    }
    
    private func configureCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(
            UINib(
                nibName: String(describing: CategoryCollectionViewCell.self),
                bundle: nil),
            forCellWithReuseIdentifier: CategoryCollectionViewCell.reusedID)
        
        storeCollectionView.dataSource = self
        storeCollectionView.delegate = self
        storeCollectionView.register(
            UINib(
                nibName: String(describing: StoreCollectionViewCell.self),
                bundle: nil),
            forCellWithReuseIdentifier: StoreCollectionViewCell.reusedID)
    }
    
    private func configureTableView() {
        productsTableView.dataSource = self
        productsTableView.delegate = self
        productsTableView.register(
            UINib(
                nibName: String(describing: ProductTableViewCell.self),
                bundle: nil),
            forCellReuseIdentifier: ProductTableViewCell.reuseID)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView == categoryCollectionView {
            return categoryDataArray.count
        }else{
            return storesDatArray.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CategoryCollectionViewCell",
                for: indexPath) as! CategoryCollectionViewCell
            let data = categoryDataArray[indexPath.row]
            cell.display(item: data, selected: data)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "StoreCollectionViewCell",
                for: indexPath) as! StoreCollectionViewCell
            let data = storesDatArray[indexPath.row]
            cell.display(item: data)
            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: 120, height: 36)
        } else {
            return CGSize(width: 100, height: 130)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        guard let phone = phones else {
            print("000000")
            return 0
        }
        print("Table view ds:\(phone.count)")
        return phone.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(
            withIdentifier: String(
                describing: ProductTableViewCell.reuseID
            )
        ) as? ProductTableViewCell
        guard let phone = phones?[indexPath.row] else {
            print("Phone is nil!!")
            fatalError()
        }

        cell?.configureCellBeforeShowing(phone: phone)

        guard let cell = cell else {
            fatalError()
        }

        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath)
    -> CGFloat {
        return 300
    }
}
 
