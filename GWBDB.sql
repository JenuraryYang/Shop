/*
	名称：购物宝数据库
	创建日期：2017-10-17
	团队：
	备注：
*/
if exists(select 1 from sys.sysdatabases where name='shopDB')
drop database shopDB
GO
create database shopDB
go
use shopDB
go
/*
	名称：管理员和店主帐号及客服帐号
	创建日期：2017-10-16
	备注：
*/
if exists(select 1 from sys.objects where name='AdministratorInfo')
drop table AdministratorInfo
go
create table AdministratorInfo(
	AI_ID int identity(1,1) primary key,		--编号
	AI_HImage varchar(30),		--头像路径
	AI_Num varchar(20)  ,		--手机号
	AI_LoginPwd varchar(20),		--登录密码
	AI_Name varchar(20),		--姓名
	AI_Sex varchar(2),			--性别
	AI_IDCard  varchar(20),		--身份证号
	AI_Alipay varchar(20),		--支付宝账户
	AI_Balance varchar(20),		--账户余额
	AI_Type int,			--帐号所用类型(0:管理员,1：店主,2：站内客服)
	AI_Date datetime		--注册日期
)
go


/*
	名称：普通会员帐号
	创建日期：2017-10-16
	备注：
*/
if exists(select 1 from sys.objects where name='BuyerInfo')
drop table BuyerInfo
go
create table BuyerInfo(
	BI_ID int   identity(1,1) primary key,		--编号
	BI_HImage varchar(30),		--头像路径
	BI_Phone varchar(20),		--手机号
	BI_NickName nvarchar(20)  ,		--昵称
	BI_LoginPwd nvarchar(20),		--登录密码
	BI_Name nvarchar(20),				--姓名
	BI_IDCared varchar(20),		--身份证号
	BI_Sex int default 2,		--性别(0:女  1:男  2:未知)
	BI_PayPwd nvarchar(20),		--支付密码
	BI_Balance Varchar(10),			--账户余额
	BI_Date datetime,			--注册日期
	BI_SumScore int--用户积分
)
go

/*
	名称：商品类型
	创建日期：2017-10-16
	备注：
*/
if exists(select 1 from sys.objects where name='CommodityTypeInfo')
drop table CommodityTypeInfo
go
create table CommodityTypeInfo(
	CTI_ID int identity(1,1) primary key,	--商品类型的唯一标识，主键，自增
	CTI_Name varchar(20),--商品类型名称，用于区别商品种类，便于搜索
	CTI_CTI_ID int,--引用商品类型编号
	CTI_SaveUrl nvarchar(20) default '' ,  --商品图片储存文件夹
	CTI_Remark varchar(20)--商品备注
	
)
go

/*
	名称：店铺类型
	创建日期：2017-10-16
	备注：
*/
if exists(select 1 from sys.objects where name='StoreTypeInfo')
drop table StoreTypeInfo
go
create table StoreTypeInfo
(
    STI_ID int primary key identity , --店铺类型编号
    STI_Name nvarchar(20),   --店铺类型编号
    STI_Remark nvarchar(50)   --备注
)
go
select * from StoreTypeInfo
/*
	名称：店铺
	创建日期：2017-10-16
	备注：
*/
if exists(select 1 from sys.objects where name='StoreInfo')
drop table StoreInfo
go
create table StoreInfo
(
    SI_ID int primary key identity ,-- 店铺编号
    SI_AI_ID int , --店主编号
    SI_STI_ID int,  --店铺类型编号
    SI_Name nvarchar(20),  --店铺名称
    SI_Logo  nvarchar(30),  --店铺logo
    SI_Intro nvarchar(100),  --店铺简介
    SI_CreateDate datetime,  --简谱创建日期
    SI_Remark nvarchar(20)   --备注
)
go
select * from StoreInfo
/*
	名称：商品
	创建日期：2017-10-16
	备注：1、名称：添加CI_Sendgoods字段，时间：17-10-23
*/
if exists(select 1 from sys.objects where name='CommodityInfo')
drop table CommodityInfo
go
create table CommodityInfo
(
   CI_ID  int  primary key identity,  --商品编号
   CI_CTI_ID int,	--商品类型
   CI_SI_ID  int,  --店铺编号
   CI_Name  nvarchar(50),  --商品名称
   CI_CreateDate  datetime ,  --商品创建日期
   CI_Is int ,   --商品是否上架，0:上架，1:未上架
   CI_Num  int  ,  --商品库存量 默认0
   CI_SalesNum  int ,   --商品销量 默认0
   CI_Discount	Varchar (5)	,--商品折扣
   CI_Price	Varchar	(10),  --商品原价
   CI_NowPrice	Varchar	(10)	,--商品现在的销售价格
   CI_Url	Varchar	(30),		--存入商品图片，部分参数的文件路径
   CI_Sendgoods int	--邮费

)
go
/*
	名称：账单（ReckoningInfo）
	创建日期：2017-10-16
	备注：
*/
if exists(select 1 from sys.objects where name='ReckoningInfo')
drop table ReckoningInfo
go

