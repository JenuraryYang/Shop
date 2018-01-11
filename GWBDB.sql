/*
	���ƣ����ﱦ���ݿ�
	�������ڣ�2017-10-17
	�Ŷӣ�
	��ע��
*/
if exists(select 1 from sys.sysdatabases where name='shopDB')
drop database shopDB
GO
create database shopDB
go
use shopDB
go
/*
	���ƣ�����Ա�͵����ʺż��ͷ��ʺ�
	�������ڣ�2017-10-16
	��ע��
*/
if exists(select 1 from sys.objects where name='AdministratorInfo')
drop table AdministratorInfo
go
create table AdministratorInfo(
	AI_ID int identity(1,1) primary key,		--���
	AI_HImage varchar(30),		--ͷ��·��
	AI_Num varchar(20)  ,		--�ֻ���
	AI_LoginPwd varchar(20),		--��¼����
	AI_Name varchar(20),		--����
	AI_Sex varchar(2),			--�Ա�
	AI_IDCard  varchar(20),		--���֤��
	AI_Alipay varchar(20),		--֧�����˻�
	AI_Balance varchar(20),		--�˻����
	AI_Type int,			--�ʺ���������(0:����Ա,1������,2��վ�ڿͷ�)
	AI_Date datetime		--ע������
)
go


/*
	���ƣ���ͨ��Ա�ʺ�
	�������ڣ�2017-10-16
	��ע��
*/
if exists(select 1 from sys.objects where name='BuyerInfo')
drop table BuyerInfo
go
create table BuyerInfo(
	BI_ID int   identity(1,1) primary key,		--���
	BI_HImage varchar(30),		--ͷ��·��
	BI_Phone varchar(20),		--�ֻ���
	BI_NickName nvarchar(20)  ,		--�ǳ�
	BI_LoginPwd nvarchar(20),		--��¼����
	BI_Name nvarchar(20),				--����
	BI_IDCared varchar(20),		--���֤��
	BI_Sex int default 2,		--�Ա�(0:Ů  1:��  2:δ֪)
	BI_PayPwd nvarchar(20),		--֧������
	BI_Balance Varchar(10),			--�˻����
	BI_Date datetime,			--ע������
	BI_SumScore int--�û�����
)
go

/*
	���ƣ���Ʒ����
	�������ڣ�2017-10-16
	��ע��
*/
if exists(select 1 from sys.objects where name='CommodityTypeInfo')
drop table CommodityTypeInfo
go
create table CommodityTypeInfo(
	CTI_ID int identity(1,1) primary key,	--��Ʒ���͵�Ψһ��ʶ������������
	CTI_Name varchar(20),--��Ʒ�������ƣ�����������Ʒ���࣬��������
	CTI_CTI_ID int,--������Ʒ���ͱ��
	CTI_SaveUrl nvarchar(20) default '' ,  --��ƷͼƬ�����ļ���
	CTI_Remark varchar(20)--��Ʒ��ע
	
)
go

