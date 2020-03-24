//
//  JZWCameraViewController.m
//  CarDetection
//
//  Created by 李明洋 on 2019/4/3.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "JZWCameraViewController.h"
#import "UIButtonTransform.h"
//导入相机框架
#import <AVFoundation/AVFoundation.h>
//将拍摄好的照片写入系统相册中，所以我们在这里还需要导入一个相册需要的头文件iOS8
#import <Photos/Photos.h>
#import "UIImage+Transform.h"

@interface JZWCameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>

//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic)AVCaptureDevice *device;

//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic)AVCaptureDeviceInput *input;

//当启动摄像头开始捕获输入
@property(nonatomic)AVCaptureMetadataOutput *output;

//照片输出流
@property (nonatomic)AVCaptureStillImageOutput *ImageOutPut;

//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic)AVCaptureSession *session;

//图像预览层，实时显示捕获的图像
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;

// ------------- UI --------------
//拍照按钮
@property (nonatomic)UIButton *photoButton;
//相册
@property (nonatomic) UIButtonTransform  *libaryButton;
@property (nonatomic) UIButtonTransform  *waterButton;

//取消&重拍
@property (weak, nonatomic) UIButton *cancelButton;
@property (nonatomic)UIButton *rePhotoButton;

//水印
@property (nonatomic)UIImageView *waterView;
@property (nonatomic)UIButton *makeSure;

//闪光灯按钮
@property (nonatomic)UIButton *flashButton;
//聚焦
@property (nonatomic) UIView *focusView;
//是否开启闪光灯
@property (strong, nonatomic) UIImage *ChooseImage;
@property (strong, nonatomic) UIImage *WaterImage;
@property (strong, nonatomic) UIImageView *imageView;

@property (nonatomic)BOOL isflashOn;

@property (assign, nonatomic) CGFloat safeBottom;
@property (assign, nonatomic) CGFloat safeNavTop;

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) BOOL isFormLibaray;

@end

@implementation JZWCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 11.0, *) ) {
        _safeBottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }else{
        _safeBottom = 0;
    }
    _safeNavTop = [UIApplication sharedApplication].statusBarFrame.size.height;
    _width = self.view.bounds.size.width;
    _height = self.view.bounds.size.height;

    self.view.backgroundColor = [UIColor blackColor];
    
    [self checkCameraPermission];
    [self customCamera];
    [self CreateUI];

}

#pragma mark- 检测相机权限,自动跳到设置里。
- (BOOL)checkCameraPermission
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        __weak typeof(self) weakself = self;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(JZWCameraViewControllerDidCancel:)]) {
                [weakself.delegate JZWCameraViewControllerDidCancel:weakself];
            }else if (weakself.navigationController.viewControllers.count > 1) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }else{
                [weakself dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        [alert addAction:action];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}

- (void)customCamera
{
    //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //使用设备初始化输入
    self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    //生成输出对象
    self.output = [[AVCaptureMetadataOutput alloc]init];
    
    self.ImageOutPut = [[AVCaptureStillImageOutput alloc]init];
    //生成会话，用来结合输入输出
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        [self.session setSessionPreset:AVCaptureSessionPreset1280x720];
    }
    if([self.session canSetSessionPreset:AVCaptureSessionPreset1920x1080]){
        [self.session setSessionPreset:AVCaptureSessionPreset1920x1080];
    }
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.ImageOutPut]) {
        [self.session addOutput:self.ImageOutPut];
    }
    //使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    self.previewLayer.frame = self.view.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.masksToBounds = YES;
    [self.view.layer addSublayer:self.previewLayer];
    //开始启动
    [self.session startRunning];
    //修改设备的属性，先加锁
    if ([self.device lockForConfiguration:nil]) {
        //闪光灯自动
        if ([self.device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [self.device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡
        if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [self.device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        //解锁
        [self.device unlockForConfiguration];
    }
    
    self.focusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.focusView.layer.borderWidth = 1.0;
    self.focusView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:self.focusView];
    self.focusView.hidden = YES;
    
}

-(void)CreateUI{
    self.imageView = [[UIImageView alloc]init];
    self.imageView.frame = self.view.bounds;
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.hidden = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.masksToBounds = YES;
    [self.view addSubview:self.imageView];
    
    UIButton *CancelBTN = [[UIButton alloc]init];
    [CancelBTN setImage:[UIImage imageNamed:@"cameraCancel"] forState:UIControlStateNormal];
    [CancelBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [CancelBTN addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    CancelBTN.layer.shadowColor = [UIColor grayColor].CGColor;
    CancelBTN.layer.shadowOffset = CGSizeMake(0, 0);
    CancelBTN.layer.shadowOpacity = 2.0;
    [self.view addSubview:CancelBTN];
    _cancelButton = CancelBTN;
    [CancelBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(self.safeNavTop);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.width.height.mas_equalTo(40);
    }];
    
    self.photoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.height-85-_safeBottom, 70, 70)];
    self.photoButton.center = CGPointMake(self.width/2.0, self.photoButton.center.y);
    [self.photoButton setImage:[UIImage imageNamed:@"photograph"] forState:UIControlStateNormal];
    [self.photoButton addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.photoButton];
    
    self.makeSure = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 54, 54)];
    [self.makeSure setImage:[UIImage imageNamed:@"使用照片"] forState:UIControlStateNormal];
    [self.makeSure addTarget:self action:@selector(makeSureAction) forControlEvents:UIControlEventTouchUpInside];
