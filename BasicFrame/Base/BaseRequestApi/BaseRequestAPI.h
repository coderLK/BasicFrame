//
//  BaseRequestAPI.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/3.
//

#import <YTKNetwork/YTKNetwork.h>

@interface BaseRequestAPI : YTKBaseRequest

@property(nonatomic,assign)BOOL isOpenAES;//是否开启加密 默认开启


//自定义属性值
@property(nonatomic,assign)BOOL isSuccess;//是否成功
@property (nonatomic,copy) NSString * message;//服务器返回的信息
@property (nonatomic,copy) NSDictionary * result;//服务器返回的数据 已解密

@end