create table ReckoningInfo
(
  	RI_ID	Int  primary key identity , --账单编号
	RI_BI_ID	Int ,  --普通会员编号
	RI_CI_ID	Int ,  --商品编号
	RI_CPI_ID	int ,  --使用的优惠券的编号
	RI_Amount	Varchar(20) ,  --交易金额
	RI_States	Int ,  --状态0:失败1：成功
	RI_TransactionDate	Datetime ,  --交易日期
	RI_Remark	Varchar(50) --备注
)
go

/*
	名称：活动优惠券（CouponInfo）
	创建日期：2017-10-16
	修改:1.修改日期:17-10-18
			注:添加了CPI_CI_ID和CPI_IS
	备注：
*/
if exists(select 1 from sys.objects where name='CouponInfo')
drop table  CouponInfo
go
create table CouponInfo
(
   	CPI_ID	Int identity primary key ,  --优惠券编号
	CPI_Type	Varchar(5) ,  --所属类型
	CPI_MaxMoney	Varchar(10) ,  --满多少可用
	CPI_MinusMoney	Varchar(10)  ,  --抵扣多少
	CPI_CouponType	int,   --优惠券类型  绑定店铺编号，未绑定则默认为全站使用
	CPI_CI_ID int,--优惠券使用商品编号，绑定则必须绑定店铺编号，不绑定则可使用该店铺
	CPI_BeginDate datetime,--开始日期
	CPI_EndDate datetime,--结束日期
	CPI_IS int,--0:不启用1：启用

)
go
/*
	名称：活动（ActivityInfo）
	创建日期：2017-10-16
	修改:1.修改日期:17-10-18
			注:添加AI_IS
	备注：
*/
if exists(select 1 from sys.objects where name='ActivityInfo')
drop table ActivityInfo
go
create table ActivityInfo
(
  	AI_ID	Int identity primary key,  --活动编号
	AI_CI_ID  int  ,  --参与活动的商品编号
	AI_Price	Varchar(5) ,  --活动价
	AI_Starttime	Datetime ,  --活动开始时间
	AI_Endtime	Datetime , --活动结束时间
	AI_IS int--0:不启用1：启用

)
go

/*
	名称：地址
	创建日期：17-10-17
	备注：1、名称：添加MAI_IS，时间：17-10-19
		2、名称：添加MAI_Name字段，时间：17-10-22
*/
if exists(select 1 from sys.objects where name='MyAddressInfo')
drop table MyAddressInfo
go
create table MyAddressInfo
(
MAI_ID	Int	identity(1,1) primary key,				--收货地址的唯一标识，主键，自增
MAI_Name nvarchar(20),--收货人姓名
MAI_Type	Int,				--0：发货地址1：收货地址
MAI_BI_ID	Int, 			--识别用户的唯一标识
MAI_Phone	Varchar(20),		--到货后的联系电话
MAI_Province	Nvarchar(20),--配送省
MAI_City	Nvarchar(20),	--配送市
MAI_County	Nvarchar(20),	--配送县
MAI_Town	Nvarchar(20),	--配送镇
MAI_MinuteAddress	nvarchar(50),--配送详细地址（街道。。。）
MAI_IS int,--是否是默认地址，0：默认，其他值为非默认
MAI_Remark	Nvarchar(30)	--收货地址备注
)
go

