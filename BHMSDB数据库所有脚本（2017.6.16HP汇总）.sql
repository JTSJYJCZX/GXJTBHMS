use BHMSDB
GO
-----------------------------原始数据转到基础数据-------------------------------------------------------------------原始数据转到基础数据--------------------------------------
-----------------------------原始数据转到基础数据-------------------------------------------------------------------原始数据转到基础数据--------------------------------------
-----------------------------原始数据转到基础数据-------------------------------------------------------------------原始数据转到基础数据--------------------------------------
-----------------------------原始数据转到基础数据-------------------------------------------------------------------原始数据转到基础数据--------------------------------------

-------------索力--------------------------------------
if(OBJECT_ID('tgr_Original_CableForce','TR') is not null)
drop trigger tgr_Original_CableForce
go
create trigger tgr_Original_CableForce
on Original_CableForceTable
for insert
as
set nocount on
declare @CableForce float,@Frequency float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @CableForce=CableForce from inserted
select @Frequency=Frequency from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---上层吊杆的异常阈值Id=3
if @PointsNumberId between 121 and 138
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=3
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=3
	if @CableForce>@AnomalousEventThresholdValueMax or @CableForce<@AnomalousEventThresholdValueMin 
	return
end
---下层吊杆的异常阈值Id=4
if @PointsNumberId between 139 and 146
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=4
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=4
	if @CableForce>@AnomalousEventThresholdValueMax or @CableForce<@AnomalousEventThresholdValueMin 
	return
end
---柔性系杆的异常阈值Id=5
if @PointsNumberId between 147 and 158
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=5
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=5
	if @CableForce>@AnomalousEventThresholdValueMax or @CableForce<@AnomalousEventThresholdValueMin 
	return
end
---没有异常则可以判断预警等级后存储进基础数据库
select @ThresholdGradeId=
case 
	when @CableForce>=(select PositiveSecondLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId)
     then 3
    when @CableForce>=(select PositiveFirstLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId)
    then 2
	else 1
end
insert into Basic_CableForceTable (CableForce,Frequency,Temperature,"Time",PointsNumberId,ThresholdGradeId)
values(@CableForce,@Frequency,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)


declare @TotalNumber int
declare @MinId int
select @TotalNumber=count(*) from RealTime_CableForceTable
if @TotalNumber >=500
begin
   select @MinId=MIN(Id) from RealTime_CableForceTable
   delete from RealTime_CableForceTable WHERE Id=@MinId
end

insert into RealTime_CableForceTable (CableForce,Frequency,Temperature,"Time",PointsNumberId,ThresholdGradeId)
values(@CableForce,@Frequency,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)

go


--------------------混凝土应变----------------------------
if(OBJECT_ID('tgr_Original_ConcreteStrainTable','TR') is not null)
drop trigger tgr_Original_ConcreteStrainTable
go
create trigger tgr_Original_ConcreteStrainTable
on Original_ConcreteStrainTable
for insert
as
set nocount on
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---混凝土的异常阈值Id=2
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=2
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=2
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
return
---没有异常则可以判断预警等级后存储进基础数据库
select @ThresholdGradeId=
case 
	when @strain>=(select PositiveSecondLevelThresholdValue from ThresholdValue_ConcreteStrainThresholdValueTable where PointsNumberId=@PointsNumberId)
	 or @strain<=(select NegativeSecondLevelThresholdValue from ThresholdValue_ConcreteStrainThresholdValueTable where PointsNumberId=@PointsNumberId) 
     then 3
    when @strain>=(select PositiveFirstLevelThresholdValue from ThresholdValue_ConcreteStrainThresholdValueTable where PointsNumberId=@PointsNumberId)
	 or @strain<=(select NegativeFirstLevelThresholdValue from ThresholdValue_ConcreteStrainThresholdValueTable where PointsNumberId=@PointsNumberId) 
    then 2
	else 1
end
insert into Basic_ConcreteStrainTable(Strain,Temperature,"Time",PointsNumberId,ThresholdGradeId)
values(@strain,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)
declare @TotalNumber int
declare @MinId int
select @TotalNumber=count(*) from RealTime_ConcreteStrainTable
if @TotalNumber >=500
begin
   select @MinId=MIN(Id) from RealTime_ConcreteStrainTable
   delete from RealTime_ConcreteStrainTable WHERE Id=@MinId
end
insert into RealTime_ConcreteStrainTable(Strain,Temperature,"Time",PointsNumberId,ThresholdGradeId)
values(@strain,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)
go


---------------------------------位移-------------------------------------
if(OBJECT_ID('tgr_Original_DisplacementTable','TR') is not null)
drop trigger tgr_Original_DisplacementTable
go
create trigger tgr_Original_DisplacementTable
on Original_DisplacementTable     --触发表格
for insert
as
set nocount on
declare @displacement float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @displacement=Displacement from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---钢拱肋X方向异常阈值Id=9
if @PointsNumberId between 95 and 98
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=9
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=9
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---钢拱肋Y方向异常阈值Id=10
if @PointsNumberId between 99 and 102
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=10
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=10
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---钢拱肋Z方向异常阈值Id=11
if @PointsNumberId between 103 and 106
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=11
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=11
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---桥面挠度异常阈值Id=12
if @PointsNumberId between 107 and 112
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=12
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=12
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---过渡墩变形异常阈值Id=13
if @PointsNumberId between 113 and 116
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=13
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=13
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---伸缩缝变形异常阈值Id=14
if @PointsNumberId between 117 and 120
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=14
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=14
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---没有异常则可以判断预警等级后存储进基础数据库
select @ThresholdGradeId=
case 
	when @displacement>=(select PositiveSecondLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId)
      or @displacement<=(select NegativeSecondLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId) 
     then 3
    when @displacement>=(select PositiveFirstLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId)
      or @displacement<=(select NegativeFirstLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId) 
    then 2
	else 1
end
insert into Basic_DisplacementTable(Displacement,"Time",PointsNumberId,ThresholdGradeId)
values(@displacement,@Time,@PointsNumberId,@ThresholdGradeId)
declare @TotalNumber int
declare @MinId int
select @TotalNumber=count(*) from RealTime_DisplacementTable
if @TotalNumber >=500
begin
   select @MinId=MIN(Id) from RealTime_DisplacementTable
   delete from RealTime_DisplacementTable WHERE Id=@MinId
end
insert into RealTime_DisplacementTable(Displacement,"Time",PointsNumberId,ThresholdGradeId)
values(@displacement,@Time,@PointsNumberId,@ThresholdGradeId)
go

---------------------------------湿度-------------------------------------
if(OBJECT_ID('tgr_Original_HumidityTable','TR') is not null)
drop trigger tgr_Original_HumidityTable
go
create trigger tgr_Original_HumidityTable
on Original_HumidityTable    --触发表格
for insert
as
set nocount on
declare @humidity float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @humidity=Humidity from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---湿度的异常阈值Id=7
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=7
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=7
if @Humidity>@AnomalousEventThresholdValueMax or @Humidity<@AnomalousEventThresholdValueMin 
return
---没有异常则可以判断预警等级后存储进基础数据库
select @ThresholdGradeId=
case 
	when @humidity>=(select PositiveSecondLevelThresholdValue from ThresholdValue_HumidityThresholdValueTable where PointsNumberId=@PointsNumberId)
     then 3
    when @humidity>=(select PositiveFirstLevelThresholdValue from ThresholdValue_HumidityThresholdValueTable where PointsNumberId=@PointsNumberId)
    then 2
	else 1
end
insert into Basic_HumidityTable(Humidity,"Time",PointsNumberId,ThresholdGradeId)
values(@humidity,@Time,@PointsNumberId,@ThresholdGradeId)
declare @TotalNumber int
declare @MinId int
select @TotalNumber=count(*) from RealTime_HumidityTable
if @TotalNumber >=500
begin
   select @MinId=MIN(Id) from RealTime_HumidityTable
   delete from RealTime_HumidityTable WHERE Id=@MinId
end
insert into RealTime_HumidityTable(Humidity,"Time",PointsNumberId,ThresholdGradeId)
values(@humidity,@Time,@PointsNumberId,@ThresholdGradeId)
go


----------------------------------温度----------------------------------
if(OBJECT_ID('tgr_Original_TemperatureTable','TR') is not null)
drop trigger tgr_Original_TemperatureTable
go
create trigger tgr_Original_TemperatureTable
on Original_TemperatureTable    --触发表格
for insert
as
set nocount on
declare @temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---温度的异常阈值Id=6
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=6
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=6
if @Temperature>@AnomalousEventThresholdValueMax or @Temperature<@AnomalousEventThresholdValueMin 
return
---没有异常则可以判断预警等级后存储进基础数据库
select @ThresholdGradeId=
case 
	when @temperature>=(select PositiveSecondLevelThresholdValue from ThresholdValue_TemperatureThresholdValueTable where PointsNumberId=@PointsNumberId)
	  or @temperature<=(select NegativeSecondLevelThresholdValue from ThresholdValue_TemperatureThresholdValueTable where PointsNumberId=@PointsNumberId) 
     then 3
    when @temperature>=(select PositiveFirstLevelThresholdValue from ThresholdValue_TemperatureThresholdValueTable where PointsNumberId=@PointsNumberId)
	  or @temperature<=(select NegativeFirstLevelThresholdValue from ThresholdValue_TemperatureThresholdValueTable where PointsNumberId=@PointsNumberId)
    then 2
	else 1
end
insert into Basic_TemperatureTable(Temperature,"Time",PointsNumberId,ThresholdGradeId)
values(@temperature,@Time,@PointsNumberId,@ThresholdGradeId)
declare @TotalNumber int
declare @MinId int
select @TotalNumber=count(*) from RealTime_TemperatureTable
if @TotalNumber >=500
begin
   select @MinId=MIN(Id) from RealTime_TemperatureTable
   delete from RealTime_TemperatureTable WHERE Id=@MinId
end
insert into RealTime_TemperatureTable(Temperature,"Time",PointsNumberId,ThresholdGradeId)
values(@temperature,@Time,@PointsNumberId,@ThresholdGradeId)
go


----------------------------------风速------------------------------
if(OBJECT_ID('tgr_Original_WindLoadTable','TR') is not null)
drop trigger tgr_Original_WindLoadTable
go
create trigger tgr_Original_WindLoadTable
on Original_WindLoadTable    --触发表格
for insert
as
set nocount on
declare @windSpeed float,@WindDirection float, @Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @windSpeed=WindSpeed from inserted
select @WindDirection=WindDirection from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---湿度的异常阈值Id=8
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=8
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=8
if @windSpeed>@AnomalousEventThresholdValueMax or @windSpeed<@AnomalousEventThresholdValueMin 
return
---没有异常则可以判断预警等级后存储进基础数据库
select @ThresholdGradeId=
case 
	when @windSpeed>=(select PositiveSecondLevelThresholdValue from ThresholdValue_WindLoadThresholdValueTable where PointsNumberId=@PointsNumberId)
     then 3
    when @windSpeed>=(select PositiveFirstLevelThresholdValue from ThresholdValue_WindLoadThresholdValueTable where PointsNumberId=@PointsNumberId)
    then 2
	else 1
end
insert into Basic_WindLoadTable(WindSpeed,WindDirection,"Time",PointsNumberId,ThresholdGradeId)
values(@windSpeed,@WindDirection,@Time,@PointsNumberId,@ThresholdGradeId)
declare @TotalNumber int
declare @MinId int
select @TotalNumber=count(*) from RealTime_WindLoadTable
if @TotalNumber >=500
begin
   select @MinId=MIN(Id) from RealTime_WindLoadTable
   delete from RealTime_WindLoadTable WHERE Id=@MinId
end
insert into RealTime_WindLoadTable(WindSpeed,WindDirection,"Time",PointsNumberId,ThresholdGradeId)
values(@windSpeed,@WindDirection,@Time,@PointsNumberId,@ThresholdGradeId)
go


