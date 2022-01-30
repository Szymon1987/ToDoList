//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 20/01/2022.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories = [Category]()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ColorManager.background
        setupViews()
        tableView.sectionHeaderTopPadding = 10
        tableView.separatorStyle = .none
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CATEGORIES"
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CellId")
        setUpNavigationController()
        loadCategory()
    }
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = ColorManager.background
        return tableView
}()
    
   
    
    let roundedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorManager.roundedButton
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .medium)
        let image = UIImage(systemName: "plus", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        
        button.tintColor = .white
//        button.layer.masksToBounds = true
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.2
//        button.layer.borderColor = UIColor.lightGray.cgColor
//        button.layer.borderWidth = 0.5
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    private func setupViews() {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as? CustomCell else {
            fatalError("Unable to dequeue the CustomCell")
        }
        cell.titleLabel.text = categories[indexPath.section].name
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.section]
        let vc = ToDoListViewController()
        vc.title = category.name
        vc.selectedCategory = category
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {

        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            context.delete(categories[indexPath.section])
            categories.remove(at: indexPath.section)
            saveData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    private func setUpNavigationController() {

        navigationItem.title = "CATEGORIES"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = ColorManager.background
//                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

//                navigationController?.navigationBar.tintColor = .white
//                navigationController?.navigationBar.standardAppearance = appearance
//                navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func addTapped() {
        let ac = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac .addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
        
        ac.addAction(UIAlertAction(title: "Add ", style: .default, handler: { [weak self, weak ac] _ in
        guard let newCategory = ac?.textFields?[0].text else { return }
        self?.addCategory(newCategory)
        }))
    }
    
    func addCategory(_ category: String) {
        if category == "" { return }
        let newCategory = Category(context: context)
        newCategory.name = category
        categories.append(newCategory)
        saveData()
    }
    
    func saveData() {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
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
    

}







// MIGHT BE USEFUL IN THE FUTURE AS SWIPING ISN'T AS SMOOTH AS EXPECTED RIGHT NOW




    

        

        
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//            let deleteAction = UITableViewRowAction(style: .destructive, title: "KUPA") { _, _ in
//                self.categories.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                self.saveData()
//            }
//            deleteAction.backgroundColor = .red
//            return [deleteAction]
//        }
//
//
//
//
//func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { _, _, complete in
//            self.categories.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            self.saveData()
//
//            complete(true)
//        }
//        deleteAction.backgroundColor = .systemRed
//
//
//
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//
//        configuration.performsFirstActionWithFullSwipe = true
//        return configuration
//    }
//




