//
//  ViewController.swift
//  RemainderApp
//
//  Created by Mobarak on 3/6/22.
//

import UIKit

class ViewController: UIViewController {
    let tableView : UITableView = {
        let table = UITableView()
        return table
    } ()
    let navView = UIView()
    var models = [RemainderModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBar()
        addTableView()
        addRightBarBtn()
        addLeftTestBtn()
        
    }
    func addLeftTestBtn()  {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Test", style: .done, target: self, action: #selector(testBtnTapped))
    }
    @objc func testBtnTapped(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
            if success {
                self.setTestNotification()
            }else{
                print(error)
            }
        }
    }
    func setTestNotification()  {
        let content = UNMutableNotificationContent()
        content.title = "Helo world"
        content.body = "Nofificatin body Nofificatin body Nofificatin bodyNofificatin body"
        content.sound  = .default
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "some_log_id", content: content, trigger: trigger)
        
        
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print(error)
            }
        }
    }
    
    func addRightBarBtn()  {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRemainderTapped))
    }
    @objc func addRemainderTapped(){
        let vc = AddViewController()
        vc.title = "New Remainder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = {title,body,date in
            
            print(title)
            print(body)
            print(date)
            
            DispatchQueue.main.async {
                
                self.navigationController?.popToRootViewController(animated: true)

            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func addNavBar()  {
        navView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navView)
        navView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        navView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:0).isActive = true
        navView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        navView.heightAnchor.constraint(equalToConstant: (navigationController?.navigationBar.frame.height ?? 10)).isActive =  true
    }
    func addTableView()  {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 50).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.dataSource = self
        tableView.delegate = self

    }


}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        return cell
    }
    
    
}


struct RemainderModel {
    let title:String
    let date : Date
    let indentifire: String
}
