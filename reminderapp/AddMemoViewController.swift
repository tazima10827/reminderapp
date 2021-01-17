//
//  EntryViewController.swift
//  memo
//
//  Created by Sara Kuroda  on 2021/01/12.
//  Copyright © 2021 Sara Kuroda . All rights reserved.
//

import UIKit

//Notesのページでプラスボタン押した時に開く画面
class AddMemoViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!

    //saveボタンをタップした時にデータに問題がなければ、成功したことを他の他のファイルに伝えるもの。
    public var completion: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "note"
        navigationItem.largeTitleDisplayMode = .never
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }

    //saveボタンをタップした時に呼ばれる
    @objc func didTapSave() {
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            completion?(text, noteField.text)
        }
    }


}

