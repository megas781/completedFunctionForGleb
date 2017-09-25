//
//  LoginViewController.swift
//  SocialNet
//
//  Created by Gleb Kalachev on 4/21/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var loginTextField: UITextField!
   @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var signInOutlet: UIButton!
   @IBOutlet weak var signUpOutlet: UIButton!
   @IBOutlet weak var forgotPasswordOutlet: UIButton!
   
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
      print("the desired string: \"\(getProperArrayElement(ofArray: ["Первая Цитата","Вторая Цитата", "Третья Цитата","Четвертая Цитата", "Пятая Цитата"]))\"")
      
    }
   
   func getProperArrayElement<T>(ofArray theArray: [T]) -> T {
      
      //Дата, от которой будет вестись отсчет
      var initialDate: Date!
      //Здесь я создаю переменную currentDate вместо исользования Date(), чтобы было легко симулировать разные даты 
      let currentDate = Date()
      //Создаем календарь, с помощью которого будем узнавать час данной даты
      let calendar = Calendar.init(identifier: .gregorian)
      
      
      //MARK: Извлечение или создание новой даты отсчета
      
      //Здесь я обнулял initialDate для тестов
//      UserDefaults.standard.setValue(nil, forKey: "initialDate")
      
      //Если удалось извлечь по ключу "initialDate" то конфертируем Double значение обратно в Date
      if let retrivenTimeInterval = UserDefaults.standard.value(forKey: "initialDate") as? Double {
         initialDate = Date.init(timeIntervalSinceReferenceDate: retrivenTimeInterval)
         print("retrieved initialDate: \(initialDate)")
      } else {
         //Иначе создаем дату, от которой будем считать
         
         //Здесь можно симулировать initialDate
         initialDate = Date()
         
         print("initialDate before formatting: \(initialDate)")
            
         //Уменьшаем дату на час до тех пор, пока час у initialDate не станет 9 или 17
         while ![9,17].contains(calendar.dateComponents([.hour], from: initialDate).hour!) {
            initialDate = initialDate.addingTimeInterval(-3600)
         }
         
         print("initialDate after formatting : \(initialDate)")
         
         //После того, как уравняли часы, извлекаем компоненты
         let dateComponentsOfDateWithEqualizedHour = calendar.dateComponents([.timeZone,.year,.month,.day,.hour,], from: initialDate)
         
         initialDate = DateComponents.init(calendar: calendar, timeZone: TimeZone.current, year: dateComponentsOfDateWithEqualizedHour.year!, month: dateComponentsOfDateWithEqualizedHour.month!, day: dateComponentsOfDateWithEqualizedHour.day!, hour:dateComponentsOfDateWithEqualizedHour.hour!, minute: 0, second: 0, nanosecond: 0).date!
         
         //Просто принты
         print("currentDate: \(currentDate)")
         print("initialDate: \(initialDate)")
         
         UserDefaults.standard.setValue(initialDate.timeIntervalSinceReferenceDate, forKey: "initialDate")
      }
      
      //Теперь delta будет в секундах
      let deltaTimeInterval: Int = Int(currentDate.timeIntervalSince(initialDate))
      
      print("deltaTimeInterval  : \(deltaTimeInterval)")
      
      //Собственно, шаги
      let steps: Int = deltaTimeInterval/28800
      
      print("steps: \(steps)")
      
      //Количество переключений будет записываться сюда
      var primeIndex = 0
      
      switch calendar.dateComponents([.hour], from: initialDate).hour! {
      case 9:
         primeIndex = (steps / 3) * 2 + ((steps % 3 == 1) ? 1 : 0)
      case 17:
         primeIndex = (steps / 3) * 2 + ((steps % 3 == 2) ? 1 : 0)
      default:
         fatalError("Ошибка форматирования начальной даты")
      }
      return theArray[primeIndex % theArray.count]
   }
   
   
}
