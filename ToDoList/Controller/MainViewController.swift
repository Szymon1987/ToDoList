//
//  MainViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 31/01/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedIndexPath: IndexPath?
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .viewBackground
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
        tableView.backgroundColor = .viewBackground
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var roundedButton: RoundedButton = {
         let button = RoundedButton()
         button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
         return button
     }()
    
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
    
    @objc func addButtonTapped() {
    }
   
    @objc func doneButtonPressed() {
        if let selectedIndexPath = selectedIndexPath {
            if let cell = tableView.cellForRow(at: selectedIndexPath) as? BaseCell {
                cell.textField.isUserInteractionEnabled = false
                cell.textField.endEditing(true)
            }
        }
    }
    
    func setupNavigationController() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .label
        let image = UIImage(systemName: "arrow.up.arrow.down.circle")?.withRenderingMode(.alwaysTemplate)
        let sortButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(sortButtonTapped))
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = sortButton
    }
    
    @objc func sortButtonTapped() {
    }

    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(roundedButton)

        roundedButton.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: -150, right: -70), size: CGSize(width: 60, height: 60))
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
        selectedIndexPath = indexPath
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate Methods

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
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
        if tableView.isEditing == false {
            return UISwipeActionsConfiguration(actions: [delete, rename])
        } else {
            return UISwipeActionsConfiguration(actions: [])
        }
    }
}

