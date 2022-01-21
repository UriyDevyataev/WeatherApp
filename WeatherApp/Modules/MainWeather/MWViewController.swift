//
//  MWViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation
import UIKit
import SnapKit
import SpriteKit

class MWViewController: UIViewController {
    
    //UI
    var collectionView: UICollectionView?
    var bottomContentView: UIView?
    var pageControl: UIPageControl?
    var localyButton: UIButton?
    var listButton: UIButton?
    var scene: SKScene?
    
    //Viper
    var presenter: MWPresenterInput!
    var entity: MWEntity?
    
    //MARK: - App Life Cycle
    
    override func loadView() {
        super.loadView()
        prepareView()
    }
    
    private func prepareView() {
        view = SKView(frame: view.frame)
        var skView: SKView { view as! SKView }
        
        let scene = SKScene(size: view.frame.size)
        scene.backgroundColor = .black

        skView.presentScene(scene)
        self.scene = scene
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        presenter.viewIsReady()
    }
    
    deinit {
        print("deinit MWViewController")
    }
    
    //MARK: - Funcs configuration
    
    func config(){
        configCollectionView()
        configBar()
        configConstaraint()
    }
    
    func updatePageControl(){
        guard let count = entity?.count else {return}
        guard let index = entity?.choisedIndex else {return}
        self.pageControl?.numberOfPages = count
        self.pageControl?.currentPage = index
    }
    
    func configCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(AllWeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: AllWeatherCollectionViewCell.identifier)
        
        view.addSubview(cv)
        collectionView = cv
    }
    
    func configBar(){
        let barView = UIView(frame: .zero)
        barView.backgroundColor = .gray
        view.addSubview(barView)
        bottomContentView = barView
        createButtons()
        createPageControll()
    }
    
    func createButtons() {
        let locBut = UIButton(frame: .zero)
        locBut.setTitle("", for: .normal)
        locBut.setImage(UIImage(systemName: "location"), for: .normal)
        locBut.tintColor = .black
        locBut.addTarget(self, action: #selector(actionLocaly), for: .touchUpInside)
        bottomContentView?.addSubview(locBut)
        localyButton = locBut
        
        let listBut = UIButton(frame: .zero)
        listBut.setTitle("", for: .normal)
        listBut.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        listBut.tintColor = .black
        listBut.addTarget(self, action: #selector(actionList), for: .touchUpInside)
        bottomContentView?.addSubview(listBut)
        listButton = listBut
    }
    
    func createPageControll(){
        let pageC = UIPageControl(frame: .zero)
        pageC.pageIndicatorTintColor = UIColor.black
        pageC.currentPageIndicatorTintColor = UIColor.white
        bottomContentView?.addSubview(pageC)
        pageControl = pageC
    }
    
    func configConstaraint() {
        
        guard let barView = bottomContentView else {return}
        guard let localyBut = localyButton else {return}
        guard let listBut = listButton else {return}
        
        bottomContentView?.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.1)
        }
        
        localyButton?.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(barView.snp.height).multipliedBy(0.6)
            make.width.equalTo(localyBut.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        listButton?.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(barView.snp.height).multipliedBy(0.6)
            make.width.equalTo(listBut.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        pageControl?.snp.makeConstraints { make in
            make.leading.equalTo(localyBut.snp.trailing).offset(10)
            make.trailing.equalTo(listBut.snp.leading).offset(-10)
            make.centerY.equalTo(listBut.snp.centerY)
        }
        
        collectionView?.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(barView.snp.top)
        }
    }
    
    //MARK: - Actions
    
    @objc func actionLocaly() {
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: false)
//        presenter.actionGetLocalWeather()
    }
    
    @objc func actionList() {
        presenter.actionShowChoiseCity()
    }
    
    //MARK: - Funcs Other
    
    func addChildViewController(container: UIView, controller: UIViewController) {
        
        container.subviews.forEach { view in
            view.removeFromSuperview()
        }
                
        self.children.forEach { child in
            child.removeFromParent()
        }
        
        addChild(controller)
    
        container.addSubview(controller.view)
        controller.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        controller.didMove(toParent: self)
    }
    
    func updateView(with entity: MWEntity) {
        self.entity = entity
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.entity = entity
            self.collectionView?.scrollToItem(
                at: IndexPath(row: entity.choisedIndex, section: 0),
                at: .centeredVertically, animated: false)
            self.updatePageControl()
            self.presenter.swipeListTo(index: entity.choisedIndex)
        }
    }
    
    private func configBackgroud(_ backGround: Background) {
        scene?.removeAllChildren()
        scene?.backgroundColor = UIColor.init(backGround.timesOfDay)
        let nodes = backGround.nodes
        nodes.forEach { nodeEntity in
            guard let node = SKSpriteNode(fileNamed: nodeEntity.name) else { return }
            node.position = nodeEntity.position
            self.scene?.addChild(node)
        }
    }
}

extension MWViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entity?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AllWeatherCollectionViewCell.identifier,
            for: indexPath)
        
        guard let controller = CWAssembly.configurateModule(output: nil) else {return cell}
        
        controller.index = indexPath.row
        
        addChildViewController(container: cell.contentView, controller: controller)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let currIndexPath = collectionView.indexPathsForVisibleItems.first else {return}
    
        entity?.choisedIndex = currIndexPath.row
        updatePageControl()
        presenter.swipeListTo(index: currIndexPath.row)
    }
}

extension MWViewController: UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

//MARK: - Extension MWPresenterOutput

extension MWViewController: MWPresenterOutput{

    func setState(entity: MWEntity) {
        print("MW_setState")
        updateView(with: entity)
    }
    
    func updateBackground(background: Background) {
        print("updateBackground")
        configBackgroud(background)
    }
}
