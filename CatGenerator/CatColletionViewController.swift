//
//  CatCollectionViewController.swift
//  CatGenerator
//
//  Created by Alexander on 03.11.2024.
//

import UIKit

final class CatCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var savedCats: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarVC = tabBarController as? MainTabBarController {
            savedCats = tabBarVC.savedCatImages
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath)
        cell.imageView?.image = savedCats[indexPath.row]
        cell.textLabel?.text = "Кот \(indexPath.row + 1)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCatImage = savedCats[indexPath.row]
        
        if let catDetailVC = storyboard?.instantiateViewController(withIdentifier: "CatDetailViewController") as? CatDetailViewController {
            catDetailVC.catImage = selectedCatImage
            present(catDetailVC, animated: true, completion: nil)
        }
    }
}