//    self.makeSure.layer.shadowColor = BACKVIEW_COLOR.CGColor;
//    self.makeSure.layer.shadowOffset = CGSizeMake(0, 0);
//    self.makeSure.layer.shadowOpacity = 2.0;
    [self.view addSubview:self.makeSure];
    self.makeSure.hidden = YES;
    [self.makeSure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(54);
        make.centerX.mas_equalTo(self.photoButton.mas_centerX);
        make.centerY.mas_equalTo(self.photoButton.mas_centerY);
    }];
    
    self.libaryButton = [[UIButtonTransform alloc]init];
    [self.libaryButton setImage:[UIImage imageNamed:@"相册图标"] forState:UIControlStateNormal];
    [self.libaryButton setTitle:@"相册" forState:UIControlStateNormal];
    self.libaryButton.titleLabel.font = Font(12);
    [self.libaryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.libaryButton addTarget:self action:@selector(libaryBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.libaryButton topImageLayout];
    [self.view addSubview:self.libaryButton];
    [self.libaryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.centerY.mas_equalTo(self.makeSure.mas_centerY);
        make.left.mas_equalTo(self.photoButton.mas_right).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
    }];
    self.libaryButton.hidden = !_allowLibary;

    self.rePhotoButton = [[UIButton alloc]init];
    [self.rePhotoButton setImage:[UIImage imageNamed:@"重拍照片"] forState:UIControlStateNormal];
    [self.rePhotoButton addTarget:self action:@selector(rePhotoAction) forControlEvents:UIControlEventTouchUpInside];
