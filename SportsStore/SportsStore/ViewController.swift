//
//  ViewController.swift
//  SportsStore
//
//  Created by wdy on 2019/11/9.
//  Copyright © 2019 wdy. All rights reserved.
//

import UIKit


class ProductTableCell: UITableViewCell {
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockField: UITextField!
    
    var product: Product?
}


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stockLevelTotalLabel: UILabel!
    var productStore = ProductDataSore.init()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        
        self.initViews()
        
        self.displayStockTotal()
        
        productStore.callback = {(p: Product) in
            for cell in self.tableView.visibleCells {
                if let pcell = cell as? ProductTableCell {
                    if pcell.product?.name == p.name {
                        pcell.stockStepper.value = Double(p.stockLevel)
                        pcell.stockField.text = String(p.stockLevel)
                    }
                }
            }
            self.displayStockTotal()
        }
    }

    // 自定义视图
    func initViews() {
        self.tableView?.allowsSelection = true
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView.init()
    }
    // 加载数据
    func loadDatas() {
        
    }

    @IBAction func stoclLevelValueChanged(_ sender: Any) {
        if var currentCell = sender as? UIView {
            while true {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product {
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        } else if let textField = sender as? UITextField {
                            if let newValue = textField.text {
                                product.stockLevel = Int.init(newValue)!
                            }
                        }
                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.stockField.text = String(product.stockLevel)
                        productLogger.logItem(item: product)
                    }
                    break
                }
            }
            self.displayStockTotal()
        }
    }
    
    func displayStockTotal() {
        let finalTotals: (Int, Double) = productStore.products.reduce((0, 0.0)) { (totals, p) -> (Int, Double) in
            return (totals.0 + p.stockLevel, totals.1 + p.stockValue)
        }
        
        self.stockLevelTotalLabel?.text = "\(finalTotals.0) Products in Stock. Total Value: \(Utils.currencyStringFromNumber(number: finalTotals.1))"
    }
    
}


extension ViewController: UITableViewDelegate {
    
}


extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productStore.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productStore.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableCell
        cell.product = productStore.products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.productDescription
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: true)
    }
    
}
