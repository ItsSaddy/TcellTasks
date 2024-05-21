//
//  CompleteTaskViewController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 16/05/24.
//

import Foundation
import UIKit
import Moya

class CompleteTaskViewController: UIViewController {
    
    @IBOutlet weak var selectedImageCount: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var objectLabel: UILabel!
    @IBOutlet weak var isZIP: UISwitch!
    @IBOutlet weak var isGoToPlaceRequired: UISwitch!
    @IBOutlet weak var numberIdLabel: UILabel!
    @IBOutlet weak var selectedImageCollection: UICollectionView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneTaskButton: UIButton!
    
    var selectedPhotos = [UIImage]() {
        didSet {
            selectedImageCount.text = selectedPhotos.count.description
        }
    }
    
    let imagePicker = UIImagePickerController()
    let placeholderText = "Ваш комментарий..."
    var task: TaskResponse?
    
    static func storyboardInstance() -> CompleteTaskViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! CompleteTaskViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
    }
    
    func setupData() {
        guard let task = task else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        objectLabel.text = task.obj
        dateLabel.text = dateFormatter.string(from: task.date)
        numberIdLabel.text = task.id.description
    }
    
    @IBAction func taskButtonTap(_ sender: UIButton) {
        guard let task = task else { return }
        
        var imagesToSend: [Data] = []
        
        selectedPhotos.forEach { image in
            guard let imageData = image.pngData() else { return }
            
            imagesToSend.append(imageData)
        }
        
        APIManager.shared.completeTask(
            id: task.id,
            images: imagesToSend,
            comment: textView.text,
            isGoToPlaceRequired: isGoToPlaceRequired.isOn ? 1 : 0,
            state: (isZIP.isOn ? TaskState.closedZIP : TaskState.onApproval).rawValue,
            completion: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    navigationController?.popToRootViewController(animated: true)
                case .failure(let failure):
                    print(failure)
                }
            })
            
        
    }
}

extension CompleteTaskViewController {
    
    func setupViews() {
        selectedImageCollection.dataSource = self
        selectedImageCollection.register(
            ImageCollectionViewCell.nib,
            forCellWithReuseIdentifier: ImageCollectionViewCell.identifier
        )
        selectedImageCollection.layer.borderColor = UIColor.systemGray.cgColor
        selectedImageCollection.layer.borderWidth = 0.3
        selectedImageCollection.layer.cornerRadius = 3
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        navigationItem.rightBarButtonItem = .init(
            image: .init(systemName: "paperclip"),
            style: .plain,
            target: self,
            action: #selector(openImagePicker)
        )
        
        textView.delegate = self
        textView.text = placeholderText
        textView.textColor = UIColor.lightGray
        
        textView.layer.borderWidth = 0.3
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.layer.cornerRadius = 3.0
    }
    
    @objc func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Галерея недоступна")
        }
    }
    
}

//MARK: Placeholder Text
extension CompleteTaskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
}

//MARK: - UIImagePickerControllerDelegate
extension CompleteTaskViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedPhotos.append(pickedImage)
            selectedImageCollection.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UICollectionViewDataSource
extension CompleteTaskViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.identifier,
            for: indexPath
        ) as! ImageCollectionViewCell
        cell.imageView.image = selectedPhotos[indexPath.item]
        return cell
    }
}
