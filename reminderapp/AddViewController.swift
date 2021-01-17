
//
//  AddViewController.swift
//  reminderapp
//
//  Created by Sara Kuroda  on 2021/01/11.
//  Copyright © 2021 Sara Kuroda . All rights reserved.
//

import UIKit

//remindersページのプラスボタン押した時に開く画面
class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    public var completion: ((String, String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        bodyField.delegate = self
        navigationItem.title = "Don't forget to stay hydrated!"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }

    @objc func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty,
            let bodyText = bodyField.text, !bodyText.isEmpty {
            let targetDate = datePicker.date

            completion?(titleText, bodyText, targetDate)

        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
