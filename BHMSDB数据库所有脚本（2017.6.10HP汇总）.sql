use BHMSDB
GO
-----------------------------ԭʼ����ת����������-------------------------------------------------------------------ԭʼ����ת����������--------------------------------------
-----------------------------ԭʼ����ת����������-------------------------------------------------------------------ԭʼ����ת����������--------------------------------------
-----------------------------ԭʼ����ת����������-------------------------------------------------------------------ԭʼ����ת����������--------------------------------------
-----------------------------ԭʼ����ת����������-------------------------------------------------------------------ԭʼ����ת����������--------------------------------------

-------------����--------------------------------------
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
---�ϲ���˵��쳣��ֵId=3
if @PointsNumberId between 121 and 138
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=3
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=3
	if @CableForce>@AnomalousEventThresholdValueMax or @CableForce<@AnomalousEventThresholdValueMin 
	return
end
---�²���˵��쳣��ֵId=4
if @PointsNumberId between 139 and 146
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=4
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=4
	if @CableForce>@AnomalousEventThresholdValueMax or @CableForce<@AnomalousEventThresholdValueMin 
	return
end
---����ϵ�˵��쳣��ֵId=5
if @PointsNumberId between 147 and 158
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=5
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=5
	if @CableForce>@AnomalousEventThresholdValueMax or @CableForce<@AnomalousEventThresholdValueMin 
	return
end
---û���쳣������ж�Ԥ���ȼ���洢���������ݿ�
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


--------------------������Ӧ��----------------------------
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
---���������쳣��ֵId=2
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=2
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=2
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
return
---û���쳣������ж�Ԥ���ȼ���洢���������ݿ�
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


---------------------------------λ��-------------------------------------
if(OBJECT_ID('tgr_Original_DisplacementTable','TR') is not null)
drop trigger tgr_Original_DisplacementTable
go
create trigger tgr_Original_DisplacementTable
on Original_DisplacementTable     --�������
for insert
as
set nocount on
declare @displacement float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @displacement=Displacement from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---�ֹ���X�����쳣��ֵId=9
if @PointsNumberId between 95 and 98
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=9
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=9
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---�ֹ���Y�����쳣��ֵId=10
if @PointsNumberId between 99 and 102
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=10
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=10
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---�ֹ���Z�����쳣��ֵId=11
if @PointsNumberId between 103 and 106
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=11
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=11
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---�����Ӷ��쳣��ֵId=12
if @PointsNumberId between 107 and 112
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=12
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=12
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---���ɶձ����쳣��ֵId=13
if @PointsNumberId between 113 and 116
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=13
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=13
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---����������쳣��ֵId=14
if @PointsNumberId between 117 and 120
begin
	select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=14
	select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=14
	if @Displacement>@AnomalousEventThresholdValueMax or @Displacement<@AnomalousEventThresholdValueMin 
	return
end
---û���쳣������ж�Ԥ���ȼ���洢���������ݿ�
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

---------------------------------ʪ��-------------------------------------
if(OBJECT_ID('tgr_Original_HumidityTable','TR') is not null)
drop trigger tgr_Original_HumidityTable
go
create trigger tgr_Original_HumidityTable
on Original_HumidityTable    --�������
for insert
as
set nocount on
declare @humidity float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @humidity=Humidity from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---ʪ�ȵ��쳣��ֵId=7
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=7
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=7
if @Humidity>@AnomalousEventThresholdValueMax or @Humidity<@AnomalousEventThresholdValueMin 
return
---û���쳣������ж�Ԥ���ȼ���洢���������ݿ�
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


----------------------------------�¶�----------------------------------
if(OBJECT_ID('tgr_Original_TemperatureTable','TR') is not null)
drop trigger tgr_Original_TemperatureTable
go
create trigger tgr_Original_TemperatureTable
on Original_TemperatureTable    --�������
for insert
as
set nocount on
declare @temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---�¶ȵ��쳣��ֵId=6
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=6
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=6
if @Temperature>@AnomalousEventThresholdValueMax or @Temperature<@AnomalousEventThresholdValueMin 
return
---û���쳣������ж�Ԥ���ȼ���洢���������ݿ�
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


----------------------------------����------------------------------
if(OBJECT_ID('tgr_Original_WindLoadTable','TR') is not null)
drop trigger tgr_Original_WindLoadTable
go
create trigger tgr_Original_WindLoadTable
on Original_WindLoadTable    --�������
for insert
as
set nocount on
declare @windSpeed float,@WindDirection float, @Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @windSpeed=WindSpeed from inserted
select @WindDirection=WindDirection from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---ʪ�ȵ��쳣��ֵId=8
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=8
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=8
if @windSpeed>@AnomalousEventThresholdValueMax or @windSpeed<@AnomalousEventThresholdValueMin 
return
---û���쳣������ж�Ԥ���ȼ���洢���������ݿ�
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


----------------------------------�ֹ���Ӧ��------------------------------------------
if(OBJECT_ID('tgr_Original_SteelArchStrainTable','TR') is not null)
drop trigger tgr_Original_SteelArchStrainTable
go
create trigger tgr_Original_SteelArchStrainTable
on Original_SteelArchStrainTable    --�������
for insert
as
set nocount on
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---��Ӧ����쳣��ֵId=1
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
return
---û���쳣������ж�Ԥ���ȼ���洢���������ݿ�
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


-----------------------------------�ָ�Ӧ��----------------------------------------
if(OBJECT_ID('tgr_Original_SteelLatticeStrainTable','TR') is not null)
drop trigger tgr_Original_SteelLatticeStrainTable
go
create trigger tgr_Original_SteelLatticeStrainTable
on Original_SteelLatticeStrainTable    --�������
for insert
as
set nocount on
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int,@AnomalousEventThresholdValueMax float,@AnomalousEventThresholdValueMin float
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
---��Ӧ����쳣��ֵId=1
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
return
---û���쳣������ж�Ԥ���ȼ���洢���������ݿ�
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
-----------------------------ԭʼ����ת������ֵ����--------------------------------------
-----------------------------------------------------------------------------------------


-------------������������ת������ֵ���ݱ�---------------------------------
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


-------------------λ�ƻ�������ת������ֵ���ݱ�------------------------------------
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





--------------------------������Ӧ���������ת������ֵ���ݱ�--------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_ConcreteStrainTable','TR') is not null)           --������
drop trigger tgr_Basic_EigenValue_ConcreteStrainTable              --������
go
create trigger tgr_Basic_EigenValue_ConcreteStrainTable     --������
on Basic_ConcreteStrainTable   --�滻�������ݱ��
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
	order by a.Time             --�滻�������ݱ��

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_ConcreteStrainTable where PointsNumberId=@pointsNumberId)=1)      --�滻�������ݱ��
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Strain) from Basic_ConcreteStrainTable              --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_ConcreteStrainTable                --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_ConcreteStrainTable             --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_ConcreteStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --�滻��ֵ���
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Strain) from Basic_ConcreteStrainTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_ConcreteStrainTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_ConcreteStrainTable                 --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_ConcreteStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --�滻��ֵ���
end
go


