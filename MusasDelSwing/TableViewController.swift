//
//  TableViewController.swift
//  MusasDelSwing
//
//  Created by Fernando Haro Martínez on 16/11/22.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    var musas = [Musa]()
    private var searchController : UISearchController?
    private var searchResults = [Musa]()
    private var colorFondo : UIColor? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "Musas del Swing"
        
        crearPeliculas()
        
        // Creamos una tabla alternativa para visualizar los resultados cuando se seleccione la búsqueda
        let searchResultsController = UITableViewController(style: .plain)
        searchResultsController.tableView.dataSource = self
        searchResultsController.tableView.delegate = self

        // Asignamos esta tabla a nuestro controlador de búsqueda
        self.searchController = UISearchController(searchResultsController: searchResultsController)
        self.searchController?.searchResultsUpdater = self

        // Especificamos el tamaño de la barra de búsqueda
        if let frame = self.searchController?.searchBar.frame {
            self.searchController?.searchBar.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 44.0)
        }
        
        //customiza la barra de búsqueda
        let naranja = UIColor(red: 217/255, green: 103/255, blue: 63/255, alpha:0.5)
        colorFondo = UIColor(red: 189/255, green: 166/255, blue: 144/255, alpha: 1)
        
        self.searchController?.searchBar.barTintColor = naranja
        
        self.searchController?.searchBar.tintColor = .white // cancel button
           
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] //textField text color

        // La añadimos a la cabecera de la tabla
        self.tableView.tableHeaderView = self.searchController?.searchBar

        // Esto es para indicar que nuestra vista de tabla de búsqueda se superpondrá a la ya existente
        self.definesPresentationContext = true

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //le añado la opción de la tabla con los resultados de la búsqueda
        let src = self.searchController?.searchResultsController as! UITableViewController
        
        if tableView == src.tableView {
                return self.searchResults.count
            }
            else {
                return self.musas.count
            }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let musa : Musa?
        
        //opción del buscador sobre el tableview
        let src = self.searchController?.searchResultsController as! UITableViewController
        
        if tableView == src.tableView {
                musa = self.searchResults[indexPath.row]
            }
            else {
                musa = musas[indexPath.row]
            }
        
        cell.fondo.image = UIImage(named:"celda_jukebox.png")
        cell.nombre.text = musa?.nombre
        cell.apodo.text = musa?.apodo
        cell.fecha.text = musa?.fecha

        // Configure the cell...
        //cell.textLabel!.text = contenido[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            let musa = self.musas[indexPath.row]

            // Conexión con el controlador detalle
            let detailViewController = splitViewController!.viewController(for: .secondary) as? DetailViewController
            
            //le envía la musa el detailViewcontroller
            detailViewController?.didChangeMusa(musa: musa)
            
            // Si el controlador detalle no está presentado lo mostramos
            if !detailViewController!.isBeingPresented {
                splitViewController!.showDetailViewController(detailViewController!, sender: self)
            }
        } else {
            var musa = self.musas[indexPath.row]
            
            let sc = self.searchController?.searchResultsController as! UITableViewController
            musa = self.searchResults[(sc.tableView.indexPathForSelectedRow?.row)!]
            
            // Conexión con el controlador detalle
            let detailViewController = splitViewController!.viewController(for: .secondary) as? DetailViewController
            
            //le envía la musa el detailViewcontroller
            detailViewController?.didChangeMusa(musa: musa)
            
            // Si el controlador detalle no está presentado lo mostramos
            if !detailViewController!.isBeingPresented {
                splitViewController!.showDetailViewController(detailViewController!, sender: self)
            }
        }
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        // Cogemos el texto introducido en la barra de búsqueda
        let searchString = self.searchController?.searchBar.text


        // Si la cadena de búsqueda es vacía, copiamos en searchResults todos los objetos
        if searchString == nil || searchString == "" {
            self.searchResults = self.musas
        }
        // Si no, copiamos en searchResults sólo los que coinciden con el texto de búsqueda
        else {
            //let searchPredicate = NSPredicate(format: "SELF BEGINSWITH[c] %@", searchString!)
            let array = musas.filter({($0.nombre.localizedCaseInsensitiveContains(searchString!))})
            //let array = (self.musas as NSArray).filtered(using: searchPredicate)
            self.searchResults = array
        }

        // Recargamos los datos de la tabla
        let tvc = self.searchController?.searchResultsController as! UITableViewController
        tvc.tableView.backgroundColor = colorFondo
        tvc.tableView.reloadData()

        // Deseleccionamos la celda de la tabla principal
        if let selected = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at:selected, animated: false)
        }
    }

    
    func crearPeliculas() {
        let musa1 = Musa(nombre: "Helen Forrest", foto: "foto1.png", fecha: "(1917-1999)", bio: "Su verdadero nombre era Helen Fogel, y nació en Atlantic City, Nueva Jersey, siendo sus padres Louis y Rebecca Fogel, ambos judios nacidos en Rusia. Siendo ella una niña, su padre falleció a causa de la gripe. Su madre se casó con un pintor, un hombre que no gustaba a Helen. Pronto, su madre y su padrastro convirtieron el hogar familiar en un burdel a los 14 anos de edad, Helen estuvo a punto de ser violada por su padrastro, defendiendose ella con un cuchillo e hiriendo a su agresor. A partir de entonces su madre permitio que ella viviera con su profesora de piano, Honey Silverman, y su familia Silverman noto la habilidad de su alumna para el canto, por lo que la animo a hacerse cantante. Por ese motivo helen dejo sus estudios en la high school y se dedico a la consecucion de su sueño, hacerse cantante",apodo: "The voice of the name bands",linkArray: ["0EjndHTw4y4","vk1vz_6CIR0","PkFexfgZ3CA","uOxq3p5e-7M"])

        self.musas.append(musa1)
        
        let musa2 = Musa(nombre: "Anita O'Day", foto: "foto2.png", fecha: "(1919-2006)", bio: "Anita Belle Colton, mas conocida como Anita O'day (Chicago, 18 de octubre de 1919-Los Angeles, California, 23 de noviembre de 2006), fue una cantante estadounidense de jazz. Se trata de una de las principales voces femeninas del jazz. Su estilo es tradicional, y oscila entre el swing y el bop; tiene un gran sentido de la improvisacion y del ritmo. Su voz era ligeramente grave y siempre suave. Su primera aparicion en una big band rompio con la imagen tradicional de las vocalistas femeninas, y se situo a un nivel similar al de los otros musicos del grupo.", apodo: "The Jezebel of Jazz", linkArray: ["GHCaxVCXNIc","fgMg9G8t2_w","1l_TiX4t12M","yLPbpCuyNcY","9mu7zF7RcuE"])
        
        self.musas.append(musa2)
        
        let musa3 = Musa(nombre: "Peggy Lee", foto: "foto3.png", fecha: "(1920-2002)", bio: "Norma Deloris Egstrom (Jamestown, Dakota del Norte, 26 de mayo de 1920-Los Angeles, 21 de enero de 2002), conocida como Peggy Lee, fue una cantante, compositora y actriz estadounidense, a lo largo de una carrera que abarco seis decadas. Ampliamente reconocida como una de las personalidades musicales mas influyentes en la musica comercial anglosajona del siglo xx, lee ha sido citada como mentora de artistas tan diversos como bobby darin, Paul McCartney, Bette Midler, Madonna, k. D. Lang, Elvis Costello y otros muchos. ", apodo: "Miss Piggy, The Queen", linkArray: ["4zRwze8_SGk","wLJVfc_xlN4"])
        
        self.musas.append(musa3)
        
        let musa4 = Musa(nombre: "Ella Fitzgerald", foto: "foto4.png", fecha: "(1917-1996)", bio: "Ella Jane Fitzgerald (Newport News, Virginia, 25 de abril de 1917 Beverly Hills, 15 de junio de 1996), apodada Lady Ella, La reina del jazz y La primera dama de la canción, fue una cantante estadounidense de jazz. No obstante, esta condicion basica de jazzista, el repertorio musical de Ella Fitzgerald es muy amplio e incluye swing, blues, bossa nova, samba, gospel, calypso, canciones navidenas, pop, etc. Junto con billie holiday y sarah vaughan, esta considerada como la cantante mas importante e influyente de toda la historia del jazz (y, en general, de la cancion melodica popular de estados unidos). Estaba dotada de una voz con un rango vocal de tres octavas, destacando su clara y precisa vocalizacion y su capacidad de improvisacion, sobre todo en el scat, tecnica que desarrollo en los anos cuarenta y que anuncio el surgimiento del bop. En los anos cincuenta sentó cátedra con su concepción de la canción melódica, en paralelo a la obra de Frank Sinatra, con sus versiones de los temas de los grandes compositores de la canción popular estadounidense (los songbooks de Duke Ellington, Cole Porter, Johnny Mercer, etc. ).", apodo: "First Lady of Song", linkArray:[ "cb2w2m1JmCY","wYaEVSjg5BE"])
        
        self.musas.append(musa4)
        
        let musa5 = Musa(nombre: "Pamela Gaizutyte", foto: "foto5.png", fecha: "Jam, 25th Nov.", bio: "Actualmente es reconocida como una de las mejores instructoras de baile y artistas emocionantes en el mundo del swing, el jazz y el lindy hop en la actualidad. Pamela quedo fascinada por la energia del lindy hop y la positividad de la comunidad de baile a la temprana edad de dieciseis anos cuando participo en sus primeras clases en lindyhop. Lt club en vilnius. A pesar de su corta edad, pamela inmediatamente comenzo a incursionar en todo lo relacionado con el jazz y la danza, incluida la teoria musical, la historia de la musica, la historia de la danza, la psicologia y la anatomia. En 2009, Pamela comenzó a trabajar en hopper's dance studio en su ciudad natal de Vilnius, Lituania.", apodo: "The girl with the contortionist legs", linkArray: ["ofdFj_giGWU","LwJbmtWBASA","x3kvAt_TmPg","1_NbVUSVorQ"])
        
        self.musas.append(musa5)
        
        let musa6 = Musa(nombre: "Alice Mei", foto: "foto6.png", fecha: "Jam, 26th Jan.", bio: "Natural de Montpellier. Alice tenía 19 años la primera vez que bailó lindy hop. Fue el primer baile en pareja que probó y le encantó. Fue sorprendente al principio, lo divertido que era. Todo el baile que había hecho antes del ballet, el contemporáneo y el jazz era muy serio, así que cuando vi a la gente divirtiéndose juntos, pensé, wow, ¿es eso posible? ¡Pensé que se suponía que debía estar triste! Alice comenzó a tomar clases de lindy hop en su ciudad natal, Montpellier. Nina Gilkenson fue una gran inspiración.", apodo: "just Mei", linkArray: ["MUQuDMq2fzQ","6btiN77XEH8","oBhCecIAQFY","Rrm22RHRD6I"])
        
        self.musas.append(musa6)
        
    }




    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