/*
	名称：订单（OrderFormInfo）
	创建日期：2017-10-16
	备注：1、添加OFI_Sendgoods字段，时间：17-10-23
			2、添加OFI_DHL字段，时间：17-10-25
*/
if exists(select 1 from sys.objects where name='OrderFormInfo')
drop table OrderFormInfo
go
create table OrderFormInfo
(
  	OFI_ID	int primary key identity , --订单编号
	OFI_CI_ID	Int , --商品编号
	OFI_Number	Int , --商品数量
	OFI_BI_ID	Int , --买家编号
	OFI_Money	Varchar(15) , --订单金额
	OFI_States	Int , --订单状态 0:代发货，1：代付款，2：待收货，3：代评论
	OFI_CreateDate	Datetime , --创建日期
	OFI_SAI_ID int,--收货地址编号
	OFI_Address	Varchar(50),  --收货地址
	--OFI_Sendgoods int,	--邮费
	--OFI_DHL nvarchar(15) -- 快递公司
	Express_ID INT  -- 快递公司
)
go
/*
	名称：快递（Express）
	创建日期：2017-10-16
	
*/
if exists(select 1 from sys.objects where name='Express')
drop table Express
go
create table Express
(
   Express_ID int primary key identity,  --快递公司编号
   
   Express_Name nvarchar(50) ,-- 名称
   
   Express_Expense int ,-- 收费标准
   
   Express_Image nvarchar(64), --快递公司图片
   
   Express_Desc nvarchar(256) --快递公司简介
)

if exists(select 1 from sys.objects where name='Dic_OrderFormInfo_OFI_States')
drop table Dic_OrderFormInfo_OFI_States
go
create table Dic_OrderFormInfo_OFI_States
(
id int identity(0,1) primary key,
name varchar(10)
)

--select * from Dic_OrderFormInfo_OFI_States

/*
	名称：收藏（CollectGoodsInfo）
	创建日期：2017-10-16
	备注：
*/
if exists(select 1 from sys.objects where name='CollectGoodsInfo')
drop table CollectGoodsInfo
go
create table CollectGoodsInfo
(
	CGI_ID int identity(1,1) primary key,--收藏编号
	CGI_CI_ID int,--商品编号
	CGI_BI_ID int,--买家编号
	CGI_Time Datetime,--收藏时间
)
go

/*
	名称:足迹(FootprintInfo)
	创建日期:17-10-18
	备注:
*/
if exists(select 1 from sys.sysobjects where name='FootprintInfo')
	drop table FootprintInfo
go
create table FootprintInfo
(
	FI_ID	Int	identity primary key,	--足迹的唯一标识，自增，主键
	FI_BI_ID	Int,				--指明用户
	FI_CI_ID	int	,			--商品的唯一标识，指明商品
	FI_Date	Datetime			--商品浏览日期
)
go


/*
	名称:购物车(ShopCartInfo)
	创建日期:17-10-21
	备注:添加了一个字段：SCI_Money，修改日期2017-10-24
*/
if exists(select 1 from sys.sysobjects where name='ShopCartInfo')
	drop table ShopCartInfo
go
create table ShopCartInfo
(
	SCI_ID	Int	identity(1,1) primary key,	--购物车的唯一标识，自增，主键
	SCI_BI_ID	Int,				--指明用户
	SCI_CI_ID   int,				--商品编号
	SCI_Number	int	,			--商品数量
	SCI_Caozuo	int,			--操作
	SCI_Money   varchar(5)				--购物车选中金额
)
go
select * from ShopCartInfo






--select name from shopDB..sysobjects where xtype='u' 
--select * from sys.tables

/*===================================测试数据=========================================*/

/*
名称：管理员和店主帐号及客服帐号
创建日期：2017-10-16
备注：
*/
insert into AdministratorInfo values('','13271941321','123456','张小凡',0,'503021199801358142','13271941321','100',0,'2017-10-17')
insert into AdministratorInfo values('','13271941322','123456','张凡',0,'503021199801358142','13271941321','100',1,'2017-10-17')
insert into AdministratorInfo values('','13271941323','123456','张小峰',0,'503021199801358142','13271941321','100',2,'2017-10-17')
select * from AdministratorInfo

