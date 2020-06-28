//
//  ViewController.swift
//  Farol
//
//  Created by yury antony on 04/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("HabitDays.plist")
    
    let defaults = UserDefaults.standard
    var daysOfHabit: [HabitDate] = []
    var farolAcendeImages: [UIImage] = []
    var completedTodayHabit: Bool = false
    var daysNotCompleted: Int = 0
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var congratulationNotification: UIView!
    @IBOutlet weak var dateOfCollectionViewLabel: UILabel!
    @IBOutlet weak var ilusionViewOfCollectionView: UIView!
    @IBOutlet weak var ilusionView: UIView!
    @IBOutlet weak var textViewInsight: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var insightQuestionLabel: UILabel!
    @IBOutlet weak var environment: UIImageView!
    
    @IBOutlet weak var calendarCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        
        farolAcendeImages = createImageArray(total: 5, imagePrefix: "farolAcendendo")
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(dayChanged), name: .NSCalendarDayChanged, object: nil)
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
        
        let today = getTodayNumber()
        for habit in daysOfHabit {
            if habit.day == today {
                if habit.badUI == true {
                    // botar ui feia aqui
                    print("BAD UI")
                } else if habit.completed == true {
                    self.insightQuestionLabel.isHidden = true
                    self.textViewInsight.isHidden = true
                    self.ilusionView.isHidden = true
                    self.saveButton.isHidden = true
                                  
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.textViewInsight.backgroundColor = UIColor(red: 43/255, green: 42/255, blue: 64/255, alpha: 0.0)
                        self.ilusionView.backgroundColor = UIColor(red: 43/255, green: 42/255, blue: 64/255, alpha: 0.0)
                        self.textViewInsight.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                        self.textViewInsight.textAlignment = .center
                        self.insightQuestionLabel.text = habit.date!
                        self.textViewInsight.text = habit.insight
                        self.textViewInsight.textAlignment = .center
                        self.textViewInsight.isUserInteractionEnabled = false
                                      
                        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                            self.insightQuestionLabel.isHidden = false
                            self.textViewInsight.isHidden = false
                            self.ilusionView.isHidden = false
                        })
                    }
                } else if habit.day == today && habit.completed == false {
                    self.insightQuestionLabel.isHidden = true
                    self.textViewInsight.isHidden = true
                    self.ilusionView.isHidden = true
                    self.saveButton.isHidden = true
                    
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

                        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                            self.insightQuestionLabel.isHidden = false
                            self.saveButton.isHidden = false
                            self.ilusionView.isHidden = false
                            self.textViewInsight.isHidden = false
                        })
                    }
                }
            }
        }
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(daysOfHabit)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                daysOfHabit = try decoder.decode([HabitDate].self, from: data)
            } catch {
                print("Error decoding habitDays array, \(error)")
            }
        }
    }
    
    func resetAll() {
        daysNotCompleted = 0
        daysOfHabit = calenDays(numOfDays: 21)
        DispatchQueue.main.async {
            self.calendarCV.reloadData()
        }
        
    }
    
    @objc func dayChanged() {
        print("dayChanged")
        if completedTodayHabit == false {
            daysNotCompleted += 1
            print("days not completed \(daysNotCompleted)")
            completedTodayHabit = false
            if daysNotCompleted >= 3 {
                print("reset tudo")
                resetAll()
                saveItems()
                print("save no dia mudado e reset tudo, tem que ver se resetou tudo")
            } else {
                let yesterday = getTodayNumberInt() - 1
                let yesterdayString = String(yesterday)
                for habit in daysOfHabit {
                    if habit.day == yesterdayString {
                        habit.badUI = true
                    }
                }
                let lastDayOfChallengeString = daysOfHabit.last?.day
                let newHabitAdded = Int(lastDayOfChallengeString!)! + 1
                let newHabitDayAddedToLastPosition = String(newHabitAdded)
                let newDays = calenDays(numOfDays: 21)
                for day in newDays {
                    if day.day == newHabitDayAddedToLastPosition {
                        daysOfHabit.append(day)
                        DispatchQueue.main.async {
                            self.calendarCV.reloadData()
                        }
                    }
                }
                saveItems()
                print("save no dia mudado e menos de 3 erros, tem que ver se adicionou so um no final")
            }
        } else {
            completedTodayHabit = false
            daysNotCompleted = 0
        }
        
        let today = getTodayNumber()
        for habit in daysOfHabit {
            if habit.day == today {
                habit.habitDay = true
                DispatchQueue.main.async {
                    self.calendarCV.reloadData()
                }
                saveItems()
                print("save no dia mudado, aqui verifica se é o do dia para botar bolinha roxa vazia")
            }
        }
        
        var count = 0
        for habit in daysOfHabit {
            if habit.day == today {
                break
            }
            count += 1
        }
        
        DispatchQueue.main.async {
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
        }
    }
    
    @objc func appMovedToForegroundCheckIfIsNewHabitDay() {
        print("observador")
        let today = getTodayNumber()
        for habit in daysOfHabit {
            if habit.day == today {
                habit.habitDay = true
                saveItems()
                print("save quando verifica se eh dia do habito para mudar pra bolinha roxa vazia")
                DispatchQueue.main.async {
                    self.calendarCV.reloadData()
                }
            }
        }
        loadItems()
        DispatchQueue.main.async {
            self.calendarCV.reloadData()
        }
        var count = 0
        for habit in daysOfHabit {
            if habit.day == today {
                break
            }
            count += 1
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            let desiredPosition = IndexPath(item: count, section: 0)
            self.calendarCV.scrollToItem(at: desiredPosition, at: .centeredHorizontally, animated: false)
            self.calendarCV.layoutIfNeeded()
        })
        
        // kikiki
        for habit in daysOfHabit {
            if habit.day == today {
                if habit.badUI == true {
                           // botar ui feia aqui
                           print("BAD UI")
                       } else if habit.completed == true {
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
                               self.insightQuestionLabel.text = habit.date!
                               self.textViewInsight.text = habit.insight
                               self.textViewInsight.textAlignment = .center
                               self.textViewInsight.isUserInteractionEnabled = false
                               
                               UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                                   self.insightQuestionLabel.alpha = 1
                                   self.textViewInsight.alpha = 1
                                   self.ilusionView.alpha = 1
                               })
                           }
                       } else if habit.day == today && habit.completed == false {
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
    }

    func checkIfFirstTimeInApp(reset: Bool) {
        if reset == true {
            defaults.removeObject(forKey: "First Launch")
        } else {
            if defaults.bool(forKey: "First Launch") == true {
                print("Not first time in the app")
                let today = getTodayNumber()
                loadItems()
                var count = 0
                for habit in daysOfHabit {
                    if habit.day == today {
                        break
                    }
                    count += 1
                }
                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                    let desiredPosition = IndexPath(item: count, section: 0)
                    self.calendarCV.scrollToItem(at: desiredPosition, at: .centeredHorizontally, animated: false)
                    self.calendarCV.layoutIfNeeded()
                })
            } else {
                // Run Code At First Launch
                print("First time in the app")
                // Run Code After First Launch
                daysOfHabit = calenDays(numOfDays: 21)
                saveItems()
                print("salvando habitos primeira vez que entra no app")
                defaults.set(true, forKey: "First Launch")
            }
        }
    }
    var daysCompleted = 0
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let date = getCurrentDate()
        completedTodayHabit = true
        textViewInsight.isUserInteractionEnabled = false
        let today = getTodayNumber()
        for habit in daysOfHabit {
            if habit.day == today {
                habit.completed = true
                habit.date = date
                habit.incompleted = false
                habit.selecionavel = true
                habit.badUI = false
                habit.insight = self.textViewInsight.text
                DispatchQueue.main.async {
                    self.calendarCV.reloadData()
                }
                saveItems()
                print("salva quando adiciona um insight")
                break
            }
        }
        
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
                self.insightQuestionLabel.text = date
                self.insightQuestionLabel.alpha = 1
                self.textViewInsight.alpha = 1
                self.ilusionView.alpha = 1
            })
            DispatchQueue.main.async {
                animate(imageView: self.environment, images: self.farolAcendeImages,duration: 2,repeatCount: 2)
            }
        }
                    
        daysCompleted += 1
        if daysCompleted == 21{
            print("HABITO CRIADO")
            NotificationCenter.default.removeObserver(self)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseInOut], animations: {
                self.congratulationNotification.center.y += 100
            })
        }
        
        UIView.animate(withDuration: 0.4, delay: 1, options: [.curveEaseInOut], animations: {
            self.congratulationNotification.center.y -= 100
        })
        
        var count = 0
        for habit in daysOfHabit {
            if habit.day == today {
                break
            }
            count += 1
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            let desiredPosition = IndexPath(item: count, section: 0)
            self.calendarCV.scrollToItem(at: desiredPosition, at: .centeredHorizontally, animated: false)
            self.calendarCV.layoutIfNeeded()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pickedDay = daysOfHabit[indexPath.item]
        let todayNumber = getTodayNumber()
        
        if pickedDay.badUI == true {
            // botar ui feia aqui
            print("BAD UI")
        } else if pickedDay.completed == true {
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
                self.insightQuestionLabel.text = pickedDay.date!
                self.textViewInsight.text = pickedDay.insight
                self.textViewInsight.textAlignment = .center
                self.textViewInsight.isUserInteractionEnabled = false
                
                UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                    self.insightQuestionLabel.alpha = 1
                    self.textViewInsight.alpha = 1
                    self.ilusionView.alpha = 1
                })
            }
        } else if pickedDay.day == todayNumber && pickedDay.completed == false {
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
