//
//  GameViewController.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import UIKit
import SnapKit
import RxSwift

protocol GameViewControllerProtocol {
    var viewModel: GameViewModelProtocol? { get set }
    func setupViews()
    func bindToViewModel(viewModel: GameViewModelProtocol)
    func layoutViews()
}

class GameViewController: UIViewController, GameViewControllerProtocol {
    
    //MARK: UIElements
    private let correctCounterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()
    
    private let wrongCounterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()
    
    private let secondLanguageWordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let firstLanguageWordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let answersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Dimens.narrowPadding
        return stackView
    }()
    
    private let countDownLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: Class variables
    var viewModel: GameViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    //MARK: Protocol functions
    func bindToViewModel(viewModel: GameViewModelProtocol) {
        self.viewModel = viewModel
        viewModel.firstWord.bind(to: firstLanguageWordLabel.rx.text).disposed(by: disposeBag)
        viewModel.secondWord.bind(to: secondLanguageWordLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.wrongCounter.asDriver().drive {[unowned self] wrongCounterText in
            wrongCounterLabel.text = String.localized("wrong attempts", with: wrongCounterText)
        }.disposed(by: disposeBag)
        
        viewModel.correctCounter.asDriver().drive {[unowned self] correctCounterText in
            correctCounterLabel.text = String.localized("correct attempts", with: correctCounterText)
        }.disposed(by: disposeBag)
        
        viewModel.secondWord.asDriver().drive {[unowned self] secondWordText in
            secondLanguageWordLabel.text = String.localized("translation for", with: secondWordText)
            animateFirstWord()
        }.disposed(by: disposeBag)
        
        viewModel.answers.asDriver().drive {[unowned self] answers in
            setupStackView(answers: answers)
        }.disposed(by: disposeBag)
        
        viewModel.previousAnswerState.asDriver().skip(1).drive {[unowned self] answerState in
            if answerState {
                successFlicker()
            } else {
                failureFlicker()
            }
        }.disposed(by: disposeBag)
        
        viewModel.countDownValue.asDriver().drive {[unowned self] countValue in
            countDownLabel.text = String.localized("time remaining", with: countValue)
        }.disposed(by: disposeBag)
        
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(correctCounterLabel)
        view.addSubview(wrongCounterLabel)
        view.addSubview(countDownLabel)
        view.addSubview(firstLanguageWordLabel)
        view.addSubview(secondLanguageWordLabel)
        view.addSubview(answersStackView)
        layoutViews()
    }
    
    func layoutViews() {
        correctCounterLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Dimens.defaultPadding)
            make.top.equalToSuperview().offset(Dimens.topSafeAreaInset + Dimens.defaultPadding)
        }
        
        wrongCounterLabel.snp.makeConstraints { make in
            make.trailing.equalTo(correctCounterLabel.snp.trailing)
            make.top.equalTo(correctCounterLabel.snp.bottom).offset(Dimens.narrowPadding)
        }
        
        countDownLabel.snp.makeConstraints { make in
            make.trailing.equalTo(correctCounterLabel.snp.trailing)
            make.top.equalTo(wrongCounterLabel.snp.bottom).offset(Dimens.narrowPadding)
        }
        
        secondLanguageWordLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Dimens.defaultPadding)
            make.trailing.equalToSuperview().offset(-Dimens.defaultPadding)
        }
        
        firstLanguageWordLabel.snp.makeConstraints { make in
            make.top.equalTo(secondLanguageWordLabel.snp.bottom).offset(Dimens.defaultPadding)
            make.leading.equalToSuperview().offset(Dimens.defaultPadding)
            make.trailing.equalToSuperview().offset(-Dimens.defaultPadding)
        }
        
        answersStackView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().offset(-Dimens.defaultPadding)
            make.leading.equalToSuperview().offset(Dimens.defaultPadding)
            make.height.equalTo(Dimens.buttonHeight)
        }
    }
    
    //MARK: ViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupStackView(answers: [String]) {
        for subView in answersStackView.arrangedSubviews {
            subView.removeFromSuperview()
        }
        
        for (index, answer) in answers.enumerated() {
            let button = UIButton()
            button.tag = index
            button.setTitle(answer, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.backgroundColor = index == 0 ? Colors.correctColor : Colors.wrongColor
            button.layer.cornerRadius = Dimens.defaultCornerRadius
            button.rx.tap.bind {[unowned self] in
                viewModel?.selectAnswer(index: index)
            }.disposed(by: disposeBag)
            answersStackView.addArrangedSubview(button)
        }
    }
    
    private func successFlicker() {
        view.backgroundColor = Colors.correctColor
        UIView.animate(withDuration: 1, animations: {[weak self] in
            self?.view.backgroundColor = .white
        })
    }
    
    private func failureFlicker() {
        view.backgroundColor = Colors.wrongColor
        UIView.animate(withDuration: 1, animations: {[weak self] in
            self?.view.backgroundColor = .white
        })
    }
    
    func animateFirstWord() {
        self.firstLanguageWordLabel.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height/2)
        UIView.animate(withDuration: viewModel?.game?.timeInterval ?? 5, animations: {[weak self] in
            self?.firstLanguageWordLabel.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height/2)
        })
    }
}