/*
	名称：普通会员添加测试数据
	创建日期：2017-10-17
	备注：
*/
insert into BuyerInfo values('','13271941330','小张','123456','张三','510562199412025234',0,'121212','1000','2017-10-11',0)
insert into BuyerInfo values('','13271941331','端木锡','123456','李四','510256199611112534',0,'121212','1000','2017-10-11',0)
insert into BuyerInfo values('','13271941332','落月','123456','王五','522154199806061425',0,'121212','1000','2017-10-11',0)
select * from BuyerInfo
go
/*
	名称：添加店铺类型测试数据
	日期：17-10-17
	备注：
*/
insert into StoreTypeInfo values('旗舰店','')
insert into StoreTypeInfo values('专卖店','')
insert into StoreTypeInfo values('专营店','')
select * from StoreTypeInfo
go
/*
	名称：添加商品类型测试数据
	日期：17-10-17
	备注：
*/
insert into CommodityTypeInfo values('服饰美妆',null,'yifu','')		--1
insert into CommodityTypeInfo values('家用电器',null,'dianqi','')		--2
insert into CommodityTypeInfo values('厨具家具',null,'cook','')		--3
insert into CommodityTypeInfo values('鞋包配饰',null,'xiebao','')		--4
insert into CommodityTypeInfo values('食品饮料',null,'food','')		--5
insert into CommodityTypeInfo values('新鲜水果',null,'fruit','')		--6
insert into CommodityTypeInfo values('手机数码',null,'shuma','')		--7
insert into CommodityTypeInfo values('电脑',null,'diannao','')		--8
insert into CommodityTypeInfo values('乐器',null,'yuqi','')		--9
insert into CommodityTypeInfo values('户外运动',null,'sport','')		--10



--服饰美妆
insert into CommodityTypeInfo values('男装',1,'','')
insert into CommodityTypeInfo values('童装',1,'','')
insert into CommodityTypeInfo values('女装',1,'','')
insert into CommodityTypeInfo values('洗面奶',1,'','')
insert into CommodityTypeInfo values('洗发水',1,'','')
insert into CommodityTypeInfo values('牙膏',1,'','')

--家用电器
insert into CommodityTypeInfo values('烤箱',2,'','')
insert into CommodityTypeInfo values('豆浆机',2,'','')
insert into CommodityTypeInfo values('电饭煲',2,'','')
insert into CommodityTypeInfo values('吹风机',2,'','')
insert into CommodityTypeInfo values('足浴盆',2,'','')
insert into CommodityTypeInfo values('剃须刀',2,'','')


--厨具家具
insert into CommodityTypeInfo values('铲子',3,'','')
insert into CommodityTypeInfo values('刀具',3,'','')
insert into CommodityTypeInfo values('锅具套装',3,'','')
insert into CommodityTypeInfo values('微波炉',3,'','')
insert into CommodityTypeInfo values('沙发',3,'','')
insert into CommodityTypeInfo values('衣柜',3,'','')



--鞋包配饰
insert into CommodityTypeInfo values('女鞋',4,'','')
insert into CommodityTypeInfo values('男鞋',4,'','')
insert into CommodityTypeInfo values('靴子',4,'','')
insert into CommodityTypeInfo values('女包',4,'','')
insert into CommodityTypeInfo values('帽子',4,'','')
insert into CommodityTypeInfo values('围巾',4,'','')

--食品饮料
insert into CommodityTypeInfo values('麦片',5,'','')
insert into CommodityTypeInfo values('咖啡',5,'','')
insert into CommodityTypeInfo values('牛奶',5,'','')
insert into CommodityTypeInfo values('三文鱼',5,'','')
insert into CommodityTypeInfo values('开心果',5,'','')
insert into CommodityTypeInfo values('夏威夷果',5,'','')


--新鲜水果
insert into CommodityTypeInfo values('百香果',6,'','')
insert into CommodityTypeInfo values('红心猕猴桃',6,'','')
insert into CommodityTypeInfo values('苹果',6,'','')
insert into CommodityTypeInfo values('天山雪莲果',6,'','')
insert into CommodityTypeInfo values('无花果',6,'','')

--户外运动
insert into CommodityTypeInfo values('钓竿',10,'','')
insert into CommodityTypeInfo values('鱼线',10,'','')
insert into CommodityTypeInfo values('登山包',10,'','')
insert into CommodityTypeInfo values('登山包',10,'','')
insert into CommodityTypeInfo values('帐篷',10,'','')
insert into CommodityTypeInfo values('睡袋',10,'','')
insert into CommodityTypeInfo values('望远镜',10,'','')


