//
//  AppMacro.h
//  STDG
//
//  Created by 翟涛 on 14-3-14.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#ifndef STDG_AppMacro_h
#define STDG_AppMacro_h
/*
 *  咨询部分
 */
//  获取资讯列表栏目信息
#define STCLIENT_CATEGORY @"http://115.28.162.154/bbs/tvdb/category.php"
//  根据栏目分页查询，catid：栏目ID、strat：起始文章的id、count：本页文章加载数量
#define STCLIENT_CATEGORY_NEWS @"http://115.28.162.154/bbs/tvdb/categorynews.php?catid=%d&start=%d&count=%d"
//  根据文章id获取文章内容的接口
#define STCLIENT_CATEGOPY_NEWS_CONTENT @"http://115.28.162.154/bbs/tvdb/newscontent.php?aid=%d"
/*
 *  论坛部分
 */
//  获取论坛版块列表
#define STCLIENT_FORUM @"http://115.28.162.154/bbs/tvdb/forum.php"
//  分页获取某论坛板块的主题信息
#define STCLIENT_FORUM_POSTS_TITLE @"http://115.28.162.154/bbs/tvdb/postTitle.php?fid=%d&start=%d&count=%d"
//  分页获取主题下的帖子,其中tid：主题id，start：从第一个开始查询（即偏移量），count：本页查询最大数量
#define STCLIENT_FORUM_POSTS @"http://115.28.162.154/bbs/tvdb/post.php?tid=%d&start=%d&count=%d"
//  跟帖接口，post方法提交，其中fid：板块id,tid：主题id,author：发帖者用户名，mesage：帖子内容，authorid：发帖者id;返回0:表示发帖失败，1为发帖成功
#define STCLIENT_FORUM_REPLY @"http://115.28.162.154/bbs/tvdb/replyPost.php"
/*  
 *  登入接口 username：用户名，password：登入密码；返回{"code":3,"uid":"10","email":"...","state":"0"}
 *  code为登入状态码1为用户不存在，2为密码错误，3为登入成功，state为签约状态（-1未申请，0申请待审核，1已签约）
 */
#define STCLIENT_LOGIN @"http://115.28.162.154/bbs/tvdb/login.php"
/*
 *  查看开发者上架的应用信息
 */
/*
 * did表示开发者id，start表示分页偏移量，count表示本页数

 */
#define STCLIENT_APPINFOS @"http://115.28.162.154/discuz/gwtv/appsinfo.php?did=%d&start=0&count=30"

#define STCLIENT_APPINFO @"http://115.28.162.154/discuz/gwtv/appmarket/appinfo.php?app_id=%d"

#define STCLIENT_ORDERINFO @"http://115.28.162.154/discuz/gwtv/appmarket/orderinfo.php?app_id=%d&author_name=%@&from=gwtv&starttime=%@&endtime=%@&page_no=%d&page_size=10"
#endif
