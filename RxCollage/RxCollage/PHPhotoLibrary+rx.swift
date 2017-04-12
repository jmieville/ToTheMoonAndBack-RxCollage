//
//  PHPhotoLibrary+rx.swift
//  RxCollage
//
//  Created by Jean-Marc Kampol Mieville on 4/12/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation
import Photos
import RxSwift

extension PHPhotoLibrary {
    static var authorized: Observable<Bool> {
        return Observable.create{ observer in
            DispatchQueue.main.async {
                if authorizationStatus() == .authorized {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    requestAuthorization({ (newStatus) in
                        observer.onNext(newStatus == .authorized)
                        observer.onCompleted()
                    })
                }
            }
            return Disposables.create()
        }
    }
}
