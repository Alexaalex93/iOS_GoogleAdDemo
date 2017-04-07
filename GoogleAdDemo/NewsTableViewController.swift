//
//  NewsTableViewController.swift
//  GoogleAdDemo
//
//  Created by Pablo Mateo Fernández on 02/02/2017.
//  Copyright © 2017 355 Berry Street S.L. All rights reserved.
//

import UIKit
import GoogleMobileAds

//Añadido en app delegate el import y la linea en didfinishlaunching GADMobileAds.configure(withApplicationID: "ca-app-pub-5391720206606263~7342666233")
class NewsTableViewController: UITableViewController, GADBannerViewDelegate, GADInterstitialDelegate {

    /*lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = "ca-app-pub-5391720206606263/8819399439" //Identificador del banner que se coge desde la web
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        return adBannerView
    }() //Con lazy la inicializará cuando tenga los valores para hacerlo 
 */
    var adBannerView: GADBannerView?
    var interstitial: GADInterstitial?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ////////////// SIN declararlo lazy
        
        adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView?.adUnitID = "ca-app-pub-5391720206606263/8819399439" //Identificador del banner que se coge desde la web
        adBannerView?.delegate = self
        adBannerView?.rootViewController = self
        //////////////////////
        
        adBannerView?.load(GADRequest())
        
        interstitial = createAndLoadInterstitial()
        
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView!) { //Hemos recibido el anuncio correctamente
        print("Banner se ha cargado correctamente")
        
        //Reposicionar el anuncio para moverlo hacia abajo
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) { 
            bannerView.transform = CGAffineTransform.identity
            
            //Quitamos esto para hacrlo Sticky
           // self.tableView.tableHeaderView?.frame = bannerView.frame
           // self.tableView.tableHeaderView = bannerView
        }
        //Movido dentro de la animacion
        //tableView.tableHeaderView?.frame = bannerView.frame
        //tableView.tableHeaderView = bannerView
    }
    
    func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) { //No hemos recibido correctamente el anuncio
        print("Error al cargar el banner")
        print(error)
        
    }
    
    //Para haver el banner permanente y no se mueva
    /////////////////////////
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return adBannerView //Con esto le decimos que metemos el bannr en el header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adBannerView!.frame.height //Como el header el header es muy pequeño el header no va a crecer. Con esto le decimos que crezca
    }
    /////////////////////////
    
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial!) { //Si recibió el interstitial
        print("Interstitial recibido")
        ad.present(fromRootViewController: self)
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial!) { //Si fallo en la recepcion
        print("Error al carhar el interstitial")
    }
    func createAndLoadInterstitial() -> GADInterstitial? {
        
    interstitial = GADInterstitial(adUnitID: "ca-app-pub-5391720206606263/4609525839")
        guard let interstitial = interstitial else { return nil }
        let request = GADRequest ()
        //Para probarlos en el simulador hay que especificarlo
            //Eliminar esta linea antes de subir a la AppStore
        
        request.testDevices = [kGADSimulatorID]
        interstitial.load(request)
        interstitial.delegate = self
        return interstitial
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        // Configure the cell...
        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "red-lights-lisbon")
            cell.postTitle.text = "Red Lights, Lisbon"
            cell.postAuthor.text = "Texto Descripción"
            cell.authorImageView.image = UIImage(named: "fav-logo")
            
        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "val-throrens-france")
            cell.postTitle.text = "Val Thorens, France"
            cell.postAuthor.text = "Texto Descripción"
            cell.authorImageView.image = UIImage(named: "fav-logo")
            
        } else if indexPath.row == 2 {
            cell.postImageView.image = UIImage(named: "summer-beach-huts")
            cell.postTitle.text = "Summer Beach Huts, England"
            cell.postAuthor.text = "Texto Descripción"
            cell.authorImageView.image = UIImage(named: "fav-logo")
            
        } else {
            cell.postImageView.image = UIImage(named: "taxis-nyc")
            cell.postTitle.text = "Taxis, NYC"
            cell.postAuthor.text = "Texto Descripción"
            cell.authorImageView.image = UIImage(named: "fav-logo")
            
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
