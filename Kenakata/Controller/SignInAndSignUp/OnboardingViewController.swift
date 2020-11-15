//
//  OnboardingViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 15/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}
class OnboardingViewController: UIViewController {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        let profile = UIImage(named: "pran-mixed-fruit-jam-375-gm")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = profile
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       view.addSubview(profileImageView)
        // Do any additional setup after loading the view.
        setupBottomControls()
               setupLayout()
    }
    
    private let previousButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("PREV", for: .normal)
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
           button.setTitleColor(.gray, for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
       
    private let nextButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("NEXT", for: .normal)
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
           button.setTitleColor(.mainPink, for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = .gray
        
        return pc
    }()
    
    fileprivate func setupBottomControls(){
            
            let yellowView = UIView()
            yellowView.backgroundColor = .yellow
            
            let greenView = UIView()
            greenView.backgroundColor = .green
            
            let blueView = UIView()
            blueView.backgroundColor = .blue
            let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
            
            bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
            bottomControlsStackView.distribution = .fillEqually
            
            view.addSubview(bottomControlsStackView)
            
            NSLayoutConstraint.activate([
                bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    private func setupLayout(){
        let topImageContainerView = UIView()
        view.addSubview(topImageContainerView)
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false

        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        
        topImageContainerView.addSubview(profileImageView)
        
        
        
       
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
