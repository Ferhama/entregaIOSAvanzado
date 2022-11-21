//
//  ImagenViewController.swift
//  MusasDelSwing
//
//  Created by Fernando Haro Martínez on 20/11/22.
//

import UIKit

class ImagenViewController: UIViewController {
    @IBOutlet weak var segmControl: UISegmentedControl!
    
    @IBOutlet weak var imagen: UIImageView!
    
    var foto : String?
    var nombre : String?
    var initialLocation: CGPoint = CGPoint(x: 0, y: 0)
    var colorFirma : UIColor = .black

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (foto != nil){
         imagen.image = UIImage(named: foto!)
        }
        
    }
    
    @IBAction func seleccionColor(_ sender: Any) {
        
        switch segmControl.selectedSegmentIndex {
               case 0:
            self.colorFirma = .black
               case 1 :
            self.colorFirma = .white
               case 2:
            self.colorFirma = .blue
               default:
                   break
               }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            print("Touches began")
            let loc = touch.location(in: self.view)
            if self.imagen.frame.contains(loc) {
                print("Detectado toque sobre la imagen")
                addButtonClicked(loc: loc)

            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func addButtonClicked(loc : CGPoint){
        
        let alertController = UIAlertController(title: "Tu foto dedicada", message: " Escribe tu nombre", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField{ (textField : UITextField!) -> Void in
            textField.placeholder = "Escribe tu nombre"
        }

        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let miName = firstTextField.text
            
            self.addDeditatoria(name: miName!, Dedic: "", loc: loc)
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addDeditatoria(name : String, Dedic : String, loc : CGPoint){
      
        let titleLabel = UILabel(frame: CGRect(x: loc.x, y: (loc.y - 225), width: imagen.frame.width, height: 150))
           
            titleLabel.numberOfLines = 0
            titleLabel.text = "Best Wishes \n to \(name) \n \(nombre ?? "")"
            titleLabel.textColor = self.colorFirma
            titleLabel.font = UIFont(name:"Savoye LET", size: 35)
            titleLabel.transform = CGAffineTransform(rotationAngle: -.pi / 6)
    
            imagen.addSubview(titleLabel)
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
