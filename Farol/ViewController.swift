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
    var daysOfHabit: [HabitDate] = []
    var scenesInScreen: SceneManager = DEFAULTSCENES
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var congratulationNotification: UIView!
    @IBOutlet weak var dateOfCollectionViewLabel: UILabel!
    @IBOutlet weak var ilusionViewOfCollectionView: UIView!
    @IBOutlet weak var ilusionView: UIView!
    @IBOutlet weak var textViewInsight: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var insightQuestionLabel: UILabel!
    @IBOutlet weak var botaoTeste: UIButton!
    //@IBOutlet weak var environment: UIImageView!
    
    @IBOutlet weak var calendarCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForegroundCheckIfIsNewHabitDay), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        checkIfFirstTimeInApp(reset: false)
        calendarCV.delegate = self
        calendarCV.dataSource = self
        textViewInsight.delegate = self
        configureTextViewInsight()
        configureSaveButton()
        
        congratulationNotification.center.y += 100
        congratulationNotification.layer.cornerRadius = 10
        ilusionViewOfCollectionView.layer.cornerRadius = 30
    }
    
    @objc func appMovedToForegroundCheckIfIsNewHabitDay() {
        let today = getTodayNumber()
        for habit in daysOfHabit {
            if habit.day == today {
                habit.habitDay = true
                calendarCV.reloadData()
            }
        }
    }

    func checkIfFirstTimeInApp(reset: Bool) {
        if reset == true {
            defaults.removeObject(forKey: "First Launch")
        } else {
            if defaults.bool(forKey: "First Launch") == true {
                print("Seconds+")

                // Run Code After First Launch
                daysOfHabit = calenDays(numOfDays: 21)

                defaults.set(true, forKey: "First Launch")
            } else {
                print("First")

                // Run Code At First Launch
                daysOfHabit = calenDays(numOfDays: 21)
                defaults.set(true, forKey: "First Launch")
            }
        }
    }

    var counterSaveButton = 0
    var saveTestToday = 1
    var actualDay = 0
    var daysCompleted = 0

    var testDay: String = ""
    
    func testSaveButton(date: String) {
        
        let today = getTodayNumber()
        var todayInt = Int(today)! + self.counterSaveButton
        if todayInt >= 31 {
            todayInt = self.saveTestToday
            self.saveTestToday += 1
        }
        let todayString = String(todayInt)
               
        for habit in self.daysOfHabit {
            if habit.day == todayString {
                habit.date = date
                habit.selecionavel = true
                habit.completed = true
                habit.insight = self.textViewInsight.text
                habit.testDay = date.replacingOccurrences(of: today, with: todayString)
                self.calendarCV.reloadData()
                break
            }
        }
        self.actualDay += 1
        self.counterSaveButton += 1
        testDay = date.replacingOccurrences(of: today, with: todayString)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let date = getCurrentDate()
        textViewInsight.isUserInteractionEnabled = false
        testSaveButton(date: date)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.insightQuestionLabel.alpha = 0
            self.textViewInsight.alpha = 0
            self.ilusionView.alpha = 0
            self.saveButton.alpha = 0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.textViewInsight.backgroundColor = UIColor(red: 43/255, green: 42/255, blue: 64/255, alpha: 0.0)
            self.ilusionView.backgroundColor = UIColor(red: 43/255, green: 42/255, blue: 64/255, alpha: 0.0)
            self.textViewInsight.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
            self.textViewInsight.textAlignment = .center
            
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.insightQuestionLabel.text = self.testDay
                self.insightQuestionLabel.alpha = 1
                self.textViewInsight.alpha = 1
                self.ilusionView.alpha = 1
            })
            self.backgroundImage.image = self.scenesInScreen.currentScene
            animateScene(imageView: self.backgroundImage, images: self.scenesInScreen.animatedScene,duration: 0.5,repeatCount: 5)
        }
        
        let todayInNumber = getTodayNumber()
        defaults.setValue(todayInNumber, forKey: "today")
                    
        daysCompleted += 1
        if daysCompleted == 21{
            print("huehue")
            botaoTeste.isHidden = true
            botaoTeste.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseInOut], animations: {
                    self.congratulationNotification.center.y += 100
                })
            }
        }
        UIView.animate(withDuration: 0.4, delay: 1, options: [.curveEaseInOut], animations: {
            self.congratulationNotification.center.y -= 100
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.botaoTeste.setTitleColor(UIColor(red: 63/255, green: 61/255, blue: 86/255, alpha: 1), for: .normal)
            self.botaoTeste.isEnabled = true
        }
        
    }
    
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
        for habit in daysOfHabit {
            if habit.day == todayString {
                habit.habitDay = true
                calendarCV.reloadData()
            }
        }
        
        var count = 0
        for habit in daysOfHabit {
            if habit.day == todayString {
                break
            }
            count += 1
        }
        counterBotaoTeste += 1
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.insightQuestionLabel.alpha = 0
            self.textViewInsight.alpha = 0
            self.ilusionView.alpha = 0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.insightQuestionLabel.text = "Qual seu insight de hoje?"
            
            self.textViewInsight.isUserInteractionEnabled = true
            self.textViewInsight.textAlignment = .left
            self.textViewInsight.text = nil
            self.textViewInsight.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
            self.textViewInsight.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                       
            self.ilusionView.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
            
            self.saveButton.isEnabled = false
            self.saveButton.backgroundColor = UIColor(red: 182/255, green: 182/255, blue: 182/255, alpha: 1)
            self.saveButton.setTitleColor(UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1), for: .normal)
            
            self.botaoTeste.setTitleColor(UIColor(red: 182/255, green: 182/255, blue: 182/255, alpha: 1), for: .normal)
            self.botaoTeste.isEnabled = false
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.insightQuestionLabel.alpha = 1
                self.saveButton.alpha = 1
                self.ilusionView.alpha = 1
                self.textViewInsight.alpha = 1
                
                let desiredPosition = IndexPath(item: count, section: 0)
                self.calendarCV.scrollToItem(at: desiredPosition, at: .centeredHorizontally, animated: false)
                self.calendarCV.layoutIfNeeded()
            })
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseInOut], animations: {
            self.congratulationNotification.center.y += 100
        })
    }
    
    func configureTextViewInsight() {
        textViewInsight.roundCorners([.bottomLeft, .bottomRight], radius: 12)
        ilusionView.roundCorners([.topLeft, .topRight], radius: 12)
        textViewInsight.contentInset = UIEdgeInsets(top: 3, left: 10, bottom: 5, right: 10)
    }
    
    func configureSaveButton() {
        saveButton.layer.cornerRadius = 15
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysOfHabit.count
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        cell.day = daysOfHabit[indexPath.item]
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
        let pickedDay = daysOfHabit[indexPath.item]
        
        let todayNumber = getTodayNumber()
        var todayInt = Int(todayNumber)! + actualDay
        if todayInt >= 31 {
            todayInt = todayInt - 30
        }
        
        let todayString = String(todayInt)
        
        backgroundImage.image = pickedDay.scenes.defaultScene
        scenesInScreen = pickedDay.scenes
        
        if pickedDay.selecionavel == true && pickedDay.day != todayString { // O codigo oficial aqui é "pickedDay.selecionavel == true && pickedDay.day != todayString"
            print("kkk \(pickedDay.day)")
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.insightQuestionLabel.alpha = 0
                self.textViewInsight.alpha = 0
                self.ilusionView.alpha = 0
                self.saveButton.alpha = 0
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.textViewInsight.backgroundColor = UIColor(red: 43/255, green: 42/255, blue: 64/255, alpha: 0.0)
                self.ilusionView.backgroundColor = UIColor(red: 43/255, green: 42/255, blue: 64/255, alpha: 0.0)
                self.textViewInsight.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                self.textViewInsight.textAlignment = .center
                self.insightQuestionLabel.text = pickedDay.testDay
                self.textViewInsight.text = pickedDay.insight
                self.textViewInsight.textAlignment = .center
                self.textViewInsight.isUserInteractionEnabled = false
                
                UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                    self.insightQuestionLabel.alpha = 1
                    self.textViewInsight.alpha = 1
                    self.ilusionView.alpha = 1
                })
            }
        } else if pickedDay.day == todayString {
            print("hihihi \(pickedDay.day)")
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.insightQuestionLabel.alpha = 0
                self.textViewInsight.alpha = 0
                self.ilusionView.alpha = 0
                self.saveButton.alpha = 0
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.insightQuestionLabel.text = "Qual seu insight de hoje?"
           
                self.textViewInsight.isUserInteractionEnabled = true
                self.textViewInsight.textAlignment = .left
                self.textViewInsight.text = nil
                self.textViewInsight.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
                self.textViewInsight.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                      
                self.ilusionView.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
           
                self.saveButton.isEnabled = false
                self.saveButton.backgroundColor = UIColor(red: 182/255, green: 182/255, blue: 182/255, alpha: 1)
                self.saveButton.setTitleColor(UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1), for: .normal)
           
                self.botaoTeste.setTitleColor(UIColor(red: 182/255, green: 182/255, blue: 182/255, alpha: 1), for: .normal)
                self.botaoTeste.isEnabled = false
           
                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                    self.insightQuestionLabel.alpha = 1
                    self.saveButton.alpha = 1
                    self.ilusionView.alpha = 1
                    self.textViewInsight.alpha = 1
                })
            }
        }
    }
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if text != "" {
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor(red: 255/255, green: 154/255, blue: 34/255, alpha: 1)
            saveButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = UIColor(red: 182/255, green: 182/255, blue: 182/255, alpha: 1)
            saveButton.setTitleColor(UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1), for: .normal)
        }
    }
}
