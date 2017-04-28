# AFClearCache
Delete Cache Manager.


清除缓存。
'''
AFClearCacheManager.asynCalcCacheSize { (size) in
            print("占用空间！ \(size)")
        }
        AFClearCacheManager.asynRemoveCache(calcCallBack: { size in
            print("清除成功！")
        })
'''
