//
//  GeneralChatView.swift
//  Chat-test
//
//  Created by Zhekon Kovalevskiy on 27.04.2023.
//

import UIKit
 import SnapKit

class GeneralChatView: UIView {
    
     lazy var chatTableView: UITableView = {
        let tableView = UITableView()
         tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    lazy var inputMessageTextTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Write text..."
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(14)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    lazy var getMessagesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Gray1-40")
        button.setImage( UIImage(systemName: "plus.app.fill"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        configUi()
        configConstraints()
    }
    
    func configUi() {
        backgroundColor = UIColor(named: "BG-90")
        addSubview(inputMessageTextTextField)
        addSubview(chatTableView)
        addSubview(getMessagesButton)
    }
    
    func configConstraints() {
        inputMessageTextTextField.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(65)
        }
        
        getMessagesButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(10)
         }
        
        chatTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(5)
            make.bottom.equalTo(inputMessageTextTextField.snp.top)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 }