-------------------------------ʪ�Ȼ�������ת������ֵ���ݱ�------------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_HumidityTable','TR') is not null)           --������
drop trigger tgr_Basic_EigenValue_HumidityTable              --������
go
create trigger tgr_Basic_EigenValue_HumidityTable     --������
on Basic_HumidityTable   --�滻�������ݱ��
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
	order by a.Time             --�滻�������ݱ��

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_HumidityTable where PointsNumberId=@pointsNumberId)=1)      --�滻�������ݱ��
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Humidity) from Basic_HumidityTable              --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Humidity) from Basic_HumidityTable                --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Humidity) from Basic_HumidityTable             --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_HumidityEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --�滻��ֵ���
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Humidity) from Basic_HumidityTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Humidity) from Basic_HumidityTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Humidity) from Basic_HumidityTable                 --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_HumidityEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --�滻��ֵ���
end
go

-----------------���买Ӧ���������ת������ֵ���ݱ�--------------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_SteelArchStrainTable','TR') is not null)           --������
drop trigger tgr_Basic_EigenValue_SteelArchStrainTable              --������
go
create trigger tgr_Basic_EigenValue_SteelArchStrainTable     --������
on Basic_SteelArchStrainTable   --�滻�������ݱ��
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
	order by a.Time             --�滻�������ݱ��

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_SteelArchStrainTable where PointsNumberId=@pointsNumberId)=1)      --�滻�������ݱ��
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Strain) from Basic_SteelArchStrainTable              --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_SteelArchStrainTable                --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_SteelArchStrainTable             --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_SteelArchStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --�滻��ֵ���
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Strain) from Basic_SteelArchStrainTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_SteelArchStrainTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_SteelArchStrainTable                 --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_SteelArchStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --�滻��ֵ���
end
go


-----------------------�ָ�Ӧ���������ת������ֵ���ݱ�----------------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_SteelLatticeStrainTable','TR') is not null)           --������
drop trigger tgr_Basic_EigenValue_SteelLatticeStrainTable              --������
go
create trigger tgr_Basic_EigenValue_SteelLatticeStrainTable     --������
on Basic_SteelLatticeStrainTable   --�滻�������ݱ��
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
	order by a.Time             --�滻�������ݱ��

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_SteelLatticeStrainTable where PointsNumberId=@pointsNumberId)=1)      --�滻�������ݱ��
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Strain) from Basic_SteelLatticeStrainTable              --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_SteelLatticeStrainTable                --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_SteelLatticeStrainTable             --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_SteelLatticeStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --�滻��ֵ���
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Strain) from Basic_SteelLatticeStrainTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Strain) from Basic_SteelLatticeStrainTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Strain) from Basic_SteelLatticeStrainTable                 --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_SteelLatticeStrainEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --�滻��ֵ���
end
go

---------------------�¶Ȼ�������ת������ֵ���ݱ�-------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_TemperatureTable','TR') is not null)           --������
drop trigger tgr_Basic_EigenValue_TemperatureTable              --������
go
create trigger tgr_Basic_EigenValue_TemperatureTable     --������
on Basic_TemperatureTable   --�滻�������ݱ��
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
	order by a.Time             --�滻�������ݱ��

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_TemperatureTable where PointsNumberId=@pointsNumberId)=1)      --�滻�������ݱ��
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(Temperature) from Basic_TemperatureTable              --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Temperature) from Basic_TemperatureTable                --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Temperature) from Basic_TemperatureTable             --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_TemperatureEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --�滻��ֵ���
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(Temperature) from Basic_TemperatureTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(Temperature) from Basic_TemperatureTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(Temperature) from Basic_TemperatureTable                 --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_TemperatureEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --�滻��ֵ���
end
go

---------------------------------���ٻ�������ת������ֵ���ݱ�-------------------------------
if(OBJECT_ID('tgr_Basic_EigenValue_WindLoadTable','TR') is not null)           --������
drop trigger tgr_Basic_EigenValue_WindLoadTable              --������
go
create trigger tgr_Basic_EigenValue_WindLoadTable     --������
on Basic_WindLoadTable   --�滻�������ݱ��
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
	order by a.Time             --�滻�������ݱ��

select @insertHourTime=dateadd(ms,-datepart(ms,@insertTime),dateadd(ss,-datepart(ss,@insertTime),dateadd(mi,-datepart(mi,@insertTime),@insertTime)))
select @preInsertHourTime=dateadd(ms,-datepart(ms,@preInsertTime),dateadd(ss,-datepart(ss,@preInsertTime),dateadd(mi,-datepart(mi,@preInsertTime),@preInsertTime)))

if ((select count(*) from Basic_WindLoadTable where PointsNumberId=@pointsNumberId)=1)      --�滻�������ݱ��
begin
	return
end

if datediff(hh,@preInsertHourTime,@insertHourTime)=1
begin
    set @endTime=@insertHourTime
	select @startTime=dateadd(hh,-1,@endTime)
	select @max=MAX(WindSpeed) from Basic_WindLoadTable              --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(WindSpeed) from Basic_WindLoadTable                --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(WindSpeed) from Basic_WindLoadTable             --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_WindLoadEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)               --�滻��ֵ���
end
if datediff(hh,@preInsertHourTime,@insertHourTime)>1
begin
    set @startTime=@preInsertHourTime
	select @endTime=dateadd(hh,1,@preInsertHourTime)
	select @max=MAX(WindSpeed) from Basic_WindLoadTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @min=MIN(WindSpeed) from Basic_WindLoadTable                     --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	select @average=AVG(WindSpeed) from Basic_WindLoadTable                 --�滻�������ͺͱ��
	where PointsNumberId=@pointsNumberId and "Time" >= @startTime and "Time"< @endTime
	insert into Eigenvalue_WindLoadEigenvalueTable ("Max","Min",Average,"Time",PointsNumberId)
		values(@max,@min,@average,@startTime,@pointsNumberId)                       --�滻��ֵ���
end
go


-----------------------------------------------------------------------------------------
-----------------------------ԭʼ����ת��Ԥ������----------------------------------------
-----------------------------------------------------------------------------------------

