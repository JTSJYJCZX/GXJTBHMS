
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,houp>
-- Create date: <Create Date,2017-6-13,>
-- Description:	<�������ݵ�ԭʼ���ݿ�>
-- =============================================
--------------------------------------------------------------------------------------------
--------------------------����ԭʼ���ݷ������ű�--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_CableForceTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_CableForceTable]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_CableForceTable]   ---�����洢����
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@pointsNumberId int,
	@temperature int,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --��ȡСʱ����
	@timeMinute int=datepart(mi,GETDATE()), --��ȡ���Ӳ���	
	@abnormalData int =0, -----�쳣������ʱ����
	@warningData int,     -----Ԥ��������ʱ����
	@normalData int,     -----����������ʱ����
	@max int,            ----�����������������         
	@min int             -----�����������������
	----�������------------------------------------�������
	----�������------------------------------------�������
	declare
	@pNId1 int=121,---���˿�ʼ
	@pNId2 int=138,---�ϲ����
	@pNId3 int=146,---�²����
	@pNId4 int=158,---����ϵ��
	@cableforce float,
	@frequency float
	----ѭ������ϲ���˵�����------------------------------------ѭ������ϲ���˵�����
	----ѭ������ϲ���˵�����------------------------------------ѭ������ϲ���˵�����
	set @pointsNumberId=@pNId1
	while @pointsNumberId<=@pNId2
    begin
	    ----����쳣������7000,10000֮�䡣
		 set @min=7000
		 set @max=10000
		 set @abnormaldata=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----����ϲ���˱���������1500,��2200֮��
		 set @min=1500
		 set @max=2200
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----����ϲ������������
		 set @min=1200
		 set @max=1500
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		-----�������ֵ
		select @cableforce=
				case 
					when (@pointsNumberId=128 or @pointsNumberId=131) and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----�����쳣����
					when (@pointsNumberId=121 or @pointsNumberId=135)and @timeHour=7 and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
		select @frequency =CONVERT(float, cast((@cableforce+2.568)/3.56 as decimal(18,2))) ------�������Ƶ��
	insert into Original_CableForceTable(CableForce,Frequency,Temperature,Time,PointsNumberId)values(@cableforce,@frequency,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end

	----ѭ������²���˵�����------------------------------------ѭ������²���˵�����
	----ѭ������²���˵�����------------------------------------ѭ������²���˵�����
	set @pointsNumberId=@pNId2+1
	while @pointsNumberId<=@pNId3
    begin
		
		----����²���˱���������2000,��3500֮��
    	 set @min=2000
		 set @max=3500
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----����²������������
		 set @min=1500
		 set @max=2200
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----�������ֵ
		select @cableforce=
				case 
					when (@pointsNumberId=140 or @pointsNumberId=142) and (@timeHour=7 or @timeHour=17) and @timeMinute=35 
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
		select @frequency =CONVERT(float, cast((@cableforce+2.568)/3.56 as decimal(18,2))) ------�������Ƶ��
	insert into Original_CableForceTable(CableForce,Frequency,Temperature,Time,PointsNumberId)values(@cableforce,@frequency,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	----ѭ���������ϵ�˵�����------------------------------------ѭ���������ϵ�˵�����
	----ѭ���������ϵ�˵�����------------------------------------ѭ���������ϵ�˵�����
	set @pointsNumberId=@pNId3+1
	while @pointsNumberId<=@pNId4
    begin	
		----��ñ���������1400,��2200֮��
    	 set @min=1400
		 set @max=2200
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----����²������������
		 set @min=1200
		 set @max=1600
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----�������ֵ
		select @cableforce=
				case 
					when (@pointsNumberId=150 or @pointsNumberId=152) and (@timeHour=7 or @timeHour=17) and @timeMinute=40 
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
		select @frequency =CONVERT(float, cast((@cableforce+2.568)/3.56 as decimal(18,2))) ------�������Ƶ��
	insert into Original_CableForceTable(CableForce,Frequency,Temperature,Time,PointsNumberId)values(@cableforce,@frequency,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	END
GO

--------------------------------------------------------------------------------------------
--------------------------������ԭʼ���ݷ������ű�--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_ConcreteStrainTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_ConcreteStrainTable]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_ConcreteStrainTable]   ---�����洢����
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@strain float,
	@pointsNumberId int,
	@temperature int,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --��ȡСʱ����
	@timeMinute int=datepart(mi,GETDATE()), --��ȡ���Ӳ���	
	@abnormalData int =0, -----�쳣������ʱ����
	@warningData int,     -----Ԥ��������ʱ����
	@normalData int,     -----����������ʱ����
	@max int,            ----�����������������         
	@min int,             -----�����������������
	@concreteStrainPNId1 int=79,---������Ӧ�俪ʼ�����
	@concreteStrainPNId2 int=94---����������Ӧ������
	set @pointsNumberId=@concreteStrainPNId1
	while @pointsNumberId<=@concreteStrainPNId2
    begin
		----����쳣������-2000,-1000֮�䡣	
		 set @min=-2000
		 set @max=-1000
		 set @abnormaldata=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))	
				----��ñ���������-230,��-50֮��
    	 set @min=-230
		 set @max=-50
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-175
		 set @max=-90
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when (@pointsNumberId=79 or @pointsNumberId=91) and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----�����쳣����
					when (@pointsNumberId=84 or @pointsNumberId=90)and @timeHour=7 and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_ConcreteStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	END
