//
//  QRPaymentController.swift
//  recruitment-sdd_study_case_1
//
//  Created by Jonathan Kristian on 03/04/24.
//

import UIKit
import AVFoundation

protocol QRPaymentDelegate: AnyObject{
    func finalizeTransaction(transaction: Transaction)
}
class QRPaymentController: UIViewController {
    
    @IBOutlet weak var captureAreaView: UIView!
    
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var delegate: QRPaymentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupQRScaner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            if (self.captureSession?.isRunning == false) {
                self.captureSession.startRunning()
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async {
            if (self.captureSession?.isRunning == true) {
                self.captureSession.stopRunning()
            }
        }
    }

    func setupQRScaner(){
        DispatchQueue.main.async {
            self.captureSession = AVCaptureSession()
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                self.failed()
                return
            }
            let videoInput: AVCaptureDeviceInput
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                self.failed()
                return
            }
            if (self.captureSession.canAddInput(videoInput)) {
                self.captureSession.addInput(videoInput)
            } else {
                self.failed()
                return
            }
            let metadataOutput = AVCaptureMetadataOutput()
            if (self.captureSession.canAddOutput(metadataOutput)) {
                self.captureSession.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr]
            } else {
                self.failed()
                return
            }
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.previewLayer.videoGravity = .resizeAspectFill
            self.captureAreaView.layer.addSublayer(self.previewLayer)
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    }
    

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(ac, animated: true)
        self.captureSession = nil
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

extension QRPaymentController: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.stopRunning()
        }
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
    func found(code: String) {
        let data: [String] = code.components(separatedBy: ".")
        if data.count == 4{
            guard let thisTransaction: Transaction = Transaction(dictionary: [
                "bankName" : data[0],
                "transID" : data[1],
                "merchName" : data[2],
                "value" : Int(data[3]) ?? 0,
                "type" : "credits"
                
            ]) else{
                self.invalidQR()
                return
            }
            if thisTransaction.value <= MINIMUM_TRANSACTION{
                DispatchQueue.main.async {
                    let ac = UIAlertController(title: "Invalid Transaction", message: "Amount must grater or equal to Rp.\(MINIMUM_TRANSACTION.formatted()).", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        DispatchQueue.global(qos: .userInitiated).async {                    self.captureSession.startRunning()
                        }
                    }))
                    self.present(ac, animated: true)
                }
            } else if thisTransaction.bankName != "" &&
                thisTransaction.transID != "" &&
                thisTransaction.merchName != "" &&
                thisTransaction.value > 0 {
                print("-------- \(code)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.dismiss(animated: false, completion: { 
                        self.delegate?.finalizeTransaction(transaction: thisTransaction)
                    })
                }
                return
                
            }else{
                self.invalidQR()
            }
        }else{
            self.invalidQR()
        }
    }
    
    func invalidQR(){
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Invalid QR", message: "This QR is not valid for this transaction", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                DispatchQueue.global(qos: .userInitiated).async {                    
                    self.captureSession.startRunning()
                }
            }))
            self.present(ac, animated: true)
        }
    }
}
