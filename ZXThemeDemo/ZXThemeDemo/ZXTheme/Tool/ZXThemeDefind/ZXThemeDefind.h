//
//  ZXThemeDefind.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#ifndef ZXThemeDefind_h
#define ZXThemeDefind_h
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ZXThemeData(type) [ZXThemeTool zx_getThemeWithPropertyStr:NSStringFromSelector(_cmd) themeInstance:self orgSetData:set themeType:type]

#define ZXThemeDarkLevel1Color UIColorFromRGB(0x000000)
#define ZXThemeDarkLevel2Color UIColorFromRGB(0x1c1c1c)
#define ZXThemeLightLevel1Color UIColorFromRGB(0xffffff)
#define ZXThemeLightLevel2Color UIColorFromRGB(0xfefefe)

#define ZXThemeUpdateNotification @"ZXThemeUpdateNotification"

#endif /* ZXThemeDefind_h */