----------------------------------钢拱肋应变------------------------------------------
if(OBJECT_ID('tgr_Original_SteelArchStrainTable','TR') is not null)
drop trigger tgr_Original_SteelArchStrainTable
go
create trigger tgr_Original_SteelArchStrainTable
on Original_SteelArchStrainTable    --触发表格
for insert
as
set nocount on
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---钢应变的异常阈值Id=1
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
return
---没有异常则可以判断预警等级后存储进基础数据库
select @ThresholdGradeId=
case 
	when @strain>=(select PositiveSecondLevelThresholdValue from ThresholdValue_SteelArchStrainThresholdValueTable where PointsNumberId=@PointsNumberId)
	  or @strain<=(select NegativeSecondLevelThresholdValue from ThresholdValue_SteelArchStrainThresholdValueTable where PointsNumberId=@PointsNumberId) 
     then 3
    when @strain>=(select PositiveFirstLevelThresholdValue from ThresholdValue_SteelArchStrainThresholdValueTable where PointsNumberId=@PointsNumberId)
	  or @strain<=(select NegativeFirstLevelThresholdValue from ThresholdValue_SteelArchStrainThresholdValueTable where PointsNumberId=@PointsNumberId) 
    then 2
	else 1
end
insert into Basic_SteelArchStrainTable(Strain,Temperature,"Time",PointsNumberId,ThresholdGradeId)
values(@strain,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)

declare @TotalNumber int
declare @MinId int
select @TotalNumber=count(*) from RealTime_SteelArchStrainTable
if @TotalNumber >=500
begin
   select @MinId=MIN(Id) from RealTime_SteelArchStrainTable
   delete from RealTime_SteelArchStrainTable WHERE Id=@MinId
end
insert into RealTime_SteelArchStrainTable(Strain,Temperature,"Time",PointsNumberId,ThresholdGradeId)
values(@strain,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)
go


-----------------------------------钢格构应变----------------------------------------
if(OBJECT_ID('tgr_Original_SteelLatticeStrainTable','TR') is not null)
drop trigger tgr_Original_SteelLatticeStrainTable
go
create trigger tgr_Original_SteelLatticeStrainTable
on Original_SteelLatticeStrainTable    --触发表格
for insert
as
set nocount on
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---钢应变的异常阈值Id=1
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
return
---没有异常则可以判断预警等级后存储进基础数据库
select @ThresholdGradeId=
case 
	when @strain>=(select PositiveSecondLevelThresholdValue from ThresholdValue_SteelLatticeStrainThresholdValueTable where PointsNumberId=@PointsNumberId)
		 or @strain<=(select NegativeSecondLevelThresholdValue from ThresholdValue_SteelLatticeStrainThresholdValueTable where PointsNumberId=@PointsNumberId) 
     then 3
    when @strain>=(select PositiveFirstLevelThresholdValue from ThresholdValue_SteelLatticeStrainThresholdValueTable where PointsNumberId=@PointsNumberId)
	 or @strain<=(select NegativeFirstLevelThresholdValue from ThresholdValue_SteelLatticeStrainThresholdValueTable where PointsNumberId=@PointsNumberId) 
    then 2
	else 1
end
insert into Basic_SteelLatticeStrainTable(Strain,Temperature,"Time",PointsNumberId,ThresholdGradeId)
values(@strain,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)

declare @TotalNumber int
declare @MinId int
select @TotalNumber=count(*) from RealTime_SteelLatticeStrainTable
if @TotalNumber >=500
begin
   select @MinId=MIN(Id) from RealTime_SteelLatticeStrainTable
   delete from RealTime_SteelLatticeStrainTable WHERE Id=@MinId
end
insert into RealTime_SteelLatticeStrainTable(Strain,Temperature,"Time",PointsNumberId,ThresholdGradeId)
values(@strain,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)
go



-----------------------------------------------------------------------------------------
-----------------------------原始数据转到预警数据----------------------------------------
-----------------------------------------------------------------------------------------

----基础数据库索力值有新的记录时,触发预警数据的存储(仅存储黄色预警和红色预警,黄色预警等级ThresholdGradeId=2,红色预警等级ThresholdGradeId=3
if(OBJECT_ID('tgr_Basic_CableForceTable','TR') is not null)
drop trigger tgr_Basic_CableForceTable
go
create trigger tgr_Basic_CableForceTable
on Basic_CableForceTable
for insert
as
set nocount on
declare @CableForce float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@ThresholdValue float,@FirstThresholdCount int,@FirstAssessmentTime datetime
select @CableForce=CableForce from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted
select top 1 @FirstAssessmentTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
select @FirstThresholdCount=COUNT(*) from SafetyPreWarning_CableForceTable where "Time">=@FirstAssessmentTime and ThresholdGradeId=2 and PointsNumberId=@PointsNumberId
if @ThresholdGradeId=3
	begin
    select @ThresholdValue=PositiveSecondLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId
    insert into SafetyPreWarning_CableForceTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@CableForce,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
	end
if @ThresholdGradeId=2
	begin
	if @FirstThresholdCount<10 
		begin
		select @ThresholdValue=PositiveFirstLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId 
		insert into SafetyPreWarning_CableForceTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue) 
		values(@CableForce,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
		end
	else
		begin
		select @ThresholdValue=PositiveSecondLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId 
		insert into SafetyPreWarning_CableForceTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue) 
		values(@CableForce,@Time,@PointsNumberId,(@ThresholdGradeId+1),@ThresholdValue)
		end
	end
if @ThresholdGradeId=1
	return
go


