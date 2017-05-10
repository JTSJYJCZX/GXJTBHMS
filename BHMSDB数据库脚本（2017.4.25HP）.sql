use BHMSDB
GO
-----------------------------原始数据转到基础数据--------------------------------------

-------------索力--------------------------------------
if(OBJECT_ID('tgr_Original_CableForce','TR') is not null)
drop trigger tgr_Original_CableForce
go
create trigger tgr_Original_CableForce
on Original_CableForceTable
for insert
as
set nocount on
declare @CableForce float,@Frequency float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @CableForce=CableForce from inserted
select @Frequency=Frequency from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
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
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
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
declare @displacement float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @displacement=Displacement from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
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
declare @humidity float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @humidity=Humidity from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
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
declare @temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
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
declare @windSpeed float,@WindDirection float, @Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @windSpeed=WindSpeed from inserted
select @WindDirection=WindDirection from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
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
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
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
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
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
go



-----------------------------------------------------------------------------------------
-----------------------------原始数据转到特征值数据--------------------------------------
-----------------------------------------------------------------------------------------


-------------索力基础数据转到特征值数据表---------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_CableForceTable','TR') is not null)
drop trigger tgr_Basic_EigenValue_CableForceTable
go
create trigger tgr_Basic_EigenValue_CableForceTable
on Basic_CableForceTable
for insert
as
set nocount on
declare @max float,@min float,@average int,@pointsNumberId int,@insertTime datetime,
@preInsertTime datetime,@startTime datetime,@endTime datetime,
@insertHourTime datetime,@preInsertHourTime datetime

select @insertTime="Time" from inserted
select @pointsNumberId=PointsNumberId from inserted
select top 1 @preInsertTime = "Time" from(
	select top 2 "Time" from Basic_CableForceTable where PointsNumberId=@pointsNumberId order by "Time" desc ) as a
	order by a.Time  

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_CableForceTable where PointsNumberId=@pointsNumberId)=1)
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(CableForce) from Basic_CableForceTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(CableForce) from Basic_CableForceTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(CableForce) from Basic_CableForceTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_CableForceEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(CableForce) from Basic_CableForceTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(CableForce) from Basic_CableForceTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(CableForce) from Basic_CableForceTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_CableForceEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)
end
go


-------------------位移基础数据转到特征值数据表------------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_DisplacementTable','TR') is not null)
drop trigger tgr_Basic_EigenValue_DisplacementTable
go
create trigger tgr_Basic_EigenValue_DisplacementTable
on Basic_DisplacementTable
for insert
as
set nocount on
declare @max float,@min float,@average int,@pointsNumberId int,@insertTime datetime,
@preInsertTime datetime,@startTime datetime,@endTime datetime,
@insertHourTime datetime,@preInsertHourTime datetime

select @insertTime="Time" from inserted
select @pointsNumberId=PointsNumberId from inserted
select top 1 @preInsertTime = "Time" from(
	select top 2 "Time" from Basic_DisplacementTable where PointsNumberId=@pointsNumberId order by "Time" desc ) as a
	order by a.Time  

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_DisplacementTable where PointsNumberId=@pointsNumberId)=1)
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Displacement) from Basic_DisplacementTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Displacement) from Basic_DisplacementTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Displacement) from Basic_DisplacementTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_DisplacementEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Displacement) from Basic_DisplacementTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Displacement) from Basic_DisplacementTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Displacement) from Basic_DisplacementTable 
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_DisplacementEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)
end
go





--------------------------混凝土应变基础数据转到特征值数据表--------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_ConcreteStrainTable','TR') is not null)           --改名字
drop trigger tgr_Basic_EigenValue_ConcreteStrainTable              --改名字
go
create trigger tgr_Basic_EigenValue_ConcreteStrainTable     --改名字
on Basic_ConcreteStrainTable   --替换基础数据表格
for insert
as
set nocount on
declare @max float,@min float,@average int,@pointsNumberId int,@insertTime datetime,
@preInsertTime datetime,@startTime datetime,@endTime datetime,
@insertHourTime datetime,@preInsertHourTime datetime

