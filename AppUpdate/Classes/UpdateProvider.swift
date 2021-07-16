//
//  UpdateProvider.swift
//  
//
//  Copyright © Senyas. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON

public class UpdateProvider: NSObject {
    
    static var AppUpdateUrl: URL!
    
    var updateView : AppUpdateView = {
        
        var m_associateBundleURL: URL = Bundle.main.url(forResource: "Frameworks", withExtension: nil)!
        m_associateBundleURL = m_associateBundleURL.appendingPathComponent("AppUpdate")
        m_associateBundleURL = m_associateBundleURL.appendingPathExtension("framework")
        let m_associateBunle: Bundle = Bundle.init(url: m_associateBundleURL)!
        m_associateBundleURL = m_associateBunle.url(forResource: "AppUpdate", withExtension: "bundle")!
        let m_bundle: Bundle = Bundle(url: m_associateBundleURL)!
        
        let myView : AppUpdateView = m_bundle.loadNibNamed("AppUpdateView", owner: self, options: nil)?.last as! AppUpdateView
        myView.frame = CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return myView
    }()
    
    @objc public static let shared = UpdateProvider()
    private override init() { }
    
    
    /// App Check Version, Reminder Update.
    ///
    /// - parameter update_url: check app version url
    /// - parameter channel: method of distribution - developer,distribute
    /// - parameter bundleID: app bundle id, default current app bundle id
    /// - note: please read README.md.
    @objc public func updateVersion(update_url: String, channel: String, bundleID: String = "") {

        let bundleIdentifier:String = Bundle.main.bundleIdentifier!
        Alamofire.request(URL(string: update_url)!, method: .post, parameters: ["packname": bundleID.isEmpty ? bundleIdentifier : bundleID, "channel": channel], encoding: URLEncoding.default, headers: nil).responseString { (response) in
            switch response.result{
            case .success(let value):
                let result = JSON.init(parseJSON: value)
                let resultObj = result["resultObj"].dictionaryValue
                var forceUpdate:Bool = false
                var content = ""
                if let temp = resultObj["IsOver"], let resultValue = temp.bool {
                    forceUpdate = resultValue
                }
                if let temp = resultObj["UpdateContent"],let resultValue = temp.string {
                    content = resultValue
                }
                
                var serverVersion = ""
                if let temp = resultObj["VersionName"],let resultValue = temp.string {
                    serverVersion = resultValue
                }
                let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                
                if "\(serverVersion)".version2Float - "\(currentVersion)".version2Float > 0 {
                    
                    var plistString: String = ""
                    if let tempStr = resultObj["Plist"],let resultValue = tempStr.string {
                        plistString = resultValue
                    }
                    if let tempURL = URL(string: "itms-services:///?action=download-manifest&url=\(plistString)") {
                        UpdateProvider.AppUpdateUrl = tempURL
                    }
                    DispatchQueue.main.async {
                        //当版本号相差版本号>0.03的时候必须更新
                        //到10进1 CFBundleShortVersionString //否则会失效
                        if "\(serverVersion)".version2Float - "\(currentVersion)".version2Float>0.03 || forceUpdate {
                            self.updateView.btn_close.isHidden = true
                            self.updateView.mustUpdate = true
                        }
                        UIApplication.shared.keyWindow?.addSubview(self.updateView)
                        self.updateView.label_version.text = serverVersion
                        
                        let paraph = NSMutableParagraphStyle()
                        paraph.lineSpacing = 6
                        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor.init(hexColor: "666666"),NSAttributedString.Key.paragraphStyle: paraph]
                        self.updateView.contentTextView.attributedText = NSAttributedString(string: content, attributes: attributes)
                    }
                }
            case .failure(_):
                break
            }
        }
    }
    
}


extension String {
    
    //3.5.5转为3.55
    var version2Float : Float {
        
        let arr = self.components(separatedBy: ".")
        if arr.count <= 2{
            return self.FloatValue
        }else{
            var str = ""
            for (index,item) in arr.enumerated(){
                if index == 0 {
                    str = "\(item)."
                }else{
                    str += item
                }
            }
            return str.FloatValue
        }
    }
    
    //转换为浮点数
    var FloatValue : Float {
        if let temp = Float(self) {
            return temp;
        }
        return 0.0
    }
}

extension UIColor {
    convenience init(hexColor: String) {
        var red: UInt32 = 0, green: UInt32 = 0, blue: UInt32 = 0
        
        let hex = hexColor as NSString
        Scanner(string: hex.substring(with: NSRange(location: 0, length: 2))).scanHexInt32(&red)
        Scanner(string: hex.substring(with: NSRange(location: 2, length: 2))).scanHexInt32(&green)
        Scanner(string: hex.substring(with: NSRange(location: 4, length: 2))).scanHexInt32(&blue)
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
}