/*
	���ƣ���������
	�������ڣ�2017-10-16
	��ע��
*/
if exists(select 1 from sys.objects where name='StoreTypeInfo')
drop table StoreTypeInfo
go
create table StoreTypeInfo
(
    STI_ID int primary key identity , --�������ͱ��
    STI_Name nvarchar(20),   --�������ͱ��
    STI_Remark nvarchar(50)   --��ע
)
go
select * from StoreTypeInfo
/*
	���ƣ�����
	�������ڣ�2017-10-16
	��ע��
*/
if exists(select 1 from sys.objects where name='StoreInfo')
drop table StoreInfo
go
create table StoreInfo
(
    SI_ID int primary key identity ,-- ���̱��
    SI_AI_ID int , --�������
    SI_STI_ID int,  --�������ͱ��
    SI_Name nvarchar(20),  --��������
    SI_Logo  nvarchar(30),  --����logo
    SI_Intro nvarchar(100),  --���̼��
    SI_CreateDate datetime,  --���״�������
    SI_Remark nvarchar(20)   --��ע
)
go
select * from StoreInfo
/*
	���ƣ���Ʒ
	�������ڣ�2017-10-16
	��ע��1�����ƣ����CI_Sendgoods�ֶΣ�ʱ�䣺17-10-23
*/
if exists(select 1 from sys.objects where name='CommodityInfo')
drop table CommodityInfo
go
create table CommodityInfo
(
   CI_ID  int  primary key identity,  --��Ʒ���
   CI_CTI_ID int,	--��Ʒ����
   CI_SI_ID  int,  --���̱��
   CI_Name  nvarchar(50),  --��Ʒ����
   CI_CreateDate  datetime ,  --��Ʒ��������
   CI_Is int ,   --��Ʒ�Ƿ��ϼܣ�0:�ϼܣ�1:δ�ϼ�
   CI_Num  int  ,  --��Ʒ����� Ĭ��0
   CI_SalesNum  int ,   --��Ʒ���� Ĭ��0
   CI_Discount	Varchar (5)	,--��Ʒ�ۿ�
   CI_Price	Varchar	(10),  --��Ʒԭ��
   CI_NowPrice	Varchar	(10)	,--��Ʒ���ڵ����ۼ۸�
   CI_Url	Varchar	(30),		--������ƷͼƬ�����ֲ������ļ�·��
   CI_Sendgoods int	--�ʷ�

)
go
/*
	���ƣ��˵���ReckoningInfo��
	�������ڣ�2017-10-16
	��ע��
*/
if exists(select 1 from sys.objects where name='ReckoningInfo')
drop table ReckoningInfo
go

create table ReckoningInfo
(
  	RI_ID	Int  primary key identity , --�˵����
	RI_BI_ID	Int ,  --��ͨ��Ա���
	RI_CI_ID	Int ,  --��Ʒ���
	RI_CPI_ID	int ,  --ʹ�õ��Ż�ȯ�ı��
	RI_Amount	Varchar(20) ,  --���׽��
	RI_States	Int ,  --״̬0:ʧ��1���ɹ�
	RI_TransactionDate	Datetime ,  --��������
	RI_Remark	Varchar(50) --��ע
)
go

/*
	���ƣ���Ż�ȯ��CouponInfo��
	�������ڣ�2017-10-16
	�޸�:1.�޸�����:17-10-18
			ע:�����CPI_CI_ID��CPI_IS
	��ע��
*/
if exists(select 1 from sys.objects where name='CouponInfo')
drop table  CouponInfo
go
create table CouponInfo
(
   	CPI_ID	Int identity primary key ,  --�Ż�ȯ���
	CPI_Type	Varchar(5) ,  --��������
	CPI_MaxMoney	Varchar(10) ,  --�����ٿ���
	CPI_MinusMoney	Varchar(10)  ,  --�ֿ۶���
	CPI_CouponType	int,   --�Ż�ȯ����  �󶨵��̱�ţ�δ����Ĭ��Ϊȫվʹ��
	CPI_CI_ID int,--�Ż�ȯʹ����Ʒ��ţ��������󶨵��̱�ţ��������ʹ�øõ���
	CPI_BeginDate datetime,--��ʼ����
	CPI_EndDate datetime,--��������
	CPI_IS int,--0:������1������

)
go
/*
	���ƣ����ActivityInfo��
	�������ڣ�2017-10-16
	�޸�:1.�޸�����:17-10-18
			ע:���AI_IS
	��ע��
*/
if exists(select 1 from sys.objects where name='ActivityInfo')
drop table ActivityInfo
go
create table ActivityInfo
(
  	AI_ID	Int identity primary key,  --����
	AI_CI_ID  int  ,  --��������Ʒ���
	AI_Price	Varchar(5) ,  --���
	AI_Starttime	Datetime ,  --���ʼʱ��
	AI_Endtime	Datetime , --�����ʱ��
	AI_IS int--0:������1������

)
go