select @insertTime="Time" from inserted
select @pointsNumberId=PointsNumberId from inserted
select top 1 @preInsertTime = "Time" from(
	select top 2 "Time" from Basic_ConcreteStrainTable where PointsNumberId=@pointsNumberId order by "Time" desc ) as a
	order by a.Time             --替换基础数据表格

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_ConcreteStrainTable where PointsNumberId=@pointsNumberId)=1)      --替换基础数据表格
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Strain) from Basic_ConcreteStrainTable              --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_ConcreteStrainTable                --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_ConcreteStrainTable             --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_ConcreteStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --替换阈值表格
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Strain) from Basic_ConcreteStrainTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_ConcreteStrainTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_ConcreteStrainTable                 --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_ConcreteStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --替换阈值表格
end
go


-------------------------------湿度基础数据转到特征值数据表------------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_HumidityTable','TR') is not null)           --改名字
drop trigger tgr_Basic_EigenValue_HumidityTable              --改名字
go
create trigger tgr_Basic_EigenValue_HumidityTable     --改名字
on Basic_HumidityTable   --替换基础数据表格
for insert
as
set nocount on
declare @max float,@min float,@average int,@pointsNumberId int,@insertTime datetime,
@preInsertTime datetime,@startTime datetime,@endTime datetime,
@insertHourTime datetime,@preInsertHourTime datetime

select @insertTime="Time" from inserted
select @pointsNumberId=PointsNumberId from inserted
select top 1 @preInsertTime = "Time" from(
	select top 2 "Time" from Basic_HumidityTable where PointsNumberId=@pointsNumberId order by "Time" desc ) as a
	order by a.Time             --替换基础数据表格

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_HumidityTable where PointsNumberId=@pointsNumberId)=1)      --替换基础数据表格
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Humidity) from Basic_HumidityTable              --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Humidity) from Basic_HumidityTable                --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Humidity) from Basic_HumidityTable             --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_HumidityEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --替换阈值表格
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Humidity) from Basic_HumidityTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Humidity) from Basic_HumidityTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Humidity) from Basic_HumidityTable                 --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_HumidityEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --替换阈值表格
end
go

-----------------拱箱拱应变基础数据转到特征值数据表--------------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_SteelArchStrainTable','TR') is not null)           --改名字
drop trigger tgr_Basic_EigenValue_SteelArchStrainTable              --改名字
go
create trigger tgr_Basic_EigenValue_SteelArchStrainTable     --改名字
on Basic_SteelArchStrainTable   --替换基础数据表格
for insert
as
set nocount on
declare @max float,@min float,@average int,@pointsNumberId int,@insertTime datetime,
@preInsertTime datetime,@startTime datetime,@endTime datetime,
@insertHourTime datetime,@preInsertHourTime datetime

select @insertTime="Time" from inserted
select @pointsNumberId=PointsNumberId from inserted
select top 1 @preInsertTime = "Time" from(
	select top 2 "Time" from Basic_SteelArchStrainTable where PointsNumberId=@pointsNumberId order by "Time" desc ) as a
	order by a.Time             --替换基础数据表格

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_SteelArchStrainTable where PointsNumberId=@pointsNumberId)=1)      --替换基础数据表格
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Strain) from Basic_SteelArchStrainTable              --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_SteelArchStrainTable                --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_SteelArchStrainTable             --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_SteelArchStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --替换阈值表格
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Strain) from Basic_SteelArchStrainTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_SteelArchStrainTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_SteelArchStrainTable                 --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_SteelArchStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --替换阈值表格
end
go


-----------------------钢格构应变基础数据转到特征值数据表----------------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_SteelLatticeStrainTable','TR') is not null)           --改名字
drop trigger tgr_Basic_EigenValue_SteelLatticeStrainTable              --改名字
go
create trigger tgr_Basic_EigenValue_SteelLatticeStrainTable     --改名字
on Basic_SteelLatticeStrainTable   --替换基础数据表格
for insert
as
set nocount on
declare @max float,@min float,@average int,@pointsNumberId int,@insertTime datetime,
@preInsertTime datetime,@startTime datetime,@endTime datetime,
@insertHourTime datetime,@preInsertHourTime datetime

select @insertTime="Time" from inserted
select @pointsNumberId=PointsNumberId from inserted
select top 1 @preInsertTime = "Time" from(
	select top 2 "Time" from Basic_SteelLatticeStrainTable where PointsNumberId=@pointsNumberId order by "Time" desc ) as a
	order by a.Time             --替换基础数据表格

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_SteelLatticeStrainTable where PointsNumberId=@pointsNumberId)=1)      --替换基础数据表格
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Strain) from Basic_SteelLatticeStrainTable              --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_SteelLatticeStrainTable                --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_SteelLatticeStrainTable             --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_SteelLatticeStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --替换阈值表格
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Strain) from Basic_SteelLatticeStrainTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_SteelLatticeStrainTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_SteelLatticeStrainTable                 --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_SteelLatticeStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --替换阈值表格
end
go

