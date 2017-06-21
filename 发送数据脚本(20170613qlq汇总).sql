
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,houp>
-- Create date: <Create Date,2017-6-13,>
-- Description:	<发送数据到原始数据库>
-- =============================================
--------------------------------------------------------------------------------------------
--------------------------索力原始数据发报机脚本--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_CableForceTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_CableForceTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_CableForceTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@pointsNumberId int,
	@temperature int,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --获取小时部分
	@timeMinute int=datepart(mi,GETDATE()), --获取分钟部分	
	@abnormalData int =0, -----异常数据临时变量
	@warningData int,     -----预警数据临时变量
	@normalData int,     -----正常数据临时变量
	@max int,            ----定义随机变量的上限         
	@min int             -----定义随机变量的下限
	----获得索力------------------------------------获得索力
	----获得索力------------------------------------获得索力
	declare
	@pNId1 int=121,---吊杆开始
	@pNId2 int=138,---上层吊杆
	@pNId3 int=146,---下层吊杆
	@pNId4 int=158,---柔性系杆
	@cableforce float,
	@frequency float
	----循环获得上层吊杆的索力------------------------------------循环获得上层吊杆的索力
	----循环获得上层吊杆的索力------------------------------------循环获得上层吊杆的索力
	set @pointsNumberId=@pNId1
	while @pointsNumberId<=@pNId2
    begin
	    ----获得异常数据在7000,10000之间。
		 set @min=7000
		 set @max=10000
		 set @abnormaldata=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得上层吊杆报警数据在1500,到2200之间
		 set @min=1500
		 set @max=2200
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得上层吊杆正常数据
		 set @min=1200
		 set @max=1500
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		-----获得索力值
		select @cableforce=
				case 
					when (@pointsNumberId=128 or @pointsNumberId=131) and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----产生异常数据
					when (@pointsNumberId=121 or @pointsNumberId=135)and @timeHour=7 and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
		select @frequency =CONVERT(float, cast((@cableforce+2.568)/3.56 as decimal(18,2))) ------获得索力频率
	insert into Original_CableForceTable(CableForce,Frequency,Temperature,Time,PointsNumberId)values(@cableforce,@frequency,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end

	----循环获得下层吊杆的索力------------------------------------循环获得下层吊杆的索力
	----循环获得下层吊杆的索力------------------------------------循环获得下层吊杆的索力
	set @pointsNumberId=@pNId2+1
	while @pointsNumberId<=@pNId3
    begin
		
		----获得下层吊杆报警数据在2000,到3500之间
    	 set @min=2000
		 set @max=3500
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得下层吊杆正常数据
		 set @min=1500
		 set @max=2200
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得索力值
		select @cableforce=
				case 
					when (@pointsNumberId=140 or @pointsNumberId=142) and (@timeHour=7 or @timeHour=17) and @timeMinute=35 
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
		select @frequency =CONVERT(float, cast((@cableforce+2.568)/3.56 as decimal(18,2))) ------获得索力频率
	insert into Original_CableForceTable(CableForce,Frequency,Temperature,Time,PointsNumberId)values(@cableforce,@frequency,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	----循环获得柔性系杆的索力------------------------------------循环获得柔性系杆的索力
	----循环获得柔性系杆的索力------------------------------------循环获得柔性系杆的索力
	set @pointsNumberId=@pNId3+1
	while @pointsNumberId<=@pNId4
    begin	
		----获得报警数据在1400,到2200之间
    	 set @min=1400
		 set @max=2200
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得下层吊杆正常数据
		 set @min=1200
		 set @max=1600
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得索力值
		select @cableforce=
				case 
					when (@pointsNumberId=150 or @pointsNumberId=152) and (@timeHour=7 or @timeHour=17) and @timeMinute=40 
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
		select @frequency =CONVERT(float, cast((@cableforce+2.568)/3.56 as decimal(18,2))) ------获得索力频率
	insert into Original_CableForceTable(CableForce,Frequency,Temperature,Time,PointsNumberId)values(@cableforce,@frequency,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	END
GO

--------------------------------------------------------------------------------------------
--------------------------混凝土原始数据发报机脚本--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_ConcreteStrainTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_ConcreteStrainTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_ConcreteStrainTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@strain float,
	@pointsNumberId int,
	@temperature int,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --获取小时部分
	@timeMinute int=datepart(mi,GETDATE()), --获取分钟部分	
	@abnormalData int =0, -----异常数据临时变量
	@warningData int,     -----预警数据临时变量
	@normalData int,     -----正常数据临时变量
	@max int,            ----定义随机变量的上限         
	@min int,             -----定义随机变量的下限
	@concreteStrainPNId1 int=79,---混凝土应变开始测点编号
	@concreteStrainPNId2 int=94---混凝土结束应变测点编号
	set @pointsNumberId=@concreteStrainPNId1
	while @pointsNumberId<=@concreteStrainPNId2
    begin
		----获得异常数据在-2000,-1000之间。	
		 set @min=-2000
		 set @max=-1000
		 set @abnormaldata=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))	
				----获得报警数据在-230,到-50之间
    	 set @min=-230
		 set @max=-50
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-175
		 set @max=-90
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when (@pointsNumberId=79 or @pointsNumberId=91) and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----产生异常数据
					when (@pointsNumberId=84 or @pointsNumberId=90)and @timeHour=7 and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_ConcreteStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	END
GO


--------------------------------------------------------------------------------------------
--------------------------钢拱肋原始数据发报机脚本--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_SteelArchStrainTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_SteelArchStrainTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_SteelArchStrainTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@strain float,
	@pointsNumberId int,
	@temperature int,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --获取小时部分
	@timeMinute int=datepart(mi,GETDATE()), --获取分钟部分	
	@abnormalData int =0, -----异常数据临时变量
	@warningData int,     -----预警数据临时变量
	@normalData int,     -----正常数据临时变量
	@max int,            ----定义随机变量的上限         
	@min int,             -----定义随机变量的下限
	@SteelArchStrainPNId1 int=1,---混凝土应变开始测点编号
	@SteelArchStrainPNId2 int=8,---混凝土结束应变测点编号
	@SteelArchStrainPNId3 int=16,---混凝土结束应变测点编号
	@SteelArchStrainPNId4 int=24,---混凝土结束应变测点编号
	@SteelArchStrainPNId5 int=32,---混凝土结束应变测点编号
	@SteelArchStrainPNId6 int=40,---混凝土结束应变测点编号
	@SteelArchStrainPNId7 int=48---混凝土结束应变测点编号
	--------------获得A截面应变--------------------------获得A截面应变---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId1
	while @pointsNumberId<=@SteelArchStrainPNId2
    begin
		----获得异常数据在2000,1000之间。	
		 set @min=2000
		 set @max=1000
		 set @abnormaldata=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))	
		----获得报警数据在-600,到-350之间
    	 set @min=-600
		 set @max=-350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-450
		 set @max=-260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @pointsNumberId=5 and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----产生异常数据
					when @pointsNumberId=7 and @timeHour=7 and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------获得B截面应变--------------------------获得B截面应变---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId2+1
	while @pointsNumberId<=@SteelArchStrainPNId3
    begin
			----获得报警数据在-810,到-480之间
    	 set @min=-810
		 set @max=-480
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-580
		 set @max=-260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @pointsNumberId=15 and @timeHour=7 and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
		--------------获得C截面应变--------------------------获得C截面应变---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId3+1
	while @pointsNumberId<=@SteelArchStrainPNId4
    begin
		----获得报警数据在-600,到-350之间
    	 set @min=-600
		 set @max=-350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-450
		 set @max=-260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @pointsNumberId=20 and @timeHour=8 and @timeMinute=20
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
		--------------获得D截面应变--------------------------获得D截面应变---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId4+1
	while @pointsNumberId<=@SteelArchStrainPNId5
    begin
			----获得报警数据在-810,到-480之间
    	 set @min=-810
		 set @max=-480
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-580
		 set @max=-260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @pointsNumberId=28 and @timeHour=9 and @timeMinute=23
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------获得E截面应变--------------------------获得E截面应变---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId5+1
	while @pointsNumberId<=@SteelArchStrainPNId6
    begin
		----获得报警数据在-600,到-350之间
    	 set @min=-600
		 set @max=-350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-450
		 set @max=-260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @pointsNumberId=35 and @timeHour=12 and @timeMinute=12
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------拱肋横撑AB截面应变--------------------------拱肋横撑AB截面应变---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId6+1
	while @pointsNumberId<=@SteelArchStrainPNId7
    begin
		----获得报警数据在-510,到-300之间
    	 set @min=-510
		 set @max=-300
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-400
		 set @max=280
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when (@pointsNumberId=42 or @pointsNumberId=47) and @timeHour=16 and @timeMinute=55
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
END
GO


