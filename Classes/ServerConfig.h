//
//  ServerConfig.h
//
// Created by lin waiwai(jiansihun@foxmail.com) on 1/19/11.
// Copyright 2011 __waiwai__. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//


#error fill the mutiple ApiKeys and your SecretKey of Douban

#define DoubanApiKeys [NSArray arrayWithObjects:@"", \
								 nil]


#define DoubanSecretKey @""

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
