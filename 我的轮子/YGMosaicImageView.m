//
//  YGMosaicImageView.m
//  我的轮子
//
//  Created by zccl2 on 16/9/13.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGMosaicImageView.h"
#import "YGHeader.h"

static NSInteger const Intreal = 10;
static NSInteger const LogoImageWidth = 80;
static NSInteger const TitleLblWidth = 400;
static NSInteger const TwoCodeWidth = 100;
static NSInteger const LogoWidth = 60;
static NSInteger const LogoNameWidth = 140;

@implementation YGMosaicImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        frame.size.height = 1000*ViewWidth/600;
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 860*ViewWidth/600)];
    backView.backgroundColor = RGBCOLOR(248, 248, 248);
    [self addSubview:backView];
    
    _image = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth-LogoImageWidth*ViewWidth/600-TitleLblWidth*ViewWidth/600-Intreal)/2, 60*ViewWidth/600, LogoImageWidth*ViewWidth/600, LogoImageWidth*ViewWidth/600)];
    _image.backgroundColor = [UIColor orangeColor];
    _image.layer.cornerRadius = LogoImageWidth*ViewWidth/600/2;
    _image.layer.masksToBounds = YES;
    [backView addSubview:_image];
    
    _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_image.frame)+Intreal, CGRectGetMinY(_image.frame), TitleLblWidth*ViewWidth/600, LogoImageWidth*ViewWidth/600/2)];
    _titleLbl.font = [UIFont systemFontOfSize:30*ViewWidth/600];
    _titleLbl.textColor = [UIColor blackColor];
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:_titleLbl];
    
    _mobileLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_image.frame)+Intreal, CGRectGetMaxY(_titleLbl.frame), TitleLblWidth*ViewWidth/600, LogoImageWidth*ViewWidth/600/2)];
    _mobileLbl.font = [UIFont systemFontOfSize:24*ViewWidth/600];
    _mobileLbl.textColor = RGBCOLOR(204, 204, 204);
    _mobileLbl.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:_mobileLbl];
    
    _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200*ViewWidth/600, ViewWidth, ViewWidth)];
    _picImageView.backgroundColor = [UIColor redColor];
    _picImageView.contentMode = UIViewContentModeScaleAspectFill;
    _picImageView.layer.masksToBounds = YES;
    [backView addSubview:_picImageView];
    
    _messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_picImageView.frame), ViewWidth, 60*ViewWidth/600)];
    _messageLbl.textAlignment = NSTextAlignmentCenter;
    _messageLbl.font = [UIFont systemFontOfSize:24*ViewWidth/600];
    _messageLbl.textColor = [UIColor blackColor];
    [backView addSubview:_messageLbl];
    
    _twoCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Intreal, CGRectGetMaxY(_messageLbl.frame)+20*ViewWidth/600, TwoCodeWidth*ViewWidth/600, TwoCodeWidth*ViewWidth/600)];
    _twoCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_twoCodeImageView];
    
    UILabel *promptLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_twoCodeImageView.frame)+Intreal, CGRectGetMinY(_twoCodeImageView.frame), 250*ViewWidth/600-2*Intreal, CGRectGetWidth(_twoCodeImageView.frame)/2)];
    promptLbl.font = [UIFont systemFontOfSize:24*ViewWidth/600];
    promptLbl.textColor = [UIColor blackColor];
    promptLbl.text = @"长按或扫描二维码";
    [self addSubview:promptLbl];
    
    UILabel *viewDetailsLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_twoCodeImageView.frame)+Intreal, CGRectGetMaxY(promptLbl.frame), 250*ViewWidth/600-2*Intreal, CGRectGetWidth(_twoCodeImageView.frame)/2)];
    viewDetailsLbl.font = [UIFont systemFontOfSize:20*ViewWidth/600];
    viewDetailsLbl.textColor = RGBCOLOR(204, 204, 204);
    viewDetailsLbl.text = @"查看详情";
    [self addSubview:viewDetailsLbl];
    
    UIView *layer = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(promptLbl.frame), CGRectGetMinY(_twoCodeImageView.frame), 1, TwoCodeWidth*ViewWidth/600)];
    layer.backgroundColor = RGBCOLOR(248, 248, 248);
    [self addSubview:layer];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(370*ViewWidth/600, CGRectGetMaxY(_messageLbl.frame)+40*ViewWidth/600, LogoWidth*ViewWidth/600, LogoWidth*ViewWidth/600)];
    logo.image = [UIImage imageNamed:@"云店铺图标"];
    logo.layer.cornerRadius = LogoWidth*ViewWidth/600/2;
    logo.layer.masksToBounds = YES;
    [self addSubview:logo];
    
    UILabel *logoNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logo.frame)+Intreal*ViewWidth/600, CGRectGetMinY(logo.frame), LogoNameWidth*ViewWidth/600, LogoWidth*ViewWidth/600)];
    logoNameLbl.font = [UIFont systemFontOfSize:26*ViewWidth/600];
    logoNameLbl.textColor = [UIColor orangeColor];
    logoNameLbl.text = @"汽配云店铺";
    [self addSubview:logoNameLbl];
}

- (void)setContentViewWithInfo:(YGMosaicImageInfo *)info {
    _image.image = [UIImage imageNamed:info.logoImage];
    _titleLbl.text = info.storeName;
    _mobileLbl.text = info.mobile;
    _picImageView.image = [UIImage imageNamed:info.photo];;
    _messageLbl.text = info.accessoriesName;
    _twoCodeImageView.image = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:info.twoCode] withSize:TwoCodeWidth];
}

#pragma mark 保存图片
- (void)savePhoto {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 1024/ViewWidth);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();/**<生成图片*/
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

#pragma mark 生成二维码
- (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return qrFilter.outputImage;
}
#pragma mark 将二维码转换成UIImage格式，并改变其大小
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
