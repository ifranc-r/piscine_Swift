//
//  ViewController.swift
//  d00
//
//  Created by Inti FRANC-REGIS on 3/26/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit
func calc(num1 :Float, num2 :Float, operation :String) -> Float {
    var result = Float();
    switch operation {
    case "+":
        result = num1 + num2;
        break;
    case "-":
        result = num1 - num2;
        break;
    case "*":
        result = num1 * num2;
        break;
    case "/":
        result = num1 / num2;
        break;
    default:
        break;
    }
    return result;
}
class ViewController: UIViewController {
    @IBOutlet weak var Num_Show: UILabel!
    
    var num_calc = Float();
    var num_op_previous = Float();
    var operation = String();
    var startOp = Bool();
    var processMath = Bool();
    
    func reset(){
        num_calc = 0;
        num_op_previous = 0;
        operation = String();
        processMath = false;
        startOp = false;
        
    }
    @IBAction func functionButton(_ sender: UIButton) {
        if (num_calc * 10 < 2147483647 && num_calc * 10 > -2147483647){
            num_calc *= 10;
            let numselect = Float(sender.currentTitle!);
            num_calc += numselect!;
            Num_Show.text = String(num_calc);
            startOp = false
        }
        else
        {
            Num_Show.text = "Erreur: Max or Min float";
            self.reset();
        }
    }
    @IBAction func FunctionOperation(_ sender: UIButton) {
        if (startOp == false){
            if (processMath == true) {
                if(operation == "/" && (num_op_previous == 0 || num_calc == 0)){
                    Num_Show.text = "Erreur : divid by 0";
                    self.reset();
                }
                else{
                    num_op_previous = calc(num1 :num_op_previous, num2 :num_calc, operation : operation);
                    if (num_op_previous < 2147483647 && num_op_previous > -2147483647){
//                        num_op_previous = calc(num1 :num_op_previous, num2 :num_calc, operation : operation);
                        num_calc = 0;
                        Num_Show.text = String(num_op_previous);
                    }
                    else
                    {
                        Num_Show.text = "Erreur: Max or Min float";
                        self.reset();
                    }
                }
            }
            else {
                num_op_previous = num_calc;
                num_calc = 0;
                Num_Show.text = String(num_op_previous);
                processMath = true
            }
        }
        startOp = true;
        operation = sender.currentTitle!;
    }
    @IBAction func functionNEG(_ sender: UIButton) {
        if  Float(Num_Show.text!) != nil {
            if (Float(Num_Show.text!)! == num_calc){
                if (-num_calc < 2147483647 && -num_calc > -2147483647){
                    num_calc = -num_calc;
                    Num_Show.text = String(num_calc);
                }
            }
            else{
                if (-num_op_previous < 2147483647 && -num_op_previous > -2147483647){
                    num_op_previous = -num_op_previous;
                    Num_Show.text = String(num_op_previous);
                }
            }
        }
    }
    @IBAction func functionAC(_ sender: UIButton) {
        self.reset()
        Num_Show.text = String(num_calc);
    }
    @IBAction func functionEqual(_ sender: UIButton) {
        if (processMath == true) {
            if(operation == "/" && (num_op_previous == 0 || num_calc == 0)){
                Num_Show.text = "Erreur: divid by 0";
            }
            else{
                num_op_previous = calc(num1 :num_op_previous, num2 :num_calc, operation : operation)
                if (num_op_previous < 2147483647 && num_op_previous > -2147483647){
                    Num_Show.text = String(num_op_previous);
                }else{
                    Num_Show.text = "Erreur: Max or Min float";
                }
            }
        }
        self.reset();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.reset();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
}