GO


--------------------------------------------------------------------------------------------
--------------------------�ֹ���ԭʼ���ݷ������ű�--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_SteelArchStrainTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_SteelArchStrainTable]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_SteelArchStrainTable]   ---�����洢����
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@strain float,
	@pointsNumberId int,
	@temperature int,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --��ȡСʱ����
	@timeMinute int=datepart(mi,GETDATE()), --��ȡ���Ӳ���	
	@abnormalData int =0, -----�쳣������ʱ����
	@warningData int,     -----Ԥ��������ʱ����
	@normalData int,     -----����������ʱ����
	@max int,            ----�����������������         
	@min int,             -----�����������������
	@SteelArchStrainPNId1 int=1,---������Ӧ�俪ʼ�����
	@SteelArchStrainPNId2 int=8,---����������Ӧ������
	@SteelArchStrainPNId3 int=16,---����������Ӧ������
	@SteelArchStrainPNId4 int=24,---����������Ӧ������
	@SteelArchStrainPNId5 int=32,---����������Ӧ������
	@SteelArchStrainPNId6 int=40,---����������Ӧ������
	@SteelArchStrainPNId7 int=48---����������Ӧ������
	--------------���A����Ӧ��--------------------------���A����Ӧ��---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId1
	while @pointsNumberId<=@SteelArchStrainPNId2
    begin
		----����쳣������2000,1000֮�䡣	
		 set @min=2000
		 set @max=1000
		 set @abnormaldata=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))	
		----��ñ���������-600,��-350֮��
    	 set @min=-600
		 set @max=-350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-450
		 set @max=-260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @pointsNumberId=5 and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----�����쳣����
					when @pointsNumberId=7 and @timeHour=7 and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------���B����Ӧ��--------------------------���B����Ӧ��---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId2+1
	while @pointsNumberId<=@SteelArchStrainPNId3
    begin
			----��ñ���������-810,��-480֮��
    	 set @min=-810
		 set @max=-480
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-580
		 set @max=-260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @pointsNumberId=15 and @timeHour=7 and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
		--------------���C����Ӧ��--------------------------���C����Ӧ��---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId3+1
	while @pointsNumberId<=@SteelArchStrainPNId4
    begin
		----��ñ���������-600,��-350֮��
    	 set @min=-600
		 set @max=-350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-450
		 set @max=-260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @pointsNumberId=20 and @timeHour=8 and @timeMinute=20
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
		--------------���D����Ӧ��--------------------------���D����Ӧ��---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId4+1
	while @pointsNumberId<=@SteelArchStrainPNId5
    begin
			----��ñ���������-810,��-480֮��
    	 set @min=-810
		 set @max=-480
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-580
		 set @max=-260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @pointsNumberId=28 and @timeHour=9 and @timeMinute=23
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------���E����Ӧ��--------------------------���E����Ӧ��---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId5+1
	while @pointsNumberId<=@SteelArchStrainPNId6
    begin
		----��ñ���������-600,��-350֮��
    	 set @min=-600
		 set @max=-350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-450
		 set @max=-260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @pointsNumberId=35 and @timeHour=12 and @timeMinute=12
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------���ߺ��AB����Ӧ��--------------------------���ߺ��AB����Ӧ��---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId6+1
	while @pointsNumberId<=@SteelArchStrainPNId7
    begin
		----��ñ���������-510,��-300֮��
    	 set @min=-510
		 set @max=-300
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-400
		 set @max=280
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when (@pointsNumberId=42 or @pointsNumberId=47) and @timeHour=16 and @timeMinute=55
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelArchStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
END
GO


