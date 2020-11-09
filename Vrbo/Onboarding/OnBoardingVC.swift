//
//  OnBoardingVC.swift
//  Vrbo
//
//  Created by Ashutosh Lasod on 06/11/20.
//  Copyright © 2020 Ashutosh Lasod. All rights reserved.
//

import UIKit

//MARK:- Implementation of OnBoarding ViewController
final class OnBoardingVC: UIViewController {
    
    ///Identifier responsible for getting the viewController for given identifier
    static let identifier: String = "OnBoardingVC"
    
    //MARK:- IBOutlets for the OnBoardingVC
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    
    /**
     This method is responsible for getting the instance of Login Controller
     */
    class func getController() -> OnBoardingVC {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController: OnBoardingVC = storyBoard.instantiateViewController(withIdentifier: identifier) as! OnBoardingVC
        return viewController
    }
    
    ///A viewModel property which helps a intermediate between Model and ViewController
    private lazy var viewModel: OnBoardingVM = {
       return OnBoardingVM()
    }()
    
    //MARK:- OnBoardingVC Life cycle Methods Implementation begins
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

//MARK:- Extension for IBActions Implementation
private extension OnBoardingVC {
    
    ///This method is responsible for tap action of Skip button
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: kUserDefaults.onBoardingDone)
    }
    
    ///This method is responsible for tap action of Next button
    @IBAction func nextButtonTapped(_ sender: UIButton) { }
}

//MARK:- Helper Methods for setting up ViewController
private extension OnBoardingVC {
    
    /**
     Setting up ViewController.
     1. Confirming the delegate/datasource of Collection View.
     2. Registering the cell.
     3. Setting up page control based on number of pages.
     */
    func setupViewController() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: OnBoardingCVC.identifier, bundle: Bundle.main),
                                     forCellWithReuseIdentifier: "OnBoardingCVC")
        
        //setup viewModel
        viewModel.setup()
        
        // set the number of pages to the number of Onboarding Screens
        self.pageControl.numberOfPages = viewModel.getTotalCount()
    }
}

//MARK:- Collection view Delegate and data source method implementation
extension OnBoardingVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///This method is resposible getting total number of items to be shown
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTotalCount()
    }
    
    ///This method is resposible for setting up collection cell with Model and UI
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let onBoardingScreenModel: OnBoardingPageModel = viewModel.getOnBoardScreenModel(for: indexPath.row) else {
            return UICollectionViewCell()
        }
        
        let cell: OnBoardingCVC = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCVC.identifier,
                                                      for: indexPath) as! OnBoardingCVC
        cell.configureCell(with: onBoardingScreenModel)
        return cell
    }
    
    ///This method is responsible for setting up collection view cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    ///This method is responsible for updating page control and skip button visibility handling
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let curretIndex: Int = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = curretIndex
        skipButton.isHidden = (curretIndex == (viewModel.getTotalCount() - 1))
    }
    
}

