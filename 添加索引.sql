use BHMSDB

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