--------------------------------------------------------------------------------------------
--------------------------�ֹ���ԭʼ���ݷ������ű�--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_SteelLatticeStrainTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_SteelLatticeStrainTable]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_SteelLatticeStrainTable]   ---�����洢����
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@strain float,
	@pointsNumberId int,
	@temperature int,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --��ȡСʱ����
	@timeMinute int=datepart(mi,GETDATE()), --��ȡ���Ӳ���	
	@abnormalData int =0, -----�쳣������ʱ����
	@warningData int,     -----Ԥ��������ʱ����
	@normalData int,     -----����������ʱ����
	@max int,            ----�����������������         
	@min int,             -----�����������������
	@SteelArchStrainPNId1 int=49,---������Ӧ�俪ʼ�����
	@SteelArchStrainPNId2 int=56,---����������Ӧ������
	@SteelArchStrainPNId3 int=62,---����������Ӧ������
	@SteelArchStrainPNId4 int=64,---����������Ӧ������
	@SteelArchStrainPNId5 int=66,---����������Ӧ������
	@SteelArchStrainPNId6 int=68,---����������Ӧ������
	@SteelArchStrainPNId7 int=70,---����������Ӧ������
	@SteelArchStrainPNId8 int=72,---����������Ӧ������
	@SteelArchStrainPNId9 int=74,---����������Ӧ������
	@SteelArchStrainPNId10 int=76,---����������Ӧ������
	@SteelArchStrainPNId11 int=78---����������Ӧ������
	--------------�����߼����A/B����/�ϲ�ֺ���A/B�����Ӧ��ֵ--------------------------�����߼����A/B����/�ϲ�ֺ���A/B�����Ӧ��ֵ---------
	set @pointsNumberId=@SteelArchStrainPNId1
	while @pointsNumberId<=@SteelArchStrainPNId2
    begin
		----����쳣������2000,1000֮�䡣	
		 set @min=2000
		 set @max=1000
		 set @abnormaldata=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))	
		----��ñ���������-800,��850֮��
    	 set @min=-800
		 set @max=850
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-450
		 set @max=260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @pointsNumberId=55 and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----�����쳣����
					when (@pointsNumberId=50 or @pointsNumberId=52) and @timeHour=7 and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------���ø�����A/B����Ӧ��--------------------------���ø�����A/B����Ӧ��---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId2+1
	while @pointsNumberId<=@SteelArchStrainPNId3
    begin
		----����쳣������2000,1000֮�䡣	
		 set @min=2000
		 set @max=1000
		 set @abnormaldata=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))	
		----��ñ���������-810,��500֮��
    	 set @min=-810
		 set @max=500
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-450
		 set @max=260
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @pointsNumberId=61 and @timeHour=8 and @timeMinute=35 
					then @abnormalData       -----�����쳣����
					when (@pointsNumberId=60 or @pointsNumberId=62) and @timeHour=8 and @timeMinute=10
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------�����ϲ����ϵ�˽������ԵӦ��ֵ-------------------------�����ϲ����ϵ�˽������ԵӦ��ֵ---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId3+1
	while @pointsNumberId<=@SteelArchStrainPNId4
    begin
		----��ñ���������-310,��650֮��
    	 set @min=-310
		 set @max=650
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-200
		 set @max=480
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------�����ϲ����ϵ�˽������ԵӦ��ֵ-------------------------�����ϲ����ϵ�˽������ԵӦ��ֵ---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId4+1      --64
	while @pointsNumberId<=@SteelArchStrainPNId5     --66
    begin
		----��ñ���������-520,��350֮��
    	 set @min=-520
		 set @max=350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-350
		 set @max=200
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------�����ϲ����ϵ�˽������ԵӦ��ֵ-------------------------�����ϲ����ϵ�˽������ԵӦ��ֵ---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId5+1   --67
	while @pointsNumberId<=@SteelArchStrainPNId6  --68
    begin
		----��ñ���������-310,��650֮��
    	 set @min=-310
		 set @max=650
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-200
		 set @max=480
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @pointsNumberId=67and @timeHour=8 and @timeMinute=10
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------�����ϲ����ϵ�˽������ԵӦ��ֵ-------------------------�����ϲ����ϵ�˽������ԵӦ��ֵ---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId6+1       --69
	while @pointsNumberId<=@SteelArchStrainPNId7      --70
    begin
		----��ñ���������-520,��350֮��
    	 set @min=-520
		 set @max=350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-350
		 set @max=200
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
		--------------�����ϲ����ϵ�˽������ԵӦ��ֵ-------------------------�����ϲ����ϵ�˽������ԵӦ��ֵ---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId7+1  --71
	while @pointsNumberId<=@SteelArchStrainPNId8  --72
    begin
		----��ñ���������-310,��650֮��
    	 set @min=-310
		 set @max=650
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-200
		 set @max=480
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @pointsNumberId=71 and @timeHour=8 and @timeMinute=10
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
	--------------�����ϲ����ϵ�˽������ԵӦ��ֵ-------------------------�����ϲ����ϵ�˽������ԵӦ��ֵ---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId8+1    --73
	while @pointsNumberId<=@SteelArchStrainPNId9   --74
    begin
		----��ñ���������-520,��350֮��
    	 set @min=-520
		 set @max=350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-350
		 set @max=200
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
			--------------�����ϲ����ϵ�˽������ԵӦ��ֵ-------------------------�����ϲ����ϵ�˽������ԵӦ��ֵ---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId9+1       --75
	while @pointsNumberId<=@SteelArchStrainPNId10     --76
    begin
		----��ñ���������-310,��650֮��
    	 set @min=-310
		 set @max=650
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-200
		 set @max=480
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
		--------------�����ϲ����ϵ�˽������ԵӦ��ֵ-------------------------�����ϲ����ϵ�˽������ԵӦ��ֵ---------------------------------
	set @pointsNumberId=@SteelArchStrainPNId10+1    --77
	while @pointsNumberId<=@SteelArchStrainPNId11   --78
    begin
		----��ñ���������-520,��350֮��
    	 set @min=-520
		 set @max=350
		 set @warningData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
		----�����������
		 set @min=-350
		 set @max=200
		 set @normalData=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))		
		----����¶�����
		 set @min=15
		 set @max=60
		 set @temperature=CONVERT(float, cast((rand()*(@max-@min)+@min) as decimal(18,2)))
	    -----���Ӧ��ֵֵ
		select @strain=
				case 
					when @timeHour=8 and @timeMinute=10
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
	insert into Original_SteelLatticeStrainTable(Strain,Temperature,Time,PointsNumberId)values(@strain,@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end
END
GO

--------------------------------------------------------------------------------------------
--------------------------λ��ԭʼ���ݷ������ű�--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginalDisplacementTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginalDisplacementTable]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginalDisplacementTable]   ---�����洢����
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@pointsNumberId int,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --��ȡСʱ����
	@timeMinute int=datepart(mi,GETDATE()), --��ȡ���Ӳ���	
	@abnormalData int =0, -----�쳣������ʱ����
	@warningData int,     -----Ԥ��������ʱ����
	@normalData int,       -----����������ʱ����
	@min int,           -----���������
	@max int             -----���������


	----���λ��-----------------------------------���λ��
	----���λ��-----------------------------------���λ��
	declare
	@pNId1 int=95,---λ�Ʋ�㿪ʼ
	@pNId2 int=102,---�ֹ��߲��X��Y��λ�ƽ���
	@pNId3 int=106,---�ֹ��߲��Z��λ�ƽ���
	@pNId4 int=107,---�߿������Ӷ�
	@pNId5 int=108,---�п������Ӷ�
	@pNId6 int=109,---�߿������Ӷ�
	@pNId7 int=110,---�߿������Ӷ�
	@pNId8 int=111,---�п������Ӷ�
	@pNId9 int=112,---�߿������Ӷ�
	@pNId10 int=116,---���ɶ�λ�ƽ���
	@pNId11 int=120,---������λ�ƽ���
	@displacement float

	----ѭ����øֹ��߲��X��Y��λ��------------------------------------ѭ����øֹ��߲��X��Y��λ��
	----ѭ����øֹ��߲��X��Y��λ��------------------------------------ѭ����øֹ��߲��X��Y��λ��
	set @pointsNumberId=@pNId1
	while @pointsNumberId<=@pNId2
    begin
		----����쳣����Ϊ500��		
		set @abnormalData=500								
		----��øֹ��߲��X��Y��λ�Ʊ���������-17��-11֮��
		set @min =-17
        set @max =-11
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----��øֹ��߲��X��Y��λ����������
		set @min =-11
        set @max =11
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----���λ��ֵ
		select @displacement=
				case 
					when @pointsNumberId=98 and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----�����쳣����
					when @pointsNumberId=100 and (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    end

	----ѭ����øֹ��߲��Z��λ��------------------------------------ѭ����øֹ��߲��Z��λ��
	----ѭ����øֹ��߲��Z��λ��------------------------------------ѭ����øֹ��߲��Z��λ��
	set @pointsNumberId=@pNId2+1
	while @pointsNumberId<=@pNId3
    begin
		----��øֹ��߲��Z��λ�Ʊ���������-28��-10֮��
		set @min =-28
        set @max =-10
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----��øֹ��߲��Z��λ����������
		set @min =-10
        set @max =5
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----���λ��ֵ
		select @displacement=
				case 
					when @pointsNumberId=104 and (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    end

	----��ñ߿������λ��------------------------------------��ñ߿������λ��
	----��ñ߿������λ��------------------------------------��ñ߿������λ��
	set @pointsNumberId=@pNId4
	----��ñ߿�����λ�Ʊ���������-55��-20֮��
		set @min =-55
        set @max =-20
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----��ñ߿�����λ����������
		set @min =-35
        set @max =4
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----���λ��ֵ
		select @displacement=
				case 
					when (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    
	----����п������λ��------------------------------------����п������λ��
	----����п������λ��------------------------------------����п������λ��
	set @pointsNumberId=@pNId5
	    ----����п�����λ�Ʊ���������-55��-20֮��
		set @min =-125
        set @max =-50
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----��ñ߿�����λ����������
		set @min =-80
        set @max =50
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----���λ��ֵ
		select @displacement=
				case 
					when (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    	
	----��ñ߿������λ��------------------------------------��ñ߿������λ��
	----��ñ߿������λ��------------------------------------��ñ߿������λ��
	set @pointsNumberId=@pNId6
	while @pointsNumberId<=@pNId7
    begin
	    ----����쳣����Ϊ500��		
		set @abnormalData=500	
		----��ñ߿�����λ����������
		set @min =-35
        set @max =4
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----���λ��ֵ
		select @displacement=
				case 
					when @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----�����쳣����
					else @normalData         -----������������
				end 		
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    end

	----����п������λ��------------------------------------����п������λ��
	----����п������λ��------------------------------------����п������λ��
	set @pointsNumberId=@pNId8
	    ----����п������λ����������
		set @min =-80
        set @max =50
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----���λ��ֵ
		select @displacement=@normalData					
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)

	----��ñ߿������λ��------------------------------------��ñ߿������λ��
	----��ñ߿������λ��------------------------------------��ñ߿������λ��
	set @pointsNumberId=@pNId9
		----��ñ߿�����λ����������
		set @min =-35
        set @max =4
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----���λ��ֵ
		select @displacement=@normalData
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    
	----ѭ����ù��ɶ�λ��------------------------------------ѭ����ù��ɶ�λ��
	----ѭ����ù��ɶ�λ��------------------------------------ѭ����ù��ɶ�λ��
	set @pointsNumberId=@pNId9+1
	while @pointsNumberId<=@pNId10
    begin
		----����쳣����Ϊ500��		
		set @abnormalData=500								
		----��ù��ɶ�λ�Ʊ���������50��110֮��
		set @min =50
        set @max =110
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----��ù��ɶ�λ����������
		set @min =40
        set @max =79
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----���λ��ֵ
		select @displacement=
				case 
					when @pointsNumberId=114 and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----�����쳣����
					when @pointsNumberId=115 and (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    end
	----ѭ�����������λ��------------------------------------ѭ�����������λ��
	----ѭ�����������λ��------------------------------------ѭ�����������λ��
	set @pointsNumberId=@pNId10+1
	while @pointsNumberId<=@pNId11
    begin
		----����쳣����Ϊ500��		
		set @abnormalData=500								
		----���������λ�Ʊ���������70��160֮��
		set @min =70
        set @max =160
        set @warningData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
  		----���������λ����������
		set @min =40
        set @max =70
        set @normalData= CONVERT(float,cast((rand()*(@max-@min)+@min) as decimal(18,0)))
	    -----���λ��ֵ
		select @displacement=
				case 
					when @pointsNumberId=118 and @timeHour=7 and @timeMinute=35 
					then @abnormalData       -----�����쳣����
					when @pointsNumberId=119 and (@timeHour=7 or @timeHour=17) and @timeMinute=17
					then @warningData        -----����Ԥ������
					else @normalData         -----������������
				end 
		insert into Original_DisplacementTable(Displacement,"Time",PointsNumberId)values(@displacement,@time,@pointsNumberId)
	    set @pointsNumberId=@pointsNumberId+1
    end
END
GO
	
------�¶Ȳ�������------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToTemperatureOriginalDataTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToTemperatureOriginalDataTable]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToTemperatureOriginalDataTable]   ---�����洢����
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@pointsNumberId int,
	@temperature float,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --��ȡСʱ����
	@timeMinute int=datepart(mi,GETDATE()), --��ȡ���Ӳ���
	@timeForCalculate float,	
	@pNId1 int=168,---�¶ȿ�ʼ�����
	@pNId2 int=176,---�¶Ƚ��������
	@min int=-2,
	@max int=5
	----ѭ����ô����¶�ֵ------------------------------------
	set @pointsNumberId=@pNId1
	while @pointsNumberId=@pNId1
    begin
	set @timeForCalculate=convert(float,cast((@timeHour+@timeMinute/60) as decimal(18,2)))
	set @temperature=convert(float,cast((0.0006688963*power(@timeForCalculate,4)-0.0348599334*power(@timeForCalculate,3)+0.5121538687*power(@timeForCalculate,2)-1.3478253362 *@timeForCalculate+20.4826210826+(rand()*(@max-@min)+@min)) as decimal(18,2)))
	insert into Original_TemperatureTable(Temperature,Time,PointsNumberId)values(@temperature,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end

	----ѭ����ø������¶�ֵ------------------------------------ѭ����ø������¶�ֵ
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

------ʪ�Ȳ�������------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToHumidityOriginalDataTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToHumidityOriginalDataTable]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToHumidityOriginalDataTable]   ---�����洢����
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@pointsNumberId int,
	@humidity float,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --��ȡСʱ����
	@timeMinute int=datepart(mi,GETDATE()), --��ȡ���Ӳ���
	@timeForCalculate float,	
	@pNId1 int=159,---ʪ�ȿ�ʼ�����
	@pNId2 int=167,---ʪ�Ƚ��������
	@min int=-5,
	@max int=5
	----ѭ����ô���ʪ��ֵ------------------------------------
	set @pointsNumberId=@pNId1
	while @pointsNumberId=@pNId1
    begin
	set @timeForCalculate=convert(float,cast((@timeHour+@timeMinute/60) as decimal(18,2)))
	set @humidity=convert(float,cast((-0.0000078423*power(@timeForCalculate,6)+0.0002969528*power(@timeForCalculate,5)-0.0003479320*power(@timeForCalculate,4)-0.0882313919*power(@timeForCalculate,3)+0.9074929115*power(@timeForCalculate,2)-2.7612024709 *@timeForCalculate+94.4810448062+(rand()*(@max-@min)+@min)) as decimal(18,2)))
	insert into Original_HumidityTable(Humidity,Time,PointsNumberId)values(@humidity,@time,@pointsNumberId)
	set @pointsNumberId=@pointsNumberId+1
    end

	----ѭ����ø�����ʪ��ֵ------------------------------------ѭ����ø�����ʪ��ֵ
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



------���ٲ�������------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToWindLoadOriginalDataTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToWindLoadOriginalDataTable]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToWindLoadOriginalDataTable]   ---�����洢����
AS
BEGIN
	SET NOCOUNT ON;
	declare
	@pointsNumberId int,
	@windSpeed float,
	@time datetime =GETDATE(),
    @timeHour int= datepart(hh,GETDATE()),   --��ȡСʱ����
	@timeMinute int=datepart(mi,GETDATE()), --��ȡ���Ӳ���
	@timeForCalculate float,	
	@pNId1 int=177,---�¶ȿ�ʼ�����
	@min int=-2,
	@max int=4
	----ѭ����÷���ֵ------------------------------------
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

--------------ִ�������Ĵ洢����
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginall_CableForce]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginall_CableForce]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginall_CableForce]    ---�����洢����
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

----------ִ�иָ�Ӧ��
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_SteelLatticeStrain]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_SteelLatticeStrain]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_SteelLatticeStrain]    ---�����洢����
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

--------ִ�л�����Ӧ��
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_ConcreteStrain]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_ConcreteStrain]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_ConcreteStrain]    ---�����洢����
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

-------ִ�иֹ���Ӧ��
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_SteelArch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_SteelArch]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_SteelArch]    ---�����洢����
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

-------ִ��λ��
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_Displacement]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_Displacement]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_Displacement]    ---�����洢����
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

------------------ִ���¶�
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_Temperature]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_Temperature]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_Temperature]    ---�����洢����
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

----------------ִ��ʪ��
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_Humidity]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_Humidity]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_Humidity]    ---�����洢����
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

----------------ִ�з���
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_InsertDataToOriginal_WindLoad]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_InsertDataToOriginal_WindLoad]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToOriginal_WindLoad]    ---�����洢����
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