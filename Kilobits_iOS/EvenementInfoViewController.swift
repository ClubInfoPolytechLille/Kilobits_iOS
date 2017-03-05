//
//  EvenementInfoViewController.swift
//  Kilobits_iOS
//
//  Created by Marianne on 05/03/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class EvenementInfoViewController : UIViewController
{
    // MARK: - IBOutlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lieu: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var nbParticipants: UILabel!
    @IBOutlet weak var organisateur: UILabel!
    @IBOutlet weak var participateButton: UIButton!
    
    // MARK: - Variables
    var evenement : EvenementData?
    var nbParticipantsVal : Int = 0
    var organisateurVal : UserData?
    var comingFrom : String = ""
    
    // MARK: - Initialisation
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if self.comingFrom == "Menu" //Si on vient du menu, cacher le bouton participer, car l'utilisateur n'est pas connecté
        {
            participateButton.isHidden = true
        }
        
        descriptionLabel.text = evenement!.description
        lieu.text = evenement!.lieu
        date.text = evenement!.dat.toString()
        nbParticipantsVal = 0 //a remplacer
        nbParticipants.text = String(nbParticipantsVal) //a remplacer
        
        //TODO: RestApiManager : getAllParticipe, getAllOrganises
        //TODO: classes ParticipeData, OrganiseData
        //TODO: uncomment
        /*RestApiManager.sharedInstance.getAllParticipe(completionHandler: { participes in
            for participe in participes
            {
                print(participe.toDict())
                if participe.evenement == self.evenement!.id
                {
                    nbParticipantsVal++
                }
            }
            print("fin des participes")

            RestApiManager.sharedInstance.getAllOrganise(completionHandler: { organises in
                for organise in organises
                {
                    print(organise.toDict())
                    if organise.evenement == self.evenement!.id
                    {
                        RestApiManager.sharedInstance.getAllUser(completionHandler: { users in
                            for user in users
                            {
                                print(user.toDict())
                                if organise.user == user.id
                                {
                                    organisateur = user
                                }
                            }
                            print("fin des users")
         
                            organisateur.text = "\(organisateurVal!.prenom!) \(organisateurVal!.nom!)"
                            nbParticipants.text = String(nbParticipantsVal)
                        })
                    }
                }
                print("fin des organises")
            })
        })*/
        //get nbParticipants -> parcourir les Participe (getAllParticipe) et compteur + 1 pour ceux associés à l'événement.
        //get organisateur -> parcourir les Organise (getAllOrganise) et prendre celui dont l'evenement = id de cet evenement.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func participate(_ sender: UIButton)
    {
        //PostParticipe -> update nb participants (+1)
        
    }
}