--手机数码
insert into CommodityTypeInfo values('电脑主机',7,'','')
insert into CommodityTypeInfo values('数码相机',7,'','')
insert into CommodityTypeInfo values('电玩动漫',7,'','')
select * from CommodityTypeInfo
go
/*
	名称：添加店铺测试数据
	日期：17-10-17
	备注：
*/
insert into StoreInfo values(1,11,'小黑家女装','xiaoheigirl.jpg','','2017-10-11','')
insert into StoreInfo values(2,10,'小白家男装','xiaobaiboy.jpg','','2017-10-11','')
insert into StoreInfo values(3,12,'天猫电器城','tianmaodianqi.jpg','','2017-10-11','')

--insert into StoreInfo values(4,2,'oppo官方旗舰店','oppoguanfang.jpg','','2017-10-11','')
--insert into StoreInfo values(5,3,'恒进科技电脑店','hengjinkeji.jpg','','2017-10-11','')
--insert into StoreInfo values(6,4,'三只松鼠旗舰店','sanzhisongshu.jpg','','2017-10-11','')
select * from StoreInfo
/*
	名称：添加商品测试数据
	日期：17-10-17
	备注：
*/
select * from CommodityTypeInfo


/*
服饰美妆
*/
insert into CommodityInfo values(11,1,'英爵伦 棒球领外套 2017秋装新款男士运动夹克春秋韩版潮流棒球服','2017-10-17',0,1000,0,'1','238','238','IMG/yifu/1.1.jpg',10)
insert into CommodityInfo values(12,1,'Oece2017冬装新款女装 英伦女生复古翻领双排扣短款呢大衣外套','2017-10-17',0,1000,0,'1','449','449','IMG/yifu/2.jpg',10)
insert into CommodityInfo values(13,1,'儿童宝宝加绒保暖内衣套装男童女童加厚秋衣秋裤中大童装冬季睡衣','2017-10-17',0,1000,0,'1','31','31','IMG/yifu/3.jpg',10)
insert into CommodityInfo values(14,1,'卓蓝雅无硅油防脱发生姜洗发水男女士正品育发老姜王控油去油姜汁','2017-10-17',0,1000,0,'1','65','65','IMG/yifu/4.jpg',10)
insert into CommodityInfo values(15,1,'百雀羚泡沫洗面奶女男士深度清洁补水保湿收缩毛孔控油温和洁面乳','2017-10-17',0,1000,0,'1','59','59','IMG/yifu/5.jpg',10)
insert into CommodityInfo values(16,1,'【双十一预售】Linefriends限量版礼盒-高露洁劲白牙膏120g8','2017-10-17',0,1000,0,'1','10','10','IMG/yifu/6.jpg',10)
insert into CommodityInfo values(11,1,'2017秋冬新款男士运动套装中老年大码休闲服套装卫衣长袖开衫男装','2017-10-17',0,1000,0,'1','250','250','IMG/yifu/1.2.jpg',10)
insert into CommodityInfo values(11,1,'2017秋冬季男士外套青少年韩版潮流休闲棉衣帅气男装棉服加厚棉袄','2017-10-17',0,1000,0,'1','158','158','IMG/yifu/1.3.jpg',10)
select *from CommodityInfo

