//
//  ListeEvenementsViewController.swift
//  Kilobits_iOS
//
//  Created by Marianne on 04/03/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import UIKit

class ListeEvenementsViewController: UITableViewController
{
    // MARK: - Variables
    var evenements : [EvenementData] = []
    var comingFrom : String = ""
    
    // MARK: - Initialisation
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        RestApiManager.sharedInstance.getAllEvenements(completionHandler: { evenements in
            for evenement in evenements
            {
                print(evenement.toDict())
            }
            print("fin des événements")
            self.loadSampleEvents()
            
            //self.evenements = evenements
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let viewController = segue.destination as? EvenementInfoViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedCell = sender as? UITableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedEvenement = evenements[indexPath.row]
        viewController.evenement = selectedEvenement
        viewController.comingFrom = self.comingFrom
    }
    
    // MARK: - IBActions
    @IBAction func Cancel(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Private Methods
    private func loadSampleEvents()
    {
        let event = EvenementData(lieu: "Lille", dat: Date(), description: "Evenement 1", id: nil)
        evenements.append(event)
    }
    
    //MARK: - UITableViewDelegate
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return evenements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EvenementListCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Fetches the appropriate meal for the data source layout.
        let evenement = evenements[indexPath.row]
        
        cell.textLabel!.text = evenement.description
        cell.detailTextLabel!.text = "at \(evenement.lieu!) on the \(evenement.dat.toString())"
        
        return cell
    }
}
