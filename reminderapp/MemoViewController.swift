//
//  MemoViewController.swift
//  reminderapp
//
//  Created by Sara Kuroda  on 2021/01/12.
//  Copyright © 2021 Sara Kuroda . All rights reserved.
//

import UserNotifications
import UIKit

struct memoData {
    let title: String
    let body: String
}

class MemoViewController: UIViewController {
    @IBOutlet var table: UITableView!
    var models = [memoData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self as UITableViewDelegate //as? UITableViewDelegate
        table.dataSource = self as UITableViewDataSource  //before: table.dataSource = self
    }

    @IBAction func didTapAdd() {
        // show add vc
        guard let vc = storyboard?.instantiateViewController(identifier: "AddMemoViewController") as? AddMemoViewController else {
            return
        }

        vc.completion = { title, body in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = memoData(title: title, body: body)
                self.models.append(new)
                self.table.reloadData()
            }
        }
        navigationController?.pushViewController(vc, animated: true)

    }
}

//added this after adding memo part
extension MemoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


extension MemoViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].body

        cell.textLabel?.font = UIFont(name: "Callibri", size: 26)
        cell.detailTextLabel?.font = UIFont(name: "Callibri", size: 24)
        return cell
    }

}
