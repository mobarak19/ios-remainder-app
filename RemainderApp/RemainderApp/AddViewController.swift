//
//  AddViewController.swift
//  RemainderApp
//
//  Created by Mobarak on 3/7/22.
//

import UIKit

class AddViewController: UIViewController {

    
    var titleF : UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Title"
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.layer.cornerRadius = 5
        return field
    } ()
    var bodyF : UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Body"
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.layer.cornerRadius = 5
        field.textAlignment = .left
        return field
    } ()
    
    var datePicker : UIDatePicker = {
        let field = UIDatePicker()
        return field
    } ()

    
    public var completion :((String,String,Date)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpTitleF()
        setUpBodyF()
        setUpDatePicker()
        setUpSaveBtn()
    }
    
    func setUpTitleF()  {
        titleF.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleF)
        titleF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive =  true
        titleF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive =  true
        titleF.topAnchor.constraint(equalTo: view.topAnchor, constant: navigationController!.navigationBar.frame.height).isActive =  true
        titleF.heightAnchor.constraint(equalToConstant: 52).isActive = true

    }
    func setUpBodyF()  {
        bodyF.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bodyF)
        bodyF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive =  true
        bodyF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive =  true
        bodyF.topAnchor.constraint(equalTo: titleF.bottomAnchor, constant: 10).isActive =  true
        bodyF.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    func setUpDatePicker()  {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive =  true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive =  true
        datePicker.topAnchor.constraint(equalTo: bodyF.bottomAnchor, constant: 10).isActive =  true
        datePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    func setUpSaveBtn()  {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTappedSaved))
    }
    
    @objc func didTappedSaved(){
        if let titleText = titleF.text,!titleText.isEmpty,
           let bodyText = bodyF.text,!bodyText.isEmpty{
            let targetDate = datePicker.date

            completion?(titleText,bodyText,targetDate)
        }
    }

}
