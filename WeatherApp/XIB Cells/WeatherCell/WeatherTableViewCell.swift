//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 08.01.2022.
//

import UIKit
import SpriteKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var topContentView: UIView!
    @IBOutlet weak var bottomContentView: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    
    var scene: SKScene?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configBackgroundView()
        conficScene()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        configFont()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scene?.removeAllChildren()
    }
    
    private func configBackgroundView() {
        let skView = SKView()
        backgroundView = skView
        backgroundView!.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        backgroundView?.corner(withRadius: 10)
        backgroundView?.clipsToBounds = true
    }
    
    private func conficScene() {
        var skView: SKView { backgroundView as! SKView }
        let scene = SKScene(size: contentView.frame.size)
        skView.presentScene(scene)
        self.scene = scene
    }
    
    private func configFont() {
        cityLabel.font = UIFont.boldSystemFont(ofSize: cityLabel.frame.height * 0.7)
        timeLabel.font = UIFont.boldSystemFont(ofSize: timeLabel.frame.height * 0.7)
        tempLabel.font = UIFont.systemFont(ofSize: tempLabel.frame.height * 0.8)
        infoLabel.font = UIFont.boldSystemFont(ofSize: infoLabel.frame.height * 0.3)
        maxMinTempLabel.font = UIFont.boldSystemFont(ofSize: maxMinTempLabel.frame.height * 0.3)
    }
    
    func configBackgroud(_ backGround: Background?) {
        guard let backGround = backGround else {return}
        scene?.backgroundColor = UIColor.init(backGround.timesOfDay)
        let nodes = backGround.nodes
        nodes.forEach { nodeEntity in
            guard let node = SKSpriteNode(fileNamed: nodeEntity.name) else { return }

            let height: CGFloat = scene?.frame.height ?? 100
            let width: CGFloat = scene?.frame.width ?? 100

            var position = nodeEntity.position
            switch nodeEntity.name {
            case "Sun" :        position = CGPoint(x: width / 2, y: height - 10)
            case "Night" :      position = CGPoint(x: 100, y: height - 10)
            case "Clouds" :     position = CGPoint(x: 50, y: height - 10)
            case "Mist" :       position = CGPoint(x: 100, y: height - 10)
            default:            break
            }
            node.position = position
            node.xScale = 0.6
            scene?.addChild(node)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
