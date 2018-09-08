//
//  NSObject+CBMJExtension.m
//  BaseFrame
//
//  Created by 小华 on 2018/8/17.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "NSObject+CBMJExtension.h"

@implementation NSObject (CBMJExtension)

/**
 * 字典转模型过程中遇到的错误
 */
+ (NSError *)CBMJExtensionerror{
    return [self mj_error];
}

#pragma mark - 对象方法
/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 */
- (instancetype)CBMJExtensionsetKeyValues:(id)keyValues{
    return [self mj_setKeyValues:keyValues];
}

/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @param context   CoreData上下文
 */
- (instancetype)CBMJExtensionsetKeyValues:(id)keyValues context:(NSManagedObjectContext *)context{
    return [self mj_setKeyValues:keyValues context:context];
}

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSMutableDictionary *)CBMJExtensionkeyValues{
    return [self mj_keyValues];
}

/**
 *  通过模型数组来创建一个字典数组
 *  @param objectArray 模型数组
 *  @return 字典数组
 */
+ (NSMutableArray *)CBMJExtensionkeyValuesArrayWithObjectArray:(NSArray *)objectArray{
    return [self mj_keyValuesArrayWithObjectArray:objectArray];
}

#pragma mark - 字典转模型
/**
 *  通过字典来创建一个模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @return 新建的对象
 */
+ (instancetype)CBMJExtensionobjectWithKeyValues:(id)keyValues{
    return [self mj_objectWithKeyValues:keyValues];
}

/**
 *  通过字典来创建一个CoreData模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @param context   CoreData上下文
 *  @return 新建的对象
 */
+ (instancetype)CBMJExtensionobjectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context{
    return [self mj_objectWithKeyValues:keyValues context:context];
}

/**
 *  通过plist来创建一个模型
 *  @param filename 文件名(仅限于mainBundle中的文件)
 *  @return 新建的对象
 */
+ (instancetype)CBMJExtensionobjectWithFilename:(NSString *)filename{
    return [self mj_objectWithFilename:filename];
}

/**
 *  通过plist来创建一个模型
 *  @param file 文件全路径
 *  @return 新建的对象
 */
+ (instancetype)CBMJExtensionobjectWithFile:(NSString *)file{
    return [self mj_objectWithFile:file];
}

#pragma mark - 字典数组转模型数组
/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @return 模型数组
 */
+ (NSMutableArray *)CBMJExtensionobjectArrayWithKeyValuesArray:(id)keyValuesArray{
    return [self mj_objectArrayWithKeyValuesArray:keyValuesArray];
}

/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @param context        CoreData上下文
 *  @return 模型数组
 */
+ (NSMutableArray *)CBMJExtensionobjectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context{
    return [self mj_objectArrayWithKeyValuesArray:keyValuesArray context:context];
}

/**
 *  通过plist来创建一个模型数组
 *  @param filename 文件名(仅限于mainBundle中的文件)
 *  @return 模型数组
 */
+ (NSMutableArray *)CBMJExtensionobjectArrayWithFilename:(NSString *)filename{
    return [self mj_objectArrayWithFilename:filename];
}

/**
 *  通过plist来创建一个模型数组
 *  @param file 文件全路径
 *  @return 模型数组
 */
+ (NSMutableArray *)CBMJExtensionobjectArrayWithFile:(NSString *)file{
    return [self mj_objectArrayWithFile:file];
}

#pragma mark - 转换为JSON
/**
 *  转换为JSON Data
 */
- (NSData *)CBMJExtensionJSONData{
    return [self mj_JSONData];
}

/**
 *  转换为JSON 字符串
 */
- (NSString *)CBMJExtensionJSONString{
    return [self mj_JSONString];
}

/**
 *  数组中对应模型
 */
+ (void)CBMJsetupObjectClassInArray:(MJObjectClassInArray)objectClassInArray
{
    [self mj_setupObjectClassInArray:objectClassInArray];
}


/**
 *替换特殊属性名

 */
+ (void)CBMJsetupReplacedKeyFromPropertyName:(MJReplacedKeyFromPropertyName)replacedKeyFromPropertyName
{
    [self mj_setupReplacedKeyFromPropertyName:replacedKeyFromPropertyName];
}
@end
