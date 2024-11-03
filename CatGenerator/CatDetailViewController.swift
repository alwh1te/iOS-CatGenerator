//
//  CatDetailViewController.swift
//  CatGenerator
//
//  Created by Alexander on 03.11.2024.
//

import UIKit

class CatDetailViewController: UIViewController {
    @IBOutlet weak var catImageView: UIImageView!
    var catImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catImageView.image = catImage
    }
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