/*
	���ƣ���ַ
	�������ڣ�17-10-17
	��ע��1�����ƣ����MAI_IS��ʱ�䣺17-10-19
		2�����ƣ����MAI_Name�ֶΣ�ʱ�䣺17-10-22
*/
if exists(select 1 from sys.objects where name='MyAddressInfo')
drop table MyAddressInfo
go
create table MyAddressInfo
(
MAI_ID	Int	identity(1,1) primary key,				--�ջ���ַ��Ψһ��ʶ������������
MAI_Name nvarchar(20),--�ջ�������
MAI_Type	Int,				--0��������ַ1���ջ���ַ
MAI_BI_ID	Int, 			--ʶ���û���Ψһ��ʶ
MAI_Phone	Varchar(20),		--���������ϵ�绰
MAI_Province	Nvarchar(20),--����ʡ
MAI_City	Nvarchar(20),	--������
MAI_County	Nvarchar(20),	--������
MAI_Town	Nvarchar(20),	--������
MAI_MinuteAddress	nvarchar(50),--������ϸ��ַ���ֵ���������
MAI_IS int,--�Ƿ���Ĭ�ϵ�ַ��0��Ĭ�ϣ�����ֵΪ��Ĭ��
MAI_Remark	Nvarchar(30)	--�ջ���ַ��ע
)
go

