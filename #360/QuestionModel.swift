//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Jonathan Martinez on 9/14/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

class Question {
  
  var question: String
  var option0: String
  var option1: String
  var option2: String
  var option3: String
  var correctAnswer: String
  
  init(question: String, option0: String, option1: String, option2: String, option3: String,correctAnswer: String){
    self.question = question
    self.option0 = option0
    self.option1 = option1
    self.option2 = option2
    self.option3 = option3
    self.correctAnswer = correctAnswer
  }
}

var question1 = (question: "Who is the Principal of HKUST?", option0: "Tony F Chan", option1: "Lee Shau-Kee", option2: "Chu Ching-wu", option3: "Chia-Wei Woo", correctAnswer: "Tony F Chan")
var question2 = (question: "Where is HKUST", option0: "Choi Hung", option1: "Hang Hau", option2: "Sai Kung", option3: "Clear Water Bay", correctAnswer: "Clear Water Bay")
var question3 = (question: "How old is HKUST?", option0: "24", option1: "23", option2: "26", option3: "25", correctAnswer: "25")
var question4 = (question: "How many restaurants inside HKUST?", option0: "9", option1: "15", option2: "13", option3: "17", correctAnswer: "15")
var question5 = (question: "How many student residencial hall in HKUST?", option0: "12", option1: "10", option2: "9", option3: "11", correctAnswer: "12")
var question6 = (question:  "How big is HKUST?", option0: "56 Hectares", option1: "50 Hectares", option2: "58 Hectares", option3: "54 Hectares", correctAnswer: "58 Hectares")
var question7 = (question: "Which one you cannot study in HKUST", option0: "Accounting", option1: "Physics", option2: "Electronic Engineering", option3: "Education", correctAnswer: "Education")


var allQuestions = [question1, question2, question3, question4, question5, question6, question7]
