//
//  CatGeneratorViewController.swift
//  CatGenerator
//
//  Created by Alexander on 03.11.2024.
//

import UIKit

final class CatGeneratorViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextField!
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
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(gestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight / 2, right: 0)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        _ = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    @objc
    private func didTapView() {
        view.endEditing(true)
    }
    
    @IBAction func didTapGenerateButton(_ sender: Any) {
        if let tabBarVC = self.tabBarController as? MainTabBarController {
            print(tabBarVC.savedCatImages.count)
        } else {
            print("error")
        }
        downloadCat()
    }
    
    private func downloadCat() {
        generateButton.isEnabled = false
        statusLabel.text = statusLabelTemplate + "Downloading..."
        var url_template : String;
        if let text = textView.text, !text.isEmpty {
            url_template = "https://cataas.com/cat/says/\(text)?fontSize=50&fontColor=white"
        } else {
            url_template = "https://cataas.com/cat"
        }
        guard let url = URL(string: url_template) else {
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
                if let image = UIImage(data: data) {
                    self.catImageView.image = image
                    self.statusLabel.text = self.statusLabelTemplate + "Download Finished"
                    self.generateButton.isEnabled = true
                    
                    if let tabBarVC = self.tabBarController as? MainTabBarController {
                        tabBarVC.savedCatImages.append(image)
                    }
                }
            }
        }
        task.resume()
    }
    
}