----�������ݿ�����ֵ���µļ�¼ʱ,����Ԥ�����ݵĴ洢(���洢��ɫԤ���ͺ�ɫԤ��,��ɫԤ���ȼ�ThresholdGradeId=2,��ɫԤ���ȼ�ThresholdGradeId=3
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


--�������ݿ�λ��ֵ���µļ�¼ʱ,����Ԥ�����ݵĴ洢(���洢��ɫԤ���ͺ�ɫԤ��,��ɫԤ���ȼ�ThresholdGradeId=2,��ɫԤ���ȼ�ThresholdGradeId=3
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

--�������ݿ��¶�ֵ���µļ�¼ʱ,����Ԥ�����ݵĴ洢(���洢��ɫԤ���ͺ�ɫԤ��,��ɫԤ���ȼ�ThresholdGradeId=2,��ɫԤ���ȼ�ThresholdGradeId=3
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

--�������ݿ����ֵ���µļ�¼ʱ,����Ԥ�����ݵĴ洢(���洢��ɫԤ���ͺ�ɫԤ��,��ɫԤ���ȼ�ThresholdGradeId=2,��ɫԤ���ȼ�ThresholdGradeId=3
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
-----------------------------��ȫһ��������ؽű����������ɻ������ݿⴥ���������������ֵ��������ÿ�£�------------------------
-----------------------------------------------------------------------------------------
-------------------------------����������һ��������������--------------------------------------------
if(OBJECT_ID('tgr_Basic_CableForceTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_CableForceTableForAssessmentReportFirst
go
create trigger tgr_Basic_CableForceTableForAssessmentReportFirst
on Basic_CableForceTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--���ڱ���:�������ݿ�����һ�����ݣ��Ҳ�������������ʱ����ʼ��������
if (select count(*) from Basic_CableForceTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
	--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------��λ�ƴ���һ��������������--------------------------------------------
if(OBJECT_ID('tgr_Basic_DisplacementTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_DisplacementTableForAssessmentReportFirst
go
create trigger tgr_Basic_DisplacementTableForAssessmentReportFirst
on Basic_DisplacementTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--���ڱ���:�������ݿ�����һ�����ݣ��Ҳ�������������ʱ����ʼ��������
if (select count(*) from Basic_DisplacementTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
	--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------�ɻ�����Ӧ�䴥��һ��������������--------------------------------------------
if(OBJECT_ID('tgr_Basic_ConcreteStrainTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_ConcreteStrainTableForAssessmentReportFirst
go
create trigger tgr_Basic_ConcreteStrainTableForAssessmentReportFirst
on Basic_ConcreteStrainTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--���ڱ���:�������ݿ�����һ�����ݣ��Ҳ�������������ʱ����ʼ��������
if (select count(*) from Basic_ConcreteStrainTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
	--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------�ɸֹ���Ӧ�䴥��һ��������������--------------------------------------------
if(OBJECT_ID('tgr_Basic_SteelArchStrainTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_SteelArchStrainTableForAssessmentReportFirst
go
create trigger tgr_Basic_SteelArchStrainTableForAssessmentReportFirst
on Basic_SteelArchStrainTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--���ڱ���:�������ݿ�����һ�����ݣ��Ҳ�������������ʱ����ʼ��������
if (select count(*) from Basic_SteelArchStrainTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
	--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------�ɸָ�Ӧ�䴥��һ��������������--------------------------------------------
if(OBJECT_ID('tgr_Basic_SteelLatticeStrainTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_SteelLatticeStrainTableForAssessmentReportFirst
go
create trigger tgr_Basic_SteelLatticeStrainTableForAssessmentReportFirst
on Basic_SteelLatticeStrainTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--���ڱ���:�������ݿ�����һ�����ݣ��Ҳ�������������ʱ����ʼ��������
if (select count(*) from Basic_SteelLatticeStrainTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
	--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------���¶ȴ���һ��������������--------------------------------------------
if(OBJECT_ID('tgr_Basic_TemperatureTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_TemperatureTableForAssessmentReportFirst
go
create trigger tgr_Basic_TemperatureTableForAssessmentReportFirst
on Basic_TemperatureTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--���ڱ���:�������ݿ�����һ�����ݣ��Ҳ�������������ʱ����ʼ��������
if (select count(*) from Basic_TemperatureTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
	--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------��ʪ�ȴ���һ��������������--------------------------------------------
if(OBJECT_ID('tgr_Basic_HumidityTableForAssessmentReportFirst','TR') is not null)
drop trigger tgr_Basic_HumidityTableForAssessmentReportFirst
go
create trigger tgr_Basic_HumidityTableForAssessmentReportFirst
on Basic_HumidityTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--���ڱ���:�������ݿ�����һ�����ݣ��Ҳ�������������ʱ����ʼ��������
if (select count(*) from Basic_HumidityTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
	--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go

-------------------------------�ɷ��ٴ���һ��������������--------------------------------------------
if(OBJECT_ID('tgrBasic_WindLoadTableTableForAssessmentReportFirst','TR') is not null)
drop trigger tgrBasic_WindLoadTableTableForAssessmentReportFirst
go
create trigger tgrBasic_WindLoadTableTableForAssessmentReportFirst
on Basic_WindLoadTable
for insert
as
set nocount on
declare @ReportPeriods nvarchar(max),@ReportTime datetime,@AssessmentReasonsId int,@ReportTimeYear int,@ReportIdDiff int

--���ڱ���:�������ݿ�����һ�����ݣ��Ҳ�������������ʱ����ʼ��������
if (select count(*) from Basic_WindLoadTable)=1 and (select count(*) from FirstAssessment_FirstLevelSafetyAssessmentReportTable)=0
	begin
	set @AssessmentReasonsId=1
	select @ReportTime="Time" from inserted
	select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
	select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
	--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 	
	insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end
go


----------------------------������ֵ������񴥷�����һ�����������,2�����(1)��ɫԤ����������;(2)�����±�----------------------------------
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
--�鿴Ԥ�������Ƿ�����Ϊ����10�λ�ɫԤ���������ĺ�ɫԤ����¼
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

--�������ֵ�������к�ɫԤ��ֵ��ȷ��Ԥ���ȼ�
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

--Ԥ������һ����������
if @ThresholdGradeId=3 and @InsertTime not in (select ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable)
	begin
		--����ʱ�丽ֵ			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--����ԭ��ֵ
		set @AssessmentReasonsId=2
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--ͬ�������ʱ��ȷ���������� 
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			end
		--���������ʱ��ȷ���������� 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���'+convert(varchar(50),@ReportIdDiff+2)+'��'
			end			
		--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end 
--��Ԥ��������30����г��汨��
if @ThresholdGradeId<>3
	begin
	select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
	--���μ�¼������ǰ����������ʱ�䳬��30��ʱ����������
	if DATEDIFF(dd,@PreReportTime,@InsertTime)>=30
		begin
		--����ʱ�丽ֵ			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--����ԭ��ֵ
		set @AssessmentReasonsId=3
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--ͬ�������ʱ��ȷ����������  
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			end
		--���������ʱ��ȷ���������� 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���'+convert(varchar(50),@ReportIdDiff+2)+'��'
			end
		--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go

-------------------------------------------------------------------------------------------------------------------------
--------------------------------������ֵλ�Ʊ�񴥷�����һ�����������,2�����,(1)��ɫԤ����������;(2)�����±�-------------------------------------
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

--�鿴Ԥ�������Ƿ�����Ϊ����10�λ�ɫԤ���������ĺ�ɫԤ����¼
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

--�������ֵ�������к�ɫԤ��ֵ��ȷ��Ԥ���ȼ�
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

--Ԥ������һ����������
if @ThresholdGradeId=3 and @InsertTime not in (select ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable)
	begin
		--����ʱ�丽ֵ			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--����ԭ��ֵ
		set @AssessmentReasonsId=2
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--ͬ�������ʱ��ȷ���������� 
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			end
		--���������ʱ��ȷ���������� 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���'+convert(varchar(50),@ReportIdDiff+2)+'��'
			end			
		--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end 
--��Ԥ��������30����г��汨��
if @ThresholdGradeId<>3
	begin
	select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
	--���μ�¼������ǰ����������ʱ�䳬��30��ʱ����������
	if DATEDIFF(dd,@PreReportTime,@InsertTime)>=30
		begin
		--����ʱ�丽ֵ			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--����ԭ��ֵ
		set @AssessmentReasonsId=3
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--ͬ�������ʱ��ȷ����������  
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			end
		--���������ʱ��ȷ���������� 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���'+convert(varchar(50),@ReportIdDiff+2)+'��'
			end
		--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go

-------------------------------------------------------------------------------------------------------------------------
----------------------------������ֵ�¶ȱ�񴥷�����һ�����������,2�����,(1)��ɫԤ����������;(2)�����±�-----------------------------------
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

--Ԥ������һ����������
if @ThresholdGradeId=3 and @InsertTime not in (select ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable)
	begin
		--����ʱ�丽ֵ			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--����ԭ��ֵ
		set @AssessmentReasonsId=2
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--ͬ�������ʱ��ȷ���������� 
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			end
		--���������ʱ��ȷ���������� 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���'+convert(varchar(50),@ReportIdDiff+2)+'��'
			end			
		--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end 
--��Ԥ��������30����г��汨��
if @ThresholdGradeId<>3
	begin
	select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
	--���μ�¼������ǰ����������ʱ�䳬��30��ʱ����������
	if DATEDIFF(dd,@PreReportTime,@InsertTime)>=30
		begin
		--����ʱ�丽ֵ			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--����ԭ��ֵ
		set @AssessmentReasonsId=3
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--ͬ�������ʱ��ȷ����������  
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			end
		--���������ʱ��ȷ���������� 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���'+convert(varchar(50),@ReportIdDiff+2)+'��'
			end
		--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go

-------------------------------------------------------------------------------------------------------------------------
-------------------������ֵʪ�ȱ�񴥷�����һ�����������,(1)��ɫԤ����������;(2)�����±�------------------------------------
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

--Ԥ������һ����������
if @ThresholdGradeId=3 and @InsertTime not in (select ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable)
	begin
		--����ʱ�丽ֵ			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--����ԭ��ֵ
		set @AssessmentReasonsId=2
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--ͬ�������ʱ��ȷ���������� 
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			end
		--���������ʱ��ȷ���������� 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���'+convert(varchar(50),@ReportIdDiff+2)+'��'
			end			
		--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
	end 
--��Ԥ��������30����г��汨��
if @ThresholdGradeId<>3
	begin
	select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
	--���μ�¼������ǰ����������ʱ�䳬��30��ʱ����������
	if DATEDIFF(dd,@PreReportTime,@InsertTime)>=30
		begin
		--����ʱ�丽ֵ			
		select @ReportTime=dateadd(hh,1,"Time") from inserted
		--����ԭ��ֵ
		set @AssessmentReasonsId=3
		select @ReportTimeYear=DATEPART(yyyy,@ReportTime)
		select top 1 @PreReportTime=ReportTime from FirstAssessment_FirstLevelSafetyAssessmentReportTable order by ReportTime desc
		select @PreReportTimeYear=DATEPART(yyyy,@PreReportTime)
		--ͬ�������ʱ��ȷ����������  
		if @ReportTimeYear-@PreReportTimeYear<>0
			begin
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			end
		--���������ʱ��ȷ���������� 
		else
			begin
			select @ReportId=Id from FirstAssessment_FirstLevelSafetyAssessmentReportTable where ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���1��'
			select @ReportIdDiff=MAX(Id)-@ReportId from FirstAssessment_FirstLevelSafetyAssessmentReportTable			
			select @ReportPeriods=convert(varchar(50),@ReportTimeYear)+'���'+convert(varchar(50),@ReportIdDiff+2)+'��'
			end
		--���ݲ���ֵ����FirstAssessment_FirstLevelSafetyAssessmentReportTable��Ӽ�¼ 
		insert into FirstAssessment_FirstLevelSafetyAssessmentReportTable (ReportPeriods,ReportTime,AssessmentReasonsId)values(@ReportPeriods,@ReportTime,@AssessmentReasonsId)
		end
	end
go


-------------------------------------------------------------------------------------------------------------------------
--��һ����ȫ����������������쳣���ݼ�¼���Լ���������������쳣���ݼ��������������λ�ơ�Ӧ�䣩
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

--��������쳣��¼�еĲ���źʹ���
if(OBJECT_ID('TempTable','u') is not null)
drop table TempTable
select id=identity(int,1,1), PointsNumberId as PointsNumberId ,COUNT(*) as RecordCount into TempTable from SafetyPreWarning_CableForceTable 
where ThresholdGradeId=3 and "Time" between @PreInsertAssessmentTime and @InsertAssessmentTime group by PointsNumberId
--ѭ����ӽ��쳣���ݱ���
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

--���λ���쳣��¼�еĲ���źʹ���
if(OBJECT_ID('TempTable','u') is not null)
drop table TempTable
select id=identity(int,1,1), PointsNumberId as PointsNumberId ,COUNT(*) as RecordCount into TempTable from SafetyPreWarning_DisplacementTable 
where ThresholdGradeId=3 and "Time" between @PreInsertAssessmentTime and @InsertAssessmentTime group by PointsNumberId
--ѭ����ӽ��쳣���ݱ���
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

--���Ӧ���쳣��¼�еĲ���źʹ���
if(OBJECT_ID('TempTable','u') is not null)
drop table TempTable
select id=identity(int,1,1), PointsNumberId as PointsNumberId ,COUNT(*) as RecordCount into TempTable from SafetyPreWarning_StrainTable 
where ThresholdGradeId=3 and "Time" between @PreInsertAssessmentTime and @InsertAssessmentTime group by PointsNumberId
--ѭ����ӽ��쳣���ݱ���
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

--һ���������浽�����뽨���

--��������
declare @testTypeId int
declare @CableForceAssessmentResult nvarchar(max),@CableForceAssessmentSuggestion nvarchar(max)
declare @StrainAssessmentResult nvarchar(max),@StrainAssessmentSuggestion nvarchar(max)
declare @DisplacementAssessmentResult nvarchar(max),@DisplacementAssessmentSuggestion nvarchar(max)

--���������Խ�������鸳ֵ
if (select count(*) from FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable where AssessmentReportId =@AssessmentReportId and TestType='����')>=1
	begin
	set @CableForceAssessmentResult='�쳣����������ʵ��ֵ�������ֵ�����������쳣��¼'
	set @CableForceAssessmentSuggestion='�ṹ�ֲ���Ӧ�쳣,��������쳣λ�ý���ר���飬�Ų��쳣ԭ��'
	end
else
	begin
	set @CableForceAssessmentResult='������������δ����ʵ��ֵ�������ֵ�����'
	set @CableForceAssessmentSuggestion='�������Խ����������������˹�������������������ճ�������ά��'
end
--��Ӧ�����Խ�������鸳ֵ
if (select count(*) from FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable where AssessmentReportId =@AssessmentReportId and TestType='�ֹ���Ӧ��')>=1 or 
(select count(*) from FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable where AssessmentReportId =@AssessmentReportId and TestType='�ָ�Ӧ��')>=1 or
(select count(*) from FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable where AssessmentReportId =@AssessmentReportId and TestType='������Ӧ��')>=1
	begin
	set @StrainAssessmentResult='�쳣��Ӧ������ʵ��ֵ�������ֵ�����������쳣��¼'
	set @StrainAssessmentSuggestion='�ṹ�ֲ���Ӧ�쳣,��������쳣λ�ý���ר���飬�Ų��쳣ԭ��'
	end
else
	begin
	set @StrainAssessmentResult='������Ӧ����δ����ʵ��ֵ�������ֵ�����'
	set @StrainAssessmentSuggestion='Ӧ�����Խ����������������˹�������������������ճ�������ά��'
	end
--��λ�Ʋ��Խ�������鸳ֵ
if (select count(*) from FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable where AssessmentReportId =@AssessmentReportId and TestType='λ��')>=1
	begin
	set @DisplacementAssessmentResult='�쳣���ṹ���γ���ʵ��ֵ�������ֵ�����������쳣��¼'
	set @DisplacementAssessmentSuggestion='�ṹ������Ӧ�쳣,����������չ��ȫ�����������������������ʱ��֯���ά�޹���'
	end
else
	begin
	set @DisplacementAssessmentResult='�������ṹ���ξ�δ����ʵ��ֵ�������ֵ�����'
	set @DisplacementAssessmentSuggestion='�ṹ���β��Խ����������������˹�������������������ճ�������ά��'
	end
--�����õ�����
insert into FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable values(@StrainAssessmentResult,@StrainAssessmentSuggestion,@DisplacementAssessmentResult,@DisplacementAssessmentSuggestion,@CableForceAssessmentResult,@CableForceAssessmentSuggestion,@AssessmentReportId)

go

-------------------------------------------------------------------------------------------------------------------------
--�������ݿ�ֹ���Ӧ�����µļ�¼ʱ,����Ԥ�����ݵĴ洢(���洢��ɫԤ���ͺ�ɫԤ��,��ɫԤ���ȼ�ThresholdGradeId=2,��ɫԤ���ȼ�ThresholdGradeId=3
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
--�������ݿ�ָ�Ӧ�����µļ�¼ʱ,����Ԥ�����ݵĴ洢(���洢��ɫԤ���ͺ�ɫԤ��,��ɫԤ���ȼ�ThresholdGradeId=2,��ɫԤ���ȼ�ThresholdGradeId=3
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
--�������ݿ������Ӧ�����µļ�¼ʱ,����Ԥ�����ݵĴ洢(���洢��ɫԤ���ͺ�ɫԤ��,��ɫԤ���ȼ�ThresholdGradeId=2,��ɫԤ���ȼ�ThresholdGradeId=3
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
-----------------------------�쳣�¼��洢����ԭʼ���ݴ�����------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
----ԭʼ���ݿ����µļ�¼ʱ,�����쳣�¼��Ĵ洢(�������쳣��ֵ�����ݴ洢���쳣�¼��ı����
------------------------------------------------------����------------------------------------------------------
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
---�ϲ���˵��쳣��ֵId=3
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
---�²���˵��쳣��ֵId=4
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
---����ϵ�˵��쳣��ֵId=5
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

----ԭʼ���ݿ����µļ�¼ʱ,�����쳣�¼��Ĵ洢(�������쳣��ֵ�����ݴ洢���쳣�¼��ı����
------------------------------------------------------�ֹ���Ӧ��------------------------------------------------------
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
---��Ӧ����쳣��ֵId=1
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@Strain,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----ԭʼ���ݿ����µļ�¼ʱ,�����쳣�¼��Ĵ洢(�������쳣��ֵ�����ݴ洢���쳣�¼��ı����
------------------------------------------------------�ָ�Ӧ��------------------------------------------------------
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
---��Ӧ����쳣��ֵId=1
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=1
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@Strain,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----ԭʼ���ݿ����µļ�¼ʱ,�����쳣�¼��Ĵ洢(�������쳣��ֵ�����ݴ洢���쳣�¼��ı����
------------------------------------------------------������Ӧ��------------------------------------------------------
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
---���������쳣��ֵId=2
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=2
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=2
if @Strain>@AnomalousEventThresholdValueMax or @Strain<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@Strain,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----ԭʼ���ݿ����µļ�¼ʱ,�����쳣�¼��Ĵ洢(�������쳣��ֵ�����ݴ洢���쳣�¼��ı����
------------------------------------------------------�¶�------------------------------------------------------
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
---�¶ȵ��쳣��ֵId=6
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=6
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=6
if @Temperature>@AnomalousEventThresholdValueMax or @Temperature<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@Temperature,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----ԭʼ���ݿ����µļ�¼ʱ,�����쳣�¼��Ĵ洢(�������쳣��ֵ�����ݴ洢���쳣�¼��ı����
------------------------------------------------------ʪ��------------------------------------------------------
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
---ʪ�ȵ��쳣��ֵId=7
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=7
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=7
if @Humidity>@AnomalousEventThresholdValueMax or @Humidity<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@Humidity,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----ԭʼ���ݿ����µļ�¼ʱ,�����쳣�¼��Ĵ洢(�������쳣��ֵ�����ݴ洢���쳣�¼��ı����
------------------------------------------------------����------------------------------------------------------
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
---ʪ�ȵ��쳣��ֵId=8
select @AnomalousEventThresholdValueMax=MaxLevelThresholdValue from Abnormal_ThresholdValueTable where Id=8
select @AnomalousEventThresholdValueMin=MinLevelThresholdValue from Abnormal_ThresholdValueTable where Id=8
if @WindLoad>@AnomalousEventThresholdValueMax or @WindLoad<@AnomalousEventThresholdValueMin 
begin
set @AnomalousEventReasonId=1
insert into AnomalousEvent_AnomalousEventTable (AnomalousData,"Time",PointsNumberId,AnomalousEventReasonId)
values(@WindLoad,@Time,@PointsNumberId,@AnomalousEventReasonId)
end
go

----ԭʼ���ݿ����µļ�¼ʱ,�����쳣�¼��Ĵ洢(�������쳣��ֵ�����ݴ洢���쳣�¼��ı����
------------------------------------------------------λ��------------------------------------------------------
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
---�ֹ���X�����쳣��ֵId=9
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
---�ֹ���Y�����쳣��ֵId=10
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
---�ֹ���Z�����쳣��ֵId=11
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
---�����Ӷ��쳣��ֵId=12
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
---���ɶձ����쳣��ֵId=13
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
---����������쳣��ֵId=14
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


-------------------------------��������ת��ʵʱ�������--------------------------------------
-------------------------------��������ת��ʵʱ�������--------------------------------------
-------------------------------��������ת��ʵʱ�������--------------------------------------

---------------����--------------------------------------
--if(OBJECT_ID('tgr_Basic_CableForceToRealTime','TR') is not null)
--drop trigger tgr_Basic_CableForceToRealTime
--go
--create trigger tgr_Basic_CableForceToRealTime
--on Basic_CableForceTable
--for insert
--as
--set nocount on
--declare @CableForce float,@Frequency float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
--select @CableForce=CableForce from inserted
--select @Frequency=Frequency from inserted
--select @Temperature=Temperature from inserted
--select @Time="Time" from inserted
--select @PointsNumberId=PointsNumberId from inserted
--select @ThresholdGradeId=ThresholdGradeId from inserted

--declare @TotalNumber int
--declare @MinId int
--select @TotalNumber=count(*) from RealTime_CableForceTable
--if @TotalNumber >=500
--begin
--   select @MinId=MIN(Id) from RealTime_CableForceTable
--   delete from RealTime_CableForceTable WHERE Id=@MinId
--end

--insert into RealTime_CableForceTable (CableForce,Frequency,Temperature,"Time",PointsNumberId,ThresholdGradeId)
--values(@CableForce,@Frequency,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)
--go

---------------�ֹ���Ӧ��--------------------------------------
--if(OBJECT_ID('tgr_Basic_SteelArchStrainTableToRealTime','TR') is not null)
--drop trigger tgr_Basic_SteelArchStrainTableToRealTime
--go
--create trigger tgr_Basic_SteelArchStrainTableToRealTime
--on Basic_SteelArchStrainTable
--for insert
--as
--set nocount on
--declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
--select @strain=Strain from inserted
--select @Temperature=Temperature from inserted
--select @Time="Time" from inserted
--select @PointsNumberId=PointsNumberId from inserted
--select @ThresholdGradeId=ThresholdGradeId from inserted

--declare @TotalNumber int
--declare @MinId int
--select @TotalNumber=count(*) from RealTime_SteelArchStrainTable
--if @TotalNumber >=500
--begin
--   select @MinId=MIN(Id) from RealTime_SteelArchStrainTable
--   delete from RealTime_SteelArchStrainTable WHERE Id=@MinId
--end

--insert into RealTime_SteelArchStrainTable(Strain,Temperature,"Time",PointsNumberId,ThresholdGradeId)
--values(@strain,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)
--go

---------------�ָ�Ӧ��--------------------------------------
--if(OBJECT_ID('tgr_Basic_SteelLatticeStrainTableToRealTime','TR') is not null)
--drop trigger tgr_Basic_SteelLatticeStrainTableToRealTime
--go
--create trigger tgr_Basic_SteelLatticeStrainTableToRealTime
--on Basic_SteelLatticeStrainTable
--for insert
--as
--set nocount on
--declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
--select @strain=Strain from inserted
--select @Temperature=Temperature from inserted
--select @Time="Time" from inserted
--select @PointsNumberId=PointsNumberId from inserted
--select @ThresholdGradeId=ThresholdGradeId from inserted

--declare @TotalNumber int
--declare @MinId int
--select @TotalNumber=count(*) from RealTime_SteelLatticeStrainTable
--if @TotalNumber >=500
--begin
--   select @MinId=MIN(Id) from RealTime_SteelLatticeStrainTable
--   delete from RealTime_SteelLatticeStrainTable WHERE Id=@MinId
--end

--insert into RealTime_SteelLatticeStrainTable(Strain,Temperature,"Time",PointsNumberId,ThresholdGradeId)
--values(@strain,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)
--go

---------------������Ӧ��--------------------------------------
--if(OBJECT_ID('tgr_Basic_ConcreteStrainTableToRealTime','TR') is not null)
--drop trigger tgr_Basic_ConcreteStrainTableToRealTime
--go
--create trigger tgr_Basic_ConcreteStrainTableToRealTime
--on Basic_ConcreteStrainTable
--for insert
--as
--set nocount on
--declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
--select @strain=Strain from inserted
--select @Temperature=Temperature from inserted
--select @Time="Time" from inserted
--select @PointsNumberId=PointsNumberId from inserted
--select @ThresholdGradeId=ThresholdGradeId from inserted

--declare @TotalNumber int
--declare @MinId int
--select @TotalNumber=count(*) from RealTime_ConcreteStrainTable
--if @TotalNumber >=500
--begin
--   select @MinId=MIN(Id) from RealTime_ConcreteStrainTable
--   delete from RealTime_ConcreteStrainTable WHERE Id=@MinId
--end

--insert into RealTime_ConcreteStrainTable(Strain,Temperature,"Time",PointsNumberId,ThresholdGradeId)
--values(@strain,@Temperature,@Time,@PointsNumberId,@ThresholdGradeId)
--go

---------------λ��--------------------------------------
--if(OBJECT_ID('tgr_Basic_DisplacementTableToRealTime','TR') is not null)
--drop trigger tgr_Basic_DisplacementTableToRealTime
--go
--create trigger tgr_Basic_DisplacementTableToRealTime
--on Basic_DisplacementTable
--for insert
--as
--set nocount on
--declare @displacement float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
--select @displacement=Displacement from inserted
--select @Time="Time" from inserted
--select @PointsNumberId=PointsNumberId from inserted
--select @ThresholdGradeId=ThresholdGradeId from inserted

--declare @TotalNumber int
--declare @MinId int
--select @TotalNumber=count(*) from RealTime_DisplacementTable
--if @TotalNumber >=500
--begin
--   select @MinId=MIN(Id) from RealTime_DisplacementTable
--   delete from RealTime_DisplacementTable WHERE Id=@MinId
--end

--insert into RealTime_DisplacementTable(Displacement,"Time",PointsNumberId,ThresholdGradeId)
--values(@displacement,@Time,@PointsNumberId,@ThresholdGradeId)
--go

---------------�¶�--------------------------------------
--if(OBJECT_ID('tgr_Basic_TemperatureTableToRealTime','TR') is not null)
--drop trigger tgr_Basic_TemperatureTableToRealTime
--go
--create trigger tgr_Basic_TemperatureTableToRealTime
--on Basic_TemperatureTable
--for insert
--as
--set nocount on
--declare @temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
--select @temperature=Temperature from inserted
--select @Time="Time" from inserted
--select @PointsNumberId=PointsNumberId from inserted
--select @ThresholdGradeId=ThresholdGradeId from inserted

--declare @TotalNumber int
--declare @MinId int
--select @TotalNumber=count(*) from RealTime_TemperatureTable
--if @TotalNumber >=500
--begin
--   select @MinId=MIN(Id) from RealTime_TemperatureTable
--   delete from RealTime_TemperatureTable WHERE Id=@MinId
--end

--insert into RealTime_TemperatureTable(Temperature,"Time",PointsNumberId,ThresholdGradeId)
--values(@temperature,@Time,@PointsNumberId,@ThresholdGradeId)
--go

---------------ʪ��--------------------------------------
--if(OBJECT_ID('tgr_Basic_HumidityTableToRealTime','TR') is not null)
--drop trigger tgr_Basic_HumidityTableToRealTime
--go
--create trigger tgr_Basic_HumidityTableToRealTime
--on Basic_HumidityTable
--for insert
--as
--set nocount on
--declare @humidity float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
--select @humidity=Humidity from inserted
--select @Time="Time" from inserted
--select @PointsNumberId=PointsNumberId from inserted
--select @ThresholdGradeId=ThresholdGradeId from inserted

--declare @TotalNumber int
--declare @MinId int
--select @TotalNumber=count(*) from RealTime_HumidityTable
--if @TotalNumber >=500
--begin
--   select @MinId=MIN(Id) from RealTime_HumidityTable
--   delete from RealTime_HumidityTable WHERE Id=@MinId
--end

--insert into RealTime_HumidityTable(Humidity,"Time",PointsNumberId,ThresholdGradeId)
--values(@humidity,@Time,@PointsNumberId,@ThresholdGradeId)
--go

---------------����--------------------------------------
--if(OBJECT_ID('tgr_Basic_WindLoadTableToRealTime','TR') is not null)
--drop trigger tgr_Basic_WindLoadTableToRealTime
--go
--create trigger tgr_Basic_WindLoadTableToRealTime
--on Basic_WindLoadTable
--for insert
--as
--set nocount on
--declare @windSpeed float,@WindDirection float, @Time datetime,@PointsNumberId int,@ThresholdGradeId int
--select @windSpeed=WindSpeed from inserted
--select @WindDirection=WindDirection from inserted
--select @Time="Time" from inserted
--select @PointsNumberId=PointsNumberId from inserted
--select @ThresholdGradeId=ThresholdGradeId from inserted

--declare @TotalNumber int
--declare @MinId int
--select @TotalNumber=count(*) from RealTime_WindLoadTable
--if @TotalNumber >=500
--begin
--   select @MinId=MIN(Id) from RealTime_WindLoadTable
--   delete from RealTime_WindLoadTable WHERE Id=@MinId
--end

--insert into RealTime_WindLoadTable(WindSpeed,WindDirection,"Time",PointsNumberId,ThresholdGradeId)
--values(@windSpeed,@WindDirection,@Time,@PointsNumberId,@ThresholdGradeId)
--go


-------------------------------------------------------------------
----------------------�������ؽű�---------------------------------------------------------�������ؽű�-----------------------------------
----------------------�������ؽű�---------------------------------------------------------�������ؽű�-----------------------------------
----------------------�������ؽű�---------------------------------------------------------�������ؽű�-----------------------------------
----------------------�������ؽű�---------------------------------------------------------�������ؽű�-----------------------------------
-----------------------------------------------------------------------------------------------------------------------------
---------------ִ�д洢���̲��Դ���--------------------------------------
--declare @TxtPathOutput varchar(max)
--Exec usp_BasicSteelArchStrainSaveAsTxt 1,2,@StartTime='2017-5-1 00:00:00',@EndTime='2017-05-23 22:00:00',@filePath_name='D:\BHMSDB\',@TxtPath=@TxtPathOutput output
--print @TxtPathOutput

--------------------------------------------------------------------------
--select count(*) from Basic_SteelArchStrainTable 
--select top 10 * from Basic_SteelArchStrainTable
--select top 10 * from Basic_SteelArchStrainTable order by Id desc
--delete Basic_SteelArchStrainTable

------------------------BCP���������ʽģ��-------------------------------------------
--exec master..xp_cmdshell 'bcp BHMSDB.dbo.temp out "D:\�������ϵͳ�����ļ�\jtsjyjczx\GxjtBHMS.Web\Content\MontorningDataDownLoad\DownloadData_20170524.txt" -c -q  -t"," -S User-20170213RT\SQLEXPRESS  -U sa -P 123456' 

-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------


----------------------------------��������ΪTXT�洢����----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
----------------------------------�����������ش洢����-----------------------------------------
-----------------------------------------------------------------------------------------------
----------------------------------�ֹ��߻����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicSteelArchStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicSteelArchStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicSteelArchStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0, @MPN9 int=0,@MPN10 int=0,  ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_SteelArchStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select Strain,Temperature,"Time",Name 
	into temp 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------�ָ񹹻����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicSteelLatticeStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicSteelLatticeStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicSteelLatticeStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_SteelLatticeStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select Strain,Temperature,"Time",Name 
	into temp 
	from Basic_SteelLatticeStrainTable as Ba         --- ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
if  @MPN9>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
if  @MPN10>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------���������������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_Basic_CableForceSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_Basic_CableForceSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_Basic_CableForceSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,
@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0, @MPN17 int=0,@MPN18 int=0,
@MPN19 int=0,@MPN20 int=0,@MPN21 int=0,@MPN22 int=0,@MPN23 int=0,@MPN24 int=0,@MPN25 int=0, @MPN26 int=0,@MPN27 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_CableForce',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select CableForce,Frequency,Temperature,"Time",Name 
	into temp 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end
 if  @MPN16>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN16 and "Time" between @StartTime and @EndTime
	end
 if  @MPN17>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN17 and "Time" between @StartTime and @EndTime
	end
 if  @MPN18>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN18 and "Time" between @StartTime and @EndTime
	end
 if  @MPN19>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN19 and "Time" between @StartTime and @EndTime
	end
 if  @MPN20>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN20 and "Time" between @StartTime and @EndTime
	end
 if  @MPN21>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN21 and "Time" between @StartTime and @EndTime
	end
if  @MPN22>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN22 and "Time" between @StartTime and @EndTime
	end
if  @MPN23>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN23 and "Time" between @StartTime and @EndTime
	end
if  @MPN24>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN24 and "Time" between @StartTime and @EndTime
	end
if  @MPN25>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN25 and "Time" between @StartTime and @EndTime
	end
if  @MPN26>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN26 and "Time" between @StartTime and @EndTime
	end
if  @MPN27>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN27 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------ʪ�Ȼ����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicHumiditySaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicHumiditySaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicHumiditySaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_Humidity',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                             ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select Humidity,"Time",Name 
	into temp 
	from Basic_HumidityTable as Ba         --- ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------λ�ƻ����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicDisplacementSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicDisplacementSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicDisplacementSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0, @MPN11 int=0, @MPN12 int=0, @MPN13 int=0, @MPN14 int=0, @MPN15 int=0,  ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_Displacement',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                             ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select Displacement,"Time",Name 
	into temp 
	from Basic_DisplacementTable as Ba         --- ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id  
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO


----------------------------------�¶Ȼ����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicTemperatureSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicTemperatureSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicTemperatureSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_Temperature',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select Temperature,"Time",Name 
	into temp 
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
if @MPN9>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
if  @MPN10>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------���ٻ����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicWindLoadSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicWindLoadSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicWindLoadSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_WindLoad',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select WindSpeed,"Time",Name 
	into temp 
	from Basic_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Basic_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Basic_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id  
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Basic_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Basic_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------������Ӧ������������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicConcreteStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicConcreteStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicConcreteStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0,@MPN17 int=0,@MPN18 int=0,@MPN19 int=0,@MPN20 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_ConcreteStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select Strain,Temperature,"Time",Name  
	into temp 
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
if @MPN9>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
if  @MPN10>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end
if  @MPN16>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN16 and "Time" between @StartTime and @EndTime
	end
 if  @MPN17>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN17 and "Time" between @StartTime and @EndTime
	end
 if  @MPN18>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN18 and "Time" between @StartTime and @EndTime
	end
 if  @MPN19>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN19 and "Time" between @StartTime and @EndTime
	end
 if  @MPN20>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN20 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO



------------------------------------------------------------------------------------------------------------------
----------------------------------����ֵ�������ش洢����-----------------------------------------
-----------------------------------------------------------------------------------------------
----------------------------------�ֹ�������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueSteelArchStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueSteelArchStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueSteelArchStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_SteelArchStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------�ָ�����ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueSteelLatticeStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueSteelLatticeStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueSteelLatticeStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_SteelLatticeStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------������Ӧ������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueConcreteStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueConcreteStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueConcreteStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_ConcreteStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------λ������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueDisplacementSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueDisplacementSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueDisplacementSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,    ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_Displacement',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------��������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueCableForceSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueCableForceSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueCableForceSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0,@MPN17 int=0,@MPN18 int=0,@MPN19 int=0,@MPN20 int=0,    ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_CableForce',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------�¶�����ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueTemperatureSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueTemperatureSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [usp_EigenvalueTemperatureSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_Temperature',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------ʪ������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueHumiditySaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueHumiditySaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [usp_EigenvalueHumiditySaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_Humidity',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------��������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueWindLoadSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueWindLoadSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [usp_EigenvalueWindLoadSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_WindLoad',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
		
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO


------------------------------------------------------------------------------------
--------------------------------------------------------------------------------
---------------------��������ű�---------------------------------------------------��������ű�------------------------------
---------------------��������ű�---------------------------------------------------��������ű�------------------------------
---------------------��������ű�---------------------------------------------------��������ű�------------------------------
---------------------��������ű�---------------------------------------------------��������ű�------------------------------
---------------------��������ű�---------------------------------------------------��������ű�------------------------------
---------------------��������ű�---------------------------------------------------��������ű�------------------------------
---------------------��������ű�---------------------------------------------------��������ű�------------------------------
---------------------��������ű�---------------------------------------------------��������ű�------------------------------
---------------------��������ű�---------------------------------------------------��������ű�------------------------------


------------����--�쳣�¼����--��--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('AnomalousEvent_AnomalousEventTable') and name='index_Time')
drop index AnomalousEvent_AnomalousEventTable.index_Time
create nonclustered
index index_Time on AnomalousEvent_AnomalousEventTable(Time)
go


------------����-�������ݿ�������--��--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Basic_CableForceTable') and name='index_Time')
drop index Basic_CableForceTable.index_Time
create nonclustered
index index_Time on Basic_CableForceTable(Time)
go

------------����-�������ݿ��������--��--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Basic_ConcreteStrainTable') and name='index_Time')
drop index Basic_ConcreteStrainTable.index_Time
create nonclustered
index index_Time on Basic_ConcreteStrainTable(Time)
go

------------����-�������ݿ�λ�Ʊ�--��--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Basic_DisplacementTable') and name='index_Time')
drop index Basic_DisplacementTable.index_Time
create nonclustered
index index_Time on Basic_DisplacementTable(Time)
go

------------����-�������ݿ�ʪ�ȱ�--��--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Basic_HumidityTable') and name='index_Time')
drop index Basic_HumidityTable.index_Time
create nonclustered
index index_Time on Basic_HumidityTable(Time)
go

------------����-�������ݿ�ֹ���Ӧ���--��--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Basic_SteelArchStrainTable') and name='index_Time')
drop index Basic_SteelArchStrainTable.index_Time
create nonclustered
index index_Time on Basic_SteelArchStrainTable(Time)
go

------------����-�������ݿ�ָ�Ӧ���--��--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Basic_SteelLatticeStrainTable') and name='index_Time')
drop index Basic_SteelLatticeStrainTable.index_Time
create nonclustered
index index_Time on Basic_SteelLatticeStrainTable(Time)
go

------------����-�������ݿ��¶ȱ�--��--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Basic_TemperatureTable') and name='index_Time')
drop index Basic_TemperatureTable.index_Time
create nonclustered
index index_Time on Basic_TemperatureTable(Time)
go

------------����-�������ݿ���ٱ�--��--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Basic_WindLoadTable') and name='index_Time')
drop index Basic_WindLoadTable.index_Time
create nonclustered
index index_Time on Basic_WindLoadTable(Time)
go


------------����ֵ-------------
------------��������ֵ���ݿ�������--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Eigenvalue_CableForceEigenvalueTable') and name='index_Time')
drop index Eigenvalue_CableForceEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_CableForceEigenvalueTable(Time)
go

------------��������ֵ���ݿ������Ӧ���--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Eigenvalue_ConcreteStrainEigenvalueTable') and name='index_Time')
drop index Eigenvalue_ConcreteStrainEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_ConcreteStrainEigenvalueTable(Time)
go

------------��������ֵ���ݿ�λ�Ʊ�--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Eigenvalue_DisplacementEigenvalueTable') and name='index_Time')
drop index Eigenvalue_DisplacementEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_DisplacementEigenvalueTable(Time)
go

------------��������ֵ���ݿ�ʪ�ȱ�--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Eigenvalue_HumidityEigenvalueTable') and name='index_Time')
drop index Eigenvalue_HumidityEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_HumidityEigenvalueTable(Time)
go

------------��������ֵ���ݿ�ֹ���Ӧ���--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Eigenvalue_SteelArchStrainEigenvalueTable') and name='index_Time')
drop index Eigenvalue_SteelArchStrainEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_SteelArchStrainEigenvalueTable(Time)
go

------------��������ֵ���ݿ�ָ�Ӧ���--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Eigenvalue_SteelLatticeStrainEigenvalueTable') and name='index_Time')
drop index Eigenvalue_SteelLatticeStrainEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_SteelLatticeStrainEigenvalueTable(Time)
go

------------��������ֵ���ݿ��¶ȱ��--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Eigenvalue_TemperatureEigenvalueTable') and name='index_Time')
drop index Eigenvalue_TemperatureEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_TemperatureEigenvalueTable(Time)
go

------------����-�������ݿ���ٱ�--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('Eigenvalue_WindLoadEigenvalueTable') and name='index_Time')
drop index Eigenvalue_WindLoadEigenvalueTable.index_Time
create nonclustered
index index_Time on Eigenvalue_WindLoadEigenvalueTable(Time)
go


------------һ����ȫԤ��-------------
------------����һ����ȫԤ�����ݿ�������--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('SafetyPreWarning_CableForceTable') and name='index_Time')
drop index SafetyPreWarning_CableForceTable.index_Time
create nonclustered
index index_Time on SafetyPreWarning_CableForceTable(Time)
go

------------����һ����ȫԤ�����ݿ�λ�Ʊ�--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('SafetyPreWarning_DisplacementTable') and name='index_Time')
drop index SafetyPreWarning_DisplacementTable.index_Time
create nonclustered
index index_Time on SafetyPreWarning_DisplacementTable(Time)
go

------------����һ����ȫԤ�����ݿ�Ӧ���--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('SafetyPreWarning_StrainTable') and name='index_Time')
drop index SafetyPreWarning_StrainTable.index_Time
create nonclustered
index index_Time on SafetyPreWarning_StrainTable(Time)
go

------------����һ����ȫԤ�����ݿ��¶ȱ�--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('SafetyPreWarning_TemperatureTable') and name='index_Time')
drop index SafetyPreWarning_TemperatureTable.index_Time
create nonclustered
index index_Time on SafetyPreWarning_TemperatureTable(Time)
go

------------����һ����ȫԤ�����ݿ���ٱ�--ʱ��--�зǾۼ�����
if exists(select * from sysindexes where id=object_id('SafetyPreWarning_WindLoadTable') and name='index_Time')
drop index SafetyPreWarning_WindLoadTable.index_Time
create nonclustered
index index_Time on SafetyPreWarning_WindLoadTable(Time)
go
