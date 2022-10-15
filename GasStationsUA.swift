//
//  GasStationsUA.swift
//  Fuel Prices UA
//
//  Created by Admin on 12.10.2022.
//

import UIKit
import SwiftSoup
import RSLoadingView

class GasStationsUA: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var AZS1: UILabel!
    @IBOutlet weak var AZS2: UILabel!
    @IBOutlet weak var AZS3: UILabel!
    @IBOutlet weak var AZS4: UILabel!
    @IBOutlet weak var AZS5: UILabel!
    
    
    @IBOutlet weak var socar_a95plus: UILabel!
    @IBOutlet weak var socar_gas: UILabel!
    @IBOutlet weak var socar_dp: UILabel!
    
    @IBOutlet weak var okko_a95plus: UILabel!
    @IBOutlet weak var okko_a95: UILabel!
    @IBOutlet weak var okko_dp: UILabel!
    @IBOutlet weak var okko_gas: UILabel!
    
    @IBOutlet weak var wog_a95plus: UILabel!
    @IBOutlet weak var wog_a95: UILabel!
    @IBOutlet weak var wog_dp: UILabel!
    @IBOutlet weak var wog_gas: UILabel!
    
    
    @IBOutlet weak var amic_95plus: UILabel!
    @IBOutlet weak var amic_95: UILabel!
    @IBOutlet weak var amic_92: UILabel!
    @IBOutlet weak var amic_dp: UILabel!
    @IBOutlet weak var amic_gas: UILabel!
    
    @IBOutlet weak var upg_95plus: UILabel!
    @IBOutlet weak var upg_95: UILabel!
    @IBOutlet weak var upg_dp: UILabel!
    @IBOutlet weak var upg_gas: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        let azsStringURL = "https://index.minfin.com.ua/ua/markets/fuel/tm/tm.php"
        let socarStringURL = "https://index.minfin.com.ua/ua/markets/fuel/tm/socar/"
        
        Task.detached {
            guard let mySocarURL = URL(string: socarStringURL) else { return}
            guard let myAzsURL = URL(string: azsStringURL) else { return}

            do {
                let loadingView = await RSLoadingView()
                await loadingView.show(on: self.view)
                
                let myHTMLSocarString = try String(contentsOf: mySocarURL, encoding: .utf8)
                let myHTMLAzsString = try String(contentsOf: myAzsURL, encoding: .utf8)

                let htmlContentSocar = myHTMLSocarString
                
                do {
                    let docSocar = try SwiftSoup.parse(htmlContentSocar)
                    let docAzs = try SwiftSoup.parse(myHTMLAzsString)
                    do {
                        let all_azs_td = try docAzs.select("td").array()
                        let all_azs_caption = try docAzs.select("caption").first()

                        let socar = try docSocar.select("big").array()

                         await MainActor.run {
                            do {
                                self.textLabel.text = try all_azs_caption?.text()
                                
                                self.AZS1.text = try all_azs_td[70].text()
                                self.AZS2.text = try all_azs_td[105].text()
                                self.AZS3.text = try all_azs_td[168].text()
                                self.AZS4.text = try all_azs_td[0].text()
                                self.AZS5.text = try all_azs_td[91].text()
                                
                                self.socar_a95plus.text = try socar[0].text()
                                self.socar_dp.text = try socar[1].text()
                                self.socar_gas.text = try socar[2].text()
                                
                                self.wog_a95plus.text = try all_azs_td[107].text()
                                self.wog_a95.text = try all_azs_td[108].text()
                                self.wog_dp.text = try all_azs_td[110].text()
                                self.wog_gas.text = try all_azs_td[111].text()

                                self.okko_a95plus.text = try all_azs_td[170].text()
                                self.okko_a95.text = try all_azs_td[171].text()
                                self.okko_dp.text = try all_azs_td[173].text()
                                self.okko_gas.text = try all_azs_td[174].text()
                                
                                self.amic_95plus.text = try all_azs_td[2].text()
                                self.amic_95.text = try all_azs_td[3].text()
                                self.amic_92.text = try all_azs_td[4].text()
                                self.amic_dp.text = try all_azs_td[5].text()
                                self.amic_gas.text = try all_azs_td[6].text()
                                
                                self.upg_95plus.text = try all_azs_td[93].text()
                                self.upg_95.text = try all_azs_td[94].text()
                                self.upg_dp.text = try all_azs_td[96].text()
                                self.upg_gas.text = try all_azs_td[97].text()

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