/*
家用电器
*/
insert into CommodityInfo values(17,2,'Vatti华帝 ZKMB-28GB17家用蒸烤箱28升烤箱二合一蒸烤一体电烤炉','2017-10-17',0,1000,0,'1','2799','2799','IMG/dianqi/4.jpg',10)
insert into CommodityInfo values(18,2,'【免滤4.0】Joyoung九阳 DJ13E-Q3 家用全自动破壁无渣豆浆机','2017-10-17',0,1000,0,'1','699','699','IMG/dianqi/3.jpg',10)
insert into CommodityInfo values(19,2,'Panasonic松下 SR-AC071-K 电饭煲小型家用迷你智能2升2-3-4人','2017-10-17',0,1000,0,'1','1299','1299','IMG/dianqi/2.jpg',10)
insert into CommodityInfo values(20,2,'Dyson戴森Supersonic吹风机 HD01 紫红色 收纳架组合套装','2017-10-17',0,1000,0,'1','3440','3440','IMG/dianqi/1.2.jpg',10)
insert into CommodityInfo values(20,2,'飞科吹风机超大功率静音电吹冷热风家发廊用FH6232','2017-10-17',0,1000,0,'1','3440','3440','IMG/dianqi/1.1.jpg',10)
insert into CommodityInfo values(20,2,'日本TESCOM 电吹风机美发胶原蛋白家用水负离子恒温不伤发','2017-10-17',0,1000,0,'1','3440','3440','IMG/dianqi/1.3.jpg',10)
insert into CommodityInfo values(21,2,'金泰昌足浴盆全自动按摩洗脚盆加热电动泡脚盆深桶恒温家用足疗器','2017-10-17',0,1000,0,'1','500','500','IMG/dianqi/6.jpg',10)
insert into CommodityInfo values(22,2,'飞利浦电动剃须刀三头全身水洗男士胡须刀PT786干湿两用刮胡正品','2017-10-17',0,1000,0,'1','379','379','IMG/dianqi/5.jpg',10)

/*
厨具家具
*/
insert into CommodityInfo values(23,3,'高档 304不锈钢锅铲 炒菜铲子 厨具 一体成型工艺 空心防烫手柄','2017-10-17',0,1000,0,'0.5','100','50','IMG/cook/1.jpg',10)
insert into CommodityInfo values(24,3,'苏泊尔刀具套装 厨房全套刀具家用厨房刀具菜刀厨具套装组合','2017-10-17',0,1000,0,'1','230','230','IMG/cook/2.jpg',10)
insert into CommodityInfo values(25,3,'炊大皇电磁炉厨房锅具套装组合家用燃气灶适用炒锅厨炉具炒菜铁锅','2017-10-17',0,1000,0,'1','1000','999','IMG/cook/3.jpg',10)
insert into CommodityInfo values(26,3,'加厚不锈钢厨房置物架微波炉架子2层厨具调料收纳用品烤箱架落地','2017-10-17',0,1000,0,'1','100','100','IMG/cook/5.jpg',10)
insert into CommodityInfo values(27,3,'左右真皮沙发L形现代头层牛皮客厅大小户型皮艺沙发贵妃组合2821','2017-10-17',0,1000,0,'1','8599','8599','IMG/cook/4.jpg',10)
insert into CommodityInfo values(28,3,'整体衣柜 定制柜子卧室简约现代大家具衣柜推拉门移门趟门经济型','2017-10-17',0,1000,0,'1','3262','3262','IMG/cook/6.jpg',10)
insert into CommodityInfo values(27,3,'左右真皮沙发L形现代头层牛皮客厅大小户型皮艺沙发贵妃组合2821','2017-10-17',0,1000,0,'1','8599','8599','IMG/cook/4.jpg',10)
insert into CommodityInfo values(28,3,'整体衣柜 定制柜子卧室简约现代大家具衣柜推拉门移门趟门经济型','2017-10-17',0,1000,0,'1','3262','3262','IMG/cook/6.jpg',10)


/*
新鲜水果
*/
insert into CommodityInfo values(35,6,'广西百香果热带水果新鲜西番莲鸡蛋果现摘5斤精装大红果酸爽香甜','2017-10-17',0,1000,0,'1','37','37','IMG/fruit/1.jpg',10)
insert into CommodityInfo values(36,6,'【现货】蒲江红心猕猴桃新鲜水果24个约5斤 单果90-110g/个','2017-10-17',0,1000,0,'1','54','54','IMG/fruit/2.jpg',10)
insert into CommodityInfo values(37,6,'【甘福园】天水花牛苹果新鲜水果红蛇果10斤包邮甘肃礼县粉面苹果','2017-10-17',0,1000,0,'1','18','18','IMG/fruit/3.jpg',10)
insert into CommodityInfo values(38,6,'云南天山雪莲果红泥沙中圆果新鲜水果批发包邮','2017-10-17',0,1000,0,'1','37','37','IMG/fruit/4.jpg',10)
insert into CommodityInfo values(39,6,'新鲜无花果新鲜应季新鲜水果红紫皮现摘现发孕妇时令3斤空运包邮','2017-10-17',0,1000,0,'1','57','57','IMG/fruit/5.jpg',10)
insert into CommodityInfo values(37,6,'【甘福园】天水花牛苹果新鲜水果红蛇果10斤包邮甘肃礼县粉面苹果','2017-10-17',0,1000,0,'1','18','18','IMG/fruit/3.jpg',10)
insert into CommodityInfo values(38,6,'云南天山雪莲果红泥沙中圆果新鲜水果批发包邮','2017-10-17',0,1000,0,'1','37','37','IMG/fruit/4.jpg',10)
insert into CommodityInfo values(39,6,'新鲜无花果新鲜应季新鲜水果红紫皮现摘现发孕妇时令3斤空运包邮','2017-10-17',0,1000,0,'1','57','57','IMG/fruit/5.jpg',10)

