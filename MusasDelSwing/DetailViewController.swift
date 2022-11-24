//
//  DetailViewController.swift
//  MusasDelSwing
//
//  Created by Fernando Haro Martínez on 16/11/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var fecha: UILabel!
    
    @IBOutlet weak var bio: UITextView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    var miMusa : Musa!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombre.text = "Selecciona una Musa"
        fecha.text = ""
        bio.text = ""
        
                                            
        let botonJuke = UIBarButtonItem(title: "Videos", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
        
        let items: [UIBarButtonItem] = [
              botonJuke,
            ]
        
            navigationItem.setRightBarButtonItems(items, animated: true)
            self.view.setNeedsDisplay()
        
  

        //linea debajo navigationBar, No funciona en iphone
        let colorNaranja = UIColor(red: 217/255, green: 103/255, blue: 63/255, alpha: 1)
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, (self.navigationController?.navigationBar.frame.size.height)!, (self.navigationController?.navigationBar.frame.size.width)!, 2.0)
        bottomBorder.backgroundColor = colorNaranja.cgColor
        let navBar = self.navigationController!.navigationBar
        navBar.layer.addSublayer(bottomBorder)
        //fin barra superior

        
        self.title = "Musas del Swing"
    }
    
    //función para enviar el objeto desde el TableView
    func didChangeMusa(musa: Musa){
        
        self.nombre.text = musa.nombre
        self.fecha.text = musa.fecha
        self.bio.text = musa.bio
        self.foto.image = UIImage(named: musa.foto)
        
    miMusa = musa
        
    }
    
    override func viewWillLayoutSubviews() {
        if view.bounds.size.width >= view.bounds.size.height {
            self.stackView.axis = .horizontal
        }
        else {
            self.stackView.axis = .vertical
        }
    }
    
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIButton!)
        {
            print("My image button tapped")
            self.performSegue(withIdentifier: "2videos", sender: self)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            print("Touches began")
            let loc = touch.location(in: self.view)
            if self.nombre.frame.contains(loc) {
                print("Detectado toque sobre la etiqueta")
                self.performSegue(withIdentifier: "2imagen", sender: self)
            }
        }
        super.touchesBegan(touches, with: event)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "2videos" {
            if let destination = segue.destination as? UINavigationController{
                
                let cV = destination.viewControllers.first as! CollectionViewController
                
                if(miMusa != nil){
                    cV.videos = miMusa.linkArray
                }
            }
        }else if segue.identifier == "2imagen" {
            
            if let destination = segue.destination as? UINavigationController{
                
                let iV = destination.viewControllers.first as! ImagenViewController
                
                if(miMusa != nil){
                    iV.foto = miMusa.foto
                    iV.nombre = miMusa.nombre
                }
            }
        }
        
        
        
    }
    
    
    
    
    
    
}
