//
//  ViewController.swift
//  reminderapp
//
//  Created by Sara Kuroda  on 2021/01/11.
//  Copyright © 2021 Sara Kuroda . All rights reserved.
//

import UserNotifications
import UIKit

struct reminderapp {
    let title: String
    let date: Date
    let identifier: String
}

class ViewController: UIViewController {

    @IBOutlet var table: UITableView!

    var models = [reminderapp]()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self as UITableViewDelegate //as? UITableViewDelegate
        table.dataSource = self as UITableViewDataSource  //before: table.dataSource = self
    }

    @IBAction func didTapAdd() {
        // show add vc
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }

        vc.completion = { title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = reminderapp(title: title, date: date, identifier: "id_\(title)")
                self.models.append(new)
                self.table.reloadData()

                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body

                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                                                                          from: targetDate),
                                                            repeats: false)

                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                })
            }
        }
        navigationController?.pushViewController(vc, animated: true)

    }
}
//added this after adding memo part
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        cell.detailTextLabel?.text = formatter.string(from: date)

        cell.textLabel?.font = UIFont(name: "Callibri", size: 26)
        cell.detailTextLabel?.font = UIFont(name: "Callibri", size: 24)
        return cell
    }

}