--基础数据库位移值有新的记录时,触发预警数据的存储(仅存储黄色预警和红色预警,黄色预警等级ThresholdGradeId=2,红色预警等级ThresholdGradeId=3
if(OBJECT_ID('tgr_Basic_DisplacementTable','TR') is not null)
drop trigger tgr_Basic_DisplacementTable
go
create trigger tgr_Basic_DisplacementTable
on Basic_DisplacementTable
for insert
as
set nocount on
declare @Displacement float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@ThresholdValue float,@FirstThresholdCount int,@FirstAssessmentTime datetime
select @Displacement=Displacement from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted
select top 1 @FirstAssessmentTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
select @FirstThresholdCount=COUNT(*) from SafetyPreWarning_DisplacementTable where "Time">=@FirstAssessmentTime and ThresholdGradeId=2 and PointsNumberId=@PointsNumberId

if @ThresholdGradeId=3  
	begin
	if @Displacement>=0
		begin
		select @ThresholdValue=PositiveSecondLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId
		insert into SafetyPreWarning_DisplacementTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Displacement,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
		end
	else
		begin
		select @ThresholdValue=NegativeSecondLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId
		insert into SafetyPreWarning_DisplacementTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Displacement,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
		end
	end
if @ThresholdGradeId=2
	begin
	if @FirstThresholdCount<10 
		begin
		if @Displacement>=0
			begin
			select @ThresholdValue=PositiveFirstLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId
			insert into SafetyPreWarning_DisplacementTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
			values(@Displacement,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
			end
		else
			begin
			select @ThresholdValue=NegativeFirstLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId
			insert into SafetyPreWarning_DisplacementTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
			values(@Displacement,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
			end
		end
	else
		begin
		if @Displacement>=0
			begin
			select @ThresholdValue=PositiveSecondLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId
			insert into SafetyPreWarning_DisplacementTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
			values(@Displacement,@Time,@PointsNumberId,(@ThresholdGradeId+1),@ThresholdValue)
			end
		else
			begin
			select @ThresholdValue=NegativeSecondLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId
			insert into SafetyPreWarning_DisplacementTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
			values(@Displacement,@Time,@PointsNumberId,(@ThresholdGradeId+1),@ThresholdValue)
			end
		end
	end

if @ThresholdGradeId=1
	return
go

--基础数据库温度值有新的记录时,触发预警数据的存储(仅存储黄色预警和红色预警,黄色预警等级ThresholdGradeId=2,红色预警等级ThresholdGradeId=3
if(OBJECT_ID('tgr_Basic_TemperatureTable','TR') is not null)
drop trigger tgr_Basic_TemperatureTable
go
create trigger tgr_Basic_TemperatureTable
on Basic_TemperatureTable
for insert
as
set nocount on
declare @Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@ThresholdValue float
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

if @ThresholdGradeId=3  
	begin
	if @Temperature>=0
		begin
		select @ThresholdValue=PositiveSecondLevelThresholdValue from ThresholdValue_TemperatureThresholdValueTable where PointsNumberId=@PointsNumberId
		insert into SafetyPreWarning_TemperatureTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Temperature,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
		end
	else
		begin
		select @ThresholdValue=NegativeSecondLevelThresholdValue from ThresholdValue_TemperatureThresholdValueTable where PointsNumberId=@PointsNumberId
		insert into SafetyPreWarning_TemperatureTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Temperature,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
		end
	end
if @ThresholdGradeId=2
	begin
	if @Temperature>=0
		begin
		select @ThresholdValue=PositiveFirstLevelThresholdValue from ThresholdValue_TemperatureThresholdValueTable where PointsNumberId=@PointsNumberId
		insert into SafetyPreWarning_TemperatureTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Temperature,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
		end
	else
		begin
		select @ThresholdValue=NegativeFirstLevelThresholdValue from ThresholdValue_TemperatureThresholdValueTable where PointsNumberId=@PointsNumberId
		insert into SafetyPreWarning_TemperatureTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Temperature,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
		end
	end
if @ThresholdGradeId=1
	return
go

--基础数据库风速值有新的记录时,触发预警数据的存储(仅存储黄色预警和红色预警,黄色预警等级ThresholdGradeId=2,红色预警等级ThresholdGradeId=3
if(OBJECT_ID('tgr_Basic_WindLoadTable','TR') is not null)
drop trigger tgr_Basic_WindLoadTable
go
create trigger tgr_Basic_WindLoadTable
on Basic_WindLoadTable
for insert
as
set nocount on
declare @WindSpeed float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@ThresholdValue float
select @WindSpeed=WindSpeed from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

if @ThresholdGradeId=3
	begin
    select @ThresholdValue=PositiveSecondLevelThresholdValue from ThresholdValue_WindLoadThresholdValueTable where PointsNumberId=@PointsNumberId
    insert into SafetyPreWarning_WindLoadTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@WindSpeed,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
	end
if @ThresholdGradeId=2
	begin
	select @ThresholdValue=PositiveFirstLevelThresholdValue from ThresholdValue_WindLoadThresholdValueTable where PointsNumberId=@PointsNumberId
	insert into SafetyPreWarning_WindLoadTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@WindSpeed,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
	end
if @ThresholdGradeId=1
	return
go


-----------------------------------------------------------------------------------------
-----------------------------安全一级评估相关脚本（由首期由基础数据库触发，后面的由特征值触发或按照每月）------------------------
-----------------------------------------------------------------------------------------
-------------------------------由索力触发一级评估报告首期--------------------------------------------
if(OBJECT_ID('tgr_Basic_CableForceTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_CableForceTableForAssessmentReportFirst
go
create trigger tgr_Basic_CableForceTableForAssessmentReportFirst
on Basic_CableForceTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--首期报告:基础数据库进入第一条数据，且不存在评估报告时，开始首期评估
if (select count(*) from Basic_CableForceTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------由位移触发一级评估报告首期--------------------------------------------
if(OBJECT_ID('tgr_Basic_DisplacementTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_DisplacementTableForAssessmentReportFirst
go
create trigger tgr_Basic_DisplacementTableForAssessmentReportFirst
on Basic_DisplacementTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--首期报告:基础数据库进入第一条数据，且不存在评估报告时，开始首期评估
if (select count(*) from Basic_DisplacementTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------由混凝土应变触发一级评估报告首期--------------------------------------------
if(OBJECT_ID('tgr_Basic_ConcreteStrainTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_ConcreteStrainTableForAssessmentReportFirst
go
create trigger tgr_Basic_ConcreteStrainTableForAssessmentReportFirst
on Basic_ConcreteStrainTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--首期报告:基础数据库进入第一条数据，且不存在评估报告时，开始首期评估
if (select count(*) from Basic_ConcreteStrainTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------由钢拱肋应变触发一级评估报告首期--------------------------------------------
if(OBJECT_ID('tgr_Basic_SteelArchStrainTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_SteelArchStrainTableForAssessmentReportFirst
go
create trigger tgr_Basic_SteelArchStrainTableForAssessmentReportFirst
on Basic_SteelArchStrainTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--首期报告:基础数据库进入第一条数据，且不存在评估报告时，开始首期评估
if (select count(*) from Basic_SteelArchStrainTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------由钢格构应变触发一级评估报告首期--------------------------------------------
if(OBJECT_ID('tgr_Basic_SteelLatticeStrainTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_SteelLatticeStrainTableForAssessmentReportFirst
go
create trigger tgr_Basic_SteelLatticeStrainTableForAssessmentReportFirst
on Basic_SteelLatticeStrainTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--首期报告:基础数据库进入第一条数据，且不存在评估报告时，开始首期评估
if (select count(*) from Basic_SteelLatticeStrainTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------由温度触发一级评估报告首期--------------------------------------------
if(OBJECT_ID('tgr_Basic_TemperatureTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_TemperatureTableForAssessmentReportFirst
go
create trigger tgr_Basic_TemperatureTableForAssessmentReportFirst
on Basic_TemperatureTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--首期报告:基础数据库进入第一条数据，且不存在评估报告时，开始首期评估
if (select count(*) from Basic_TemperatureTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------由湿度触发一级评估报告首期--------------------------------------------
if(OBJECT_ID('tgr_Basic_HumidityTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_HumidityTableForAssessmentReportFirst
go
create trigger tgr_Basic_HumidityTableForAssessmentReportFirst
on Basic_HumidityTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--首期报告:基础数据库进入第一条数据，且不存在评估报告时，开始首期评估
if (select count(*) from Basic_HumidityTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------由风速触发一级评估报告首期--------------------------------------------
if(OBJECT_ID('tgrBasic_WindLoadTableTableForAssessmentReportFirst','TR') is not null)
drop trigger tgrBasic_WindLoadTableTableForAssessmentReportFirst
go
create trigger tgrBasic_WindLoadTableTableForAssessmentReportFirst
on Basic_WindLoadTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--首期报告:基础数据库进入第一条数据，且不存在评估报告时，开始首期评估
if (select count(*) from Basic_WindLoadTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go


----------------------------由特征值索力表格触发生成一级评估报告表,2种情况(1)红色预警触发报告;(2)常规月报----------------------------------
if(OBJECT_ID('tgr_Eigenvalue_CableForceEigenvalueTableForAssessment','TR') is not null)
drop trigger tgr_Eigenvalue_CableForceEigenvalueTableForAssessment
go
create trigger tgr_Eigenvalue_CableForceEigenvalueTableForAssessment
on Eigenvalue_CableForceEigenvalueTable
for insert
as
set nocount on
declare @PointsNumberId int,@ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ThresholdGradeId int,@MaxEigenvalue float,
@PreReportTime datetime,@ReportTimeYear int,@PreReportTimeYear int,@ReportId int,@ReportIdDiff int,@InsertTime datetime,@LastReportTime datetime,@HasSecondThresholdByFirst bit
select @MaxEigenvalue="Max" from inserted
select @PointsNumberId=PointsNumberId from inserted
--查看预警表中是否有因为超过10次黄色预警而触发的红色预警记录
if (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)>0
	begin
	select top 1 @LastReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
	if(select count(*) from SafetyPreWarning_CableForceTable where PointsNumberId=@PointsNumberId and "Time">@LastReportTime and ThresholdGradeId=3)>0
	set @HasSecondThresholdByFirst=1
	else 
	set @HasSecondThresholdByFirst=0
	end
else
    set @HasSecondThresholdByFirst=0

--根据最大值或者是有红色预警值来确定预警等级
select @ThresholdGradeId=
case 
	when @MaxEigenvalue>=(select PositiveSecondLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId)
	or @HasSecondThresholdByFirst=1
    then 3
    when @MaxEigenvalue>=(select PositiveFirstLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId)
    then 2
	else 1
end
select @InsertTime=dateadd(hh,1,"Time") from inserted

--预警触发一级评估报告
if @ThresholdGradeId=3 and @InsertTime not in (select ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable)
	begin
		--评估时间附值			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--评估原因附值
		set @AssessmentReasonsId=2
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--同年度评估时，确定评估期数 
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end			
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end 
--非预警触发，30天进行常规报告
if @ThresholdGradeId<>3
	begin
	select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
	--本次记录插入与前次评估报告时间超过30天时，进入评估
	if DATEDIFF(dd,@PreReportTime,@InsertTime)>=30
		begin
		--评估时间附值			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--评估原因附值
		set @AssessmentReasonsId=3
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--同年度评估时，确定评估期数  
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go

-------------------------------------------------------------------------------------------------------------------------
--------------------------------由特征值位移表格触发生成一级评估报告表,2种情况,(1)红色预警触发报告;(2)常规月报-------------------------------------
if(OBJECT_ID('tgr_Eigenvalue_DisplacementEigenvalueTableForAssessment','TR') is not null)
drop trigger tgr_Eigenvalue_DisplacementEigenvalueTableForAssessment
go
create trigger tgr_Eigenvalue_DisplacementEigenvalueTableForAssessment
on Eigenvalue_DisplacementEigenvalueTable
for insert
as
set nocount on
declare @PointsNumberId int,@ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ThresholdGradeId int,@MaxEigenvalue float,
@PreReportTime datetime,@ReportTimeYear int,@PreReportTimeYear int,@ReportId int,@ReportIdDiff int,@InsertTime datetime,@LastReportTime datetime,@HasSecondThresholdByFirst bit
select @MaxEigenvalue="Max" from inserted
select @PointsNumberId=PointsNumberId from inserted

--查看预警表中是否有因为超过10次黄色预警而触发的红色预警记录
if (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)>0
	begin
	select top 1 @LastReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
	if(select count(*) from SafetyPreWarning_DisplacementTable where PointsNumberId=@PointsNumberId and "Time">@LastReportTime and ThresholdGradeId=3)>0
	set @HasSecondThresholdByFirst=1
	else 
	set @HasSecondThresholdByFirst=0
	end
else
    set @HasSecondThresholdByFirst=0

--根据最大值或者是有红色预警值来确定预警等级
select @ThresholdGradeId=
case 
	when @MaxEigenvalue>=(select PositiveSecondLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId)
	or @HasSecondThresholdByFirst=1
    then 3
    when @MaxEigenvalue>=(select PositiveFirstLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId)
    then 2
	else 1
end
select @InsertTime=dateadd(hh,1,"Time") from inserted

--预警触发一级评估报告
if @ThresholdGradeId=3 and @InsertTime not in (select ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable)
	begin
		--评估时间附值			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--评估原因附值
		set @AssessmentReasonsId=2
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--同年度评估时，确定评估期数 
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end			
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end 
--非预警触发，30天进行常规报告
if @ThresholdGradeId<>3
	begin
	select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
	--本次记录插入与前次评估报告时间超过30天时，进入评估
	if DATEDIFF(dd,@PreReportTime,@InsertTime)>=30
		begin
		--评估时间附值			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--评估原因附值
		set @AssessmentReasonsId=3
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--同年度评估时，确定评估期数  
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go

-------------------------------------------------------------------------------------------------------------------------
----------------------------由特征值温度表格触发生成一级评估报告表,2种情况,(1)红色预警触发报告;(2)常规月报-----------------------------------
if(OBJECT_ID('tgr_Eigenvalue_TemperatureEigenvalueTableForAssessment','TR') is not null)
drop trigger tgr_Eigenvalue_TemperatureEigenvalueTableForAssessment
go
create trigger tgr_Eigenvalue_TemperatureEigenvalueTableForAssessment
on Eigenvalue_TemperatureEigenvalueTable
for insert
as
set nocount on
declare @PointsNumberId int,@ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ThresholdGradeId int,@MaxEigenvalue float,
@PreReportTime datetime,@ReportTimeYear int,@PreReportTimeYear int,@ReportId int,@ReportIdDiff int,@InsertTime datetime
select @MaxEigenvalue="Max" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=
case 
	when @MaxEigenvalue>=(select PositiveSecondLevelThresholdValue from ThresholdValue_TemperatureThresholdValueTable where PointsNumberId=@PointsNumberId)
     then 3
    when @MaxEigenvalue>=(select PositiveFirstLevelThresholdValue from ThresholdValue_TemperatureThresholdValueTable where PointsNumberId=@PointsNumberId)
    then 2
	else 1
end
select @InsertTime=dateadd(hh,1,"Time") from inserted

--预警触发一级评估报告
if @ThresholdGradeId=3 and @InsertTime not in (select ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable)
	begin
		--评估时间附值			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--评估原因附值
		set @AssessmentReasonsId=2
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--同年度评估时，确定评估期数 
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end			
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end 
--非预警触发，30天进行常规报告
if @ThresholdGradeId<>3
	begin
	select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
	--本次记录插入与前次评估报告时间超过30天时，进入评估
	if DATEDIFF(dd,@PreReportTime,@InsertTime)>=30
		begin
		--评估时间附值			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--评估原因附值
		set @AssessmentReasonsId=3
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--同年度评估时，确定评估期数  
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go

-------------------------------------------------------------------------------------------------------------------------
-------------------由特征值湿度表格触发生成一级评估报告表,(1)红色预警触发报告;(2)常规月报------------------------------------
if(OBJECT_ID('tgr_Eigenvalue_HumidityEigenvalueTableForAssessment','TR') is not null)
drop trigger tgr_Eigenvalue_HumidityEigenvalueTableForAssessment
go
create trigger tgr_Eigenvalue_HumidityEigenvalueTableForAssessment
on Eigenvalue_HumidityEigenvalueTable
for insert
as
set nocount on
declare @PointsNumberId int,@ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ThresholdGradeId int,@MaxEigenvalue float,
@PreReportTime datetime,@ReportTimeYear int,@PreReportTimeYear int,@ReportId int,@ReportIdDiff int,@InsertTime datetime
select @MaxEigenvalue="Max" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=
case 
	when @MaxEigenvalue>=(select PositiveSecondLevelThresholdValue from ThresholdValue_HumidityThresholdValueTable where PointsNumberId=@PointsNumberId)
     then 3
    when @MaxEigenvalue>=(select PositiveFirstLevelThresholdValue from ThresholdValue_HumidityThresholdValueTable where PointsNumberId=@PointsNumberId)
    then 2
	else 1
end
select @InsertTime=dateadd(hh,1,"Time") from inserted

--预警触发一级评估报告
if @ThresholdGradeId=3 and @InsertTime not in (select ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable)
	begin
		--评估时间附值			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--评估原因附值
		set @AssessmentReasonsId=2
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--同年度评估时，确定评估期数 
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end			
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end 
--非预警触发，30天进行常规报告
if @ThresholdGradeId<>3
	begin
	select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
	--本次记录插入与前次评估报告时间超过30天时，进入评估
	if DATEDIFF(dd,@PreReportTime,@InsertTime)>=30
		begin
		--评估时间附值			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--评估原因附值
		set @AssessmentReasonsId=3
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--同年度评估时，确定评估期数  
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'年第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go


-------------------------------------------------------------------------------------------------------------------------
--由一级安全评估报告表触发评估异常数据记录表以及评估结果表（评估异常数据及结果包括索力、位移、应变）
if(OBJECT_ID('tgr_FirstAssessment_FirstLevelSafetyAssessmentReportTableForExceptionRecordAndResult','TR') is not null)
drop trigger tgr_FirstAssessment_FirstLevelSafetyAssessmentReportTableForExceptionRecordAndResult
go
create trigger tgr_FirstAssessment_FirstLevelSafetyAssessmentReportTableForExceptionRecordAndResult
on FirstAssessment_FirstLevelSafetyAssessmentReportTable
for insert
as
set nocount on
declare @PointsNumberId int,@TestType nvarchar(max),@MonitoringPointsNumber nvarchar(max),@MonitoringPointsPositions nvarchar(max),@ExceptionNumber int,@InsertAssessmentTime datetime,@PreInsertAssessmentTime datetime,@AssessmentReportId int
select @AssessmentReportId=Id from inserted
select @InsertAssessmentTime=ReportTime from inserted
select top 1 @PreInsertAssessmentTime = ReportTime from(select top 2 ReportTime 
from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc ) as a order by a.ReportTime 

--查出索力异常记录中的测点编号和次数
if(OBJECT_ID('TempTable','u') is not null)
drop table TempTable
select id=identity(int,1,1), PointsNumberId as PointsNumberId ,COUNT(*) as RecordCount into TempTable from SafetyPreWarning_CableForceTable 
where ThresholdGradeId=3 and "Time" between @PreInsertAssessmentTime and @InsertAssessmentTime group by PointsNumberId
--循环添加进异常数据表中
while exists(select PointsNumberId from TempTable)
	begin
	select top 1 @PointsNumberId=tt.PointsNumberId ,@MonitoringPointsNumber=mpn.Name,@MonitoringPointsPositions=mpp.Name,@TestType=mtt.Name,@ExceptionNumber=RecordCount from TempTable tt
    inner join MonitoringPointsNumbers mpn on tt.PointsNumberId=mpn.Id 
    inner join MonitoringPointsPositions mpp on mpn.PointsPositionId=mpp.Id
    inner join MonitoringTestTypes mtt on mpp.TestTypeId=mtt.Id 
    insert into FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable(AssessmentReportId,TestType,MonitoringPointsNumbers,MonitoringPointsPositions,ExceptionNumber)
    values(@AssessmentReportId,@TestType,@MonitoringPointsNumber,@MonitoringPointsPositions,@ExceptionNumber)
    delete from TempTable where PointsNumberId=@PointsNumberId
	end
drop table TempTable

--查出位移异常记录中的测点编号和次数
if(OBJECT_ID('TempTable','u') is not null)
drop table TempTable
select id=identity(int,1,1), PointsNumberId as PointsNumberId ,COUNT(*) as RecordCount into TempTable from SafetyPreWarning_DisplacementTable 
where ThresholdGradeId=3 and "Time" between @PreInsertAssessmentTime and @InsertAssessmentTime group by PointsNumberId
--循环添加进异常数据表中
while exists(select PointsNumberId from TempTable)
	begin
	select top 1 @PointsNumberId=tt.PointsNumberId ,@MonitoringPointsNumber=mpn.Name,@MonitoringPointsPositions=mpp.Name,@TestType=mtt.Name,@ExceptionNumber=RecordCount from TempTable tt
    inner join MonitoringPointsNumbers mpn on tt.PointsNumberId=mpn.Id 
    inner join MonitoringPointsPositions mpp on mpn.PointsPositionId=mpp.Id
    inner join MonitoringTestTypes mtt on mpp.TestTypeId=mtt.Id 
    insert into FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable(AssessmentReportId,TestType,MonitoringPointsNumbers,MonitoringPointsPositions,ExceptionNumber)
    values(@AssessmentReportId,@TestType,@MonitoringPointsNumber,@MonitoringPointsPositions,@ExceptionNumber)
    delete from TempTable where PointsNumberId=@PointsNumberId
	end
drop table TempTable

--查出应力异常记录中的测点编号和次数
if(OBJECT_ID('TempTable','u') is not null)
drop table TempTable
select id=identity(int,1,1), PointsNumberId as PointsNumberId ,COUNT(*) as RecordCount into TempTable from SafetyPreWarning_StrainTable 
where ThresholdGradeId=3 and "Time" between @PreInsertAssessmentTime and @InsertAssessmentTime group by PointsNumberId
--循环添加进异常数据表中
while exists(select PointsNumberId from TempTable)
	begin
	select top 1 @PointsNumberId=tt.PointsNumberId ,@MonitoringPointsNumber=mpn.Name,@MonitoringPointsPositions=mpp.Name,@TestType=mtt.Name,@ExceptionNumber=RecordCount from TempTable tt
    inner join MonitoringPointsNumbers mpn on tt.PointsNumberId=mpn.Id 
    inner join MonitoringPointsPositions mpp on mpn.PointsPositionId=mpp.Id
    inner join MonitoringTestTypes mtt on mpp.TestTypeId=mtt.Id 
    insert into FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable(AssessmentReportId,TestType,MonitoringPointsNumbers,MonitoringPointsPositions,ExceptionNumber)
    values(@AssessmentReportId,@TestType,@MonitoringPointsNumber,@MonitoringPointsPositions,@ExceptionNumber)
    delete from TempTable where PointsNumberId=@PointsNumberId
	end
drop table TempTable

--一级评估报告到结论与建议表

--声明变量
declare @testTypeId int
declare @CableForceAssessmentResult nvarchar(max),@CableForceAssessmentSuggestion nvarchar(max)
declare @StrainAssessmentResult nvarchar(max),@StrainAssessmentSuggestion nvarchar(max)
declare @DisplacementAssessmentResult nvarchar(max),@DisplacementAssessmentSuggestion nvarchar(max)

--给索力测试结果及建议赋值
if (select count(*) from FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable where AssessmentReportId =@AssessmentReportId and TestType='索力')>=1
	begin
	set @CableForceAssessmentResult='异常，索力出现实测值超过设计值情况，具体见异常记录'
	set @CableForceAssessmentSuggestion='结构局部响应异常,建议针对异常位置进行专项检查，排查异常原因'
	end
else
	begin
	set @CableForceAssessmentResult='正常，索力均未出现实测值超过设计值的情况'
	set @CableForceAssessmentSuggestion='索力测试结果正常，建议根据人工检测结果，对桥梁进行日常保养和维护'
end
--给应力测试结果及建议赋值
if (select count(*) from FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable where AssessmentReportId =@AssessmentReportId and TestType='钢拱肋应变')>=1 or 
(select count(*) from FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable where AssessmentReportId =@AssessmentReportId and TestType='钢格构应变')>=1 or
(select count(*) from FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable where AssessmentReportId =@AssessmentReportId and TestType='混凝土应变')>=1
	begin
	set @StrainAssessmentResult='异常，应力出现实测值超过设计值情况，具体见异常记录'
	set @StrainAssessmentSuggestion='结构局部响应异常,建议针对异常位置进行专项检查，排查异常原因'
	end
else
	begin
	set @StrainAssessmentResult='正常，应力均未出现实测值超过设计值的情况'
	set @StrainAssessmentSuggestion='应力测试结果正常，建议根据人工检测结果，对桥梁进行日常保养和维护'
	end
--给位移测试结果及建议赋值
if (select count(*) from FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable where AssessmentReportId =@AssessmentReportId and TestType='位移')>=1
	begin
	set @DisplacementAssessmentResult='异常，结构变形出现实测值超过设计值情况，具体见异常记录'
	set @DisplacementAssessmentSuggestion='结构整体响应异常,建议立即开展安全二级评估，根据评估结果及时组织相关维修工作'
	end
else
	begin
	set @DisplacementAssessmentResult='正常，结构变形均未出现实测值超过设计值的情况'
	set @DisplacementAssessmentSuggestion='结构变形测试结果正常，建议根据人工检测结果，对桥梁进行日常保养和维护'
	end
--插入获得的数据
insert into FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable values(@StrainAssessmentResult,@StrainAssessmentSuggestion,@DisplacementAssessmentResult,@DisplacementAssessmentSuggestion,@CableForceAssessmentResult,@CableForceAssessmentSuggestion,@AssessmentReportId)

go

-------------------------------------------------------------------------------------------------------------------------
--基础数据库钢拱肋应变有新的记录时,触发预警数据的存储(仅存储黄色预警和红色预警,黄色预警等级ThresholdGradeId=2,红色预警等级ThresholdGradeId=3
if(OBJECT_ID('tgr_Basic_SteelArchStrainTable','TR') is not null)
drop trigger tgr_Basic_SteelArchStrainTable
go
create trigger tgr_Basic_SteelArchStrainTable
on Basic_SteelArchStrainTable
for insert
as
set nocount on
declare @Strain float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@ThresholdValue float
select @Strain=Strain from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

if @ThresholdGradeId=3
	begin
    select @ThresholdValue=PositiveSecondLevelThresholdValue from ThresholdValue_SteelArchStrainThresholdValueTable where PointsNumberId=@PointsNumberId
    insert into SafetyPreWarning_StrainTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Strain,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
	end
if @ThresholdGradeId=2
	begin
	select @ThresholdValue=PositiveFirstLevelThresholdValue from ThresholdValue_SteelArchStrainThresholdValueTable where PointsNumberId=@PointsNumberId
	insert into SafetyPreWarning_StrainTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Strain,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
	end
if @ThresholdGradeId=1
	return
go


-------------------------------------------------------------------------------------------------------------------------
--基础数据库钢格构应变有新的记录时,触发预警数据的存储(仅存储黄色预警和红色预警,黄色预警等级ThresholdGradeId=2,红色预警等级ThresholdGradeId=3
if(OBJECT_ID('tgr_Basic_SteelLatticeStrainTable','TR') is not null)
drop trigger tgr_Basic_SteelLatticeStrainTable
go
create trigger tgr_Basic_SteelLatticeStrainTable
on Basic_SteelLatticeStrainTable
for insert
as
set nocount on
declare @Strain float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@ThresholdValue float
select @Strain=Strain from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

if @ThresholdGradeId=3
	begin
    select @ThresholdValue=PositiveSecondLevelThresholdValue from ThresholdValue_SteelLatticeStrainThresholdValueTable where PointsNumberId=@PointsNumberId
    insert into SafetyPreWarning_StrainTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Strain,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
	end
if @ThresholdGradeId=2
	begin
	select @ThresholdValue=PositiveFirstLevelThresholdValue from ThresholdValue_SteelLatticeStrainThresholdValueTable where PointsNumberId=@PointsNumberId
	insert into SafetyPreWarning_StrainTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Strain,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
	end
if @ThresholdGradeId=1
	return
go

-------------------------------------------------------------------------------------------------------------------------
--基础数据库混凝土应变有新的记录时,触发预警数据的存储(仅存储黄色预警和红色预警,黄色预警等级ThresholdGradeId=2,红色预警等级ThresholdGradeId=3
if(OBJECT_ID('tgr_Basic_ConcreteStrainTable','TR') is not null)
drop trigger tgr_Basic_ConcreteStrainTable
go
create trigger tgr_Basic_ConcreteStrainTable
on Basic_ConcreteStrainTable
for insert
as
set nocount on
declare @Strain float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@ThresholdValue float
select @Strain=Strain from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

if @ThresholdGradeId=3
	begin
    select @ThresholdValue=PositiveSecondLevelThresholdValue from ThresholdValue_ConcreteStrainThresholdValueTable where PointsNumberId=@PointsNumberId
    insert into SafetyPreWarning_StrainTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Strain,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
	end
if @ThresholdGradeId=2
	begin
	select @ThresholdValue=PositiveFirstLevelThresholdValue from ThresholdValue_ConcreteStrainThresholdValueTable where PointsNumberId=@PointsNumberId
	insert into SafetyPreWarning_StrainTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@Strain,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
	end
if @ThresholdGradeId=1
	return
go

-----------------------------------------------------------------------------------------------------------------------
-----------------------------异常事件存储（由原始数据触发）------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
----原始数据库有新的记录时,触发异常事件的存储(仅大于异常阈值的数据存储到异常事件的表格中
------------------------------------------------------索力------------------------------------------------------
if(OBJECT_ID('tgr_Basic_CableForceTableToAnomalousEvent_CableForceTable','TR') is not null)
drop trigger tgr_Basic_CableForceTableToAnomalousEvent_CableForceTable
go
create trigger tgr_Basic_CableForceTableToAnomalousEvent_CableForceTable
on Original_CableForceTable
for insert
as
set nocount on
declare @CableForce float,@Time datetime,@PointsNumberId int,@AnomalousEventReasonId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @CableForce=CableForce from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---上层吊杆的异常阈值Id=3
if @PointsNumberId between 121 and 138
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=3
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=3
	if @CableForce>@AnomalousEventThresholdValueMax or @CableForce<@AnomalousEventThresholdValueMin 
	begin
	set @AnomalousEventReasonId=1
	insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
	values(@CableForce,@Time,@PointsNumberId,@AnomalousEventReasonId)
	end
end
---下层吊杆的异常阈值Id=4
if @PointsNumberId between 139 and 146
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=4
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=4
	if @CableForce>@AnomalousEventThresholdValueMax or @CableForce<@AnomalousEventThresholdValueMin 
	begin
	set @AnomalousEventReasonId=1
	insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
	values(@CableForce,@Time,@PointsNumberId,@AnomalousEventReasonId)
	end
end
---柔性系杆的异常阈值Id=5
if @PointsNumberId between 147 and 158
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=5
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=5
	if @CableForce>@AnomalousEventThresholdValueMax or @CableForce<@AnomalousEventThresholdValueMin 
	begin
	set @AnomalousEventReasonId=1
	insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
	values(@CableForce,@Time,@PointsNumberId,@AnomalousEventReasonId)
	end
end
go

----原始数据库有新的记录时,触发异常事件的存储(仅大于异常阈值的数据存储到异常事件的表格中
------------------------------------------------------钢拱肋应变------------------------------------------------------
if(OBJECT_ID('Original_SteelArchStrainTableToAnomalousEvent_SteelArchStrainTable','TR') is not null)
drop trigger Original_SteelArchStrainTableToAnomalousEvent_SteelArchStrainTable
go
create trigger Original_SteelArchStrainTableToAnomalousEvent_SteelArchStrainTable
on Original_SteelArchStrainTable
for insert
as
set nocount on
declare @Strain float,@Time datetime,@PointsNumberId int,@AnomalousEventReasonId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @Strain=Strain from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---钢应变的异常阈值Id=1
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@Strain,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----原始数据库有新的记录时,触发异常事件的存储(仅大于异常阈值的数据存储到异常事件的表格中
------------------------------------------------------钢格构应变------------------------------------------------------
if(OBJECT_ID('Original_SteelLatticeStrainTableToAnomalousEvent_SteelLatticeStrainTable','TR') is not null)
drop trigger Original_SteelLatticeStrainTableToAnomalousEvent_SteelLatticeStrainTable
go
create trigger Original_SteelLatticeStrainTableToAnomalousEvent_SteelLatticeStrainTable
on Original_SteelLatticeStrainTable
for insert
as
set nocount on
declare @Strain float,@Time datetime,@PointsNumberId int,@AnomalousEventReasonId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @Strain=Strain from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---钢应变的异常阈值Id=1
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@Strain,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----原始数据库有新的记录时,触发异常事件的存储(仅大于异常阈值的数据存储到异常事件的表格中
------------------------------------------------------混凝土应变------------------------------------------------------
if(OBJECT_ID('Original_ConcreteStrainTableToAnomalousEvent_ConcreteStrainTable','TR') is not null)
drop trigger Original_ConcreteStrainTableToAnomalousEvent_ConcreteStrainTable
go
create trigger Original_ConcreteStrainTableToAnomalousEvent_ConcreteStrainTable
on Original_ConcreteStrainTable
for insert
as
set nocount on
declare @Strain float,@Time datetime,@PointsNumberId int,@AnomalousEventReasonId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @Strain=Strain from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---混凝土的异常阈值Id=2
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=2
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=2
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@Strain,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----原始数据库有新的记录时,触发异常事件的存储(仅大于异常阈值的数据存储到异常事件的表格中
------------------------------------------------------温度------------------------------------------------------
if(OBJECT_ID('Original_TemperatureTableToAnomalousEvent_TemperatureTable','TR') is not null)
drop trigger Original_TemperatureTableToAnomalousEvent_TemperatureTable
go
create trigger Original_TemperatureTableToAnomalousEvent_TemperatureTable
on Original_TemperatureTable
for insert
as
set nocount on
declare @Temperature float,@Time datetime,@PointsNumberId int,@AnomalousEventReasonId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---温度的异常阈值Id=6
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=6
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=6
if @Temperature>@AnomalousEventThresholdValueMax or @Temperature<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@Temperature,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----原始数据库有新的记录时,触发异常事件的存储(仅大于异常阈值的数据存储到异常事件的表格中
------------------------------------------------------湿度------------------------------------------------------
if(OBJECT_ID('Original_HumidityTableToAnomalousEvent_HumidityTable','TR') is not null)
drop trigger Original_HumidityTableToAnomalousEvent_HumidityTable
go
create trigger Original_HumidityTableToAnomalousEvent_HumidityTable
on Original_HumidityTable
for insert
as
set nocount on
declare @Humidity float,@Time datetime,@PointsNumberId int,@AnomalousEventReasonId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @Humidity=Humidity from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---湿度的异常阈值Id=7
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=7
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=7
if @Humidity>@AnomalousEventThresholdValueMax or @Humidity<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@Humidity,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----原始数据库有新的记录时,触发异常事件的存储(仅大于异常阈值的数据存储到异常事件的表格中
------------------------------------------------------风速------------------------------------------------------
if(OBJECT_ID('Original_WindLoadTableToAnomalousEvent_WindLoadTable','TR') is not null)
drop trigger Original_WindLoadTableToAnomalousEvent_WindLoadTable
go
create trigger Original_WindLoadTableToAnomalousEvent_WindLoadTable
on Original_WindLoadTable
for insert
as
set nocount on
declare @WindLoad float,@Time datetime,@PointsNumberId int,@AnomalousEventReasonId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @WindLoad=WindSpeed from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---湿度的异常阈值Id=8
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=8
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=8
if @WindLoad>@AnomalousEventThresholdValueMax or @WindLoad<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@WindLoad,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----原始数据库有新的记录时,触发异常事件的存储(仅大于异常阈值的数据存储到异常事件的表格中
------------------------------------------------------位移------------------------------------------------------
if(OBJECT_ID('tgr_Original_DisplacementTableToAnomalousEvent_DisplacementTable','TR') is not null)
drop trigger tgr_Original_DisplacementTableToAnomalousEvent_DisplacementTable
go
create trigger tgr_Original_DisplacementTableToAnomalousEvent_DisplacementTable
on Original_DisplacementTable
for insert
as
set nocount on
declare @Displacement float,@Time datetime,@PointsNumberId int,@AnomalousEventReasonId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @Displacement=Displacement from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---钢拱肋X方向异常阈值Id=9
if @PointsNumberId between 95 and 98
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=9
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=9
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	begin
	set @AnomalousEventReasonId=1
	insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
	values(@Displacement,@Time,@PointsNumberId,@AnomalousEventReasonId)
	end
end
---钢拱肋Y方向异常阈值Id=10
if @PointsNumberId between 99 and 102
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=10
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=10
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	begin
	set @AnomalousEventReasonId=1
	insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
	values(@Displacement,@Time,@PointsNumberId,@AnomalousEventReasonId)
	end
end
---钢拱肋Z方向异常阈值Id=11
if @PointsNumberId between 103 and 106
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=11
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=11
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	begin
	set @AnomalousEventReasonId=1
	insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
	values(@Displacement,@Time,@PointsNumberId,@AnomalousEventReasonId)
	end
end
---桥面挠度异常阈值Id=12
if @PointsNumberId between 107 and 112
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=12
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=12
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	begin
	set @AnomalousEventReasonId=1
	insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
	values(@Displacement,@Time,@PointsNumberId,@AnomalousEventReasonId)
	end
end
---过渡墩变形异常阈值Id=13
if @PointsNumberId between 113 and 116
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=13
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=13
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	begin
	set @AnomalousEventReasonId=1
	insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
	values(@Displacement,@Time,@PointsNumberId,@AnomalousEventReasonId)
	end
end
---伸缩缝变形异常阈值Id=14
if @PointsNumberId between 117 and 120
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=14
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=14
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	begin
	set @AnomalousEventReasonId=1
	insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
	values(@Displacement,@Time,@PointsNumberId,@AnomalousEventReasonId)
	end
end
go


-------------------------------------------------------------------
----------------------数据下载脚本---------------------------------------------------------数据下载脚本-----------------------------------
----------------------数据下载脚本---------------------------------------------------------数据下载脚本-----------------------------------
----------------------数据下载脚本---------------------------------------------------------数据下载脚本-----------------------------------
----------------------数据下载脚本---------------------------------------------------------数据下载脚本-----------------------------------
-----------------------------------------------------------------------------------------------------------------------------
---------------执行存储过程测试代码--------------------------------------
--declare @TxtPathOutput varchar(max)
--Exec usp_BasicSteelArchStrainSaveAsTxt 1,2,@StartTime='2017-5-1 00:00:00',@EndTime='2017-05-23 22:00:00',@filePath_name='D:\BHMSDB\',@TxtPath=@TxtPathOutput output
--print @TxtPathOutput

--------------------------------------------------------------------------
--select count(*) from Basic_SteelArchStrainTable 
--select top 10 * from Basic_SteelArchStrainTable
--select top 10 * from Basic_SteelArchStrainTable order by Id desc
--delete Basic_SteelArchStrainTable

------------------------BCP工具命令格式模板-------------------------------------------
--exec master..xp_cmdshell 'bcp BHMSDB.dbo.temp out "D:\健康监测系统开发文件\jtsjyjczx\GxjtBHMS.Web\Content\MontorningDataDownLoad\DownloadData_20170524.txt" -c -q  -t"," -S User-20170213RT\SQLEXPRESS  -U sa -P 123456' 

-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------


----------------------------------数据下载为TXT存储过程----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
----------------------------------基础数据下载存储过程-----------------------------------------
-----------------------------------------------------------------------------------------------
----------------------------------钢拱肋基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicSteelArchStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicSteelArchStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicSteelArchStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0, @MPN9 int=0,@MPN10 int=0,  ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_SteelArchStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Strain,Temperature,"Time",Name 
	into temp 
	from Download_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------钢格构基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicSteelLatticeStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicSteelLatticeStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicSteelLatticeStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_SteelLatticeStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Strain,Temperature,"Time",Name 
	into temp 
	from Download_SteelLatticeStrainTable as Ba         --- ********需要修改需要修改需要修改需要修改********
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelLatticeStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelLatticeStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelLatticeStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
if  @MPN9>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
if  @MPN10>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Download_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------索力基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_Basic_CableForceSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_Basic_CableForceSaveAsTxt]    ---查找是否存在该存储过程，否则删除。********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_Basic_CableForceSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,
@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0, @MPN17 int=0,@MPN18 int=0,
@MPN19 int=0,@MPN20 int=0,@MPN21 int=0,@MPN22 int=0,@MPN23 int=0,@MPN24 int=0,@MPN25 int=0, @MPN26 int=0,@MPN27 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_CableForce',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select CableForce,Frequency,Temperature,"Time",Name 
	into temp 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end
 if  @MPN16>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN16 and "Time" between @StartTime and @EndTime
	end
 if  @MPN17>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN17 and "Time" between @StartTime and @EndTime
	end
 if  @MPN18>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN18 and "Time" between @StartTime and @EndTime
	end
 if  @MPN19>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN19 and "Time" between @StartTime and @EndTime
	end
 if  @MPN20>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN20 and "Time" between @StartTime and @EndTime
	end
 if  @MPN21>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN21 and "Time" between @StartTime and @EndTime
	end
if  @MPN22>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN22 and "Time" between @StartTime and @EndTime
	end
if  @MPN23>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN23 and "Time" between @StartTime and @EndTime
	end
if  @MPN24>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN24 and "Time" between @StartTime and @EndTime
	end
if  @MPN25>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN25 and "Time" between @StartTime and @EndTime
	end
if  @MPN26>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN26 and "Time" between @StartTime and @EndTime
	end
if  @MPN27>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Download_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN27 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------湿度基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicHumiditySaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicHumiditySaveAsTxt]    ---查找是否存在该存储过程，否则删除。********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicHumiditySaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_Humidity',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                             ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Humidity,"Time",Name 
	into temp 
	from Download_HumidityTable as Ba         --- ********需要修改需要修改需要修改需要修改********
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Download_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Download_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Download_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Download_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Download_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Download_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Download_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Download_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Download_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------位移基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicDisplacementSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicDisplacementSaveAsTxt]    ---查找是否存在该存储过程，否则删除。********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicDisplacementSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0, @MPN11 int=0, @MPN12 int=0, @MPN13 int=0, @MPN14 int=0, @MPN15 int=0,  ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_Displacement',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                             ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Displacement,"Time",Name 
	into temp 
	from Download_DisplacementTable as Ba         --- ********需要修改需要修改需要修改需要修改********
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id  
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Download_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO


----------------------------------温度基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicTemperatureSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicTemperatureSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicTemperatureSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_Temperature',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Temperature,"Time",Name 
	into temp 
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
if @MPN9>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
if  @MPN10>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Download_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------风速基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicWindLoadSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicWindLoadSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicWindLoadSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_WindLoad',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select WindSpeed,"Time",Name 
	into temp 
	from Download_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Download_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Download_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id  
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Download_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Download_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------混凝土应变基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicConcreteStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicConcreteStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicConcreteStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0,@MPN17 int=0,@MPN18 int=0,@MPN19 int=0,@MPN20 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_ConcreteStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Strain,Temperature,"Time",Name  
	into temp 
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
if @MPN9>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
if  @MPN10>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end
if  @MPN16>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN16 and "Time" between @StartTime and @EndTime
	end
 if  @MPN17>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN17 and "Time" between @StartTime and @EndTime
	end
 if  @MPN18>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN18 and "Time" between @StartTime and @EndTime
	end
 if  @MPN19>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN19 and "Time" between @StartTime and @EndTime
	end
 if  @MPN20>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Download_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN20 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO



------------------------------------------------------------------------------------------------------------------
----------------------------------特征值数据下载存储过程-----------------------------------------
-----------------------------------------------------------------------------------------------
----------------------------------钢拱肋特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueSteelArchStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueSteelArchStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueSteelArchStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_SteelArchStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------钢格构特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueSteelLatticeStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueSteelLatticeStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueSteelLatticeStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_SteelLatticeStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------混凝土应变特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueConcreteStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueConcreteStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueConcreteStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_ConcreteStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------位移特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueDisplacementSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueDisplacementSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueDisplacementSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,    ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_Displacement',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id  
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------索力特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueCableForceSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueCableForceSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueCableForceSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0,@MPN17 int=0,@MPN18 int=0,@MPN19 int=0,@MPN20 int=0,    ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_CableForce',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end	
 if  @MPN16>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN16 and "Time" between @StartTime and @EndTime
	end	
 if  @MPN17>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN17 and "Time" between @StartTime and @EndTime
	end	
 if  @MPN18>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN18 and "Time" between @StartTime and @EndTime
	end	
 if  @MPN19>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN19 and "Time" between @StartTime and @EndTime
	end	
 if  @MPN20>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN20 and "Time" between @StartTime and @EndTime
	end	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------温度特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueTemperatureSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueTemperatureSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [usp_EigenvalueTemperatureSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_Temperature',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------湿度特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueHumiditySaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueHumiditySaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [usp_EigenvalueHumiditySaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_Humidity',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------风速特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueWindLoadSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueWindLoadSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [usp_EigenvalueWindLoadSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_WindLoad',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_WindLoadEigenvalueTable as EWLET 
	inner join MonitoringPointsNumbers as MPN 
	on EWLET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_WindLoadEigenvalueTable as EWLET 
	inner join MonitoringPointsNumbers as MPN 
	on EWLET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_WindLoadEigenvalueTable as EWLET 
	inner join MonitoringPointsNumbers as MPN 
	on EWLET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
		
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO


------------------------------------------------------------------------------------
--------------------------------------------------------------------------------
---------------------添加索引脚本---------------------------------------------------添加索引脚本------------------------------
---------------------添加索引脚本---------------------------------------------------添加索引脚本------------------------------
---------------------添加索引脚本---------------------------------------------------添加索引脚本------------------------------
---------------------添加索引脚本---------------------------------------------------添加索引脚本------------------------------
---------------------添加索引脚本---------------------------------------------------添加索引脚本------------------------------
---------------------添加索引脚本---------------------------------------------------添加索引脚本------------------------------
---------------------添加索引脚本---------------------------------------------------添加索引脚本------------------------------
---------------------添加索引脚本---------------------------------------------------添加索引脚本------------------------------
---------------------添加索引脚本---------------------------------------------------添加索引脚本------------------------------


------------创建--异常事件表格--的--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('AnomalousEvent_AnomalousEventTable') and name='index_Time')
drop index AnomalousEvent_AnomalousEventTable.index_Time
create nonclustered
index index_Time on AnomalousEvent_AnomalousEventTable(Time)
go


------------创建-基础数据库索力表--的--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Basic_CableForceTable') and name='index_Time')
drop index Basic_CableForceTable.index_Time
create nonclustered
index index_Time on Basic_CableForceTable(Time)
go

------------创建-基础数据库混凝土表--的--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Basic_ConcreteStrainTable') and name='index_Time')
drop index Basic_ConcreteStrainTable.index_Time
create nonclustered
index index_Time on Basic_ConcreteStrainTable(Time)
go

------------创建-基础数据库位移表--的--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Basic_DisplacementTable') and name='index_Time')
drop index Basic_DisplacementTable.index_Time
create nonclustered
index index_Time on Basic_DisplacementTable(Time)
go

------------创建-基础数据库湿度表--的--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Basic_HumidityTable') and name='index_Time')
drop index Basic_HumidityTable.index_Time
create nonclustered
index index_Time on Basic_HumidityTable(Time)
go

------------创建-基础数据库钢拱肋应变表--的--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Basic_SteelArchStrainTable') and name='index_Time')
drop index Basic_SteelArchStrainTable.index_Time
create nonclustered
index index_Time on Basic_SteelArchStrainTable(Time)
go

------------创建-基础数据库钢格构应变表--的--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Basic_SteelLatticeStrainTable') and name='index_Time')
drop index Basic_SteelLatticeStrainTable.index_Time
create nonclustered
index index_Time on Basic_SteelLatticeStrainTable(Time)
go

------------创建-基础数据库温度表--的--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Basic_TemperatureTable') and name='index_Time')
drop index Basic_TemperatureTable.index_Time
create nonclustered
index index_Time on Basic_TemperatureTable(Time)
go

------------创建-基础数据库风速表--的--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Basic_WindLoadTable') and name='index_Time')
drop index Basic_WindLoadTable.index_Time
create nonclustered
index index_Time on Basic_WindLoadTable(Time)
go


------------特征值-------------
------------创建特征值数据库索力表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Eigenvalue_CableForceEigenvalueTable') and name='index_Time')
drop index Eigenvalue_CableForceEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_CableForceEigenvalueTable(Time)
go

------------创建特征值数据库混凝土应变表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Eigenvalue_ConcreteStrainEigenvalueTable') and name='index_Time')
drop index Eigenvalue_ConcreteStrainEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_ConcreteStrainEigenvalueTable(Time)
go

------------创建特征值数据库位移表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Eigenvalue_DisplacementEigenvalueTable') and name='index_Time')
drop index Eigenvalue_DisplacementEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_DisplacementEigenvalueTable(Time)
go

------------创建特征值数据库湿度表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Eigenvalue_HumidityEigenvalueTable') and name='index_Time')
drop index Eigenvalue_HumidityEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_HumidityEigenvalueTable(Time)
go

------------创建特征值数据库钢拱肋应变表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Eigenvalue_SteelArchStrainEigenvalueTable') and name='index_Time')
drop index Eigenvalue_SteelArchStrainEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_SteelArchStrainEigenvalueTable(Time)
go

------------创建特征值数据库钢格构应变表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Eigenvalue_SteelLatticeStrainEigenvalueTable') and name='index_Time')
drop index Eigenvalue_SteelLatticeStrainEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_SteelLatticeStrainEigenvalueTable(Time)
go

------------创建特征值数据库温度变表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Eigenvalue_TemperatureEigenvalueTable') and name='index_Time')
drop index Eigenvalue_TemperatureEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_TemperatureEigenvalueTable(Time)
go

------------创建-基础数据库风速表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('Eigenvalue_WindLoadEigenvalueTable') and name='index_Time')
drop index Eigenvalue_WindLoadEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_WindLoadEigenvalueTable(Time)
go


------------一级安全预警-------------
------------创建一级安全预警数据库索力表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('SafetyPreWarning_CableForceTable') and name='index_Time')
drop index SafetyPreWarning_CableForceTable.index_Time
create nonclustered
index index_Time on SafetyPreWarning_CableForceTable(Time)
go

------------创建一级安全预警数据库位移表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('SafetyPreWarning_DisplacementTable') and name='index_Time')
drop index SafetyPreWarning_DisplacementTable.index_Time
create nonclustered
index index_Time on SafetyPreWarning_DisplacementTable(Time)
go

------------创建一级安全预警数据库应变表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('SafetyPreWarning_StrainTable') and name='index_Time')
drop index SafetyPreWarning_StrainTable.index_Time
create nonclustered
index index_Time on SafetyPreWarning_StrainTable(Time)
go

------------创建一级安全预警数据库温度表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('SafetyPreWarning_TemperatureTable') and name='index_Time')
drop index SafetyPreWarning_TemperatureTable.index_Time
create nonclustered
index index_Time on SafetyPreWarning_TemperatureTable(Time)
go

------------创建一级安全预警数据库风速表--时间--列非聚集索引
if exists(select * from sysindexes where id=object_id('SafetyPreWarning_WindLoadTable') and name='index_Time')
drop index SafetyPreWarning_WindLoadTable.index_Time
create nonclustered
index index_Time on SafetyPreWarning_WindLoadTable(Time)
go

go
------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------处理基础数据表格--------------------------------------------------------
----------------------------------------------------处理基础数据表格--------------------------------------------------------
----------------------------------------------------处理基础数据表格--------------------------------------------------------
----------------------------------------------------处理基础数据表格--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------处理索力基础数据表格-------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DealWithEigenvalue_CableForceEigenvalueTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_DealWithEigenvalue_CableForceEigenvalueTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_DealWithEigenvalue_CableForceEigenvalueTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare @startTime datetime,
	@endTime datetime,
	@currentTime datetime,
	@PointNumberId int,
	@startPointNumberId int=121,
	@endPointNumberId int=158,
	@max float,@min float,@average float
	set @currentTime=GETDATE()
	set @endTime=dateadd(ms,-datepart(ms,@currentTime),dateadd(ss,-datepart(ss,@currentTime),dateadd(mi,-datepart(mi,@currentTime),@currentTime)))
	select @startTime=dateadd(hh,-1,@endTime)
	set @PointNumberId=@startPointNumberId
	while @PointNumberId<=@endPointNumberId
		begin
			select @max=MAX(CableForce) from Basic_CableForceTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @min=MIN(CableForce) from Basic_CableForceTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @average=AVG(CableForce) from Basic_CableForceTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			insert into Eigenvalue_CableForceEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
				values(@max,@min,@average,@startTime,@PointNumberId)
			set @PointNumberId=@PointNumberId+1
		end
	insert into Download_CableForceTable                -------------------------复制基础数据到下载表格
		select CableForce,Frequency,Temperature,ThresholdGradeId,"Time",PointsNumberId 
		from Basic_CableForceTable 
		where "Time"< @EndTime  
	delete Basic_CableForceTable where "Time"< @EndTime  ---------------------------删除基础数据表格数据
END
GO

----------------------------------------------处理混凝土应力基础数据表格-------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DealWithEigenvalue_ConcreteStrainEigenvalueTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_DealWithEigenvalue_ConcreteStrainEigenvalueTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_DealWithEigenvalue_ConcreteStrainEigenvalueTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare @startTime datetime,
	@endTime datetime,
	@currentTime datetime,
	@PointNumberId int,
	@startPointNumberId int=79,
	@endPointNumberId int=94,
	@max float,@min float,@average float
	set @currentTime=GETDATE()
	set @endTime=dateadd(ms,-datepart(ms,@currentTime),dateadd(ss,-datepart(ss,@currentTime),dateadd(mi,-datepart(mi,@currentTime),@currentTime)))
	select @startTime=dateadd(hh,-1,@endTime)
	set @PointNumberId=@startPointNumberId
	while @PointNumberId<=@endPointNumberId
		begin
			select @max=MAX(Strain) from Basic_ConcreteStrainTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @min=MIN(Strain) from Basic_ConcreteStrainTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @average=AVG(Strain) from Basic_ConcreteStrainTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			insert into Eigenvalue_ConcreteStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
				values(@max,@min,@average,@startTime,@PointNumberId)
			set @PointNumberId=@PointNumberId+1
		end
	insert into Download_ConcreteStrainTable                -------------------------复制基础数据到下载表格
		select Strain,Temperature,ThresholdGradeId,"Time",PointsNumberId 
		from Basic_ConcreteStrainTable 
		where "Time"< @EndTime  
	delete Basic_ConcreteStrainTable where "Time"< @EndTime  ---------------------------删除基础数据表格数据
END
GO

----------------------------------------------处理位移基础数据表格-------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DealWithEigenvalue_DisplacementEigenvalueTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_DealWithEigenvalue_DisplacementEigenvalueTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_DealWithEigenvalue_DisplacementEigenvalueTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare @startTime datetime,
	@endTime datetime,
	@currentTime datetime,
	@PointNumberId int,
	@startPointNumberId int=95,
	@endPointNumberId int=120,
	@max float,@min float,@average float
	set @currentTime=GETDATE()
	set @endTime=dateadd(ms,-datepart(ms,@currentTime),dateadd(ss,-datepart(ss,@currentTime),dateadd(mi,-datepart(mi,@currentTime),@currentTime)))
	select @startTime=dateadd(hh,-1,@endTime)
	set @PointNumberId=@startPointNumberId
	while @PointNumberId<=@endPointNumberId
		begin
			select @max=MAX(Displacement) from Basic_DisplacementTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @min=MIN(Displacement) from Basic_DisplacementTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @average=AVG(Displacement) from Basic_DisplacementTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			insert into Eigenvalue_DisplacementEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
				values(@max,@min,@average,@startTime,@PointNumberId)
			set @PointNumberId=@PointNumberId+1
		end
	insert into Download_DisplacementTable                -------------------------复制基础数据到下载表格
		select Displacement,ThresholdGradeId,"Time",PointsNumberId 
		from Basic_DisplacementTable 
		where "Time"< @EndTime  
	delete Basic_DisplacementTable where "Time"< @EndTime  ---------------------------删除基础数据表格数据
END
GO

----------------------------------------------处理湿度基础数据表格-------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DealWithEigenvalue_HumidityEigenvalueTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_DealWithEigenvalue_HumidityEigenvalueTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_DealWithEigenvalue_HumidityEigenvalueTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare @startTime datetime,
	@endTime datetime,
	@currentTime datetime,
	@PointNumberId int,
	@startPointNumberId int=159,
	@endPointNumberId int=167,
	@max float,@min float,@average float
	set @currentTime=GETDATE()
	set @endTime=dateadd(ms,-datepart(ms,@currentTime),dateadd(ss,-datepart(ss,@currentTime),dateadd(mi,-datepart(mi,@currentTime),@currentTime)))
	select @startTime=dateadd(hh,-1,@endTime)
	set @PointNumberId=@startPointNumberId
	while @PointNumberId<=@endPointNumberId
		begin
			select @max=MAX(Humidity) from Basic_HumidityTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @min=MIN(Humidity) from Basic_HumidityTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @average=AVG(Humidity) from Basic_HumidityTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			insert into Eigenvalue_HumidityEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
				values(@max,@min,@average,@startTime,@PointNumberId)
			set @PointNumberId=@PointNumberId+1
		end
	insert into Download_HumidityTable                -------------------------复制基础数据到下载表格
		select Humidity,ThresholdGradeId,"Time",PointsNumberId 
		from Basic_HumidityTable 
		where "Time"< @EndTime  
	delete Basic_HumidityTable where "Time"< @EndTime  ---------------------------删除基础数据表格数据
END
GO

----------------------------------------------处理钢拱肋应变基础数据表格-------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DealWithEigenvalue_SteelArchStrainEigenvalueTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_DealWithEigenvalue_SteelArchStrainEigenvalueTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_DealWithEigenvalue_SteelArchStrainEigenvalueTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare @startTime datetime,
	@endTime datetime,
	@currentTime datetime,
	@PointNumberId int,
	@startPointNumberId int=1,
	@endPointNumberId int=48,
	@max float,@min float,@average float
	set @currentTime=GETDATE()
	set @endTime=dateadd(ms,-datepart(ms,@currentTime),dateadd(ss,-datepart(ss,@currentTime),dateadd(mi,-datepart(mi,@currentTime),@currentTime)))
	select @startTime=dateadd(hh,-1,@endTime)
	set @PointNumberId=@startPointNumberId
	while @PointNumberId<=@endPointNumberId
		begin
			select @max=MAX(Strain) from Basic_SteelArchStrainTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @min=MIN(Strain) from Basic_SteelArchStrainTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @average=AVG(Strain) from Basic_SteelArchStrainTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			insert into Eigenvalue_SteelArchStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
				values(@max,@min,@average,@startTime,@PointNumberId)
			set @PointNumberId=@PointNumberId+1
		end
	insert into Download_SteelArchStrainTable                -------------------------复制基础数据到下载表格
		select Strain,Temperature,ThresholdGradeId,"Time",PointsNumberId 
		from Basic_SteelArchStrainTable 
		where "Time"< @EndTime  
	delete Basic_SteelArchStrainTable where "Time"< @EndTime  ---------------------------删除基础数据表格数据
END
GO

----------------------------------------------处理钢格构应变基础数据表格-------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DealWithEigenvalue_SteelLatticeStrainEigenvalueTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_DealWithEigenvalue_SteelLatticeStrainEigenvalueTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_DealWithEigenvalue_SteelLatticeStrainEigenvalueTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare @startTime datetime,
	@endTime datetime,
	@currentTime datetime,
	@PointNumberId int,
	@startPointNumberId int=49,
	@endPointNumberId int=78,
	@max float,@min float,@average float
	set @currentTime=GETDATE()
	set @endTime=dateadd(ms,-datepart(ms,@currentTime),dateadd(ss,-datepart(ss,@currentTime),dateadd(mi,-datepart(mi,@currentTime),@currentTime)))
	select @startTime=dateadd(hh,-1,@endTime)
	set @PointNumberId=@startPointNumberId
	while @PointNumberId<=@endPointNumberId
		begin
			select @max=MAX(Strain) from Basic_SteelLatticeStrainTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @min=MIN(Strain) from Basic_SteelLatticeStrainTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @average=AVG(Strain) from Basic_SteelLatticeStrainTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			insert into Eigenvalue_SteelLatticeStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
				values(@max,@min,@average,@startTime,@PointNumberId)
			set @PointNumberId=@PointNumberId+1
		end
	insert into Download_SteelLatticeStrainTable                -------------------------复制基础数据到下载表格
		select Strain,Temperature,ThresholdGradeId,"Time",PointsNumberId 
		from Basic_SteelLatticeStrainTable 
		where "Time"< @EndTime  
	delete Basic_SteelLatticeStrainTable where "Time"< @EndTime  ---------------------------删除基础数据表格数据
END
GO


----------------------------------------------处理温度基础数据表格-------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DealWithEigenvalue_TemperatureEigenvalueTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_DealWithEigenvalue_TemperatureEigenvalueTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_DealWithEigenvalue_TemperatureEigenvalueTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare @startTime datetime,
	@endTime datetime,
	@currentTime datetime,
	@PointNumberId int,
	@startPointNumberId int=168,
	@endPointNumberId int=176,
	@max float,@min float,@average float
	set @currentTime=GETDATE()
	set @endTime=dateadd(ms,-datepart(ms,@currentTime),dateadd(ss,-datepart(ss,@currentTime),dateadd(mi,-datepart(mi,@currentTime),@currentTime)))
	select @startTime=dateadd(hh,-1,@endTime)
	set @PointNumberId=@startPointNumberId
	while @PointNumberId<=@endPointNumberId
		begin
			select @max=MAX(Temperature) from Basic_TemperatureTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @min=MIN(Temperature) from Basic_TemperatureTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @average=AVG(Temperature) from Basic_TemperatureTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			insert into Eigenvalue_TemperatureEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
				values(@max,@min,@average,@startTime,@PointNumberId)
			set @PointNumberId=@PointNumberId+1
		end
	insert into Download_TemperatureTable                -------------------------复制基础数据到下载表格
		select Temperature,ThresholdGradeId,"Time",PointsNumberId 
		from Basic_TemperatureTable 
		where "Time"< @EndTime  
	delete Basic_TemperatureTable where "Time"< @EndTime  ---------------------------删除基础数据表格数据
END
GO

----------------------------------------------处理风载基础数据表格-------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DealWithEigenvalue_WindLoadEigenvalueTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_DealWithEigenvalue_WindLoadEigenvalueTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_DealWithEigenvalue_WindLoadEigenvalueTable]   ---创建存储过程
AS
BEGIN
	SET NOCOUNT ON;
	declare @startTime datetime,
	@endTime datetime,
	@currentTime datetime,
	@PointNumberId int,
	@startPointNumberId int=177,
	@endPointNumberId int=177,
	@max float,@min float,@average float
	set @currentTime=GETDATE()
	set @endTime=dateadd(ms,-datepart(ms,@currentTime),dateadd(ss,-datepart(ss,@currentTime),dateadd(mi,-datepart(mi,@currentTime),@currentTime)))
	select @startTime=dateadd(hh,-1,@endTime)
	set @PointNumberId=@startPointNumberId
	while @PointNumberId<=@endPointNumberId
		begin
			select @max=MAX(WindSpeed) from Basic_WindLoadTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @min=MIN(WindSpeed) from Basic_WindLoadTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			select @average=AVG(WindSpeed) from Basic_WindLoadTable 
			where PointsNumberId=@PointNumberId and "Time" >= @startTime and "Time"< @endTime
			insert into Eigenvalue_WindLoadEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
				values(@max,@min,@average,@startTime,@PointNumberId)
			set @PointNumberId=@PointNumberId+1
		end
	insert into Download_WindLoadTable                -------------------------复制基础数据到下载表格
		select WindSpeed,WindDirection,ThresholdGradeId,"Time",PointsNumberId 
		from Basic_WindLoadTable 
		where "Time"< @EndTime  
	delete Basic_WindLoadTable where "Time"< @EndTime  ---------------------------删除基础数据表格数据
END
GO


----------------------------------------------处理基础数据表格的存储过程的存储过程-------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DealWithBasicTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_DealWithBasicTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_DealWithBasicTable]   ---创建一个处理基础数据存储过程的存储过程
AS
BEGIN
	SET NOCOUNT ON;
	exec [dbo].[usp_DealWithEigenvalue_CableForceEigenvalueTable]
	exec [dbo].[usp_DealWithEigenvalue_ConcreteStrainEigenvalueTable]
	exec [dbo].[usp_DealWithEigenvalue_DisplacementEigenvalueTable]
	exec [dbo].[usp_DealWithEigenvalue_HumidityEigenvalueTable]
	exec [dbo].[usp_DealWithEigenvalue_SteelArchStrainEigenvalueTable]
	exec [dbo].[usp_DealWithEigenvalue_SteelLatticeStrainEigenvalueTable]
	exec [dbo].[usp_DealWithEigenvalue_TemperatureEigenvalueTable]
	exec [dbo].[usp_DealWithEigenvalue_WindLoadEigenvalueTable]
END
GO


GO
-- =============================================
-- Author:		<Author,houp>
-- Create date: <Create Date,2017-6-14,>
-- Description:	<作业每小时执行删除的存储过程>
-- =============================================
--------------------------------------------------------------------------------------------
--------------------------删除原始数据--------------------------------------------
--------------------------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DeleteOriginalDataTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_DeleteOriginalDataTable]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_DeleteOriginalDataTable]   ---创建删除原始数据表格存储过程
AS
BEGIN
	SET NOCOUNT ON;
	 delete from [dbo].[Original_CableForceTable]  WHERE  datepart(hh,"Time")<datepart(hh,GETDATE()) or datepart(dd,"Time")<datepart(dd,getdate())
	 delete from [dbo].[Original_ConcreteStrainTable]  WHERE datepart(hh,"Time")<datepart(hh,GETDATE()) or datepart(dd,"Time")<=datepart(dd,getdate())
	 delete from [dbo].[Original_DisplacementTable]  WHERE datepart(hh,"Time")<datepart(hh,GETDATE()) or datepart(dd,"Time")<=datepart(dd,getdate())
	 delete from [dbo].[Original_HumidityTable]  WHERE datepart(hh,"Time")<datepart(hh,GETDATE()) or datepart(dd,"Time")<=datepart(dd,getdate())
	 delete from [dbo].[Original_SteelArchStrainTable]  WHERE datepart(hh,"Time")<datepart(hh,GETDATE()) or datepart(dd,"Time")<=datepart(dd,getdate())
	 delete from [dbo].[Original_SteelLatticeStrainTable]  WHERE datepart(hh,"Time")<datepart(hh,GETDATE()) or datepart(dd,"Time")<=datepart(dd,getdate())
	 delete from [dbo].[Original_TemperatureTable]  WHERE datepart(hh,"Time")<datepart(hh,GETDATE()) or datepart(dd,"Time")<=datepart(dd,getdate())
	 delete from [dbo].[Original_WindLoadTable]  WHERE datepart(hh,"Time")<datepart(hh,GETDATE()) or datepart(dd,"Time")<=datepart(dd,getdate())
	END
GO



-----------------------------------------------------------安全预警存储过程------------------------------------------------------------------------
-----------------------------------------------------------安全预警存储过程------------------------------------------------------------------------
-----------------------------------------------------------安全预警存储过程------------------------------------------------------------------------
-----------------------------------------------------------安全预警存储过程------------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_SafetyWarningRealTimeSearch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_SafetyWarningRealTimeSearch]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_SafetyWarningRealTimeSearch]   ---安全预警实时推送
@preFirstAssessmentReportTime datetime output,  ---前次报告时间
@totalSafetyWarningResult nvarchar(max) output,
@totalSafetyWarningColor nvarchar(max) output,
@cableForceSafetyWarningResult nvarchar(max) output,
@cableForceSafetyWarningColor nvarchar(max) output,
@cableForceRedWarningTimes int output,
@cableForceYellowWarningTimes int output,

@displacementSafetyWarningResult nvarchar(max) output,
@displacementSafetyWarningColor nvarchar(max) output,
@displacementRedWarningTimes int output,
@displacementYellowWarningTimes int output,

@windLoadSafetyWarningResult nvarchar(max) output,
@windLoadSafetyWarningColor nvarchar(max) output,
@windLoadRedWarningTimes int output,
@windLoadYellowWarningTimes int output,

@temperatureSafetyWarningResult nvarchar(max) output,
@temperatureSafetyWarningColor nvarchar(max) output,
@temperatureRedWarningTimes int output,
@temperatureYellowWarningTimes int output
AS
declare @maxId int,@CurrentTime datetime=getdate(),@DifTime datetime,@SafetyWarningTime datetime,@TotalThresholdGradeId int,
@CableForceThresholdGradeId int,@DisplacementThresholdGradeId int,@WindLoadThresholdGradeId int,@TemperatureThresholdGradeId int

BEGIN
	SET NOCOUNT ON;
	select @maxId=MAX(Id) from FirstAssessment_FirstLevelSafetyAssessmentReportTable
	select @preFirstAssessmentReportTime= ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable where Id=@maxId	
	set @TotalThresholdGradeId=1
	-----------------索力预警-----------------------
	select @maxId=MAX(Id) from SafetyPreWarning_CableForceTable
	select @SafetyWarningTime=Time	from SafetyPreWarning_CableForceTable where Id=@maxId	
	select @DifTime=DATEDIFF(SS,@SafetyWarningTime,@CurrentTime) from SafetyPreWarning_CableForceTable where Id=@maxId
	if (select count(*) from SafetyPreWarning_CableForceTable)=0
		begin
		select @WindLoadThresholdGradeId=1
		select @windLoadSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@WindLoadThresholdGradeId
		select @windLoadSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@WindLoadThresholdGradeId		
		end
	if @DifTime<30
		begin
		select @CableForceThresholdGradeId=ThresholdGradeId from SafetyPreWarning_CableForceTable where Id=@maxId	
		select @cableForceSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@CableForceThresholdGradeId
		select @cableForceSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@CableForceThresholdGradeId		
		end
	else
		begin
		select @CableForceThresholdGradeId=1
		select @cableForceSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@CableForceThresholdGradeId
		select @cableForceSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@CableForceThresholdGradeId		
		end
	select @cableForceRedWarningTimes=count(*) from SafetyPreWarning_CableForceTable 
		where ThresholdGradeId=3 and ("Time" between @preFirstAssessmentReportTime and @CurrentTime)
	select @cableForceYellowWarningTimes=count(*) from SafetyPreWarning_CableForceTable 
		where ThresholdGradeId=2 and ("Time" between @preFirstAssessmentReportTime and @CurrentTime)
	if @TotalThresholdGradeId<@CableForceThresholdGradeId
	set @TotalThresholdGradeId=@CableForceThresholdGradeId

	-----------------位移预警-----------------------
	select @maxId=MAX(Id) from SafetyPreWarning_DisplacementTable
	select @SafetyWarningTime=Time	from SafetyPreWarning_DisplacementTable where Id=@maxId	
	select @DifTime=DATEDIFF(SS,@SafetyWarningTime,@CurrentTime) from SafetyPreWarning_DisplacementTable where Id=@maxId
	if (select count(*) from SafetyPreWarning_DisplacementTable)=0
		begin
		select @WindLoadThresholdGradeId=1
		select @windLoadSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@WindLoadThresholdGradeId
		select @windLoadSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@WindLoadThresholdGradeId		
		end
	if @DifTime<30
		begin
		select @DisplacementThresholdGradeId=ThresholdGradeId from SafetyPreWarning_DisplacementTable where Id=@maxId	
		select @displacementSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@DisplacementThresholdGradeId
		select @displacementSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@DisplacementThresholdGradeId		
		end
	else
		begin
		select @DisplacementThresholdGradeId=1
		select @displacementSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@DisplacementThresholdGradeId
		select @displacementSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@DisplacementThresholdGradeId		
		end
	select @displacementRedWarningTimes=count(*) from SafetyPreWarning_DisplacementTable 
		where ThresholdGradeId=3 and ("Time" between @preFirstAssessmentReportTime and @CurrentTime)
	select @displacementYellowWarningTimes=count(*) from SafetyPreWarning_DisplacementTable 
		where ThresholdGradeId=2 and ("Time" between @preFirstAssessmentReportTime and @CurrentTime)
	if @TotalThresholdGradeId<@DisplacementThresholdGradeId
	set @TotalThresholdGradeId=@DisplacementThresholdGradeId

	-----------------风速预警-----------------------
	select @maxId=MAX(Id) from SafetyPreWarning_WindLoadTable
	select @SafetyWarningTime=Time	from SafetyPreWarning_WindLoadTable where Id=@maxId	
	select @DifTime=DATEDIFF(SS,@SafetyWarningTime,@CurrentTime) from SafetyPreWarning_WindLoadTable where Id=@maxId
	if (select count(*) from SafetyPreWarning_WindLoadTable)=0
		begin
		select @WindLoadThresholdGradeId=1
		select @windLoadSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@WindLoadThresholdGradeId
		select @windLoadSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@WindLoadThresholdGradeId		
		end
	if @DifTime<30
		begin
		select @WindLoadThresholdGradeId=ThresholdGradeId from SafetyPreWarning_WindLoadTable where Id=@maxId	
		select @windLoadSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@WindLoadThresholdGradeId
		select @windLoadSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@WindLoadThresholdGradeId		
		end
	else
		begin
		select @WindLoadThresholdGradeId=1
		select @windLoadSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@WindLoadThresholdGradeId
		select @windLoadSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@WindLoadThresholdGradeId		
		end
	select @windLoadRedWarningTimes=count(*) from SafetyPreWarning_WindLoadTable 
		where ThresholdGradeId=3 and ("Time" between @preFirstAssessmentReportTime and @CurrentTime)
	select @windLoadYellowWarningTimes=count(*) from SafetyPreWarning_WindLoadTable 
		where ThresholdGradeId=2 and ("Time" between @preFirstAssessmentReportTime and @CurrentTime)
	if @TotalThresholdGradeId<@WindLoadThresholdGradeId
	set @TotalThresholdGradeId=@WindLoadThresholdGradeId

			-----------------温度预警-----------------------
	select @maxId=MAX(Id) from SafetyPreWarning_TemperatureTable
	select @SafetyWarningTime=Time	from SafetyPreWarning_TemperatureTable where Id=@maxId	
	select @DifTime=DATEDIFF(SS,@SafetyWarningTime,@CurrentTime) from SafetyPreWarning_TemperatureTable where Id=@maxId
	if (select count(*) from SafetyPreWarning_TemperatureTable)=0
		begin
		select @WindLoadThresholdGradeId=1
		select @windLoadSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@WindLoadThresholdGradeId
		select @windLoadSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@WindLoadThresholdGradeId		
		end
	if @DifTime<30
		begin
		select @TemperatureThresholdGradeId=ThresholdGradeId from SafetyPreWarning_TemperatureTable where Id=@maxId	
		select @temperatureSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@TemperatureThresholdGradeId
		select @temperatureSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@TemperatureThresholdGradeId		
		end
	else
		begin
		select @TemperatureThresholdGradeId=1
		select @temperatureSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@TemperatureThresholdGradeId
		select @temperatureSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@TemperatureThresholdGradeId		
		end
	select @temperatureRedWarningTimes=count(*) from SafetyPreWarning_TemperatureTable 
		where ThresholdGradeId=3 and ("Time" between @preFirstAssessmentReportTime and @CurrentTime)
	select @temperatureYellowWarningTimes=count(*) from SafetyPreWarning_TemperatureTable 
		where ThresholdGradeId=2 and ("Time" between @preFirstAssessmentReportTime and @CurrentTime)
	if @TotalThresholdGradeId<@temperatureRedWarningTimes
	set @TotalThresholdGradeId=@temperatureRedWarningTimes
			-----------------总体-----------------------
	select @totalSafetyWarningResult=ThresholdGrade from ThresholdGradeTables where Id=@TotalThresholdGradeId
	select @totalSafetyWarningColor=ThresholdColor from ThresholdGradeTables where Id=@TotalThresholdGradeId
END
GO

-------------------------------------------测试预警实时推送的代码-------------------------------------------------------------------------
--declare
--@preFirstAssessmentReportTime datetime,  ---前次报告时间
--@totalSafetyWarningResult nvarchar(max),
--@totalSafetyWarningColor nvarchar(max),
--@cableForceSafetyWarningResult nvarchar(max),
--@cableForceSafetyWarningColor nvarchar(max),
--@cableForceRedWarningTimes int,
--@cableForceYellowWarningTimes int,

--@displacementSafetyWarningResult nvarchar(max),
--@displacementSafetyWarningColor nvarchar(max),
--@displacementRedWarningTimes int,
--@displacementYellowWarningTimes int,

--@windLoadSafetyWarningResult nvarchar(max),
--@windLoadSafetyWarningColor nvarchar(max),
--@windLoadRedWarningTimes int ,
--@windLoadYellowWarningTimes int,

--@temperatureSafetyWarningResult nvarchar(max),
--@temperatureSafetyWarningColor nvarchar(max),
--@temperatureRedWarningTimes int,
--@temperatureYellowWarningTimes int

--exec usp_SafetyWarningRealTimeSearch @preFirstAssessmentReportTime=@preFirstAssessmentReportTime output,@totalSafetyWarningResult=@totalSafetyWarningResult output,@totalSafetyWarningColor=@totalSafetyWarningColor output,@cableForceSafetyWarningResult=@cableForceSafetyWarningResult output,@cableForceSafetyWarningColor=@cableForceSafetyWarningColor output,@cableForceRedWarningTimes=@cableForceRedWarningTimes output,@cableForceYellowWarningTimes=@cableForceYellowWarningTimes output,@displacementSafetyWarningResult=@displacementSafetyWarningResult output,@displacementSafetyWarningColor=@displacementSafetyWarningColor output,@displacementRedWarningTimes=@displacementRedWarningTimes output,@displacementYellowWarningTimes=@displacementYellowWarningTimes output,@windLoadSafetyWarningResult=@windLoadSafetyWarningResult output,@windLoadSafetyWarningColor=@windLoadSafetyWarningColor output,@windLoadRedWarningTimes=@windLoadRedWarningTimes output,@windLoadYellowWarningTimes=@windLoadYellowWarningTimes output,@temperatureSafetyWarningResult=@temperatureSafetyWarningResult output,@temperatureSafetyWarningColor=@temperatureSafetyWarningColor output,@temperatureRedWarningTimes=@temperatureRedWarningTimes output,@temperatureYellowWarningTimes=@temperatureYellowWarningTimes output


--print @windLoadSafetyWarningColor
--print @windLoadSafetyWarningResult
--print @temperatureSafetyWarningResult
--print @temperatureSafetyWarningColor
--print @cableForceRedWarningTimes
--print @cableForceYellowWarningTimes
--print @displacementRedWarningTimes
--print @displacementYellowWarningTimes
--print @windLoadRedWarningTimes
--print @windLoadYellowWarningTimes
--print @temperatureRedWarningTimes
--print @temperatureYellowWarningTimes