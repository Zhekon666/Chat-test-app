//
//  ChatTableViewCell.swift
//  Chat-test
//
//  Created by Zhekon Kovalevskiy on 27.04.2023.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {
    
    let backView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(named: "Gray1-60")
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 10
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        backgroundColor = .clear
        
        configUi()
        configConstraints()
    }
    
    func configUi() {
        contentView.addSubview(backView)
        
        backView.addArrangedSubview(nameLabel)
        backView.addArrangedSubview(messageTextLabel)
        
    }
    
    func configConstraints() {
        backView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.horizontalEdges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        messageTextLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup + refresh cell UI
extension MessageTableViewCell {
    func setup(cellData: MessageModel) {
        nameLabel.text = cellData.name
        messageTextLabel.text = cellData.message
        updateCellUI(messageType: cellData.type)
    }
    
    func updateCellUI(messageType: MessageType) {
        switch messageType {
        case .my:
            backView.snp.remakeConstraints { make in
                make.verticalEdges.equalToSuperview().inset(5)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview().inset(26)
            }
            
        case .incoming:
            backView.snp.remakeConstraints { make in
                make.verticalEdges.equalToSuperview().inset(5)
                make.leading.equalToSuperview().inset(26)
                make.trailing.equalToSuperview()
            }
            
        default: break
        }
    }
}