--------------------------------------------------------------------------------------------
--------------------------钢拱肋原始数据发报机脚本--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_SteelLatticeStrainTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_SteelLatticeStrainTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_SteelLatticeStrainTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@strain float,
	@pointsNumberId int,
	@temperature int,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --获取小时部分
	@timeMinute int=datepart(mi,GETDATE()), --获取分钟部分	
	@abnormalData int =0, -----异常数据临时变量
	@warningData int,     -----预警数据临时变量
	@normalData int,     -----正常数据临时变量
	@max int,            ----定义随机变量的上限         
	@min int,             -----定义随机变量的下限
	@SteelArchStrainPNId1 int=49,---混凝土应变开始测点编号
	@SteelArchStrainPNId2 int=56,---混凝土结束应变测点编号
	@SteelArchStrainPNId3 int=62,---混凝土结束应变测点编号
	@SteelArchStrainPNId4 int=64,---混凝土结束应变测点编号
	@SteelArchStrainPNId5 int=66,---混凝土结束应变测点编号
	@SteelArchStrainPNId6 int=68,---混凝土结束应变测点编号
	@SteelArchStrainPNId7 int=70,---混凝土结束应变测点编号
	@SteelArchStrainPNId8 int=72,---混凝土结束应变测点编号
	@SteelArchStrainPNId9 int=74,---混凝土结束应变测点编号
	@SteelArchStrainPNId10 int=76,---混凝土结束应变测点编号
	@SteelArchStrainPNId11 int=78---混凝土结束应变测点编号
	--------------设置肋间横梁A/B截面/上层钢横梁A/B截面的应变值--------------------------设置肋间横梁A/B截面/上层钢横梁A/B截面的应变值---------
	set @pointsNumberId=@SteelArchStrainPNId1
	while @pointsNumberId<=@SteelArchStrainPNId2
    begin
		----获得异常数据在2000,1000之间。	
		 set @min=2000
		 set @max=1000
		 set @abnormaldata=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))	
		----获得报警数据在-800,到850之间
    	 set @min=-800
		 set @max=850
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-450
		 set @max=260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @pointsNumberId=55 and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----产生异常数据
					when (@pointsNumberId=50 or @pointsNumberId=52) and @timeHour=7 and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------设置钢纵梁A/B截面应变--------------------------设置钢纵梁A/B截面应变---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId2+1
	while @pointsNumberId<=@SteelArchStrainPNId3
    begin
		----获得异常数据在2000,1000之间。	
		 set @min=2000
		 set @max=1000
		 set @abnormaldata=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))	
		----获得报警数据在-810,到500之间
    	 set @min=-810
		 set @max=500
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-450
		 set @max=260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @pointsNumberId=61 and @timeHour=8 and @timeMinute=35 
					then @abnormalData       -----产生异常数据
					when (@pointsNumberId=60 or @pointsNumberId=62) and @timeHour=8 and @timeMinute=10
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------设置上层钢性系杆截面的上缘应变值-------------------------设置上层钢性系杆截面的上缘应变值---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId3+1
	while @pointsNumberId<=@SteelArchStrainPNId4
    begin
		----获得报警数据在-310,到650之间
    	 set @min=-310
		 set @max=650
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-200
		 set @max=480
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------设置上层钢性系杆截面的上缘应变值-------------------------设置上层钢性系杆截面的上缘应变值---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId4+1      --64
	while @pointsNumberId<=@SteelArchStrainPNId5     --66
    begin
		----获得报警数据在-520,到350之间
    	 set @min=-520
		 set @max=350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-350
		 set @max=200
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------设置上层钢性系杆截面的上缘应变值-------------------------设置上层钢性系杆截面的上缘应变值---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId5+1   --67
	while @pointsNumberId<=@SteelArchStrainPNId6  --68
    begin
		----获得报警数据在-310,到650之间
    	 set @min=-310
		 set @max=650
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-200
		 set @max=480
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @pointsNumberId=67and @timeHour=8 and @timeMinute=10
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------设置上层钢性系杆截面的上缘应变值-------------------------设置上层钢性系杆截面的上缘应变值---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId6+1       --69
	while @pointsNumberId<=@SteelArchStrainPNId7      --70
    begin
		----获得报警数据在-520,到350之间
    	 set @min=-520
		 set @max=350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-350
		 set @max=200
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
		--------------设置上层钢性系杆截面的上缘应变值-------------------------设置上层钢性系杆截面的上缘应变值---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId7+1  --71
	while @pointsNumberId<=@SteelArchStrainPNId8  --72
    begin
		----获得报警数据在-310,到650之间
    	 set @min=-310
		 set @max=650
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-200
		 set @max=480
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @pointsNumberId=71 and @timeHour=8 and @timeMinute=10
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------设置上层钢性系杆截面的上缘应变值-------------------------设置上层钢性系杆截面的上缘应变值---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId8+1    --73
	while @pointsNumberId<=@SteelArchStrainPNId9   --74
    begin
		----获得报警数据在-520,到350之间
    	 set @min=-520
		 set @max=350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-350
		 set @max=200
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
			--------------设置上层钢性系杆截面的上缘应变值-------------------------设置上层钢性系杆截面的上缘应变值---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId9+1       --75
	while @pointsNumberId<=@SteelArchStrainPNId10     --76
    begin
		----获得报警数据在-310,到650之间
    	 set @min=-310
		 set @max=650
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-200
		 set @max=480
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
		--------------设置上层钢性系杆截面的上缘应变值-------------------------设置上层钢性系杆截面的上缘应变值---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId10+1    --77
	while @pointsNumberId<=@SteelArchStrainPNId11   --78
    begin
		----获得报警数据在-520,到350之间
    	 set @min=-520
		 set @max=350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----获得正常数据
		 set @min=-350
		 set @max=200
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----获得温度数据
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----获得应力值值
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
END
GO

