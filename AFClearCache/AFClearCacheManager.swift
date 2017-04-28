//
//  AFClearCacheManager.swift
//  AFClearCache
//
//  Created by Afer on 2017/4/28.
//  Copyright © 2017年 Afer. All rights reserved.
//

import UIKit

class AFClearCacheManager: NSObject {

    fileprivate class func getFilesAndPath() -> ([String]?, String?) {
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let files = FileManager.default.subpaths(atPath: cachePath!)
        return (files, cachePath)
    }
    
    fileprivate class func calcCacheSize() -> Double {
        let file = getFilesAndPath()
        var big: CLongLong = 0;
        for p in file.0! {
            let path = file.1!.appendingFormat("/\(p)")
            if(FileManager.default.fileExists(atPath: path) && FileManager.default.isDeletableFile(atPath: path)){
                let floder = try! FileManager.default.attributesOfItem(atPath: path)
                for (abc ,bcd) in floder {
                    if abc == FileAttributeKey.size {
                        big += (bcd as AnyObject).integerValue
                    }
                }
            }
        }
        return Double(big) / (1024.0 * 1024.0)
    }
    
    
    public class func asynCalcCacheSize(calcCallBack: @escaping (String) -> ()) {
        let queue: DispatchQueue = DispatchQueue.global()
        queue.async { 
            let size = AFClearCacheManager.calcCacheSize()
            DispatchQueue.main.async(execute: { 
                calcCallBack(String.init(format: "%.2f", size))
            })
        }
    }
    
    fileprivate class func removeCache() {
        let file = getFilesAndPath()
        for p in file.0! {
            let path = file.1!.appendingFormat("/\(p)")
            if(FileManager.default.fileExists(atPath: path) && FileManager.default.isDeletableFile(atPath: path)){
                do {
                    try FileManager.default.removeItem(atPath: path as String)
                } catch {
                    print("Remove Item AtPath Error !" + path)
                }
            }
        }
    }
    
    public class func asynRemoveCache(calcCallBack: @escaping () -> ()) {
        let queue: DispatchQueue = DispatchQueue.global()
        queue.async {
            removeCache()
            DispatchQueue.main.async(execute: {
                calcCallBack()
            })
        }

    }
    
}
