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
AVAudioPlayer，AVPlayer，AVQueuePlayer都支持后台播放、锁屏信息、耳机控制等

关联博客：<http://blog.csdn.net/dolacmeng/article/details/77430108>

## ShowSandBoxFile_SendFileByMail_Demo

1、日志写入沙盒文件中进行缓存，设置缓存机制（参考SDWebImage：保存时长+最大容量）；<br>
2、沙盒文件可视化，参考自（[AirSandbox](https://github.com/music4kid/AirSandbox)）；<br>
3、内部发送邮件，使用[SKPSMTPMessage](https://github.com/jetseven/skpsmtpmessage)，可参考[iOS发送邮件 - SKPSMTPMessage](https://www.jianshu.com/p/6cbb7f82c625)；<br>
