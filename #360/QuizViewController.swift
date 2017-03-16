//
//  QuizViewController.swift
//  360Cam
//
//  Created by Silver on 29/10/2016.
//  Copyright © 2016 Tommy Lam. All rights reserved.
//

import UIKit
import GameKit

class QuizViewController: UIViewController {
    
    var allOfThem = allQuestions
    var questionsPerRound = allQuestions.count
    var questionCounter: Int = 0
    var questionsAsked: Int = 0
    var correctQuestions: Int = 0
    var gameSound: SystemSoundID = 0
    var optionsArray:[UIButton] = []

    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option0: UIButton!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        allOfThem = allQuestions.shuffle()
        displayQuestion()
        questionField.numberOfLines = 3

        // Do any additional setup after loading the view.
    }
    
    func displayScore() {
        
        optionsArray = setOptionsArray()
        
        for i in 0..<optionsArray.count {
            optionsArray[i].isHidden = true;
        }
        
        // Display play again button
       
        
        
//        if correctQuestions >= 5 {
            questionField.text = "You got \(correctQuestions) out of \(questionsPerRound) correct!"
            
//        }else{
//            questionField.text = "You got \(correctQuestions) out of \(questionsPerRound) correct! Sorry! Try again with another video."
//        }
        
    }

    
    func displayQuestion() {

        let currentQuestion = allOfThem[questionCounter]
        questionField.text = currentQuestion.question
    
        
        option0.setTitle(currentQuestion.option0, for: .normal)
        option1.setTitle(currentQuestion.option1, for: .normal)
        option2.setTitle(currentQuestion.option2, for: .normal)
        option3.setTitle(currentQuestion.option3, for: .normal)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        let currentQuestion = allOfThem[questionCounter]
        
        let chosenOption = sender.currentTitle!
        let correctAnswer = currentQuestion.correctAnswer
        
        var optionsArray:[UIButton] = setOptionsArray()
        
        questionsAsked += 1
        
        if chosenOption == correctAnswer {
           
            questionField.text = "Correct!"
            correctQuestions += 1
            
            for i in 0..<optionsArray.count {
                if optionsArray[i].currentTitle! != correctAnswer {
                    optionsArray[i].setTitleColor(setOpacity(), for: .normal)
                }else{
                    optionsArray[i].setTitleColor(.red, for: .normal)
                }
            }
        } else {
        
            for i in 0..<optionsArray.count {
                if optionsArray[i].currentTitle! != correctAnswer {
                    optionsArray[i].setTitleColor(setOpacity(), for: .normal)
                    
                    
                }else{
                    optionsArray[i].setTitleColor(.red, for: .normal)
                    
                }
            }
            questionField.text = "Sorry, wrong answer!"
        }
        questionCounter += 1
        loadNextRoundWithDelay(seconds: 3)
        
    }
    
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            let optionsArray:[UIButton] = setOptionsArray()
            
            for i in 0..<optionsArray.count {
                optionsArray[i].isHidden = false;
                optionsArray[i].setTitleColor(restoreOpacity(), for: .normal)
            }
            displayQuestion()
        }
    }
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        //let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
       // let dispatchTime = DispatchTime.now(dispatch_time_t(DISPATCH_TIME_NOW), delay) 
       // let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {  self.nextRound()
        })
        // change 2 to desired second delay.
     
        // Executes the nextRound method at the dispatch time on the main queue
       // dispatch_after(dispatchTime, dispatch_get_main_queue()) {
          //  self.nextRound()
       // }
    }

    func setOpacity() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.3)
    }
    
    func restoreOpacity() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
    
    func setOptionsArray() -> [UIButton] {
        var optionsArray:[UIButton] = []
        optionsArray.append(option0)
        optionsArray.append(option1)
        optionsArray.append(option2)
        optionsArray.append(option3)
        
        
        return optionsArray
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let DestViewController = segue.destination as? Videoviewer{
        
            DestViewController.videoname = "https://firebasestorage.googleapis.com/v0/b/fyp-12f9e.appspot.com/o/message_movies%2FB9171560-0AC8-4ED9-BB92-82AFBEE02A11.mov?alt=media&token=3be94e4c-fec6-4c46-8f7d-dcaf2620786b" as String;
        
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
