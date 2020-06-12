//
//  ViewController.swift
//  Farol
//
//  Created by yury antony on 04/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

// TODO
// Ainda é preciso:
// CODIGO
// 1 - Conectar a collectionView pra fazer o calendario
// 1.1 - botar logica pra aparecer dia anterior quando apertar numa celula do calendario
// 1.2 - implementar o calendario
// 1.3 - fazer um calendario de 29 dias
// 2 - fazer os passos que estao dentro do action saveButtonAction
// 3 - fazer auto layout (DEIXAR PRO FINAL)

// FORA CODIGO
// 1 - Ver como saber a data do dia atual
// 2 - onde verificar a data do dia e ver se ele ja esta no outro dia pra resetar a ui




import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var daysOfChallenge = calenDays(numOfDays: 29)
    
    @IBOutlet weak var textViewInsight: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var insightQuestionLabel: UILabel!
    
    @IBOutlet weak var calendarCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarCV.delegate = self
        calendarCV.dataSource = self
        configureTextViewInsight()
        configureSaveButton()
        textViewInsight.textContainer.maximumNumberOfLines = 7
        textViewInsight.textContainer.lineBreakMode = .byWordWrapping
        
        let today = getTodayNumber()
        var count = 0
        for challenge in daysOfChallenge {
            if challenge.day == today {
                challenge.challengeDay = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        textViewInsight.isHidden = true
        textViewInsight.layer.borderWidth = 0
        textViewInsight.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.textViewInsight.textAlignment = .center
            self.textViewInsight.isHidden = false
            
            let date = getCurrentDate()
            self.insightQuestionLabel.text = date
        }
        // quando apertar o botão tem que:
        // 1- iniciar animação da bola de loading e fazer a animação do farol
        // depois que terminar as animações do farol e do loading, tem que:
        // 1 - label "qual seu insight de hoje tem que mudar pro dia de hoje"
        // 2 - mostrar insight no text view
        // 3 - marcar a bola no calendario
        // 4 - fazer o botão "salvar" sumir.
        // 5 - mostrar a notificação que foi salva
    }
    
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
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 77)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(111)
    }
}
