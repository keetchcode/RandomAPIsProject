//
//  ViewController.swift
//  RandomAPIsProject
//
//  Created by Wesley Keetch on 12/3/24.
//

import UIKit

class DogViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var loadButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    loadButton.tintColor = UIColor.orange
    loadDogPhoto()
    updateActivityIndicatorState()
    // Do any additional setup after loading the view.
  }

  @IBAction func loadButtonTapped(_ sender: Any) {
    print("Button tapped")
    updateActivityIndicatorState()
    loadDogPhoto()
  }

  func loadDogPhoto() {
    imageView.image = nil
    updateActivityIndicatorState()
    Task {
      do {
        let image = try await DogNetworkManager.fetchDogImage()
        imageView.image = image
        updateActivityIndicatorState()
      } catch {
        updateActivityIndicatorState()
        print(error)
      }
    }
  }

  private func updateActivityIndicatorState() {
    if imageView.image == nil {
      activityIndicator.startAnimating()
      activityIndicator.isHidden = false
    } else {
      activityIndicator.stopAnimating()
      activityIndicator.isHidden = true
    }
  }
}