---------------------温度基础数据转到特征值数据表-------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_TemperatureTable','TR') is not null)           --改名字
drop trigger tgr_Basic_EigenValue_TemperatureTable              --改名字
go
create trigger tgr_Basic_EigenValue_TemperatureTable     --改名字
on Basic_TemperatureTable   --替换基础数据表格
for insert
as
set nocount on
declare @max float,@min float,@average int,@pointsNumberId int,@insertTime datetime,
@preInsertTime datetime,@startTime datetime,@endTime datetime,
@insertHourTime datetime,@preInsertHourTime datetime

select @insertTime="Time" from inserted
select @pointsNumberId=PointsNumberId from inserted
select top 1 @preInsertTime = "Time" from(
	select top 2 "Time" from Basic_TemperatureTable where PointsNumberId=@pointsNumberId order by "Time" desc ) as a
	order by a.Time             --替换基础数据表格

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_TemperatureTable where PointsNumberId=@pointsNumberId)=1)      --替换基础数据表格
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Temperature) from Basic_TemperatureTable              --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Temperature) from Basic_TemperatureTable                --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Temperature) from Basic_TemperatureTable             --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_TemperatureEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --替换阈值表格
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Temperature) from Basic_TemperatureTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Temperature) from Basic_TemperatureTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Temperature) from Basic_TemperatureTable                 --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_TemperatureEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --替换阈值表格
end
go

---------------------------------风速基础数据转到特征值数据表-------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_WindLoadTable','TR') is not null)           --改名字
drop trigger tgr_Basic_EigenValue_WindLoadTable              --改名字
go
create trigger tgr_Basic_EigenValue_WindLoadTable     --改名字
on Basic_WindLoadTable   --替换基础数据表格
for insert
as
set nocount on
declare @max float,@min float,@average int,@pointsNumberId int,@insertTime datetime,
@preInsertTime datetime,@startTime datetime,@endTime datetime,
@insertHourTime datetime,@preInsertHourTime datetime

select @insertTime="Time" from inserted
select @pointsNumberId=PointsNumberId from inserted
select top 1 @preInsertTime = "Time" from(
	select top 2 "Time" from Basic_WindLoadTable where PointsNumberId=@pointsNumberId order by "Time" desc ) as a
	order by a.Time             --替换基础数据表格

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_WindLoadTable where PointsNumberId=@pointsNumberId)=1)      --替换基础数据表格
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(WindSpeed) from Basic_WindLoadTable              --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(WindSpeed) from Basic_WindLoadTable                --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(WindSpeed) from Basic_WindLoadTable             --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_WindLoadEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --替换阈值表格
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(WindSpeed) from Basic_WindLoadTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(WindSpeed) from Basic_WindLoadTable                     --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(WindSpeed) from Basic_WindLoadTable                 --替换测试类型和表格
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_WindLoadEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --替换阈值表格
end
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
declare @CableForce float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@ThresholdValue float
select @CableForce=CableForce from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

if @ThresholdGradeId=3
	begin
    select @ThresholdValue=PositiveSecondLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId
    insert into SafetyPreWarning_CableForceTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@CableForce,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
	end
if @ThresholdGradeId=2
	begin
	select @ThresholdValue=PositiveFirstLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId
	insert into SafetyPreWarning_CableForceTable (MonitoringData,"Time",PointsNumberId,ThresholdGradeId,ThresholdValue)
values(@CableForce,@Time,@PointsNumberId,@ThresholdGradeId,@ThresholdValue)
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
declare @Displacement float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@ThresholdValue float
select @Displacement=Displacement from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

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
-----------------------------安全一级评估相关脚本（由特征值触发）------------------------
-----------------------------------------------------------------------------------------

