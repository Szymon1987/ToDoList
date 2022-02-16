//
//  MainViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 31/01/2022.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var initialCenter: CGPoint = .zero
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = ColorManager.viewBackground
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        notificationForKeyboard()
    }
    // MARK: - UIComponents
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = ColorManager.viewBackground
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var roundedButton: RoundedButton = {
         let button = RoundedButton()
         button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
         return button
     }()
 
    // MARK: - TableView data source
    
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
    
    // MARK: - Helpers
    
    func notificationForKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
          // if keyboard size is not available for some reason, dont do anything
          return
        }
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height , right: 0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
      }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // reset back the content inset to zero after keyboard is gone
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
      }
    
    @objc func addTapped() {
    }

    @objc func doneButtonPressed() {
        // not sure if this code is correct (tableview.visibleCells.forEach???, might not be efficient)
        tableView.visibleCells.forEach { cell in
            if let cell = cell as? BaseCell, let title = cell.textField.text {
                cell.textField.isUserInteractionEnabled = false
                cell.baseCellDelegate?.updateUI(sender: cell, title: title)
            }
        }
    }
    
    private func setupNavigationController() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .label
    }

    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(roundedButton)
        
        roundedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        roundedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        roundedButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        roundedButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    // MARK: - CoreData
    
    func saveData() {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    
    func remove(at indexPath: IndexPath) {
        if navigationItem.rightBarButtonItems != nil {
            navigationItem.setRightBarButton(nil, animated: true)
        }
    }
    
    func rename(at indexPath: IndexPath) {
        tableView.isEditing = false
        if let cell = tableView.cellForRow(at: indexPath) as? BaseCell {
            // solution below is questionable, find better one
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                cell.textField.isUserInteractionEnabled = true
                cell.textField.becomeFirstResponder()
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneButtonPressed))
            }
        }
    }
}


    //MARK: - BaseCellProtocol

extension MainViewController: BaseCellProtocol {
   // @objc is added here to enable override this method in CategoryViewController and ToDoListViewController classes as the protocol was introuced in the extension not in the main class body
    @objc func updateUI(sender: BaseCell, title: String) {
        navigationItem.rightBarButtonItems = []
        saveData()
    }
}
