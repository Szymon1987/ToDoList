//
//  MainViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 31/01/2022.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BaseCellProtocol {
    func updateTitle(sender: BaseCell, title: String) {
            if navigationItem.rightBarButtonItem != nil {
                navigationItem.setRightBarButton(nil, animated: false)
        }
        saveData()
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let navDoneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
//    let binButton = UIBarButtonItem(image: UIImage(named: "bin"), landscapeImagePhone: UIImage(named: "bin"), style: .plain, target: self, action: #selector(binPressed))
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
//    @objc func binPressed() {
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupNavigationButtons()
    }
   
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    let roundedButton: RoundedButton = {
        let button = RoundedButton()
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func addTapped() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as? BaseCell else {
            fatalError("Unable to dequeue the cell as BaseCell")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, handler in
            self.remove(at: indexPath)
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        }
        let rename = UIContextualAction(style: .normal, title: "Edit") { action, view, handler in
            self.rename(at: indexPath)
        }
        rename.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [delete, rename])
    }

    @objc func doneButtonPressed() {
        // not sure if this code is correct (tableview.visibleCells.forEach???, might not be efficient)
        tableView.visibleCells.forEach { cell in
            if let cell = cell as? BaseCell, let title = cell.textField.text {
                cell.textField.isUserInteractionEnabled = false
                cell.baseCellDelegate?.updateTitle(sender: cell, title: title)
            }
        }
    }
    
    private func setupNavigationController() {
        navigationItem.backBarButtonItem?.tintColor = .black
        navigationItem.setRightBarButton(nil, animated: true)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = ColorManager.background
//                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

//                navigationController?.navigationBar.tintColor = .white
//                navigationController?.navigationBar.standardAppearance = appearance
//                navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupNavigationButtons() {
        navigationItem.rightBarButtonItems = []
    }
    
    func saveData() {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    
    func remove(at indexPath: IndexPath) {
    }
    
    func setupViews() {
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: -8))
        
        view.addSubview(roundedButton)
        roundedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        roundedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        roundedButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        roundedButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
    }

    func rename(at indexPath: IndexPath) {
        tableView.isEditing = false
        if let cell = tableView.cellForRow(at: indexPath) as? BaseCell {
            // solution below is questionable, find better one
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                cell.textField.isUserInteractionEnabled = true
                cell.textField.becomeFirstResponder()
                if self.navigationItem.rightBarButtonItem == nil {
//                    self.navigationItem.setRightBarButton(self.navDoneButton, animated: true)
                    self.navigationItem.rightBarButtonItems?.append(self.navDoneButton)
                }
                
            }
        }
        
    }
    
}
