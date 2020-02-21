//
//  ViewController.swift
//  Test 14. feb
//
//  Created by Anton on 14/02/2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    var file = "file.txt"
    
    var currentRow = -1
    
    var text = ""
    
    var textArray = [String]() //An empty string array
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var textField: UITextView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textArray.append("hello")
        textArray.append("whats up")
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.text = text
    }

    @IBAction func saveText(_ sender: Any) {
        text = textField.text
        if currentRow > -1{
            textArray[currentRow] = text
            currentRow = -1
        }else{
            textArray.append(text)
            }
        textField.text = ""
        tableView.reloadData()
        saveStringToFile(str: text, filename: "theString.txt")
        print(readStringFromFile(filename: "theString.txt"))
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = textArray[indexPath.row]
        return cell!
        
       }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: true)
        currentRow = indexPath.row
        textField.text = textArray[currentRow]
    }
    
    func saveStringToFile(str: String, filename:String){
        let filePath = getDocumentDir().appendingPathComponent(filename)
        do{
            try str.write(to: filePath, atomically: true, encoding: .utf8)
            print("ok writing")
        }catch{
            print("error")
        }
    }
    
    func readStringFromFile(filename: String) -> String{
        let filePath = getDocumentDir().appendingPathComponent(filename)
        do {let string = try String(contentsOf: filePath, encoding: .utf8)
            return string
        } catch  {
            print("could not read")
        }
        return "Empty"
    }
    
    func getDocumentDir() -> URL{
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentDir[0]
    }
    
}

