//
//  OnBoardingVM.swift
//  Vrbo
//
//  Created by Ashutosh Lasod on 07/11/20.
//  Copyright © 2020 Ashutosh Lasod. All rights reserved.
//

import Foundation

//MARK:- OnBoardingPage Model, which will help in creating Models for onboarding screens
struct OnBoardingPageModel: Codable {
    let imageName: String
    let title: String
    let description: String
}

//MARK:- A viewModel class implementation which helps a intermediate between Model and ViewController
class OnBoardingVM {
    
    private var onBoardingScreens: [OnBoardingPageModel] = []
    
    /**
     This method is responsible for creating datasource of the OnBoarding Screen
     Based on the regionCode, we can get the create different configuration files and if files doesn't exist, we will show user default list of onBoarding screens
     */
    func setup() {
        
        let countryCode: String = NSLocale.current.regionCode ?? "IN"
        
        //Check for pList file exist for particular locale or not
        guard let path: String = Bundle.main.path(forResource: "Onboarding-\(countryCode.uppercased())", ofType: "plist") else {
            setDefaultValues()
            return
        }
        
        let url: URL = URL(fileURLWithPath: path)
        do {
            let data: Data = try Data(contentsOf: url)
            let onBoardingPageModelArr: [OnBoardingPageModel] = try PropertyListDecoder().decode([OnBoardingPageModel].self, from: data)
            onBoardingScreens = onBoardingPageModelArr
        } catch {
            setDefaultValues()
        }
    }
    
    private func setDefaultValues() {
        onBoardingScreens = [
            OnBoardingPageModel(imageName: "Landing_1",
                                title: "Find a dream home\nfor everyone",
                                description: "Explore millions of places for you and your family to unwind in."),
            
            OnBoardingPageModel(imageName: "Landing_2",
                                title: "Compare and\nchoose together",
                                description: "Pool, or no? Trip Boards help you talk about options with the group."),
            
            OnBoardingPageModel(imageName: "Landing_3",
                                title: "Info you need,\nwhat you need",
                                description: "Pull up booking updates, messages from the owner, or get help from our team."),
            
            OnBoardingPageModel(imageName: "Landing_4",
                                title: "More trip ideas?\nWe've got you.",
                                description: "Nearby or overseas, get tons of recommendations, all in one spot!")
        ]
    }
    
    /**
     This method is responsible for getting total count of the onbarding screens to be shownn to user
     - returns: A total count of onBoarding Screens
     */
    func getTotalCount() -> Int {
        return onBoardingScreens.count
    }
    
    /**
    This method is responsible for getting object of onBoarding Page Model object.
    - parameter indexPath: Pass the indexPath for which page model is required,
    - returns: A object of OnBoardingPageModel if it's a valid indexPath else nil is return
    */
    func getOnBoardScreenModel(for index: Int) -> OnBoardingPageModel? {
        if index < getTotalCount() {
            return onBoardingScreens[index]
        }
        return nil
    }
}