--------------------------------------------------------------------------------------------
--------------------------位移原始数据发报机脚本--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginalDisplacementTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginalDisplacementTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginalDisplacementTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@pointsNumberId int,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --获取小时部分
	@timeMinute int=datepart(mi,GETDATE()), --获取分钟部分	
	@abnormalData int =0, -----异常数据临时变量
	@warningData int,     -----预警数据临时变量
	@normalData int,       -----正常数据临时变量
	@min int,           -----随机数下限
	@max int             -----随机数上限


	----获得位移-----------------------------------获得位移
	----获得位移-----------------------------------获得位移
	declare
	@pNId1 int=95,---位移测点开始
	@pNId2 int=102,---钢拱肋测点X、Y向位移结束
	@pNId3 int=106,---钢拱肋测点Z向位移结束
	@pNId4 int=107,---边跨桥面挠度
	@pNId5 int=108,---中跨桥面挠度
	@pNId6 int=109,---边跨桥面挠度
	@pNId7 int=110,---边跨桥面挠度
	@pNId8 int=111,---中跨桥面挠度
	@pNId9 int=112,---边跨桥面挠度
	@pNId10 int=116,---过渡墩位移结束
	@pNId11 int=120,---伸缩缝位移结束
	@displacement float

	----循环获得钢拱肋测点X、Y向位移------------------------------------循环获得钢拱肋测点X、Y向位移
	----循环获得钢拱肋测点X、Y向位移------------------------------------循环获得钢拱肋测点X、Y向位移
	set @pointsNumberId=@pNId1
	while @pointsNumberId<=@pNId2
    begin
		----获得异常数据为500。		
		set @abnormalData=500								
		----获得钢拱肋测点X、Y向位移报警数据在-17到-11之间
		set @min =-17
        set @max =-11
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----获得钢拱肋测点X、Y向位移正常数据
		set @min =-11
        set @max =11
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----获得位移值
		select @displacement=
				case 
					when @pointsNumberId=98 and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----产生异常数据
					when @pointsNumberId=100 and (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    end

	----循环获得钢拱肋测点Z向位移------------------------------------循环获得钢拱肋测点Z向位移
	----循环获得钢拱肋测点Z向位移------------------------------------循环获得钢拱肋测点Z向位移
	set @pointsNumberId=@pNId2+1
	while @pointsNumberId<=@pNId3
    begin
		----获得钢拱肋测点Z向位移报警数据在-28到-10之间
		set @min =-28
        set @max =-10
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----获得钢拱肋测点Z向位移正常数据
		set @min =-10
        set @max =5
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----获得位移值
		select @displacement=
				case 
					when @pointsNumberId=104 and (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    end

	----获得边跨桥面的位移------------------------------------获得边跨桥面的位移
	----获得边跨桥面的位移------------------------------------获得边跨桥面的位移
	set @pointsNumberId=@pNId4
	----获得边跨桥面位移报警数据在-55到-20之间
		set @min =-55
        set @max =-20
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----获得边跨桥面位移正常数据
		set @min =-35
        set @max =4
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----获得位移值
		select @displacement=
				case 
					when (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    
	----获得中跨桥面的位移------------------------------------获得中跨桥面的位移
	----获得中跨桥面的位移------------------------------------获得中跨桥面的位移
	set @pointsNumberId=@pNId5
	    ----获得中跨桥面位移报警数据在-55到-20之间
		set @min =-125
        set @max =-50
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----获得边跨桥面位移正常数据
		set @min =-80
        set @max =50
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----获得位移值
		select @displacement=
				case 
					when (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    	
	----获得边跨桥面的位移------------------------------------获得边跨桥面的位移
	----获得边跨桥面的位移------------------------------------获得边跨桥面的位移
	set @pointsNumberId=@pNId6
	while @pointsNumberId<=@pNId7
    begin
	    ----获得异常数据为500。		
		set @abnormalData=500	
		----获得边跨桥面位移正常数据
		set @min =-35
        set @max =4
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----获得位移值
		select @displacement=
				case 
					when @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----产生异常数据
					else @normalData         -----产生正常数据
				end 		
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    end

	----获得中跨桥面的位移------------------------------------获得中跨桥面的位移
	----获得中跨桥面的位移------------------------------------获得中跨桥面的位移
	set @pointsNumberId=@pNId8
	    ----获得中跨桥面的位移正常数据
		set @min =-80
        set @max =50
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----获得位移值
		select @displacement=@normalData					
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)

	----获得边跨桥面的位移------------------------------------获得边跨桥面的位移
	----获得边跨桥面的位移------------------------------------获得边跨桥面的位移
	set @pointsNumberId=@pNId9
		----获得边跨桥面位移正常数据
		set @min =-35
        set @max =4
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----获得位移值
		select @displacement=@normalData
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    
	----循环获得过渡墩位移------------------------------------循环获得过渡墩位移
	----循环获得过渡墩位移------------------------------------循环获得过渡墩位移
	set @pointsNumberId=@pNId9+1
	while @pointsNumberId<=@pNId10
    begin
		----获得异常数据为500。		
		set @abnormalData=500								
		----获得过渡墩位移报警数据在50到110之间
		set @min =50
        set @max =110
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----获得过渡墩位移正常数据
		set @min =40
        set @max =79
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----获得位移值
		select @displacement=
				case 
					when @pointsNumberId=114 and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----产生异常数据
					when @pointsNumberId=115 and (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    end
	----循环获得伸缩缝位移------------------------------------循环获得伸缩缝位移
	----循环获得伸缩缝位移------------------------------------循环获得伸缩缝位移
	set @pointsNumberId=@pNId10+1
	while @pointsNumberId<=@pNId11
    begin
		----获得异常数据为500。		
		set @abnormalData=500								
		----获得伸缩缝位移报警数据在70到160之间
		set @min =70
        set @max =160
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----获得伸缩缝位移正常数据
		set @min =40
        set @max =70
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----获得位移值
		select @displacement=
				case 
					when @pointsNumberId=118 and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----产生异常数据
					when @pointsNumberId=119 and (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----产生预警数据
					else @normalData         -----产生正常数据
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    end
END
GO
	
------温度测试类型------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToTemperatureOriginalDataTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToTemperatureOriginalDataTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToTemperatureOriginalDataTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@pointsNumberId int,
	@temperature float,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --获取小时部分
	@timeMinute int=datepart(mi,GETDATE()), --获取分钟部分
	@timeForCalculate float,	
	@pNId1 int=168,---温度开始测点编号
	@pNId2 int=176,---温度结束测点编号
	@min int=-2,
	@max int=5
	----循环获得大气温度值------------------------------------
	set @pointsNumberId=@pNId1
	while @pointsNumberId=@pNId1
    begin
	set @timeForCalculate=convert(float,cast((@timeHour+@timeMinute/60) as decimal(18,2)))
	set @temperature=convert(float,cast((0.0006688963*power(@timeForCalculate,4)-0.0348599334*power(@timeForCalculate,3)+0.5121538687*power(@timeForCalculate,2)-1.3478253362 *@timeForCalculate+20.4826210826+(rand()*(@max-@min)+@min)) as decimal(18,2)))
	insert into Original_TemperatureTable(Temperature,Time,PointsNumberId)values(@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end

	----循环获得钢箱内温度值------------------------------------循环获得钢箱内温度值
	set @pointsNumberId=@pNId1+1
	while @pointsNumberId<=@pNId2
    begin
			set @timeForCalculate=convert(float,cast((@timeHour+@timeMinute/60) as decimal(18,2)))
	set @temperature=convert(float,cast((-0.0000161352*power(@timeForCalculate,6)+0.0013666675*power(@timeForCalculate,5)-0.0419269504*power(@timeForCalculate,4)+ 0.5518862571*power(@timeForCalculate,3)-2.8402782982 *power(@timeForCalculate,2)+ 5.1969544638*@timeForCalculate+11.6605128245+(rand()*(@max-@min)+@min)) as decimal(18,2)))
	insert into Original_TemperatureTable(Temperature,Time,PointsNumberId)values(@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
	end
END
GO

------湿度测试类型------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToHumidityOriginalDataTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToHumidityOriginalDataTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToHumidityOriginalDataTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@pointsNumberId int,
	@humidity float,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --获取小时部分
	@timeMinute int=datepart(mi,GETDATE()), --获取分钟部分
	@timeForCalculate float,	
	@pNId1 int=159,---湿度开始测点编号
	@pNId2 int=167,---湿度结束测点编号
	@min int=-5,
	@max int=5
	----循环获得大气湿度值------------------------------------
	set @pointsNumberId=@pNId1
	while @pointsNumberId=@pNId1
    begin
	set @timeForCalculate=convert(float,cast((@timeHour+@timeMinute/60) as decimal(18,2)))
	set @humidity=convert(float,cast((-0.0000078423*power(@timeForCalculate,6)+0.0002969528*power(@timeForCalculate,5)-0.0003479320*power(@timeForCalculate,4)-0.0882313919*power(@timeForCalculate,3)+0.9074929115*power(@timeForCalculate,2)-2.7612024709 *@timeForCalculate+94.4810448062+(rand()*(@max-@min)+@min)) as decimal(18,2)))
	insert into Original_HumidityTable(Humidity,Time,PointsNumberId)values(@humidity,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end

	----循环获得钢箱内湿度值------------------------------------循环获得钢箱内湿度值
	set @pointsNumberId=@pNId1+1
	while @pointsNumberId<=@pNId2
    begin
			set @timeForCalculate=convert(float,cast((@timeHour+@timeMinute/60) as decimal(18,2)))
	set @humidity=convert(float,cast((0.0000003604*power(@timeForCalculate,6)-0.0000414864*power(@timeForCalculate,5)+0.0021461937*power(@timeForCalculate,4)-0.0521791190*power(@timeForCalculate,3)+0.5739883341*power(@timeForCalculate,2)-2.1637451666*@timeForCalculate+42.5826680075+(rand()*(@max-@min)+@min)) as decimal(18,2)))
	insert into Original_HumidityTable(Humidity,Time,PointsNumberId)values(@humidity,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
	end

END
GO



------风速测试类型------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToWindLoadOriginalDataTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToWindLoadOriginalDataTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToWindLoadOriginalDataTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@pointsNumberId int,
	@windSpeed float,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --获取小时部分
	@timeMinute int=datepart(mi,GETDATE()), --获取分钟部分
	@timeForCalculate float,	
	@pNId1 int=177,---温度开始测点编号
	@min int=-2,
	@max int=4
	----循环获得风速值------------------------------------
	set @pointsNumberId=@pNId1
	while @pointsNumberId=@pNId1
    begin
	set @timeForCalculate=convert(float,cast((@timeHour+@timeMinute/60) as decimal(18,2)))
	set @windSpeed=convert(float,cast((0.0000098798*power(@timeForCalculate,6)-0.0006773310*power(@timeForCalculate,5)+0.0168724697*power(@timeForCalculate,4)- 0.1791762231*power(@timeForCalculate,3)+0.6505986426*power(@timeForCalculate,2)+0.5279698407*@timeForCalculate+10.2690913645+(rand()*(@max-@min)+@min)) as decimal(18,2)))
	insert into Original_WindLoadTable(WindSpeed,WindDirection,Time,PointsNumberId)values(@windSpeed,35.0,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
END
GO

--------------执行索力的存储过程
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginall_CableForce]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginall_CableForce]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginall_CableForce]    ---创建存储过程
AS
BEGIN
	declare @i int=1
	while @i<=4
	begin
		SET NOCOUNT ON;
		WAITFOR DELAY '000:00:03' 
		exec [dbo].[usp_InsertDataToOriginal_CableForceTable]
		set @i=@i+1
	end
END
GO

----------执行钢格构应变
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_SteelLatticeStrain]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_SteelLatticeStrain]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_SteelLatticeStrain]    ---创建存储过程
AS
BEGIN
	declare @i int=1
	while @i<=4
	begin
		SET NOCOUNT ON;
		WAITFOR DELAY '000:00:03' 
		exec usp_InsertDataToOriginal_SteelLatticeStrainTable
		set @i=@i+1
	end
END
GO

--------执行混凝土应变
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_ConcreteStrain]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_ConcreteStrain]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_ConcreteStrain]    ---创建存储过程
AS
BEGIN
	declare @i int=1
	while @i<=4
	begin
		SET NOCOUNT ON;
		WAITFOR DELAY '000:00:03' 
		exec [dbo].[usp_InsertDataToOriginal_ConcreteStrainTable]
		set @i=@i+1
	end
END
GO

-------执行钢拱肋应变
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_SteelArch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_SteelArch]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_SteelArch]    ---创建存储过程
AS
BEGIN
	declare @i int=1
	while @i<=4
	begin
		SET NOCOUNT ON;
		WAITFOR DELAY '000:00:03' 
		exec [dbo].[usp_InsertDataToOriginal_SteelArchStrainTable]
		set @i=@i+1
	end