//    self.rePhotoButton.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.rePhotoButton.layer.shadowOffset = CGSizeMake(0, 0);
//    self.rePhotoButton.layer.shadowOpacity = 2.0;
    self.rePhotoButton.hidden = YES;
    [self.view addSubview:self.rePhotoButton];
    [self.rePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(54);
        make.centerX.mas_equalTo(self.libaryButton.mas_centerX);
        make.centerY.mas_equalTo(self.libaryButton.mas_centerY);
    }];
    
    if (_needWater) {
        UIButtonTransform *waterbtn= [[UIButtonTransform alloc]init];
        [waterbtn setImage:[UIImage imageNamed:@"waterBtnImage"] forState:UIControlStateNormal];
        [waterbtn setTitle:@"号牌遮挡图片" forState:UIControlStateNormal];
        waterbtn.titleLabel.font = Font(12);
        [waterbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [waterbtn addTarget:self action:@selector(waterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [waterbtn topImageLayout];
        [self.view addSubview:waterbtn];
        _waterButton = waterbtn;
        [waterbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.centerY.mas_equalTo(self.makeSure.mas_centerY);
            make.left.mas_equalTo(self.view.mas_left).offset(30);
            make.right.mas_equalTo(self.photoButton.mas_left).offset(-30);
        }];
        
        UIImage *wimage = [UIImage imageNamed:@"waterImage"];
        _waterView = [[UIImageView alloc]initWithImage:wimage];
        CGFloat h = wimage.size.height/wimage.size.width*80.0;
        _waterView.bounds = CGRectMake(0, 0, 100, h);
        _waterView.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
        _waterView.userInteractionEnabled = YES;
        _waterView.contentMode = UIViewContentModeScaleAspectFit;
        _waterView.hidden = YES;
        [self.view addSubview:_waterView];
        //拖动
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        pan.delegate = self;
        [_waterView addGestureRecognizer:pan];
        //图片放大缩小手势
        UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(changeScale:)];
        pinGesture.delegate = self;
        [self.view addGestureRecognizer:pinGesture];
        //图片旋转手势
        UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
        pinGesture.delegate = self;
        [self.view addGestureRecognizer:rotationGesture];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
    [self.view addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    NSLog(@"%@ - %@", gestureRecognizer.class, otherGestureRecognizer.class);
    return YES;
}

- (void)getThumbnailImages
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 获得相机胶卷
        PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.resizeMode = PHImageRequestOptionsResizeModeFast;
        // 同步获得图片, 只会返回1张图片
        options.synchronous = YES;
        // 获得某个相簿中的所有PHAsset对象
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:cameraRoll options:nil];
        if (assets.count > 0) {
            PHAsset *asset = assets.lastObject;
            CGSize size = CGSizeMake(150, 150);
            // 从asset中获得图片
            __weak typeof(self) weakSelf = self;
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                NSLog(@"%@", result);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.libaryButton setImage:result forState:UIControlStateNormal];
                });
            }];
            
        }
    });
}

- (void)focusGesture:(UITapGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:gesture.view];
    [self focusAtPoint:point];
}

- (void)focusAtPoint:(CGPoint)point{
    CGSize size = self.view.bounds.size;
    // focusPoint 函数后面Point取值范围是取景框左上角（0，0）到取景框右下角（1，1）之间,按这个来但位置就是不对，只能按上面的写法才可以。前面是点击位置的y/PreviewLayer的高度，后面是1-点击位置的x/PreviewLayer的宽度
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1 - point.x/size.width );
    if ([self.device lockForConfiguration:nil]) {
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:focusPoint];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.device setExposurePointOfInterest:focusPoint];
            //曝光量调节
            [self.device setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        [self.device unlockForConfiguration];
        _focusView.center = point;
        _focusView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.focusView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self.focusView.hidden = YES;
            }];
        }];
    }
}

#pragma mark- 拍照
- (void)shutterCamera
{
    AVCaptureConnection * videoConnection = [self.ImageOutPut connectionWithMediaType:AVMediaTypeVideo];
    if (videoConnection ==  nil) {
        return;
    }
    [self.ImageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return;
        }
        NSData *imageData =  [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        [self.session stopRunning];
        self.makeSure.hidden = NO;
//        self.waterView.hidden = NO;
        self.photoButton.hidden = YES;
        self.libaryButton.hidden = YES;
        self.rePhotoButton.hidden = NO;
        self.ChooseImage = [UIImage imageWithData:imageData];
        self.imageView.hidden = NO;
        self.imageView.image = self.ChooseImage;
        self.isFormLibaray = NO;
    }];
}

-(void)libaryBtnAction{
    [self.session stopRunning];
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:picker animated:YES completion:nil];
}

//选择完成回调函数
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    //TODO
    self.ChooseImage = image;
    self.photoButton.hidden = YES;
//    self.imageView.hidden = NO;
    self.imageView.image = image;
    self.libaryButton.hidden = YES;
    self.cancelButton.selected = YES;
    self.makeSure.hidden = NO;
    self.rePhotoButton.hidden = NO;
    self.imageView.hidden = NO;
    self.imageView.image = self.ChooseImage;
    self.isFormLibaray = YES;
}

