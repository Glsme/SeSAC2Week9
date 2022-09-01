//
//  ViewController.swift
//  SeSAC2Week9
//
//  Created by Seokjune Hong on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lottoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var viewModel = PersonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        LottoAPIManager.requestLotto(drwNo: 1000) { lotto, error in
//
//            guard let lotto = lotto else {
//                return
//            }
//
//            self.lottoLabel.text = lotto.drwNoDate
//        }
        
        viewModel.fetchPerson(query: "chris")
        viewModel.list.bind { person in
            print("VC: bind")
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInsection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.knownForDepartment
        
        return cell
    }
}
