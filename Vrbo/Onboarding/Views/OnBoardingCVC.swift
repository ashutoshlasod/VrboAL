//
//  OnBoardingCVC.swift
//  Vrbo
//
//  Created by Ashutosh Lasod on 06/11/20.
//  Copyright © 2020 Ashutosh Lasod. All rights reserved.
//

import UIKit

//MARK:- Implementation of OnBoarding Collection View Cell
final class OnBoardingCVC: UICollectionViewCell {
    
    ///Identifier of the OnBoarding collectionn view cell
    static let identifier: String = "OnBoardingCVC"
    
    //IBOutlets of the Collection View Cell
    @IBOutlet weak var bannerImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
     Method responsible for configuring the collection view Cell
     - parameter pageModel: Pass the OnBoarding Page Model which conntains image Name, Title and Description
     */
    func configureCell(with pageModel: OnBoardingPageModel) {
        bannerImgView.image = UIImage(named: pageModel.imageName)
        titleLabel.text = pageModel.title
        descriptionLabel.text = pageModel.description
    }

}