//用户取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.session startRunning];
}

-(void)waterBtnAction:(UIButtonTransform *)sender{
    sender.selected = !sender.selected;
    _waterView.hidden = !sender.selected;
    self.waterView.transform = CGAffineTransformMakeTranslation(0, 0);
}

-(void)cancelAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(JZWCameraViewControllerDidCancel:)]) {
        [_delegate JZWCameraViewControllerDidCancel:self];
    }else if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)rePhotoAction{
    self.imageView.hidden = YES;
//    self.waterView.hidden = YES;
    self.makeSure.hidden = YES;
    self.rePhotoButton.hidden = YES;
    self.photoButton.hidden = NO;
    if (_allowLibary) {
        self.libaryButton.hidden = NO;
    }else{
        self.libaryButton.hidden = YES;
    }
    [self.session startRunning];
}

-(void)makeSureAction{
    if (_needWater && _waterButton.selected == YES) {
        self.WaterImage = [UIImage addwaterImageView:_waterView toSuperView:_imageView];
    }
    if (_saveToLibary && (!_isFormLibaray || _needWater)) {
        UIImageWriteToSavedPhotosAlbum(self.WaterImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(JZWCameraViewController:didFinishPickingImage:WaterImage:)]) {
        [_delegate JZWCameraViewController:self didFinishPickingImage:_ChooseImage WaterImage:_WaterImage];
    }
}
#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
}
-(void)panGesture:(UIPanGestureRecognizer *)pan{
    if (pan.state == UIGestureRecognizerStateBegan) {
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        //获取偏移量
        // 返回的是相对于最原始的手指的偏移量
        CGPoint transP = [pan translationInView:self.waterView];
        // 移动图片控件
        self.waterView.transform = CGAffineTransformTranslate(self.waterView.transform, transP.x, transP.y);
        // 复位,表示相对上一次
        [pan setTranslation:CGPointZero inView:self.waterView];
    }else if(pan.state == UIGestureRecognizerStateEnded){
        CGFloat tx = self.waterView.transform.tx;
        CGFloat ty = self.waterView.transform.ty;
        CGFloat cx = self.waterView.center.x;
        CGFloat cy = self.waterView.center.y;
        CGFloat amendTx = 0;
        CGFloat amendTy = 0;
        BOOL safev = NO;
        if(tx + cx < self.waterView.bounds.size.width/2.0){                         //            NSLog(@"左边缘");
            safev = YES;
            amendTx = self.waterView.bounds.size.width/2.0-cx-tx;
        }else if(cx + tx > self.width-self.waterView.bounds.size.width/2.0){        //            NSLog(@"右边缘");
            safev = YES;
            amendTx = self.width-self.waterView.bounds.size.width/2.0-cx-tx;
        }
        if(ty + cy < self.waterView.bounds.size.height/2.0+STATUS_BAR_HEIGHT){      //            NSLog(@"上边缘");
            safev = YES;
            amendTy = self.waterView.bounds.size.height/2.0+STATUS_BAR_HEIGHT-cy-ty;
        }else if(cy + ty > self.height+_safeBottom-self.waterView.bounds.size.height/2.0){//            NSLog(@"下边缘");
            safev = YES;
            amendTy = self.height+_safeBottom-self.waterView.bounds.size.height/2.0-cy-ty;
        }
        if (safev) {
            [UIView animateWithDuration:0.3 animations:^{
                self.waterView.transform = CGAffineTransformTranslate(self.waterView.transform, amendTx, amendTy);
            }];
        }
    }
}

- (void)changeScale:(UIPinchGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
        self.waterView.transform = CGAffineTransformScale(self.waterView.transform, sender.scale, sender.scale);
        sender.scale = 1.0;
    }
}

- (void)rotateImage:(UIRotationGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
        self.waterView.transform = CGAffineTransformRotate(self.waterView.transform, sender.rotation);
        [sender setRotation:0];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
