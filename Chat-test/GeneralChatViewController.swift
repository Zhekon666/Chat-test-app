//
//  ViewController.swift
//  Chat-test
//
//  Created by Zhekon Kovalevskiy on 27.04.2023.
//

import UIKit
import Combine

class GeneralChatViewController: UIViewController {
    
    private let mainView = GeneralChatView()
    
    typealias DataSource = UITableViewDiffableDataSource<Section, MessageModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MessageModel>
    
    private lazy var dataSource = makeDataSource()
    private var allMessages = FakeApiData()
    
    enum Section: Hashable {
        case main
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addNewMessagesPressed() {
        allMessages.allData += allMessages.newData
        reloadData(with: allMessages.allData)
        tableViewScrollToBottom(needAnimate: true)
        mainView.getMessagesButton.isEnabled = false
    }
}

// MARK: - Table view data source + bottom animate
extension GeneralChatViewController: UITableViewDelegate {
    func makeDataSource() -> DataSource {
        DataSource(tableView: mainView.chatTableView) { [weak self] tableView, indexPath, messageModel in
            self?.cell(for: tableView, indexPath: indexPath, messageModel: messageModel)
        }
    }
    
    func cell(for tableView: UITableView, indexPath: IndexPath, messageModel: MessageModel) -> UITableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
        
        cell.setup(cellData: messageModel)
        return cell
    }
    
    func reloadData(with section: [MessageModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(section)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    
    func tableViewScrollToBottom(needAnimate: Bool){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.allMessages.allData.count-1, section: 0)
            self.mainView.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: needAnimate ? true : false)
        }
    }
}


//MARK: - TextField delegate
extension GeneralChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, (textField.text?.count ?? 0) > 0 {
            allMessages.allData.append(MessageModel(id: allMessages.allData.count + 1, type: .incoming, name: "Ann", message: text))
            reloadData(with: allMessages.allData)
            textField.resignFirstResponder()
            
            textField.text = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.tableViewScrollToBottom(needAnimate: true)
            }
            
            return true
        } else {
            return false
        }
    }
}

//MARK: - Long press ContextMenu
extension GeneralChatViewController: ContextMenu {
    static var title: String {
        "Chat table view"
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            return self.makeMenu()
        }
    }
}

//MARK: - Setup view + helper methods (show+hide)
private extension GeneralChatViewController {
    func setupView() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
 
        mainView.chatTableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "chatCell")
        mainView.chatTableView.delegate = self
        reloadData(with: allMessages.allData)
        tableViewScrollToBottom(needAnimate: false)
        
        mainView.getMessagesButton.addTarget(self, action: #selector(addNewMessagesPressed), for: .touchUpInside)
        mainView.inputMessageTextTextField.delegate = self
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

