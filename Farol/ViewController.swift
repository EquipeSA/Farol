//
//  ViewController.swift
//  Farol
//
//  Created by yury antony on 04/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let defaults = UserDefaults.standard

    var daysOfChallenge: [ChallengeDate] = []
    
    @IBOutlet weak var textViewInsight: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var insightQuestionLabel: UILabel!
    @IBOutlet weak var botaoTeste: UIButton!
    
    @IBOutlet weak var calendarCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForegroundCenterCollectionView), name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForegroundCheckIfIsChallengeDay), name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForegroundCheckIfIsNewDayToResetUI), name: UIApplication.willEnterForegroundNotification, object: nil)

        checkIfFirstTimeInApp(reset: false)
        calendarCV.delegate = self
        calendarCV.dataSource = self
        configureTextViewInsight()
        configureSaveButton()
        textViewInsight.textContainer.maximumNumberOfLines = 7
        textViewInsight.textContainer.lineBreakMode = .byWordWrapping
    }
    
    @objc func appMovedToForegroundCheckIfIsNewDayToResetUI() {
        let today = getTodayNumber()
        if defaults.string(forKey: "today") != today {
            let date = getCurrentDate()
            insightQuestionLabel.text = date
            
            textViewInsight.isHidden = false
            textViewInsight.layer.borderWidth = 0.5
            textViewInsight.isUserInteractionEnabled = true
            textViewInsight.textAlignment = .left
            textViewInsight.text = nil
            saveButton.isHidden = false
        }
    }
    
    @objc func appMovedToForegroundCheckIfIsChallengeDay() {
        let today = getTodayNumber()
        for challenge in daysOfChallenge {
            if challenge.day == today {
                challenge.challengeDay = true
                calendarCV.reloadData()
            }
        }
    }
    
    @objc func appMovedToForegroundCenterCollectionView() {
        var count = 0
        let today = getTodayNumber()
        for challenge in daysOfChallenge {
            if challenge.day == today {
                break
            }
            count += 1
        }
        
        let desiredPosition = IndexPath(item: count, section: 0)
        calendarCV.scrollToItem(at: desiredPosition, at: .centeredHorizontally, animated: false)
        calendarCV.layoutIfNeeded()
    }

    func checkIfFirstTimeInApp(reset: Bool) {
        if reset == true {
            defaults.removeObject(forKey: "First Launch")
        } else {
            if defaults.bool(forKey: "First Launch") == true {
                print("Seconds+")
                       
                // Run Code After First Launch
                daysOfChallenge = calenDays(numOfDays: 21)
                       
                defaults.set(true, forKey: "First Launch")
            } else {
                print("First")
                
                // Run Code At First Launch
                daysOfChallenge = calenDays(numOfDays: 21)
                defaults.set(true, forKey: "First Launch")
            }
        }
    }
    
    var counterSaveButton = 0
    var saveTestToday = 1
    var actualDay = 0
    var daysCompleteds = 0

    @IBAction func saveButtonAction(_ sender: Any) {
        textViewInsight.isHidden = true
        textViewInsight.layer.borderWidth = 0
        textViewInsight.isUserInteractionEnabled = false
        saveButton.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.textViewInsight.textAlignment = .center
            self.textViewInsight.isHidden = false
            
//            let date = getCurrentDate()
//            self.insightQuestionLabel.text = date
//            let today = getTodayNumber()
//            for challenge in self.daysOfChallenge {
//                if challenge.day == today {
//                    challenge.completed = true
//                    challenge.date = date
//                    challenge.selecionavel = true
//                    challenge.insight = self.textViewInsight.text
//                    self.calendarCV.reloadData()
//                    print(challenge.insight ?? "eh nil")
//                    break
//                }
//            }
            
            //essa parte do codigo e so pra testar os proximos dias
            let date = getCurrentDate()
            self.insightQuestionLabel.text = date

            let today = getTodayNumber()
            var todayInt = Int(today)! + self.counterSaveButton
            if todayInt >= 31 {
                todayInt = self.saveTestToday
                self.saveTestToday += 1
            }
            let todayString = String(todayInt)

            for challenge in self.daysOfChallenge {
                if challenge.day == todayString {
                    challenge.date = date
                    challenge.selecionavel = true
                    challenge.completed = true
                    challenge.insight = self.textViewInsight.text
                    self.calendarCV.reloadData()
                    break
                }
            }
            self.actualDay += 1
            self.counterSaveButton += 1
            //fim da parte de teste
        }
        let todayInNumber = getTodayNumber()
        defaults.setValue(todayInNumber, forKey: "today")
        
        daysCompleteds += 1
        if daysCompleteds == 21{
            botaoTeste.isHidden = true
            botaoTeste.isUserInteractionEnabled = false
        }
    }
    
    // o que ta dentro desse comentario é teste tambem
    var counterBotaoTeste = 1
    var testToday = 1
    
    @IBAction func botaoTeste(_ sender: Any) {
        let today = getTodayNumber()
        var todayInt = Int(today)! + counterBotaoTeste
        if todayInt >= 31 {
            todayInt = testToday
            testToday += 1
        }
        print(todayInt)
        let todayString = String(todayInt)
        for challenge in daysOfChallenge {
            if challenge.day == todayString {
                challenge.challengeDay = true
                calendarCV.reloadData()
            }
        }
        
        var count = 0
        for challenge in daysOfChallenge {
            if challenge.day == todayString {
                break
            }
            count += 1
        }
               
        let desiredPosition = IndexPath(item: count, section: 0)
        calendarCV.scrollToItem(at: desiredPosition, at: .centeredHorizontally, animated: false)
        calendarCV.layoutIfNeeded()
        
        counterBotaoTeste += 1
        
        
        textViewInsight.isHidden = false
        textViewInsight.layer.borderWidth = 0.5
        textViewInsight.isUserInteractionEnabled = true
        textViewInsight.textAlignment = .left
        textViewInsight.text = nil
        saveButton.isHidden = false
    }
    // fim do comentario
    
    
    func configureTextViewInsight() {
        textViewInsight.layer.borderColor = UIColor.black.cgColor
        textViewInsight.layer.borderWidth = 0.5
        textViewInsight.layer.cornerRadius = 12
        textViewInsight.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func configureSaveButton() {
        saveButton.layer.cornerRadius = 5
        saveButton.layer.borderWidth = 0.5
        saveButton.layer.borderColor = UIColor.black.cgColor
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysOfChallenge.count
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        cell.day = daysOfChallenge[indexPath.item]
        if indexPath.item == 0 || indexPath.item == 1 || indexPath.item == 2 {
            cell.isUserInteractionEnabled = false
        } else {
            cell.isUserInteractionEnabled = true
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 77)
    }
    
    var testTodayClick = 1
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("kk")
        let day = daysOfChallenge[indexPath.item]
        
        let today = getTodayNumber()
        var todayInt = Int(today)! + self.actualDay
        if todayInt >= 31 {
            todayInt = testTodayClick
            testTodayClick += 1
        }
        
        let todayString = String(todayInt)
        
        if day.selecionavel == true {
            insightQuestionLabel.text = day.date!
            textViewInsight.isHidden = false
            textViewInsight.text = day.insight!
            textViewInsight.layer.borderWidth = 0
            textViewInsight.isUserInteractionEnabled = false
            self.textViewInsight.textAlignment = .center
            saveButton.isHidden = true
        } else if day.day == todayString {
            insightQuestionLabel.text = "Qual seu insight de hoje?"
            textViewInsight.isHidden = false
            textViewInsight.text = nil
            textViewInsight.layer.borderWidth = 0.5
            textViewInsight.isUserInteractionEnabled = true
            self.textViewInsight.textAlignment = .left
            saveButton.isHidden = false
        }
    }
    
}
