//
//  AboutViewController.swift
//  BullsEye
//
//  Created by 谢振宇 on 2018/1/21.
//  Copyright © 2018年 谢振宇. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("这里打印的是Bundle.main.bundlePath: " + Bundle.main.bundlePath);
        // Do any additional setup after loading the view.
        //这里显示的是自己本地的网页
//        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html"){
//            if let htmlData = try? Data(contentsOf: url){
//                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
//                webView.load(htmlData, mimeType: "text/html",
//                             textEncodingName: "UTF-8", baseURL: baseURL)
//            }
//        }
        //这里显示外部网站
        let myURL = URL.init(string: "http://www.apple.com")
        let request: URLRequest = URLRequest(url: myURL!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