--由特征值索力表格触发生成一级评估报告表,3种情况,(1)首期报告;(2)红色预警触发报告;(3)常规月报
if(OBJECT_ID('tgr_Eigenvalue_CableForceEigenvalueTableForAssessment','TR') is not null)
drop trigger tgr_Eigenvalue_CableForceEigenvalueTableForAssessment
go
create trigger tgr_Eigenvalue_CableForceEigenvalueTableForAssessment
on Eigenvalue_CableForceEigenvalueTable
for insert
as
set nocount on
declare @PointsNumberId int,@ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ThresholdGradeId int,@MaxEigenvalue float,
@PreReportTime datetime,@ReportTimeYear int,@PreReportTimeYear int,@ReportId int,@ReportIdDiff int,@InsertTime datetime
select @MaxEigenvalue="Max" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=
case 
	when @MaxEigenvalue>=(select PositiveSecondLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId)
     then 3
    when @MaxEigenvalue>=(select PositiveFirstLevelThresholdValue from ThresholdValue_CableForceThresholdValueTable where PointsNumberId=@PointsNumberId)
    then 2
	else 1
end
select @InsertTime=dateadd(hh,1,"Time") from inserted

--首期报告:Eigenvalue_CableForceEigenvalueTable首条记录插入，且不存在评估报告时，开始首期评估
if (select count(*) from Eigenvalue_CableForceEigenvalueTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime=dateadd(hh,1,"Time") from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
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
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第'+convert(varchar(50),@ReportIdDiff+2)+'期'
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
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go

-------------------------------------------------------------------------------------------------------------------------
--由特征值位移表格触发生成一级评估报告表,3种情况,(1)首期报告;(2)红色预警触发报告;(3)常规月报
if(OBJECT_ID('tgr_Eigenvalue_DisplacementEigenvalueTableForAssessment','TR') is not null)
drop trigger tgr_Eigenvalue_DisplacementEigenvalueTableForAssessment
go
create trigger tgr_Eigenvalue_DisplacementEigenvalueTableForAssessment
on Eigenvalue_DisplacementEigenvalueTable
for insert
as
set nocount on
declare @PointsNumberId int,@ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ThresholdGradeId int,@MaxEigenvalue float,
@PreReportTime datetime,@ReportTimeYear int,@PreReportTimeYear int,@ReportId int,@ReportIdDiff int,@InsertTime datetime
select @MaxEigenvalue="Max" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=
case 
	when @MaxEigenvalue>=(select PositiveSecondLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId)
     then 3
    when @MaxEigenvalue>=(select PositiveFirstLevelThresholdValue from ThresholdValue_DisplacementThresholdValueTable where PointsNumberId=@PointsNumberId)
    then 2
	else 1
end
select @InsertTime=dateadd(hh,1,"Time") from inserted

--首期报告:Eigenvalue_DisplacementEigenvalueTable首条记录插入，且不存在评估报告时，开始首期评估
if (select count(*) from Eigenvalue_DisplacementEigenvalueTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime=dateadd(hh,1,"Time") from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
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
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第'+convert(varchar(50),@ReportIdDiff+2)+'期'
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
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go

-------------------------------------------------------------------------------------------------------------------------
--由特征值温度表格触发生成一级评估报告表,3种情况,(1)首期报告;(2)红色预警触发报告;(3)常规月报
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

--首期报告:Eigenvalue_TemperatureEigenvalueTable首条记录插入，且不存在评估报告时，开始首期评估
if (select count(*) from Eigenvalue_TemperatureEigenvalueTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime=dateadd(hh,1,"Time") from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
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
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第'+convert(varchar(50),@ReportIdDiff+2)+'期'
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
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第'+convert(varchar(50),@ReportIdDiff+2)+'期'
			end
		--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go

-------------------------------------------------------------------------------------------------------------------------
--由特征值湿度表格触发生成一级评估报告表,3种情况,(1)首期报告;(2)红色预警触发报告;(3)常规月报
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

--首期报告:Eigenvalue_HumidityEigenvalueTable首条记录插入，且不存在评估报告时，开始首期评估
if (select count(*) from Eigenvalue_HumidityEigenvalueTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime=dateadd(hh,1,"Time") from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
	--根据参数值，向FirstAssessment_FirstLevelSafetyAssessmentReportTable添加记录 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
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
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第'+convert(varchar(50),@ReportIdDiff+2)+'期'
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
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			end
		--跨年度评估时，确定评估期数 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第1期'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'第'+convert(varchar(50),@ReportIdDiff+2)+'期'
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
declare @CableForceAssessmentResult varchar(50),@CableForceAssessmentSuggestion varchar(50)
declare @StrainAssessmentResult varchar(50),@StrainAssessmentSuggestion varchar(50)
declare @DisplacementAssessmentResult varchar(50),@DisplacementAssessmentSuggestion varchar(50)

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