# SomeEasyDemos
some easy demos.


## Audio_Demo

* `AVSpeechSynthesizer`：语音合成器，播放指定文字
* `AudioServicesPlaySystemSound`：限制播放短音效，可播放系统音效或者本地短音效 <br>
系统音效参考：http://iphonedevwiki.net/index.php/AudioServices
* `AVAudioPlayer`：只能播放本地音乐文件
* `AVPlayer`：支持播放本地、分步下载、或在线流媒体音视频，不仅可以播放音频，配合AVPlayerLayer类可实现视频播放。另外支持播放进度监听。
AVPlayer只支持单个媒体资源的播放
* `AVQueuePlayer`：是 AVPlayer 子类，实现列表播放 <br>
AVAudioPlayer，AVPlayer，AVQueuePlayer都支持后台播放、锁屏信息、耳机控制等<br>
* 关联博客：<http://blog.csdn.net/dolacmeng/article/details/77430108>

**拓展：三方库语音合成**<br>
1、[科大讯飞-语音合成-**收费**](https://www.xfyun.cn/services/online_tts) <br>
2、[百度-语音合成](https://ai.baidu.com/sdk#tts) <br>
    * 离在线融合SDK - **免费，但有上限限制（QPS限制：100，可申请提高OPS）** - 提供Android/iOS离在线融合SDK，可以根据网络环境的变化自动进行在线合成与离线合成的切换，弱网环境也可继续使用。 <br>
    * 离线SDK - **免费** - 需要填写合作咨询申请。 <br>
3、[云知声-语言合成-免费 - 仅支持Android](http://dev.hivoice.cn/index.jsp) <br>

## ShowSandBoxFile_SendFileByMail_Demo

1、日志写入沙盒文件中进行缓存，设置缓存机制（参考SDWebImage：保存时长+最大容量）；<br>
2、沙盒文件可视化，参考自（[AirSandbox](https://github.com/music4kid/AirSandbox)）；<br>
3、内部发送邮件，使用[SKPSMTPMessage](https://github.com/jetseven/skpsmtpmessage)，可参考[iOS发送邮件 - SKPSMTPMessage](https://www.jianshu.com/p/6cbb7f82c625)；<br>

## Scan_QRCode_Distance

1、扫描二维码页面手势拉伸镜头、双击拉伸镜头；<br>
2、扫码二维码页面自动识别二维码并自动拉伸镜头（现在是已经识别了二维码，然后根据二维码中的坐标进行拉伸动作，马后炮）；<br>

**拓展：** <br>
有效区域：[IOS二维码扫描,你需要注意的两件事](https://blog.cnbluebox.com/blog/2014/08/26/ioser-wei-ma-sao-miao/) <br>
其他demo：[LBXScan](https://github.com/MxABC/LBXScan) <br>


## Analyze_YYModel

> 对YYModel简单使用的记录。对应文章 https://www.jianshu.com/p/912357d39b15

