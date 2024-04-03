//
//  HistoryController.swift
//  recruitment-sdd_study_case_1
//
//  Created by Jonathan Kristian on 03/04/24.
//

import UIKit

class HistoryController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var thisUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        // Do any additional setup after loading the view.
    }
    
    
    func setupTable() {
        self.tableView.register(UINib(nibName: "HistoryTableCell", bundle: nil), forCellReuseIdentifier: "HistoryTableCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HistoryController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thisUser?.history.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableCell", for: indexPath) as? HistoryTableCell else{
            return UITableViewCell()
        }
        guard let thisTransaction = self.thisUser?.history[indexPath.row] as? Transaction else {
            return UITableViewCell()
        }
        cell.setupCell(thisTransaction: thisTransaction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