/*
	���ƣ�������OrderFormInfo��
	�������ڣ�2017-10-16
	��ע��1�����OFI_Sendgoods�ֶΣ�ʱ�䣺17-10-23
			2�����OFI_DHL�ֶΣ�ʱ�䣺17-10-25
*/
if exists(select 1 from sys.objects where name='OrderFormInfo')
drop table OrderFormInfo
go
create table OrderFormInfo
(
  	OFI_ID	int primary key identity , --�������
	OFI_CI_ID	Int , --��Ʒ���
	OFI_Number	Int , --��Ʒ����
	OFI_BI_ID	Int , --��ұ��
	OFI_Money	Varchar(15) , --�������
	OFI_States	Int , --����״̬ 0:��������1�������2�����ջ���3��������
	OFI_CreateDate	Datetime , --��������
	OFI_SAI_ID int,--�ջ���ַ���
	OFI_Address	Varchar(50),  --�ջ���ַ
	--OFI_Sendgoods int,	--�ʷ�
	--OFI_DHL nvarchar(15) -- ��ݹ�˾
	Express_ID INT  -- ��ݹ�˾
)
go
/*
	���ƣ���ݣ�Express��
	�������ڣ�2017-10-16
	
*/
if exists(select 1 from sys.objects where name='Express')
drop table Express
go
create table Express
(
   Express_ID int primary key identity,  --��ݹ�˾���
   
   Express_Name nvarchar(50) ,-- ����
   
   Express_Expense int ,-- �շѱ�׼
   
   Express_Image nvarchar(64), --��ݹ�˾ͼƬ
   
   Express_Desc nvarchar(256) --��ݹ�˾���
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
	���ƣ��ղأ�CollectGoodsInfo��
	�������ڣ�2017-10-16
	��ע��
*/
if exists(select 1 from sys.objects where name='CollectGoodsInfo')
drop table CollectGoodsInfo
go
create table CollectGoodsInfo
(
	CGI_ID int identity(1,1) primary key,--�ղر��
	CGI_CI_ID int,--��Ʒ���
	CGI_BI_ID int,--��ұ��
	CGI_Time Datetime,--�ղ�ʱ��
)
go

/*
	����:�㼣(FootprintInfo)
	��������:17-10-18
	��ע:
*/
if exists(select 1 from sys.sysobjects where name='FootprintInfo')
	drop table FootprintInfo
go
create table FootprintInfo
(
	FI_ID	Int	identity primary key,	--�㼣��Ψһ��ʶ������������
	FI_BI_ID	Int,				--ָ���û�
	FI_CI_ID	int	,			--��Ʒ��Ψһ��ʶ��ָ����Ʒ
	FI_Date	Datetime			--��Ʒ�������
)
go


/*
	����:���ﳵ(ShopCartInfo)
	��������:17-10-21
	��ע:�����һ���ֶΣ�SCI_Money���޸�����2017-10-24
*/
if exists(select 1 from sys.sysobjects where name='ShopCartInfo')
	drop table ShopCartInfo
go
create table ShopCartInfo
(
	SCI_ID	Int	identity(1,1) primary key,	--���ﳵ��Ψһ��ʶ������������
	SCI_BI_ID	Int,				--ָ���û�
	SCI_CI_ID   int,				--��Ʒ���
	SCI_Number	int	,			--��Ʒ����
	SCI_Caozuo	int,			--����
	SCI_Money   varchar(5)				--���ﳵѡ�н��
)
go
select * from ShopCartInfo






--select name from shopDB..sysobjects where xtype='u' 
--select * from sys.tables

/*===================================��������=========================================*/

/*
���ƣ�����Ա�͵����ʺż��ͷ��ʺ�
�������ڣ�2017-10-16
��ע��
*/
insert into AdministratorInfo values('','13271941321','123456','��С��',0,'503021199801358142','13271941321','100',0,'2017-10-17')
insert into AdministratorInfo values('','13271941322','123456','�ŷ�',0,'503021199801358142','13271941321','100',1,'2017-10-17')
insert into AdministratorInfo values('','13271941323','123456','��С��',0,'503021199801358142','13271941321','100',2,'2017-10-17')
select * from AdministratorInfo

/*
	���ƣ���ͨ��Ա��Ӳ�������
	�������ڣ�2017-10-17
	��ע��
*/
insert into BuyerInfo values('','13271941330','С��','123456','����','510562199412025234',0,'121212','1000','2017-10-11',0)
insert into BuyerInfo values('','13271941331','��ľ��','123456','����','510256199611112534',0,'121212','1000','2017-10-11',0)
insert into BuyerInfo values('','13271941332','����','123456','����','522154199806061425',0,'121212','1000','2017-10-11',0)
select * from BuyerInfo
go
/*
	���ƣ���ӵ������Ͳ�������
	���ڣ�17-10-17
	��ע��
*/
insert into StoreTypeInfo values('�콢��','')
insert into StoreTypeInfo values('ר����','')
insert into StoreTypeInfo values('רӪ��','')
select * from StoreTypeInfo
go
/*
	���ƣ������Ʒ���Ͳ�������
	���ڣ�17-10-17
	��ע��
*/
insert into CommodityTypeInfo values('������ױ',null,'yifu','')		--1
insert into CommodityTypeInfo values('���õ���',null,'dianqi','')		--2
insert into CommodityTypeInfo values('���߼Ҿ�',null,'cook','')		--3
insert into CommodityTypeInfo values('Ь������',null,'xiebao','')		--4
insert into CommodityTypeInfo values('ʳƷ����',null,'food','')		--5
insert into CommodityTypeInfo values('����ˮ��',null,'fruit','')		--6
insert into CommodityTypeInfo values('�ֻ�����',null,'shuma','')		--7
insert into CommodityTypeInfo values('����',null,'diannao','')		--8
insert into CommodityTypeInfo values('����',null,'yuqi','')		--9
insert into CommodityTypeInfo values('�����˶�',null,'sport','')		--10



--������ױ
insert into CommodityTypeInfo values('��װ',1,'','')
insert into CommodityTypeInfo values('ͯװ',1,'','')
insert into CommodityTypeInfo values('Ůװ',1,'','')
insert into CommodityTypeInfo values('ϴ����',1,'','')
insert into CommodityTypeInfo values('ϴ��ˮ',1,'','')
insert into CommodityTypeInfo values('����',1,'','')

--���õ���
insert into CommodityTypeInfo values('����',2,'','')
insert into CommodityTypeInfo values('������',2,'','')
insert into CommodityTypeInfo values('�緹��',2,'','')
insert into CommodityTypeInfo values('�����',2,'','')
insert into CommodityTypeInfo values('��ԡ��',2,'','')
insert into CommodityTypeInfo values('���뵶',2,'','')


--���߼Ҿ�
insert into CommodityTypeInfo values('����',3,'','')
insert into CommodityTypeInfo values('����',3,'','')
insert into CommodityTypeInfo values('������װ',3,'','')
insert into CommodityTypeInfo values('΢��¯',3,'','')
insert into CommodityTypeInfo values('ɳ��',3,'','')
insert into CommodityTypeInfo values('�¹�',3,'','')



--Ь������
insert into CommodityTypeInfo values('ŮЬ',4,'','')
insert into CommodityTypeInfo values('��Ь',4,'','')
insert into CommodityTypeInfo values('ѥ��',4,'','')
insert into CommodityTypeInfo values('Ů��',4,'','')
insert into CommodityTypeInfo values('ñ��',4,'','')
insert into CommodityTypeInfo values('Χ��',4,'','')

--ʳƷ����
insert into CommodityTypeInfo values('��Ƭ',5,'','')
insert into CommodityTypeInfo values('����',5,'','')
insert into CommodityTypeInfo values('ţ��',5,'','')
insert into CommodityTypeInfo values('������',5,'','')
insert into CommodityTypeInfo values('���Ĺ�',5,'','')
insert into CommodityTypeInfo values('�����Ĺ�',5,'','')


--����ˮ��
insert into CommodityTypeInfo values('�����',6,'','')
insert into CommodityTypeInfo values('����⨺���',6,'','')
insert into CommodityTypeInfo values('ƻ��',6,'','')
insert into CommodityTypeInfo values('��ɽѩ����',6,'','')
insert into CommodityTypeInfo values('�޻���',6,'','')

--�����˶�
insert into CommodityTypeInfo values('����',10,'','')
insert into CommodityTypeInfo values('����',10,'','')
insert into CommodityTypeInfo values('��ɽ��',10,'','')
insert into CommodityTypeInfo values('��ɽ��',10,'','')
insert into CommodityTypeInfo values('����',10,'','')
insert into CommodityTypeInfo values('˯��',10,'','')
insert into CommodityTypeInfo values('��Զ��',10,'','')


--�ֻ�����
insert into CommodityTypeInfo values('��������',7,'','')
insert into CommodityTypeInfo values('�������',7,'','')
insert into CommodityTypeInfo values('���涯��',7,'','')
select * from CommodityTypeInfo
go
/*
	���ƣ���ӵ��̲�������
	���ڣ�17-10-17
	��ע��
*/
insert into StoreInfo values(1,11,'С�ڼ�Ůװ','xiaoheigirl.jpg','','2017-10-11','')
insert into StoreInfo values(2,10,'С�׼���װ','xiaobaiboy.jpg','','2017-10-11','')
insert into StoreInfo values(3,12,'��è������','tianmaodianqi.jpg','','2017-10-11','')

--insert into StoreInfo values(4,2,'oppo�ٷ��콢��','oppoguanfang.jpg','','2017-10-11','')
--insert into StoreInfo values(5,3,'����Ƽ����Ե�','hengjinkeji.jpg','','2017-10-11','')
--insert into StoreInfo values(6,4,'��ֻ�����콢��','sanzhisongshu.jpg','','2017-10-11','')
select * from StoreInfo
/*
	���ƣ������Ʒ��������
	���ڣ�17-10-17
	��ע��
*/
select * from CommodityTypeInfo


/*
������ױ
*/
insert into CommodityInfo values(11,1,'Ӣ���� ���������� 2017��װ�¿���ʿ�˶��п˴��ﺫ�泱�������','2017-10-17',0,1000,0,'1','238','238','IMG/yifu/1.1.jpg',10)
insert into CommodityInfo values(12,1,'Oece2017��װ�¿�Ůװ Ӣ��Ů�����ŷ���˫�ſ۶̿��ش�������','2017-10-17',0,1000,0,'1','449','449','IMG/yifu/2.jpg',10)
insert into CommodityInfo values(13,1,'��ͯ�������ޱ�ů������װ��ͯŮͯ�Ӻ���������д�ͯװ����˯��','2017-10-17',0,1000,0,'1','31','31','IMG/yifu/3.jpg',10)
insert into CommodityInfo values(14,1,'׿�����޹��ͷ��ѷ�����ϴ��ˮ��Ůʿ��Ʒ�����Ͻ�������ȥ�ͽ�֭','2017-10-17',0,1000,0,'1','65','65','IMG/yifu/4.jpg',10)
insert into CommodityInfo values(15,1,'��ȸ����ĭϴ����Ů��ʿ�����ಹˮ��ʪ����ë�׿����ºͽ�����','2017-10-17',0,1000,0,'1','59','59','IMG/yifu/5.jpg',10)
insert into CommodityInfo values(16,1,'��˫ʮһԤ�ۡ�Linefriends���������-��¶�ྡྷ������120g8','2017-10-17',0,1000,0,'1','10','10','IMG/yifu/6.jpg',10)
insert into CommodityInfo values(11,1,'2017�ﶬ�¿���ʿ�˶���װ������������з���װ���³��俪����װ','2017-10-17',0,1000,0,'1','250','250','IMG/yifu/1.2.jpg',10)
insert into CommodityInfo values(11,1,'2017�ﶬ����ʿ���������꺫�泱����������˧����װ�޷��Ӻ��ް�','2017-10-17',0,1000,0,'1','158','158','IMG/yifu/1.3.jpg',10)
select *from CommodityInfo

/*
���õ���
*/
insert into CommodityInfo values(17,2,'Vatti���� ZKMB-28GB17����������28���������һ����һ��翾¯','2017-10-17',0,1000,0,'1','2799','2799','IMG/dianqi/4.jpg',10)
insert into CommodityInfo values(18,2,'������4.0��Joyoung���� DJ13E-Q3 ����ȫ�Զ��Ʊ�����������','2017-10-17',0,1000,0,'1','699','699','IMG/dianqi/3.jpg',10)
insert into CommodityInfo values(19,2,'Panasonic���� SR-AC071-K �緹��С�ͼ�����������2��2-3-4��','2017-10-17',0,1000,0,'1','1299','1299','IMG/dianqi/2.jpg',10)
insert into CommodityInfo values(20,2,'Dyson��ɭSupersonic����� HD01 �Ϻ�ɫ ���ɼ������װ','2017-10-17',0,1000,0,'1','3440','3440','IMG/dianqi/1.2.jpg',10)
insert into CommodityInfo values(20,2,'�ɿƴ���������ʾ����紵���ȷ�ҷ�����FH6232','2017-10-17',0,1000,0,'1','3440','3440','IMG/dianqi/1.1.jpg',10)
insert into CommodityInfo values(20,2,'�ձ�TESCOM �紵���������ԭ���׼���ˮ�����Ӻ��²��˷�','2017-10-17',0,1000,0,'1','3440','3440','IMG/dianqi/1.3.jpg',10)
insert into CommodityInfo values(21,2,'��̩����ԡ��ȫ�Զ���Ħϴ������ȵ綯�ݽ�����Ͱ���¼���������','2017-10-17',0,1000,0,'1','500','500','IMG/dianqi/6.jpg',10)
insert into CommodityInfo values(22,2,'�����ֵ綯���뵶��ͷȫ��ˮϴ��ʿ���뵶PT786��ʪ���ùκ���Ʒ','2017-10-17',0,1000,0,'1','379','379','IMG/dianqi/5.jpg',10)

/*
���߼Ҿ�
*/
insert into CommodityInfo values(23,3,'�ߵ� 304����ֹ��� ���˲��� ���� һ����͹��� ���ķ����ֱ�','2017-10-17',0,1000,0,'0.5','100','50','IMG/cook/1.jpg',10)
insert into CommodityInfo values(24,3,'�ղ���������װ ����ȫ�׵��߼��ó������߲˵�������װ���','2017-10-17',0,1000,0,'1','230','230','IMG/cook/2.jpg',10)
insert into CommodityInfo values(25,3,'����ʵ��¯����������װ��ϼ���ȼ�������ó�����¯�߳�������','2017-10-17',0,1000,0,'1','1000','999','IMG/cook/3.jpg',10)
insert into CommodityInfo values(26,3,'�Ӻ���ֳ��������΢��¯����2����ߵ���������Ʒ��������','2017-10-17',0,1000,0,'1','100','100','IMG/cook/5.jpg',10)
insert into CommodityInfo values(27,3,'������Ƥɳ��L���ִ�ͷ��ţƤ������С����Ƥ��ɳ���������2821','2017-10-17',0,1000,0,'1','8599','8599','IMG/cook/4.jpg',10)
insert into CommodityInfo values(28,3,'�����¹� ���ƹ������Ҽ�Լ�ִ���Ҿ��¹��������������ž�����','2017-10-17',0,1000,0,'1','3262','3262','IMG/cook/6.jpg',10)
insert into CommodityInfo values(27,3,'������Ƥɳ��L���ִ�ͷ��ţƤ������С����Ƥ��ɳ���������2821','2017-10-17',0,1000,0,'1','8599','8599','IMG/cook/4.jpg',10)
insert into CommodityInfo values(28,3,'�����¹� ���ƹ������Ҽ�Լ�ִ���Ҿ��¹��������������ž�����','2017-10-17',0,1000,0,'1','3262','3262','IMG/cook/6.jpg',10)


/*
����ˮ��
*/
insert into CommodityInfo values(35,6,'����������ȴ�ˮ��������������������ժ5�ﾫװ������ˬ����','2017-10-17',0,1000,0,'1','37','37','IMG/fruit/1.jpg',10)
insert into CommodityInfo values(36,6,'���ֻ����ѽ�����⨺�������ˮ��24��Լ5�� ����90-110g/��','2017-10-17',0,1000,0,'1','54','54','IMG/fruit/2.jpg',10)
insert into CommodityInfo values(37,6,'���ʸ�԰����ˮ��ţƻ������ˮ�����߹�10����ʸ������ط���ƻ��','2017-10-17',0,1000,0,'1','18','18','IMG/fruit/3.jpg',10)
insert into CommodityInfo values(38,6,'������ɽѩ��������ɳ��Բ������ˮ����������','2017-10-17',0,1000,0,'1','37','37','IMG/fruit/4.jpg',10)
insert into CommodityInfo values(39,6,'�����޻�������Ӧ������ˮ������Ƥ��ժ�ַ��и�ʱ��3����˰���','2017-10-17',0,1000,0,'1','57','57','IMG/fruit/5.jpg',10)
insert into CommodityInfo values(37,6,'���ʸ�԰����ˮ��ţƻ������ˮ�����߹�10����ʸ������ط���ƻ��','2017-10-17',0,1000,0,'1','18','18','IMG/fruit/3.jpg',10)
insert into CommodityInfo values(38,6,'������ɽѩ��������ɳ��Բ������ˮ����������','2017-10-17',0,1000,0,'1','37','37','IMG/fruit/4.jpg',10)
insert into CommodityInfo values(39,6,'�����޻�������Ӧ������ˮ������Ƥ��ժ�ַ��и�ʱ��3����˰���','2017-10-17',0,1000,0,'1','57','57','IMG/fruit/5.jpg',10)

go
select * from CommodityInfo


/*
���ƣ���ַ��������
���ڣ�17-10-19
��ע��
*/
insert MyAddressInfo values('����',1,1,'18515486875','����','������','ɳƺ��','������','�������ѧԺ',0,'')
insert MyAddressInfo values('��˧',1,1,'18515486875','����','������','ɳƺ��','������','�Ͻ�',1,'')
insert MyAddressInfo values('��˹',1,2,'18515486875','�Ĵ�ʡ','������','�Ͻ���','�Ͻ���','�Ͻ���ѧ',0,'')
go
select * from MyAddressInfo




update BuyerInfo set BI_Balance = 1000

/*
	���ƣ������Ʒ���ﳵ����
	���ڣ�17-10-17
	��ע��
*/
insert into ShopCartInfo values(1,1,1,1,'100')
insert into ShopCartInfo values(1,2,1,1,'100')
insert into ShopCartInfo values(1,3,1,1,'100')
insert into ShopCartInfo values(1,4,1,1,'100')
insert into ShopCartInfo values(1,5,1,1,'100')
select * from ShopCartInfo

insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('Բͨ���',10,'Express/yuantong.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('��ͨ���',10,'Express/zhongtong.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('��ͨ���',10,'Express/shentong.png',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('�ϴ���',10,'Express/yunda.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('�й�����',10,'Express/youzheng.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('������',10,'Express/tiantian.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('˳����',10,'Express/shunfeng.jpg',null)
insert into Express(Express_Name,Express_Expense,Express_Image,Express_Desc) values('�������',10,'Express/baishi.jpg',null)


/*
���ƣ�����ղز�������
���ڣ�17-10-25
��ע��
*/
insert CollectGoodsInfo values(1,1,GETDATE())
insert CollectGoodsInfo values(2,1,GETDATE())
insert CollectGoodsInfo values(3,1,GETDATE())
go
select * from CollectGoodsInfo


/*
���ƣ���Ӷ�����������
���ڣ�17-10-24
��ע��
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
���ƣ�����㼣��������
���ڣ�17-10-25
��ע��
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