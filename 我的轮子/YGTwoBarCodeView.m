//
//  YGTwoBarCodeView.m
//  我的轮子
//
//  Created by zccl2 on 16/10/9.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGTwoBarCodeView.h"

@implementation YGTwoBarCodeView

-(instancetype)initWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width string:(NSString *)string{
    if (self=[super init]) {
        self.frame = CGRectMake(x, y, width, width);
        self.userInteractionEnabled = YES;
        self.image = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:string] withSize:width];
    }
    return self;
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
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.superview];
    CGPoint previousP = [touch previousLocationInView:self.superview];
    self.transform = CGAffineTransformTranslate(self.transform, currentP.x-previousP.x, currentP.y-previousP.y);
}



@end
