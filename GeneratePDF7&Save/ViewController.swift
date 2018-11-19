//
//  ViewController.swift
//  GeneratePDF7&Save
//
//  Created by volive solutions on 19/11/18.
//  Copyright © 2018 volive solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textV: UITextView!
     let pdfData = NSMutableData()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func generatePDFBtn(_ sender: Any) {
       createPdf()
    }
    
    
    @IBAction func saveBtnAction(_ sender: Any) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        pdfData.write(toFile: "\(documentsPath)/new.pdf", atomically: true)
        
        
        
        print("saved success",documentsPath )
        

        let storybord = UIStoryboard.init(name: "Main", bundle: nil)
        let loadView = storybord.instantiateViewController(withIdentifier: "LoadViewController") as! LoadViewController
        self.present(loadView, animated: true, completion: nil)
    }
    
    
    func createPdf() {
    // 1. Create Print Formatter with input text.
    
    let formatter = UIMarkupTextPrintFormatter(markupText: textV.text)
    
    // 2. Add formatter with pageRender
    
    let render = UIPrintPageRenderer()
    render.addPrintFormatter(formatter, startingAtPageAt: 0)
    
    
    // 3. Assign paperRect and printableRect
    
    let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
    let printable = page.insetBy(dx: 0, dy: 0)
    
    render.setValue(NSValue(cgRect: page), forKey: "paperRect")
    render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
    
    
    // 4. Create PDF context and draw
    let rect = CGRect.zero
    
   
    UIGraphicsBeginPDFContextToData(pdfData, rect, nil)
    
    
    for i in 1...render.numberOfPages {
    
    UIGraphicsBeginPDFPage();
    let bounds = UIGraphicsGetPDFContextBounds()
    render.drawPage(at: i - 1, in: bounds)
    }
    
    UIGraphicsEndPDFContext();
    
    
    // 5. Save PDF file
    
   
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

