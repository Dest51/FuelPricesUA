//
//  AvaragePricesUA.swift
//  Fuel Prices UA
//
//  Created by Admin on 12.10.2022.
//

import UIKit
import SwiftSoup
import RSLoadingView

class AvaragePricesUA: UIViewController {

    @IBOutlet weak var caption: UILabel!
    
    @IBOutlet weak var a95plus_price: UILabel!
    @IBOutlet weak var a95_price: UILabel!
    @IBOutlet weak var a92_price: UILabel!
    @IBOutlet weak var dp_price: UILabel!
    @IBOutlet weak var gas_price: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light

        let azsStringURL = "https://index.minfin.com.ua/ua/markets/fuel/"

        Task.detached {
            guard let myAzsURL = URL(string: azsStringURL) else { return}

            do {
                let loadingView = await RSLoadingView()
                await loadingView.show(on: self.view)
                
                let myHTMLAzsString = try String(contentsOf: myAzsURL, encoding: .utf8)
                
                do {
                    let docAzs = try SwiftSoup.parse(myHTMLAzsString)
                    do {
                        let avarage_azs_prices = try docAzs.select("big").array()
                        let avarage_azs_caption = try docAzs.select("caption").first()

                         await MainActor.run {
                            do {
                                self.caption.text = try avarage_azs_caption?.text()
                                self.a95plus_price.text = try avarage_azs_prices[0].text()
                                self.a95_price.text = try avarage_azs_prices[1].text()
                                self.a92_price.text = try avarage_azs_prices[2].text()
                                self.dp_price.text = try avarage_azs_prices[3].text()
                                self.gas_price.text = try avarage_azs_prices[4].text()
                                
                                RSLoadingView.hide(from: self.view)
                            } catch {}
                        }
                        
                    } catch {}
                }
            } catch let error {
                print("Error: \(error)")
            }
        }
        
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
