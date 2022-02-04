//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 20/01/2022.
//

import UIKit
import CoreData

class CategoryViewController: MainViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    var categories = [Category]()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ColorManager.background
        tableView.sectionHeaderTopPadding = 10
        tableView.separatorStyle = .none
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CellId")
        loadCategory()
        navigationItem.title = "CATEGORIES"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
    }

    private let roundedButton: RoundedButton = {
        let button = RoundedButton()
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()

    override func setupViews() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: -8))
        
        view.addSubview(roundedButton)
        roundedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        roundedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        roundedButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        roundedButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    // MARK: - Table view data source
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    
    // Two methods belew help with the spacing between the cells
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as? CategoryCell else {
            fatalError("Unable to dequeue the CustomCell")
        }
        cell.categoryLabel.text = categories[indexPath.section].name
        cell.quantityLabel.text = "\(categories[indexPath.section].quantity)"
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.section]
        let vc = ToDoListViewController()
        vc.title = category.name
        vc.selectedCategory = category
        navigationController?.pushViewController(vc, animated: true)
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        categories.swapAt(sourceIndexPath.section, destinationIndexPath.section)
      
    }

    
    private func setUpNavigationController() {
        navigationItem.title = "CATEGORIES"
    }
    
    @objc func addTapped() {
        let ac = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
        
        ac.addAction(UIAlertAction(title: "Add ", style: .default, handler: { [weak self, weak ac] _ in
        guard let newCategory = ac?.textFields?[0].text else { return }
        self?.addCategory(newCategory)
        }))
    }
    
    @objc func editButtonPressed() {
        if categories.count == 0 { return }
        tableView.isEditing.toggle()
        
        // check if I can change the buttonTitle here
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
        
    // rethink the code below, maybe visibleCell isnt good solution
        tableView.visibleCells.forEach { cell in
            if let cell = cell as? CategoryCell {
                
                if tableView.isEditing {
                    cell.oldLeftAnchor?.isActive = false
                    cell.oldTrailingAnchor?.isActive = false
                    cell.newLeftAnchor?.isActive = true
                    cell.newTrailingAnchor?.isActive = true
                    roundedButton.isUserInteractionEnabled = false
                    
                } else {
                    cell.oldLeftAnchor?.isActive = true
                    cell.oldTrailingAnchor?.isActive = true
                    cell.newLeftAnchor?.isActive = false
                    cell.newTrailingAnchor?.isActive = false
                    roundedButton.isUserInteractionEnabled = true
                }
                
            }
        
        }

//        view.layoutIfNeeded()
    }
    
    
    func addCategory(_ category: String) {
        if category == "" { return }
        let newCategory = Category(context: context)
        newCategory.name = category
        categories.append(newCategory)
        saveData()
        tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
           categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    override func remove(at indexPath: IndexPath) {
        self.context.delete(self.categories[indexPath.section])
        self.categories.remove(at: indexPath.section)
        tableView.reloadData()
        self.saveData()
    }
    override func rename(at indexPatx: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPatx) as? CategoryCell {
            
        }
    }
    
}


    

        






