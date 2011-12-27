//
//  ServerConfig.h
//  bookcamp
//
//  Created by lin waiwai on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define DoubanApiKeys [NSArray arrayWithObjects:@"072f9e4e47c2b4ac158edaead7481e04", \
								 @"0fdef83c42c9ac2c2f9ce8b4c85d0484", \
								 @"006c1cf9f50dee98014456eddf29cbc8", \
								 @"0402c575c1b18dee0c0850614514a9ca", \
								 @"04fd2ce3416ac3d80ef786a9c4404b88", \
								 @"0175683becbc75c4046038b3c635614c", \
								@"0b5799314288b5252206cb93c79a1f6f", \
	@"08171abdb790ae661845503926b20b32", \
@"02d88ae23aa58a110889a0a6aff09e33", \
@"0e1572ba9dc8e4092a40582fd95aac1b", \
								 nil]


#define DoubanSecretKey @"f04de9469368b5c3"

#define ApiServerBase @"http://api.douban.com/"
#define BookServerBase @"http://book.douban.com/"
#define ServerBase @"http://book.douban.com/"

#define DotSeparator @"."
#define PathSeparator @"/"
#define ServerDistination(_DISTINATION) [ServerBase stringByAppendingString:@#_DISTINATION]
#define ApiServerDistination(_DISTINATION , _PARAMETER)[NSString stringWithFormat: \
	[NSString stringWithFormat:@"%@?alt=json&apikey=%@",  \
	[ApiServerBase stringByAppendingString:@#_DISTINATION],[[Factory sharedInstance] makeDoubanApiKey]] ,_PARAMETER ]
#define BookServerDistination(_DISTINATION) [BookServerBase stringByAppendingString:@#_DISTINATION]
