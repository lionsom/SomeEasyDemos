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