END
GO

-------执行位移
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_Displacement]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_Displacement]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_Displacement]    ---创建存储过程
AS
BEGIN
	declare @i int=1
	while @i<=4
	begin
		SET NOCOUNT ON;
		WAITFOR DELAY '000:00:03' 
		exec [dbo].[usp_InsertDataToOriginalDisplacementTable]
		set @i=@i+1
	end
END
GO

------------------执行温度
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_Temperature]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_Temperature]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_Temperature]    ---创建存储过程
AS
BEGIN
	declare @i int=1
	while @i<=4
	begin
		SET NOCOUNT ON;
		WAITFOR DELAY '000:00:03' 
		exec [dbo].[usp_InsertDataToOriginal_CableForceTable]
		exec usp_InsertDataToOriginal_SteelLatticeStrainTable
		exec [dbo].[usp_InsertDataToOriginal_ConcreteStrainTable]
		exec [dbo].[usp_InsertDataToOriginal_SteelArchStrainTable]
		exec [dbo].[usp_InsertDataToOriginalDisplacementTable]
		exec usp_InsertDataToTemperatureOriginalDataTable
		exec usp_InsertDataToHumidityOriginalDataTable
		exec usp_InsertDataToWindLoadOriginalDataTable
		set @i=@i+1
	end
END
GO

----------------执行湿度
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_Humidity]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_Humidity]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_Humidity]    ---创建存储过程
AS
BEGIN
	declare @i int=1
	while @i<=4
	begin
		SET NOCOUNT ON;
		WAITFOR DELAY '000:00:03' 
		exec usp_InsertDataToHumidityOriginalDataTable
		set @i=@i+1
	end
END
GO

----------------执行风速
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_WindLoad]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_WindLoad]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_WindLoad]    ---创建存储过程
AS
BEGIN
	declare @i int=1
	while @i<=4
	begin
		SET NOCOUNT ON;
		WAITFOR DELAY '000:00:03' 
		exec usp_InsertDataToWindLoadOriginalDataTable
		set @i=@i+1
	end
END
GO