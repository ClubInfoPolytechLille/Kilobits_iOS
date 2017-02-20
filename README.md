# Version iOS du projet Kilobits

### Outils
* Version 8.2.1 de XCode
* Swift 3
* L'outil de gestion de Frameworks Cocoapods
* Le Framework SwiftyJSON
* La base de donnée liée au projet ([ici](https://github.com/ClubInfoPolytechLille/kilobits-serv))

### Installation du dépôt
1. Clônage du dépôt avec intégration Git
  1. Ouvrir XCode et choisir d'ouvrir un projet SCM déjà existant.
  2. Entrer l'addresse Github du dépôt : "git@github.com:ClubInfoPolytechLille/Kilobits_iOS.git".
  3. Lorsque les options de connection s'affichent, choisir "SSH Keys" et s'assurer d'avoir configuré auparavant une clé SSH sur l'ordinateur (cf [ici](https://help.github.com/articles/connecting-to-github-with-ssh/) pour un tuto).
2. Installer Cocoapods sur le Mac en tapant "sudo gem install cocoapods" dans un terminal.
3. Fermer le projet et à partir de maintenant, toujours ouvrir le Workspace du projet plutôt que le projet lui-même. Pour cela, se rendre avec le terminal dans le dossier du projet (là ou se trouve le fichier Kilobits_iOS.xcworkspace) et lancer la commande suivante : "open Kilobits_iOS.xcworkspace". C'est nécessaire car sinon le projet n'arrivera pas à faire le lien avec les Frameworks installés.

### Tutoriels Swift
* [Tutoriel pas à pas d'une appli Swift](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/)
* [Guide du Langage Swift](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html)
* [Tutoriel SwiftyJSON](https://devdactic.com/parse-json-with-swift)
* [SwiftyJSON Documentation](https://github.com/SwiftyJSON/SwiftyJSON)
* [Tutoriel Alamofire & SwiftyJSON](https://grokswift.com/rest-with-alamofire-swiftyjson/)
