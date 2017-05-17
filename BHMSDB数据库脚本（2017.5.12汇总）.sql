use BHMSDB
GO
-----------------------------ԭʼ����ת����������--------------------------------------

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


-----------------------------��������ת��ʵʱ�������--------------------------------------

-------------����--------------------------------------
if(OBJECT_ID('tgr_Basic_CableForceToRealTime','TR') is not null)
drop trigger tgr_Basic_CableForceToRealTime
go
create trigger tgr_Basic_CableForceToRealTime
on Basic_CableForceTable
for insert
as
set nocount on
declare @CableForce float,@Frequency float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @CableForce=CableForce from inserted
select @Frequency=Frequency from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

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

-------------�ֹ���Ӧ��--------------------------------------
if(OBJECT_ID('tgr_Basic_SteelArchStrainTableToRealTime','TR') is not null)
drop trigger tgr_Basic_SteelArchStrainTableToRealTime
go
create trigger tgr_Basic_SteelArchStrainTableToRealTime
on Basic_SteelArchStrainTable
for insert
as
set nocount on
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

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

-------------�ָ�Ӧ��--------------------------------------
if(OBJECT_ID('tgr_Basic_SteelLatticeStrainTableToRealTime','TR') is not null)
drop trigger tgr_Basic_SteelLatticeStrainTableToRealTime
go
create trigger tgr_Basic_SteelLatticeStrainTableToRealTime
on Basic_SteelLatticeStrainTable
for insert
as
set nocount on
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

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

-------------������Ӧ��--------------------------------------
if(OBJECT_ID('tgr_Basic_ConcreteStrainTableToRealTime','TR') is not null)
drop trigger tgr_Basic_ConcreteStrainTableToRealTime
go
create trigger tgr_Basic_ConcreteStrainTableToRealTime
on Basic_ConcreteStrainTable
for insert
as
set nocount on
declare @strain float,@Temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @strain=Strain from inserted
select @Temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

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

-------------λ��--------------------------------------
if(OBJECT_ID('tgr_Basic_DisplacementTableToRealTime','TR') is not null)
drop trigger tgr_Basic_DisplacementTableToRealTime
go
create trigger tgr_Basic_DisplacementTableToRealTime
on Basic_DisplacementTable
for insert
as
set nocount on
declare @displacement float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @displacement=Displacement from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

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

-------------�¶�--------------------------------------
if(OBJECT_ID('tgr_Basic_TemperatureTableToRealTime','TR') is not null)
drop trigger tgr_Basic_TemperatureTableToRealTime
go
create trigger tgr_Basic_TemperatureTableToRealTime
on Basic_TemperatureTable
for insert
as
set nocount on
declare @temperature float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @temperature=Temperature from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

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

-------------ʪ��--------------------------------------
if(OBJECT_ID('tgr_Basic_HumidityTableToRealTime','TR') is not null)
drop trigger tgr_Basic_HumidityTableToRealTime
go
create trigger tgr_Basic_HumidityTableToRealTime
on Basic_HumidityTable
for insert
as
set nocount on
declare @humidity float,@Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @humidity=Humidity from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

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

-------------����--------------------------------------
if(OBJECT_ID('tgr_Basic_WindLoadTableToRealTime','TR') is not null)
drop trigger tgr_Basic_WindLoadTableToRealTime
go
create trigger tgr_Basic_WindLoadTableToRealTime
on Basic_WindLoadTable
for insert
as
set nocount on
declare @windSpeed float,@WindDirection float, @Time datetime,@PointsNumberId int,@ThresholdGradeId int
select @windSpeed=WindSpeed from inserted
select @WindDirection=WindDirection from inserted
select @Time="Time" from inserted
select @PointsNumberId=PointsNumberId from inserted
select @ThresholdGradeId=ThresholdGradeId from inserted

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