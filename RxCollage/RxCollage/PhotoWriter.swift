//
//  PhotoWriter.swift
//  RxCollage
//
//  Created by Jean-Marc Kampol Mieville on 4/12/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PhotoWriter: NSObject {
    typealias Callback = (NSError?)->Void
    
    private var callBack: Callback
    private init(callback: @escaping Callback) {
        self.callBack = callback
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?,
               contextInfo: UnsafeRawPointer) {
        callBack(error)
    }
    
    static func save(_ image: UIImage) -> Observable<Void> {
        return Observable.create({ observer in
            let writer = PhotoWriter(callback: { (error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onCompleted()
                }
            })
            UIImageWriteToSavedPhotosAlbum(image, writer, #selector(PhotoWriter.image(_:didFinishSavingWithError:contextInfo:)), nil)
            return Disposables.create()
        })
    }
}

