//
//  CatGeneratorViewController.swift
//  CatGenerator
//
//  Created by Alexander on 03.11.2024.
//

import UIKit

final class CatGeneratorViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var generateButton: UIButton!
    private let statusLabelTemplate = "Status: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if catImageView.image == nil {
            downloadCat()
        }
    }
    
    @IBAction func didTapGenerateButton(_ sender: Any) {
        downloadCat()
    }
    
    private func downloadCat() {
        generateButton.isEnabled = false
        statusLabel.text = statusLabelTemplate + "Downloading..."
        
        guard let url = URL(string: "https://cataas.com/cat") else {
            statusLabel.text = statusLabelTemplate + "Invalid URL"
            generateButton.isEnabled = true
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.statusLabel.text = self.statusLabelTemplate + "No data"
                    self.generateButton.isEnabled = true
                }
                return
            }
            
            DispatchQueue.main.async {
                self.catImageView.image = UIImage(data: data)
                self.statusLabel.text = self.statusLabelTemplate + "Download Finished"
                self.generateButton.isEnabled = true
            }
        }
        task.resume()
    }
}
