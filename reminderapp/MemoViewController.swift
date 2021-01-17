//
//  MemoViewController.swift
//  reminderapp
//
//  Created by Sara Kuroda  on 2021/01/12.
//  Copyright © 2021 Sara Kuroda . All rights reserved.
//

import UIKit

class MemoViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var noteLabel: UITextView!

    public var noteTitle: String = ""
    public var note: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = noteTitle
        noteLabel.text = note
    }


}
