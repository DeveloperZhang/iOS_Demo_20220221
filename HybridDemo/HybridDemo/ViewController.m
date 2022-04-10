//
//  ViewController.m
//  HybridDemo
//
//  Created by Vicent on 2022/4/9.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"

@interface ViewController ()<WKUIDelegate, WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *myWebView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Hello Hybrid");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOC.html" ofType:nil];
    NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.myWebView.UIDelegate = self;
    self.myWebView.navigationDelegate = self;
    [self.myWebView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),dispatch_get_main_queue(),^{
        //OC调用JS  changeColor()是JS方法名，completionHandler是异步回调block
        NSString *jsString = [NSString stringWithFormat:@"changeColor(%d)", 1];
        [self.myWebView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
         NSLog(@"改变HTML的背景色");
        }];
    });
    // 启用 WebViewJavascriptBridge Log
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.myWebView];
    [_bridge setWebViewDelegate:self];
    [_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" } responseCallback:^(id responseData) {
        NSLog(@"JS 的返回值: %@",responseData);
    }];
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //添加监测网页加载进度的观察者
     [self.myWebView addObserver:self
                    forKeyPath:@"estimatedProgress"
                       options:0
                       context:nil];
    //添加监测网页标题title的观察者
     [self.myWebView addObserver:self
                    forKeyPath:@"title"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    //移除观察者
    [self.myWebView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.myWebView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(title))];
    [super viewDidDisappear:animated];
}


//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                  ofObject:(id)object
                    change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                   context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
     && object == self.myWebView) {
        NSLog(@"网页加载进度 = %f",self.myWebView.estimatedProgress);
        self.progressView.progress = self.myWebView.estimatedProgress;
        if (self.myWebView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
    }else if([keyPath isEqualToString:@"title"]
          && object == self.myWebView){
        self.navigationItem.title = self.myWebView.title;
    }else{
        [super observeValueForKeyPath:keyPath
                          ofObject:object
                            change:change
                           context:context];
    }
}



/**
    *  web界面中有弹出警告框时调用
    *
    *  @param webView           实现该代理的webview
    *  @param message           警告框中的内容
    *  @param completionHandler 警告框消失调用
    */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
   UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
   [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       completionHandler();
   }])];
   [self presentViewController:alertController animated:YES completion:nil];
}
   // 确认框
   //JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
   UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
   [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       completionHandler(NO);
   }])];
   [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       completionHandler(YES);
   }])];
   [self presentViewController:alertController animated:YES completion:nil];
}
   // 输入框
   //JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
   UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
   [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.text = defaultText;
   }];
   [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       completionHandler(alertController.textFields[0].text?:@"");
   }])];
   [self presentViewController:alertController animated:YES completion:nil];
}
// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
   if (!navigationAction.targetFrame.isMainFrame) {
       [webView loadRequest:navigationAction.request];
   }
   return nil;
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {

}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
}
//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}
// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}
// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSString * urlStr = navigationAction.request.URL.absoluteString;
//    NSLog(@"发送跳转请求：%@",urlStr);
    //自己定义的协议头
    NSString *htmlHeadString = @"github://";
    NSString *htmlHeadString1 = @"app://";
    if([urlStr hasPrefix:htmlHeadString]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通过截取URL调用OC" message:@"你想前往我的Github主页?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@"github://callName_?" withString:@""]];
            [[UIApplication sharedApplication] openURL:url];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else if([urlStr hasPrefix:htmlHeadString1]) {
        NSLog(@"拦截到URL为:%@",htmlHeadString1);
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    //用户身份信息
    NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
    //为 challenge 的发送方提供 credential
    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}
//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}





@end
