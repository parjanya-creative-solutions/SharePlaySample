//
//  VideoPlayer.swift
//  SharePlay-Demo
//
//  Created by Kanishka on 13/12/21.
//

import AVKit
import SwiftUI
import GroupActivities


struct VideoPlayerController : UIViewControllerRepresentable {
    @State var url : URL
    @State var ftSession : GroupSession<VideoSharingActivity>?
    
func makeUIViewController(context: Context) -> some UIViewController {
    let controller = VideoPlayer(ftSession)
    controller.player = AVPlayer(url: url)
    controller.navigationController?.navigationBar.isHidden = true


    if let ftSession = ftSession {
        ftSession.join()
        controller.player!.playbackCoordinator.coordinateWithSession(ftSession)
        print("🤝 player coordinated")
        print("ftSession: \(ftSession.id), activitySession: \(String(describing: ftSession.id))")
    }
    
    controller.player?.play()
    return controller
}
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
     
    }
    }



extension AVPlayerViewController {
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.player?.pause()
    }
}


class VideoPlayer : AVPlayerViewController {
    
    var videoSession : GroupSession<VideoSharingActivity>?
    convenience init(_ facetime: GroupSession<VideoSharingActivity>?){
        self.init(nibName: nil, bundle: nil)
        self.videoSession = facetime
        
        let button = UIButton(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        button.setImage(UIImage(named: "x.mark.fill"), for: .normal)
        button.layer.cornerRadius = button.frame.width / 2
        button.addTarget(self, action: #selector(buttonTapAction), for: .touchUpInside)
        #warning("Add using content overlay")
        self.view.addSubview(button)
    }
    
    @objc func buttonTapAction(){
        let alert = UIAlertController(title: "How do you want to end the session?",
                                      message: nil,
                                      preferredStyle: .alert)
        let endAction = UIAlertAction(title: "End it for everyone",
                                      style: .default) { _ in
            self.videoSession?.end()
            self.dismiss(animated: true)
        }
        let leaveAction = UIAlertAction(title: "End it locally",
                                        style: .default) { _ in
            self.videoSession?.leave()
            self.dismiss(animated: true)
          }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {  _ in
            self.dismiss(animated: true)
        })
        
        [endAction, leaveAction, cancelAction].forEach { action in
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