go
select * from CommodityInfo


/*
名称：地址测试数据
日期：17-10-19
备注：
*/
insert MyAddressInfo values('张三',1,1,'18515486875','重庆','重庆市','沙坪坝','西永镇','足下软件学院',0,'')
insert MyAddressInfo values('张帅',1,1,'18515486875','重庆','重庆市','沙坪坝','西永镇','老街',1,'')
insert MyAddressInfo values('李斯',1,2,'18515486875','四川省','泸州市','合江县','合江镇','合江中学',0,'')
go
select * from MyAddressInfo




update BuyerInfo set BI_Balance = 1000

/*
	名称：添加商品购物车数据
	日期：17-10-17
	备注：
*/
insert into ShopCartInfo values(1,1,1,1,'100')
insert into ShopCartInfo values(1,2,1,1,'100')
insert into ShopCartInfo values(1,3,1,1,'100')
insert into ShopCartInfo values(1,4,1,1,'100')
insert into ShopCartInfo values(1,5,1,1,'100')
select * from ShopCartInfo

insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('圆通快递',10,'Express/yuantong.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('中通快递',10,'Express/zhongtong.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('申通快递',10,'Express/shentong.png',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('韵达快递',10,'Express/yunda.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('中国邮政',10,'Express/youzheng.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('天天快递',10,'Express/tiantian.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('顺丰快递',10,'Express/shunfeng.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('百世快递',10,'Express/baishi.jpg',null)


/*
名称：添加收藏测试数据
日期：17-10-25
备注：
*/
insert CollectGoodsInfo values(1,1,GETDATE())
insert CollectGoodsInfo values(2,1,GETDATE())
insert CollectGoodsInfo values(3,1,GETDATE())
go
select * from CollectGoodsInfo


/*
名称：添加订单测试数据
日期：17-10-24
备注：
*/
--insert into OrderFormInfo values(1,1,1,34,1,'2017-10-24',23,'',0)
--insert into OrderFormInfo values(1,1,1,34,2,'2017-10-24',23,'',0)
--insert into OrderFormInfo values(1,1,1,34,3,'2017-10-24',23,'',0)
--insert into OrderFormInfo values(1,1,1,34,4,'2017-10-24',23,'',0)
insert into OrderFormInfo values(1,1,1,238,1,'2017-9-24',2,'',1)
insert into OrderFormInfo values(1,1,2,449,2,'2017-10-24',1,'',2)
insert into OrderFormInfo values(1,1,3,31,3,'2017-10-24',3,'',3)
insert into OrderFormInfo values(1,1,4,65,0,'2017-10-24',2,'',3)
insert into OrderFormInfo values(1,1,5,65,2,'2017-10-24',1,'',5)
insert into OrderFormInfo values(1,1,6,65,3,'2017-9-24',3,'',6)
select * from OrderFormInfo


/*
名称：添加足迹测试数据
日期：17-10-25
备注：
*/
insert into FootprintInfo values(1,1,'2017-10-25')
insert into FootprintInfo values(1,2,'2017-10-25')
insert into FootprintInfo values(1,3,'2017-10-25')
insert into FootprintInfo values(1,4,'2017-10-25')
select * from FootprintInfo


insert OrderFormInfo values(1,2,1,'200',1,GETDATE(),1,null,2)
insert OrderFormInfo values(1,1,2,'200',2,GETDATE(),2,null,6)
select * from OrderFormInfo

select * from CommodityTypeInfo

select * from OrderFormInfo