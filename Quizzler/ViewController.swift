//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0 //Variable para saber en que pregunta estoy
    var score : Int = 0
    
    //Place your instance variables here
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()//llamo el metodo para saber si la respuesta es correcta
        
        questionNumber = questionNumber + 1 //sumo 1 y paso a la siguiente pregunta
       nextQuestion()
  
    }
    
    
    func updateUI() {
      
        scoreLabel.text = "Score: \(score)" //de esta forma puedo colocar una variable int en el string dentro del .text que solo recibe string
        progressLabel.text = "\(questionNumber + 1) / 13"
        //con esto de arriba digo en cual pregunta voy de 13
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
        //asi controlo la barra de progreso dividiendola en las porciones que necesito
        //Ademas que el CGFloat me convierte el Int en un Float
        
    }
    

    func nextQuestion() {
        
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            //coloco la pregunta en el label text
            
            updateUI()//llamo el metodo para actualizar el puntaje
            
        }else{
            let alert = UIAlertController(title: "Awesome", message: "you've finished all the question, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction)in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer //llamo la respuesta correcta a la pregunta
        
        if correctAnswer == pickedAnswer {//valido si respondio bien o no
            ProgressHUD.showSuccess("Correct")
            score += 1 // esta es la forma corta de escribir score=score+1
        } else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    
    func startOver() {
       questionNumber = 0
        nextQuestion()
        score = 0
    }
    

    
}
