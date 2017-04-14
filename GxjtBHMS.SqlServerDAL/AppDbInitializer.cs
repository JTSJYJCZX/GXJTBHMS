using GxjtBHMS.Infrastructure;
using GxjtBHMS.Models;
using GxjtBHMS.Models.Encryption;
using System.Data.Entity;
using System.Collections.Generic;
using System;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Models.AbnormalThresholdValueSetting;

namespace GxjtBHMS.SqlServerDAL
{
    class AppDbInitializer : DropCreateDatabaseIfModelChanges<BHMSContext>
    {
        const int InitNormalUserStartNumber = 1;
        const int InitNormalUserNumber = 20;
        const int InitSuspendedUserNumber = 4;
        const int InitTotalUserNumber = InitNormalUserNumber + InitSuspendedUserNumber;
        const int InitSuspendedUserStartNumber = InitNormalUserNumber + InitNormalUserStartNumber;

        const string SteelArchStrainTypeName = "钢拱肋应变";
        const string SteelLatticeStrainTypeName = "钢格构应变";
        const string ConcreteStrainTypeName = "混凝土应变";
        const string DisplacementTypeName = "位移";
        const string CableForceTypeName = "索力";
        const string WindSpeedTypeName = "风速";
        const string TemperatureTypeName = "温度";
        const string HumidityTypeName = "湿度";

        MonitoringTestType steelArchStrainType = new MonitoringTestType { Name = SteelArchStrainTypeName, Unit = "(με)" };
        MonitoringTestType steelLatticeStrainType = new MonitoringTestType { Name = SteelLatticeStrainTypeName, Unit = "(με)" };
        MonitoringTestType concreteStrainType = new MonitoringTestType { Name = ConcreteStrainTypeName, Unit = "(με)" };
        MonitoringTestType displacementType = new MonitoringTestType { Name = DisplacementTypeName, Unit = "(mm)" };
        MonitoringTestType cableForceType = new MonitoringTestType { Name = CableForceTypeName, Unit = "(kN)" };
        MonitoringTestType windSpeedType = new MonitoringTestType { Name = WindSpeedTypeName, Unit = "(m/s)" };
        MonitoringTestType temperatureType = new MonitoringTestType { Name = TemperatureTypeName, Unit = "(℃)" };
        MonitoringTestType humidityType = new MonitoringTestType { Name = HumidityTypeName, Unit = "(%)" };

        /// <summary>
        /// 应变截面号
        /// </summary>
        MonitoringPointsPosition steelArchStrainSectionA = new MonitoringPointsPosition { Name = "钢拱肋A截面", Description = "高旺路侧边跨钢拱肋测试截面" };
        MonitoringPointsPosition steelArchStrainSectionB = new MonitoringPointsPosition { Name = "钢拱肋B截面", Description = "高旺路侧中跨钢拱肋测试截面" };
        MonitoringPointsPosition steelArchStrainSectionC = new MonitoringPointsPosition { Name = "钢拱肋C截面", Description = "中跨钢拱肋拱顶测试截面" };
        MonitoringPointsPosition steelArchStrainSectionD = new MonitoringPointsPosition { Name = "钢拱肋D截面", Description = "新兴一路侧中跨钢拱肋测试截面" };
        MonitoringPointsPosition steelArchStrainSectionE = new MonitoringPointsPosition { Name = "钢拱肋E截面", Description = "新兴一路侧边跨钢拱肋测试截面" };
        MonitoringPointsPosition archTransverseBraceStrainSectionA = new MonitoringPointsPosition { Name = "拱肋横撑A截面", Description = "" };
        MonitoringPointsPosition archTransverseBraceStrainSectionB = new MonitoringPointsPosition { Name = "拱肋横撑B截面", Description = "" };
        MonitoringPointsPosition intercostalTransverseBeamStrainSectionA = new MonitoringPointsPosition { Name = "肋间横梁A截面", Description = "" };
        MonitoringPointsPosition intercostalTransverseBeamStrainSectionB = new MonitoringPointsPosition { Name = "肋间横梁B截面", Description = "" };
        MonitoringPointsPosition upperSteelCrossBeamStrainSectionA = new MonitoringPointsPosition { Name = "上层钢横梁A截面", Description = "" };
        MonitoringPointsPosition upperSteelCrossBeamStrainSectionB = new MonitoringPointsPosition { Name = "上层钢横梁B截面", Description = "" };
        MonitoringPointsPosition upperSteelLongitudinalBeamStrainSectionA = new MonitoringPointsPosition { Name = "上层钢纵梁A截面", Description = "" };
        MonitoringPointsPosition upperSteelLongitudinalBeamStrainSectionB = new MonitoringPointsPosition { Name = "上层钢纵梁B截面", Description = "" };
        MonitoringPointsPosition rigidTiedBarStrainSectionA = new MonitoringPointsPosition { Name = "刚性系杆A截面", Description = "" };
        MonitoringPointsPosition rigidTiedBarStrainSectionB = new MonitoringPointsPosition { Name = "刚性系杆B截面", Description = "" };
        MonitoringPointsPosition concreteArchStrainSectionA = new MonitoringPointsPosition { Name = "混凝土拱肋A截面", Description = "" };
        MonitoringPointsPosition concreteArchStrainSectionB = new MonitoringPointsPosition { Name = "混凝土拱肋B截面", Description = "" };

        /// <summary>
        /// 位移截面号
        /// </summary>
        MonitoringPointsPosition steelArchDis = new MonitoringPointsPosition { Name = "钢拱肋位移", Description = "钢拱肋位移" };
        MonitoringPointsPosition bridgeDeckDis = new MonitoringPointsPosition { Name = "桥面挠度", Description = "桥面挠度" };
        MonitoringPointsPosition transitionPierDis = new MonitoringPointsPosition { Name = "过渡墩变形", Description = "过渡墩变形" };
        MonitoringPointsPosition expansionDis = new MonitoringPointsPosition { Name = "伸缩缝变形", Description = "伸缩缝变形" };

        /// <summary>
        /// 温度截面号
        /// </summary>
        MonitoringPointsPosition environmentTemp = new MonitoringPointsPosition { Name = "环境温度", Description = "" };
        MonitoringPointsPosition steelArchTemp = new MonitoringPointsPosition { Name = "钢拱肋温度", Description = "" };

        /// <summary>
        /// 湿度截面号
        /// </summary>
        MonitoringPointsPosition environmentHum = new MonitoringPointsPosition { Name = "环境湿度", Description = "" };
        MonitoringPointsPosition steelArchHum = new MonitoringPointsPosition { Name = "钢拱肋湿度", Description = "" };

        /// <summary>
        /// 索力测试位置
        /// </summary>
        MonitoringPointsPosition upperHangerCableForce = new MonitoringPointsPosition { Name = "上层吊杆", Description = "" };
        MonitoringPointsPosition underHangerCableForce = new MonitoringPointsPosition { Name = "下层吊杆", Description = "" };
        MonitoringPointsPosition flexibleTiedBarCableForce = new MonitoringPointsPosition { Name = "柔性系杆", Description = "" };

        /// <summary>
        /// 风载测试位置
        /// </summary>
        MonitoringPointsPosition windLoad = new MonitoringPointsPosition { Name = "风载", Description = "跨中拱顶" };

        /// <summary>
        /// 应变测点号
        /// </summary>
        //钢拱肋应变
        MonitoringPointsNumber sSAAL1Point = new MonitoringPointsNumber { Name = "S-SA-AL1" };
        MonitoringPointsNumber sSAAL2Point = new MonitoringPointsNumber { Name = "S-SA-AL2" };
        MonitoringPointsNumber sSAAL3Point = new MonitoringPointsNumber { Name = "S-SA-AL3" };
        MonitoringPointsNumber sSAAL4Point = new MonitoringPointsNumber { Name = "S-SA-AL4" };
        MonitoringPointsNumber sSAAR1Point = new MonitoringPointsNumber { Name = "S-SA-AR1" };
        MonitoringPointsNumber sSAAR2Point = new MonitoringPointsNumber { Name = "S-SA-AR2" };
        MonitoringPointsNumber sSAAR3Point = new MonitoringPointsNumber { Name = "S-SA-AR3" };
        MonitoringPointsNumber sSAAR4Point = new MonitoringPointsNumber { Name = "S-SA-AR4" };
        MonitoringPointsNumber sSABL1Point = new MonitoringPointsNumber { Name = "S-SA-BL1" };
        MonitoringPointsNumber sSABL2Point = new MonitoringPointsNumber { Name = "S-SA-BL2" };
        MonitoringPointsNumber sSABL3Point = new MonitoringPointsNumber { Name = "S-SA-BL3" };
        MonitoringPointsNumber sSABL4Point = new MonitoringPointsNumber { Name = "S-SA-BL4" };
        MonitoringPointsNumber sSABR1Point = new MonitoringPointsNumber { Name = "S-SA-BR1" };
        MonitoringPointsNumber sSABR2Point = new MonitoringPointsNumber { Name = "S-SA-BR2" };
        MonitoringPointsNumber sSABR3Point = new MonitoringPointsNumber { Name = "S-SA-BR3" };
        MonitoringPointsNumber sSABR4Point = new MonitoringPointsNumber { Name = "S-SA-BR4" };

        MonitoringPointsNumber sSACL1Point = new MonitoringPointsNumber { Name = "S-SA-CL1" };
        MonitoringPointsNumber sSACL2Point = new MonitoringPointsNumber { Name = "S-SA-CL2" };
        MonitoringPointsNumber sSACL3Point = new MonitoringPointsNumber { Name = "S-SA-CL3" };
        MonitoringPointsNumber sSACL4Point = new MonitoringPointsNumber { Name = "S-SA-CL4" };
        MonitoringPointsNumber sSACR1Point = new MonitoringPointsNumber { Name = "S-SA-CR1" };
        MonitoringPointsNumber sSACR2Point = new MonitoringPointsNumber { Name = "S-SA-CR2" };
        MonitoringPointsNumber sSACR3Point = new MonitoringPointsNumber { Name = "S-SA-CR3" };
        MonitoringPointsNumber sSACR4Point = new MonitoringPointsNumber { Name = "S-SA-CR4" };

        MonitoringPointsNumber sSADL1Point = new MonitoringPointsNumber { Name = "S-SA-DL1" };
        MonitoringPointsNumber sSADL2Point = new MonitoringPointsNumber { Name = "S-SA-DL2" };
        MonitoringPointsNumber sSADL3Point = new MonitoringPointsNumber { Name = "S-SA-DL3" };
        MonitoringPointsNumber sSADL4Point = new MonitoringPointsNumber { Name = "S-SA-DL4" };
        MonitoringPointsNumber sSADR1Point = new MonitoringPointsNumber { Name = "S-SA-DR1" };
        MonitoringPointsNumber sSADR2Point = new MonitoringPointsNumber { Name = "S-SA-DR2" };
        MonitoringPointsNumber sSADR3Point = new MonitoringPointsNumber { Name = "S-SA-DR3" };
        MonitoringPointsNumber sSADR4Point = new MonitoringPointsNumber { Name = "S-SA-DR4" };

        MonitoringPointsNumber sSAEL1Point = new MonitoringPointsNumber { Name = "S-SA-EL1" };
        MonitoringPointsNumber sSAEL2Point = new MonitoringPointsNumber { Name = "S-SA-EL2" };
        MonitoringPointsNumber sSAEL3Point = new MonitoringPointsNumber { Name = "S-SA-EL3" };
        MonitoringPointsNumber sSAEL4Point = new MonitoringPointsNumber { Name = "S-SA-EL4" };
        MonitoringPointsNumber sSAER1Point = new MonitoringPointsNumber { Name = "S-SA-ER1" };
        MonitoringPointsNumber sSAER2Point = new MonitoringPointsNumber { Name = "S-SA-ER2" };
        MonitoringPointsNumber sSAER3Point = new MonitoringPointsNumber { Name = "S-SA-ER3" };
        MonitoringPointsNumber sSAER4Point = new MonitoringPointsNumber { Name = "S-SA-ER4" };

        MonitoringPointsNumber sATBA1Point = new MonitoringPointsNumber { Name = "S-ATB-A1" };
        MonitoringPointsNumber sATBA2Point = new MonitoringPointsNumber { Name = "S-ATB-A2" };
        MonitoringPointsNumber sATBA3Point = new MonitoringPointsNumber { Name = "S-ATB-A3" };
        MonitoringPointsNumber sATBA4Point = new MonitoringPointsNumber { Name = "S-ATB-A4" };
        MonitoringPointsNumber sATBB1Point = new MonitoringPointsNumber { Name = "S-ATB-B1" };
        MonitoringPointsNumber sATBB2Point = new MonitoringPointsNumber { Name = "S-ATB-B2" };
        MonitoringPointsNumber sATBB3Point = new MonitoringPointsNumber { Name = "S-ATB-B3" };
        MonitoringPointsNumber sATBB4Point = new MonitoringPointsNumber { Name = "S-ATB-B4" };

        //钢格构应变
        MonitoringPointsNumber sITBA1Point = new MonitoringPointsNumber { Name = "S-ITB-A1" };
        MonitoringPointsNumber sITBA2Point = new MonitoringPointsNumber { Name = "S-ITB-A2" };
        MonitoringPointsNumber sITBB1Point = new MonitoringPointsNumber { Name = "S-ITB-B1" };
        MonitoringPointsNumber sITBB2Point = new MonitoringPointsNumber { Name = "S-ITB-B2" };
        MonitoringPointsNumber sUSCBA1Point = new MonitoringPointsNumber { Name = "S-USCB-A1" };
        MonitoringPointsNumber sUSCBA2Point = new MonitoringPointsNumber { Name = "S-USCB-A2" };
        MonitoringPointsNumber sUSCBB1Point = new MonitoringPointsNumber { Name = "S-USCB-B1" };
        MonitoringPointsNumber sUSCBB2Point = new MonitoringPointsNumber { Name = "S-USCB-B2" };
        MonitoringPointsNumber sUSLBA1Point = new MonitoringPointsNumber { Name = "S-USLB-A1" };
        MonitoringPointsNumber sUSLBA2Point = new MonitoringPointsNumber { Name = "S-USLB-A2" };
        MonitoringPointsNumber sUSLBA3Point = new MonitoringPointsNumber { Name = "S-USLB-A3" };
        MonitoringPointsNumber sUSLBB1Point = new MonitoringPointsNumber { Name = "S-USLB-B1" };
        MonitoringPointsNumber sUSLBB2Point = new MonitoringPointsNumber { Name = "S-USLB-B2" };
        MonitoringPointsNumber sUSLBB3Point = new MonitoringPointsNumber { Name = "S-USLB-B3" };

        MonitoringPointsNumber sRTBAL1Point = new MonitoringPointsNumber { Name = "S-RTB-AL1" };
        MonitoringPointsNumber sRTBAL2Point = new MonitoringPointsNumber { Name = "S-RTB-AL2" };
        MonitoringPointsNumber sRTBAL3Point = new MonitoringPointsNumber { Name = "S-RTB-AL3" };
        MonitoringPointsNumber sRTBAL4Point = new MonitoringPointsNumber { Name = "S-RTB-AL4" };
        MonitoringPointsNumber sRTBAR1Point = new MonitoringPointsNumber { Name = "S-RTB-AR1" };
        MonitoringPointsNumber sRTBAR2Point = new MonitoringPointsNumber { Name = "S-RTB-AR2" };
        MonitoringPointsNumber sRTBAR3Point = new MonitoringPointsNumber { Name = "S-RTB-AR3" };
        MonitoringPointsNumber sRTBAR4Point = new MonitoringPointsNumber { Name = "S-RTB-AR4" };

        MonitoringPointsNumber sRTBBL1Point = new MonitoringPointsNumber { Name = "S-RTB-BL1" };
        MonitoringPointsNumber sRTBBL2Point = new MonitoringPointsNumber { Name = "S-RTB-BL2" };
        MonitoringPointsNumber sRTBBL3Point = new MonitoringPointsNumber { Name = "S-RTB-BL3" };
        MonitoringPointsNumber sRTBBL4Point = new MonitoringPointsNumber { Name = "S-RTB-BL4" };
        MonitoringPointsNumber sRTBBR1Point = new MonitoringPointsNumber { Name = "S-RTB-BR1" };
        MonitoringPointsNumber sRTBBR2Point = new MonitoringPointsNumber { Name = "S-RTB-BR2" };
        MonitoringPointsNumber sRTBBR3Point = new MonitoringPointsNumber { Name = "S-RTB-BR3" };
        MonitoringPointsNumber sRTBBR4Point = new MonitoringPointsNumber { Name = "S-RTB-BR4" };

        //混凝土应变
        MonitoringPointsNumber sCAAL1Point = new MonitoringPointsNumber { Name = "S-CA-AL1" };
        MonitoringPointsNumber sCAAL2Point = new MonitoringPointsNumber { Name = "S-CA-AL2" };
        MonitoringPointsNumber sCAAL3Point = new MonitoringPointsNumber { Name = "S-CA-AL3" };
        MonitoringPointsNumber sCAAL4Point = new MonitoringPointsNumber { Name = "S-CA-AL4" };
        MonitoringPointsNumber sCAAR1Point = new MonitoringPointsNumber { Name = "S-CA-AR1" };
        MonitoringPointsNumber sCAAR2Point = new MonitoringPointsNumber { Name = "S-CA-AR2" };
        MonitoringPointsNumber sCAAR3Point = new MonitoringPointsNumber { Name = "S-CA-AR3" };
        MonitoringPointsNumber sCAAR4Point = new MonitoringPointsNumber { Name = "S-CA-AR4" };
        MonitoringPointsNumber sCABL1Point = new MonitoringPointsNumber { Name = "S-CA-BL1" };
        MonitoringPointsNumber sCABL2Point = new MonitoringPointsNumber { Name = "S-CA-BL2" };
        MonitoringPointsNumber sCABL3Point = new MonitoringPointsNumber { Name = "S-CA-BL3" };
        MonitoringPointsNumber sCABL4Point = new MonitoringPointsNumber { Name = "S-CA-BL4" };
        MonitoringPointsNumber sCABR1Point = new MonitoringPointsNumber { Name = "S-CA-BR1" };
        MonitoringPointsNumber sCABR2Point = new MonitoringPointsNumber { Name = "S-CA-BR2" };
        MonitoringPointsNumber sCABR3Point = new MonitoringPointsNumber { Name = "S-CA-BR3" };
        MonitoringPointsNumber sCABR4Point = new MonitoringPointsNumber { Name = "S-CA-BR4" };


        /// <summary>
        /// 位移测点号
        /// </summary>
        MonitoringPointsNumber dSA1xPoint = new MonitoringPointsNumber { Name = "D-SA-1x" };
        MonitoringPointsNumber dSA2xPoint = new MonitoringPointsNumber { Name = "D-SA-2x" };
        MonitoringPointsNumber dSA3xPoint = new MonitoringPointsNumber { Name = "D-SA-3x" };
        MonitoringPointsNumber dSA4xPoint = new MonitoringPointsNumber { Name = "D-SA-4x" };
        MonitoringPointsNumber dSA1yPoint = new MonitoringPointsNumber { Name = "D-SA-1y" };
        MonitoringPointsNumber dSA2yPoint = new MonitoringPointsNumber { Name = "D-SA-2y" };
        MonitoringPointsNumber dSA3yPoint = new MonitoringPointsNumber { Name = "D-SA-3y" };
        MonitoringPointsNumber dSA4yPoint = new MonitoringPointsNumber { Name = "D-SA-4y" };
        MonitoringPointsNumber dSA1zPoint = new MonitoringPointsNumber { Name = "D-SA-1z" };
        MonitoringPointsNumber dSA2zPoint = new MonitoringPointsNumber { Name = "D-SA-2z" };
        MonitoringPointsNumber dSA3zPoint = new MonitoringPointsNumber { Name = "D-SA-3z" };
        MonitoringPointsNumber dSA4zPoint = new MonitoringPointsNumber { Name = "D-SA-4z" };
        MonitoringPointsNumber dBD1Point = new MonitoringPointsNumber { Name = "D-BD-1" };
        MonitoringPointsNumber dBD2Point = new MonitoringPointsNumber { Name = "D-BD-2" };
        MonitoringPointsNumber dBD3Point = new MonitoringPointsNumber { Name = "D-BD-3" };
        MonitoringPointsNumber dBD4Point = new MonitoringPointsNumber { Name = "D-BD-4" };
        MonitoringPointsNumber dBD5Point = new MonitoringPointsNumber { Name = "D-BD-5" };
        MonitoringPointsNumber dBD6Point = new MonitoringPointsNumber { Name = "D-BD-6" };
        MonitoringPointsNumber dSP1Point = new MonitoringPointsNumber { Name = "D-SP-1" };
        MonitoringPointsNumber dSP2Point = new MonitoringPointsNumber { Name = "D-SP-2" };
        MonitoringPointsNumber dSP3Point = new MonitoringPointsNumber { Name = "D-SP-3" };
        MonitoringPointsNumber dSP4Point = new MonitoringPointsNumber { Name = "D-SP-4" };
        MonitoringPointsNumber dE1Point = new MonitoringPointsNumber { Name = "D-E-1" };
        MonitoringPointsNumber dE2Point = new MonitoringPointsNumber { Name = "D-E-2" };
        MonitoringPointsNumber dE3Point = new MonitoringPointsNumber { Name = "D-E-3" };
        MonitoringPointsNumber dE4Point = new MonitoringPointsNumber { Name = "D-E-4" };


        /// <summary>
        /// 温度测点号
        /// </summary>
        MonitoringPointsNumber tE1Point = new MonitoringPointsNumber { Name = "T-E-1" };
        MonitoringPointsNumber tSAL1Point = new MonitoringPointsNumber { Name = "T-SA-L1" };
        MonitoringPointsNumber tSAL2Point = new MonitoringPointsNumber { Name = "T-SA-L2" };
        MonitoringPointsNumber tSAL3Point = new MonitoringPointsNumber { Name = "T-SA-L3" };
        MonitoringPointsNumber tSAL4Point = new MonitoringPointsNumber { Name = "T-SA-L4" };
        MonitoringPointsNumber tSAR1Point = new MonitoringPointsNumber { Name = "T-SA-R1" };
        MonitoringPointsNumber tSAR2Point = new MonitoringPointsNumber { Name = "T-SA-R2" };
        MonitoringPointsNumber tSAR3Point = new MonitoringPointsNumber { Name = "T-SA-R3" };
        MonitoringPointsNumber tSAR4Point = new MonitoringPointsNumber { Name = "T-SA-R4" };


        /// <summary>
        /// 湿度测点号
        /// </summary>
        MonitoringPointsNumber hE1Point = new MonitoringPointsNumber { Name = "H-E-1" };
        MonitoringPointsNumber hSAL1Point = new MonitoringPointsNumber { Name = "H-SA-L1" };
        MonitoringPointsNumber hSAL2Point = new MonitoringPointsNumber { Name = "H-SA-L2" };
        MonitoringPointsNumber hSAL3Point = new MonitoringPointsNumber { Name = "H-SA-L3" };
        MonitoringPointsNumber hSAL4Point = new MonitoringPointsNumber { Name = "H-SA-L4" };
        MonitoringPointsNumber hSAR1Point = new MonitoringPointsNumber { Name = "H-SA-R1" };
        MonitoringPointsNumber hSAR2Point = new MonitoringPointsNumber { Name = "H-SA-R2" };
        MonitoringPointsNumber hSAR3Point = new MonitoringPointsNumber { Name = "H-SA-R3" };
        MonitoringPointsNumber hSAR4Point = new MonitoringPointsNumber { Name = "H-SA-R4" };


        /// <summary>
        /// 索力测点号
        /// </summary>
        // 上层吊杆
        MonitoringPointsNumber cFUPHL1Point = new MonitoringPointsNumber { Name = "CF-UPH-L1" };
        MonitoringPointsNumber cFUPHL2Point = new MonitoringPointsNumber { Name = "CF-UPH-L2" };
        MonitoringPointsNumber cFUPHL3Point = new MonitoringPointsNumber { Name = "CF-UPH-L3" };
        MonitoringPointsNumber cFUPHL4Point = new MonitoringPointsNumber { Name = "CF-UPH-L4" };
        MonitoringPointsNumber cFUPHL5Point = new MonitoringPointsNumber { Name = "CF-UPH-L5" };
        MonitoringPointsNumber cFUPHL6Point = new MonitoringPointsNumber { Name = "CF-UPH-L6" };
        MonitoringPointsNumber cFUPHL7Point = new MonitoringPointsNumber { Name = "CF-UPH-L7" };
        MonitoringPointsNumber cFUPHL8Point = new MonitoringPointsNumber { Name = "CF-UPH-L8" };
        MonitoringPointsNumber cFUPHL9Point = new MonitoringPointsNumber { Name = "CF-UPH-L9" };
        MonitoringPointsNumber cFUPHR1Point = new MonitoringPointsNumber { Name = "CF-UPH-R1" };
        MonitoringPointsNumber cFUPHR2Point = new MonitoringPointsNumber { Name = "CF-UPH-R2" };
        MonitoringPointsNumber cFUPHR3Point = new MonitoringPointsNumber { Name = "CF-UPH-R3" };
        MonitoringPointsNumber cFUPHR4Point = new MonitoringPointsNumber { Name = "CF-UPH-R4" };
        MonitoringPointsNumber cFUPHR5Point = new MonitoringPointsNumber { Name = "CF-UPH-R5" };
        MonitoringPointsNumber cFUPHR6Point = new MonitoringPointsNumber { Name = "CF-UPH-R6" };
        MonitoringPointsNumber cFUPHR7Point = new MonitoringPointsNumber { Name = "CF-UPH-R7" };
        MonitoringPointsNumber cFUPHR8Point = new MonitoringPointsNumber { Name = "CF-UPH-R8" };
        MonitoringPointsNumber cFUPHR9Point = new MonitoringPointsNumber { Name = "CF-UPH-R9" };

        //下层吊杆
        MonitoringPointsNumber cFUNHL1Point = new MonitoringPointsNumber { Name = "CF-UNH-L1" };
        MonitoringPointsNumber cFUNHL2Point = new MonitoringPointsNumber { Name = "CF-UNH-L2" };
        MonitoringPointsNumber cFUNHL3Point = new MonitoringPointsNumber { Name = "CF-UNH-L3" };
        MonitoringPointsNumber cFUNHL4Point = new MonitoringPointsNumber { Name = "CF-UNH-L4" };
        MonitoringPointsNumber cFUNHR1Point = new MonitoringPointsNumber { Name = "CF-UNH-R1" };
        MonitoringPointsNumber cFUNHR2Point = new MonitoringPointsNumber { Name = "CF-UNH-R2" };
        MonitoringPointsNumber cFUNHR3Point = new MonitoringPointsNumber { Name = "CF-UNH-R3" };
        MonitoringPointsNumber cFUNHR4Point = new MonitoringPointsNumber { Name = "CF-UNH-R4" };

        //柔性系杆
        MonitoringPointsNumber cFFTBL1Point = new MonitoringPointsNumber { Name = "CF-FTB-L1" };
        MonitoringPointsNumber cFFTBL2Point = new MonitoringPointsNumber { Name = "CF-FTB-L2" };
        MonitoringPointsNumber cFFTBL3Point = new MonitoringPointsNumber { Name = "CF-FTB-L3" };
        MonitoringPointsNumber cFFTBL4Point = new MonitoringPointsNumber { Name = "CF-FTB-L4" };
        MonitoringPointsNumber cFFTBL5Point = new MonitoringPointsNumber { Name = "CF-FTB-L5" };
        MonitoringPointsNumber cFFTBL6Point = new MonitoringPointsNumber { Name = "CF-FTB-L6" };
        MonitoringPointsNumber cFFTBR1Point = new MonitoringPointsNumber { Name = "CF-FTB-R1" };
        MonitoringPointsNumber cFFTBR2Point = new MonitoringPointsNumber { Name = "CF-FTB-R2" };
        MonitoringPointsNumber cFFTBR3Point = new MonitoringPointsNumber { Name = "CF-FTB-R3" };
        MonitoringPointsNumber cFFTBR4Point = new MonitoringPointsNumber { Name = "CF-FTB-R4" };
        MonitoringPointsNumber cFFTBR5Point = new MonitoringPointsNumber { Name = "CF-FTB-R5" };
        MonitoringPointsNumber cFFTBR6Point = new MonitoringPointsNumber { Name = "CF-FTB-R6" };

        MonitoringPointsNumber wL1Point = new MonitoringPointsNumber { Name = "WL-1" };

        /// <summary>
        /// 预警等级
        /// </summary>
        /// <param name="context"></param>
        ThresholdGradeTable ThresholdGrade1 = new ThresholdGradeTable
        {
            ThresholdGrade = "正常",
            Suggest="无",
            ThresholdColor = "Green"
        };
        ThresholdGradeTable ThresholdGrade2 = new ThresholdGradeTable
        {
            ThresholdGrade = "黄色预警",
            Suggest="加强观测",
            ThresholdColor = "Gold"
        };
        ThresholdGradeTable ThresholdGrade3 = new ThresholdGradeTable
        {
            ThresholdGrade = "红色预警",
            Suggest="进行专项检查",
            ThresholdColor = "Red"
        };


        protected override void Seed(BHMSContext context)
        {
            InitDbDatas(context);
            base.Seed(context);
        }
        /// <summary>
        /// 自定义初始化DB数据方法
        /// </summary>
        /// <param name="context">EF上下文</param>
        void InitDbDatas(BHMSContext context)
        {
            InitUserStates(context);
            CreateAdminUser(context);
            CreateNormalUsers(context);
            CreateSuspendedUsers(context);
            CreateMonitoringTestType(context);
            CreateMonitoringDatas(context);
            CreateStrainThresholdValues(context);
            CreateDisplaymentThresholdValues(context);
            CreateCableForceThresholdValues(context);
            CreateTemperatureThresholdValues(context);
            CreateHumidityThresholdValues(context);
            CreateWindloadThresholdValues(context);
            CreateAbnormalThresholdValue(context);
            CreateSafetyPreWarning(context);
            CreateThresholdGradeValue(context);
        }

        /// <summary>
        /// 初始化索力安全预警值，安全预警表格的内容
        /// </summary>
        /// <param name="context"></param>
        private void CreateSafetyPreWarning(BHMSContext context)
        {
            InitialSafetyPreWarning(context);
        }

        private void InitialSafetyPreWarning(BHMSContext context)
        {
            var random = new Random();
            int intlTime = 5;
            for (int i = 0; i <= 15; i++)
            {
                DateTime time = DateTime.Now.AddMinutes(intlTime + i);
                for (int j = 0; j < tmpNumbers26.Length; j++)
                {
                    var SafetyPreWarning_CableFrces = new SafetyPreWarning_CableForceTable { PointsNumber = tmpNumbers26[j], Time = time, MonitoringData = random.Next(2100, 2500), ThresholdValue = 2000, ThresholdGrade = ThresholdGrade2 };
                    context.SafetyPreWarning_CableFrces.Add(SafetyPreWarning_CableFrces);
                }
                for (int j = 0; j < tmpNumbers27.Length; j++)
                {
                    var SafetyPreWarning_CableFrces = new SafetyPreWarning_CableForceTable { PointsNumber = tmpNumbers27[j], Time = time, MonitoringData = random.Next(2210, 2500), ThresholdValue = 2200, ThresholdGrade = ThresholdGrade3 };
                    context.SafetyPreWarning_CableFrces.Add(SafetyPreWarning_CableFrces);
                }
                for (int j = 0; j < tmpNumbers28.Length; j++)
                {
                    var SafetyPreWarning_CableFrces = new SafetyPreWarning_CableForceTable { PointsNumber = tmpNumbers28[j], Time = time, MonitoringData = random.Next(1500, 1900), ThresholdValue = 2000, ThresholdGrade = ThresholdGrade2 };
                    context.SafetyPreWarning_CableFrces.Add(SafetyPreWarning_CableFrces);
                }
                //温度安全预警表格
                for (int j = 0; j < tmpNumbers24.Length; j++)
                {
                    var SafetyPreWarning_Temperatures = new SafetyPreWarning_TemperatureTable { PointsNumber = tmpNumbers24[j], Time = time, MonitoringData = random.Next(30, 40), ThresholdValue = 30, ThresholdGrade = ThresholdGrade2 };
                    context.SafetyPreWarning_Temperatures.Add(SafetyPreWarning_Temperatures);
                }
                for (int j = 0; j < tmpNumbers25.Length; j++)
                {
                    var SafetyPreWarning_Temperatures = new SafetyPreWarning_TemperatureTable { PointsNumber = tmpNumbers25[j], Time = time, MonitoringData = random.Next(30, 40), ThresholdValue = 30, ThresholdGrade = ThresholdGrade2 };
                    context.SafetyPreWarning_Temperatures.Add(SafetyPreWarning_Temperatures);
                }
                //风速
                for (int j = 0; j < tmpNumbers29.Length; j++)
                {
                    var SafetyPreWarning_windloads = new SafetyPreWarning_WindLoadTable { PointsNumber = tmpNumbers29[j], Time = time, MonitoringData = random.Next(5, 8), ThresholdValue = 5, ThresholdGrade = ThresholdGrade2 };
                    context.SafetyPreWarning_WindLoads.Add(SafetyPreWarning_windloads);
                }
                //位移
                for (int j = 0; j < tmpNumbers18.Length; j++)
                {
                    var SafetyPreWarning_Displacements = new SafetyPreWarning_DisplacementTable { PointsNumber = tmpNumbers18[j], Time = time, MonitoringData = random.Next(3, 5), ThresholdValue = 3, ThresholdGrade = ThresholdGrade2 };
                    context.SafetyPreWarning_Displacements.Add(SafetyPreWarning_Displacements);
                }
                for (int j = 0; j < tmpNumbers19.Length; j++)
                {
                    var SafetyPreWarning_Displacements = new SafetyPreWarning_DisplacementTable { PointsNumber = tmpNumbers19[j], Time = time, MonitoringData = random.Next(5, 8), ThresholdValue = 5, ThresholdGrade = ThresholdGrade3 };
                    context.SafetyPreWarning_Displacements.Add(SafetyPreWarning_Displacements);
                }
                for (int j = 0; j < tmpNumbers20.Length; j++)
                {
                    var SafetyPreWarning_Displacements = new SafetyPreWarning_DisplacementTable { PointsNumber = tmpNumbers20[j], Time = time, MonitoringData = random.Next(3, 5), ThresholdValue = 3, ThresholdGrade = ThresholdGrade2 };
                    context.SafetyPreWarning_Displacements.Add(SafetyPreWarning_Displacements);
                }
                for (int j = 0; j < tmpNumbers21.Length; j++)
                {
                    var SafetyPreWarning_Displacements = new SafetyPreWarning_DisplacementTable { PointsNumber = tmpNumbers21[j], Time = time, MonitoringData = random.Next(3, 5), ThresholdValue = 3, ThresholdGrade = ThresholdGrade2 };
                    context.SafetyPreWarning_Displacements.Add(SafetyPreWarning_Displacements);
                }
            }
        }
        /// <summary>
        /// 预警等级初始化
        /// </summary>
        /// <param name="context"></param>
        private void CreateThresholdGradeValue(BHMSContext context)
        {

            context.ThresholdGradeModel.Add(ThresholdGrade1);
            context.ThresholdGradeModel.Add(ThresholdGrade2);
            context.ThresholdGradeModel.Add(ThresholdGrade3);
        }



        /// <summary>
        /// 风速阈值设置
        /// </summary>
        /// <param name="context"></param>
        private void CreateWindloadThresholdValues(BHMSContext context)
        {
            InitialWindloadThresholdValue(context);
        }

        private void InitialWindloadThresholdValue(BHMSContext context)
        {
            var p = 40;
            for (int i = 0; i < tmpNumbers29.Length; i++)
            {
                var ThresholdValue = new WindLoadThresholdValueTable
                {
                    PointsNumber = tmpNumbers29[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                };
                context.WindLoadThresholdValues.Add(ThresholdValue);
            }
        }


        /// <summary>
        /// 湿度阈值设置
        /// </summary>
        /// <param name="context"></param>
        private void CreateHumidityThresholdValues(BHMSContext context)
        {
            InitialHumidityThresholdValue(context);
        }

        private void InitialHumidityThresholdValue(BHMSContext context)
        {
            var p = 80;
            for (int i = 0; i < tmpNumbers24.Length; i++)
            {
                var ThresholdValue = new HumidityThresholdValueTable
                {
                    PointsNumber = tmpNumbers24[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                };
                context.HumidityThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers25.Length; i++)
            {
                var ThresholdValue = new HumidityThresholdValueTable
                {
                    PointsNumber = tmpNumbers25[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                };
                context.HumidityThresholdValues.Add(ThresholdValue);
            }

        }

        /// <summary>
        /// 温度阈值设置
        /// </summary>
        /// <param name="context"></param>
        private void CreateTemperatureThresholdValues(BHMSContext context)
        {
            InitialTemperatureThresholdValue(context);
        }

        private void InitialTemperatureThresholdValue(BHMSContext context)
        {
            var p = 80;
            var n = -20;
            for (int i = 0; i < tmpNumbers22.Length; i++)
            {
                var ThresholdValue = new TemperatureThresholdValueTable
                {
                    PointsNumber = tmpNumbers22[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.TemperatureThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers23.Length; i++)
            {
                var ThresholdValue = new TemperatureThresholdValueTable
                {
                    PointsNumber = tmpNumbers23[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.TemperatureThresholdValues.Add(ThresholdValue);
            }
        }

        /// <summary>
        /// 初始化索力阈值
        /// </summary>
        /// <param name="context"></param>
        private void CreateCableForceThresholdValues(BHMSContext context)
        {
            InitialCableForceThresholdValue(context);
        }

        private void InitialCableForceThresholdValue(BHMSContext context)
        {
            var p = 2500;
            for (int i = 0; i < tmpNumbers26.Length; i++)
            {
                var ThresholdValue = new CableForceThresholdValueTable
                {
                    PointsNumber = tmpNumbers26[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                };
                context.CableForceThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers27.Length; i++)
            {
                var ThresholdValue = new CableForceThresholdValueTable
                {
                    PointsNumber = tmpNumbers27[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                };
                context.CableForceThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers28.Length; i++)
            {
                var ThresholdValue = new CableForceThresholdValueTable
                {
                    PointsNumber = tmpNumbers28[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                };
                context.CableForceThresholdValues.Add(ThresholdValue);
            }
        }

        /// <summary>
        /// 初始化位移阈值
        /// </summary>
        /// <param name="context"></param>
        private void CreateDisplaymentThresholdValues(BHMSContext context)
        {
            InitialDisplaymentThresholdValue(context);
        }

        private void InitialDisplaymentThresholdValue(BHMSContext context)
        {
            var p = 50;
            var n = -50;
            for (int i = 0; i < tmpNumbers18.Length; i++)
            {
                var ThresholdValue = new DisplacementThresholdValueTable
                {
                    PointsNumber = tmpNumbers18[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.DisplaymentThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers19.Length; i++)
            {
                var ThresholdValue = new DisplacementThresholdValueTable
                {
                    PointsNumber = tmpNumbers19[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.DisplaymentThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers20.Length; i++)
            {
                var ThresholdValue = new DisplacementThresholdValueTable
                {
                    PointsNumber = tmpNumbers20[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.DisplaymentThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers21.Length; i++)
            {
                var ThresholdValue = new DisplacementThresholdValueTable
                {
                    PointsNumber = tmpNumbers21[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.DisplaymentThresholdValues.Add(ThresholdValue);
            }

        }

        /// <summary>
        /// 初始化应变阈值
        /// </summary>
        /// <param name="context"></param>
        private void CreateStrainThresholdValues(BHMSContext context)
        {
            InitialConcreteStrainThresholdValue(context);
            InitialSteelStrainThresholdValue(context);
        }
        private void InitialSteelStrainThresholdValue(BHMSContext context)
        {
            var p = 350.00;
            var n = -350.00;
            for (int i = 0; i < tmpNumbers1.Length; i++)
            {
                var ThresholdValue = new SteelArchStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers1[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelArchStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers2.Length; i++)
            {
                var ThresholdValue = new SteelArchStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers2[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelArchStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers3.Length; i++)
            {
                var ThresholdValue = new SteelArchStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers3[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelArchStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers4.Length; i++)
            {
                var ThresholdValue = new SteelArchStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers4[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelArchStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers5.Length; i++)
            {
                var ThresholdValue = new SteelArchStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers5[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelArchStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers6.Length; i++)
            {
                var ThresholdValue = new SteelArchStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers6[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelArchStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers7.Length; i++)
            {
                var ThresholdValue = new SteelArchStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers7[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelArchStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers8.Length; i++)
            {
                var ThresholdValue = new SteelLatticeStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers8[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelLatticeStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers9.Length; i++)
            {
                var ThresholdValue = new SteelLatticeStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers9[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelLatticeStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers10.Length; i++)
            {
                var ThresholdValue = new SteelLatticeStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers10[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelLatticeStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers11.Length; i++)
            {
                var ThresholdValue = new SteelLatticeStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers11[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelLatticeStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers12.Length; i++)
            {
                var ThresholdValue = new SteelLatticeStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers12[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelLatticeStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers13.Length; i++)
            {
                var ThresholdValue = new SteelLatticeStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers13[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelLatticeStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers14.Length; i++)
            {
                var ThresholdValue = new SteelLatticeStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers14[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelLatticeStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers15.Length; i++)
            {
                var ThresholdValue = new SteelLatticeStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers15[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.SteelLatticeStrainThresholdValues.Add(ThresholdValue);
            }
        }
        private void InitialConcreteStrainThresholdValue(BHMSContext context)
        {
            var p = 100.00;
            var n = -80.00;
            for (int i = 0; i < tmpNumbers16.Length; i++)
            {
                var ThresholdValue = new ConcreteStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers16[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.ConcreteStrainThresholdValues.Add(ThresholdValue);
            }
            for (int i = 0; i < tmpNumbers17.Length; i++)
            {
                var ThresholdValue = new ConcreteStrainThresholdValueTable
                {
                    PointsNumber = tmpNumbers17[i],
                    PositiveFirstLevelThresholdValue = p * 0.8,
                    PositiveSecondLevelThresholdValue = p * 1.0,
                    NegativeFirstLevelThresholdValue = n * 0.8,
                    NegativeSecondLevelThresholdValue = n * 1.0,
                };
                context.ConcreteStrainThresholdValues.Add(ThresholdValue);
            }
        }


        private void CreateMonitoringDatas(BHMSContext context)
        {
            InitialMonitoringDatasEigenValue(context);
            InitialMonitoringDatasOriginalValue(context);
        }

        void InitialMonitoringDatasEigenValue(BHMSContext context)
        {
            var random = new Random();


            int intlTime = -5;

            for (int i = 0; i < 5; i++)
            {
                DateTime time = DateTime.Now.AddHours(intlTime + i);
                //钢拱肋应变特征值初始化
                for (int j = 0; j < tmpNumbers1.Length; j++)
                {
                    var steelArchStrainEigenvalue = new SteelArchStrainEigenvalueTable { PointsNumber = tmpNumbers1[j], Time = time, Max = random.Next(100, 150), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelArchStrainEigenvalues.Add(steelArchStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers2.Length; j++)
                {
                    var steelArchStrainEigenvalue = new SteelArchStrainEigenvalueTable { PointsNumber = tmpNumbers2[j], Time = time, Max = random.Next(100, 150), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelArchStrainEigenvalues.Add(steelArchStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers3.Length; j++)
                {
                    var steelArchStrainEigenvalue = new SteelArchStrainEigenvalueTable { PointsNumber = tmpNumbers3[j], Time = time, Max = random.Next(100, 150), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelArchStrainEigenvalues.Add(steelArchStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers4.Length; j++)
                {
                    var steelArchStrainEigenvalue = new SteelArchStrainEigenvalueTable { PointsNumber = tmpNumbers4[j], Time = time, Max = random.Next(100, 150), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelArchStrainEigenvalues.Add(steelArchStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers5.Length; j++)
                {
                    var steelArchStrainEigenvalue = new SteelArchStrainEigenvalueTable { PointsNumber = tmpNumbers5[j], Time = time, Max = random.Next(100, 150), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelArchStrainEigenvalues.Add(steelArchStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers6.Length; j++)
                {
                    var steelArchStrainEigenvalue = new SteelArchStrainEigenvalueTable { PointsNumber = tmpNumbers6[j], Time = time, Max = random.Next(100, 150), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelArchStrainEigenvalues.Add(steelArchStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers7.Length; j++)
                {
                    var steelArchStrainEigenvalue = new SteelArchStrainEigenvalueTable { PointsNumber = tmpNumbers7[j], Time = time, Max = random.Next(100, 150), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelArchStrainEigenvalues.Add(steelArchStrainEigenvalue);
                }

                //钢格构应变特征值初始化
                for (int j = 0; j < tmpNumbers8.Length; j++)
                {
                    var steelLatticeStrainEigenvalue = new SteelLatticeStrainEigenvalueTable { PointsNumber = tmpNumbers8[j], Time = time, Max = random.Next(10, 20), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelLatticeStrainEigenvalues.Add(steelLatticeStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers9.Length; j++)
                {
                    var steelLatticeStrainEigenvalue = new SteelLatticeStrainEigenvalueTable { PointsNumber = tmpNumbers9[j], Time = time, Max = random.Next(10, 20), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelLatticeStrainEigenvalues.Add(steelLatticeStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers10.Length; j++)
                {
                    var steelLatticeStrainEigenvalue = new SteelLatticeStrainEigenvalueTable { PointsNumber = tmpNumbers10[j], Time = time, Max = random.Next(10, 20), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelLatticeStrainEigenvalues.Add(steelLatticeStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers11.Length; j++)
                {
                    var steelLatticeStrainEigenvalue = new SteelLatticeStrainEigenvalueTable { PointsNumber = tmpNumbers11[j], Time = time, Max = random.Next(10, 20), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelLatticeStrainEigenvalues.Add(steelLatticeStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers12.Length; j++)
                {
                    var steelLatticeStrainEigenvalue = new SteelLatticeStrainEigenvalueTable { PointsNumber = tmpNumbers12[j], Time = time, Max = random.Next(10, 20), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelLatticeStrainEigenvalues.Add(steelLatticeStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers13.Length; j++)
                {
                    var steelLatticeStrainEigenvalue = new SteelLatticeStrainEigenvalueTable { PointsNumber = tmpNumbers13[j], Time = time, Max = random.Next(10, 20), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelLatticeStrainEigenvalues.Add(steelLatticeStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers14.Length; j++)
                {
                    var steelLatticeStrainEigenvalue = new SteelLatticeStrainEigenvalueTable { PointsNumber = tmpNumbers14[j], Time = time, Max = random.Next(10, 20), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelLatticeStrainEigenvalues.Add(steelLatticeStrainEigenvalue);
                }

                for (int j = 0; j < tmpNumbers15.Length; j++)
                {
                    var steelLatticeStrainEigenvalue = new SteelLatticeStrainEigenvalueTable { PointsNumber = tmpNumbers15[j], Time = time, Max = random.Next(10, 20), Min = random.Next(-100, -50), Average = random.Next(-50, 100) };
                    context.SteelLatticeStrainEigenvalues.Add(steelLatticeStrainEigenvalue);
                }

                //混凝土应变特征值初始化
                for (int j = 0; j < tmpNumbers16.Length; j++)
                {
                    var concreteStrainEigenvalue = new ConcreteStrainEigenvalueTable { PointsNumber = tmpNumbers16[j], Time = time, Max = random.Next(10, 40), Min = random.Next(-20, -10), Average = random.Next(-10, 10) };
                    context.ConcreteStrainEigenvalues.Add(concreteStrainEigenvalue);
                }
                for (int j = 0; j < tmpNumbers17.Length; j++)
                {
                    var concreteStrainEigenvalue = new ConcreteStrainEigenvalueTable { PointsNumber = tmpNumbers17[j], Time = time, Max = random.Next(10, 40), Min = random.Next(-20, -10), Average = random.Next(-10, 10) };
                    context.ConcreteStrainEigenvalues.Add(concreteStrainEigenvalue);
                }

                //位移特征值初始化
                for (int j = 0; j < tmpNumbers18.Length; j++)
                {
                    var displacementEigenvalue = new DisplacementEigenvalueTable { PointsNumber = tmpNumbers18[j], Time = time, Max = random.Next(10, 40), Min = random.Next(-20, -10), Average = random.Next(-10, 10) };
                    context.DisplacementEigenvalues.Add(displacementEigenvalue);
                }
                for (int j = 0; j < tmpNumbers19.Length; j++)
                {
                    var displacementEigenvalue = new DisplacementEigenvalueTable { PointsNumber = tmpNumbers19[j], Time = time, Max = random.Next(10, 40), Min = random.Next(-20, -10), Average = random.Next(-10, 10) };
                    context.DisplacementEigenvalues.Add(displacementEigenvalue);
                }
                for (int j = 0; j < tmpNumbers20.Length; j++)
                {
                    var displacementEigenvalue = new DisplacementEigenvalueTable { PointsNumber = tmpNumbers20[j], Time = time, Max = random.Next(10, 40), Min = random.Next(-20, -10), Average = random.Next(-10, 10) };
                    context.DisplacementEigenvalues.Add(displacementEigenvalue);
                }
                for (int j = 0; j < tmpNumbers21.Length; j++)
                {
                    var displacementEigenvalue = new DisplacementEigenvalueTable { PointsNumber = tmpNumbers21[j], Time = time, Max = random.Next(10, 40), Min = random.Next(-20, -10), Average = random.Next(-10, 10) };
                    context.DisplacementEigenvalues.Add(displacementEigenvalue);
                }

                //索力特征值初始化
                for (int j = 0; j < tmpNumbers26.Length; j++)
                {
                    var cableForceEigenvalue = new CableForceEigenValueTable { PointsNumber = tmpNumbers26[j], Time = time, Max = random.Next(1200, 1500), Min = random.Next(800, 1100), Average = random.Next(1000, 1300) };
                    context.CableForceEigenvalues.Add(cableForceEigenvalue);
                }

                for (int j = 0; j < tmpNumbers27.Length; j++)
                {
                    var cableForceEigenvalue = new CableForceEigenValueTable { PointsNumber = tmpNumbers27[j], Time = time, Max = random.Next(1200, 1500), Min = random.Next(800, 1100), Average = random.Next(1000, 1300) };
                    context.CableForceEigenvalues.Add(cableForceEigenvalue);
                }

                for (int j = 0; j < tmpNumbers28.Length; j++)
                {
                    var cableForceEigenvalue = new CableForceEigenValueTable { PointsNumber = tmpNumbers28[j], Time = time, Max = random.Next(1200, 1500), Min = random.Next(800, 1100), Average = random.Next(1000, 1300) };
                    context.CableForceEigenvalues.Add(cableForceEigenvalue);
                }

                //温度特征值初始化
                for (int j = 0; j < tmpNumbers22.Length; j++)
                {
                    var temperatureEigenvalue = new TemperatureEigenvalueTable { PointsNumber = tmpNumbers22[j], Time = time, Max = random.Next(50, 60), Min = random.Next(0, 10), Average = random.Next(20, 30) };
                    context.TemperatureEigenvalues.Add(temperatureEigenvalue);
                }

                for (int j = 0; j < tmpNumbers23.Length; j++)
                {
                    var temperatureEigenvalue = new TemperatureEigenvalueTable { PointsNumber = tmpNumbers23[j], Time = time, Max = random.Next(50, 60), Min = random.Next(0, 10), Average = random.Next(20, 30) };
                    context.TemperatureEigenvalues.Add(temperatureEigenvalue);
                }

                //湿度特征值初始化
                for (int j = 0; j < tmpNumbers24.Length; j++)
                {
                    var humidityEigenvalue = new HumidityEigenvalueTable { PointsNumber = tmpNumbers24[j], Time = time, Max = random.Next(50, 60), Min = random.Next(20, 30), Average = random.Next(40, 50) };
                    context.HumidityEigenvalues.Add(humidityEigenvalue);
                }

                for (int j = 0; j < tmpNumbers25.Length; j++)
                {
                    var humidityEigenvalue = new HumidityEigenvalueTable { PointsNumber = tmpNumbers25[j], Time = time, Max = random.Next(50, 60), Min = random.Next(20, 30), Average = random.Next(40, 50) };
                    context.HumidityEigenvalues.Add(humidityEigenvalue);
                }

                //风速特征值
                for (int j = 0; j < tmpNumbers29.Length; j++)
                {
                    var windLoadEigenvalue = new WindLoadEigenvalueTable { PointsNumber = tmpNumbers29[j], Time = time, Max = random.Next(6, 10), Min = random.Next(0, 3), Average = random.Next(2, 5) };
                    context.WindLoadEigenvalues.Add(windLoadEigenvalue);
                }
            }
        }



        void InitialMonitoringDatasOriginalValue(BHMSContext context)
        {
            var random = new Random();


            int intlTime = -5;



            for (int i = 0; i < 5; i++)
            {
                DateTime time = DateTime.Now.AddMinutes(intlTime + i);
                //钢拱肋应变初始值初始化
                for (int j = 0; j < tmpNumbers1.Length; j++)
                {
                    var steelArchStrainOriginalvalue = new SteelArchStrainTable { PointsNumber = tmpNumbers1[j], Time = time, Strain = random.Next(-100, 150), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelArchStrains.Add(steelArchStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers2.Length; j++)
                {
                    var steelArchStrainOriginalvalue = new SteelArchStrainTable { PointsNumber = tmpNumbers2[j], Time = time, Strain = random.Next(-100, 150), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade2 };
                    context.SteelArchStrains.Add(steelArchStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers3.Length; j++)
                {
                    var steelArchStrainOriginalvalue = new SteelArchStrainTable { PointsNumber = tmpNumbers3[j], Time = time, Strain = random.Next(-100, 150), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade3 };
                    context.SteelArchStrains.Add(steelArchStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers4.Length; j++)
                {
                    var steelArchStrainOriginalvalue = new SteelArchStrainTable { PointsNumber = tmpNumbers4[j], Time = time, Strain = random.Next(-100, 150), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelArchStrains.Add(steelArchStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers5.Length; j++)
                {
                    var steelArchStrainOriginalvalue = new SteelArchStrainTable { PointsNumber = tmpNumbers5[j], Time = time, Strain = random.Next(-100, 150), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelArchStrains.Add(steelArchStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers6.Length; j++)
                {
                    var steelArchStrainOriginalvalue = new SteelArchStrainTable { PointsNumber = tmpNumbers6[j], Time = time, Strain = random.Next(-100, 150), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelArchStrains.Add(steelArchStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers7.Length; j++)
                {
                    var steelArchStrainOriginalvalue = new SteelArchStrainTable { PointsNumber = tmpNumbers7[j], Time = time, Strain = random.Next(-100, 150), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelArchStrains.Add(steelArchStrainOriginalvalue);
                }


                //钢格构应变初始值初始化
                for (int j = 0; j < tmpNumbers8.Length; j++)
                {
                    var steelLatticeStrainOriginalvalue = new SteelLatticeStrainTable { PointsNumber = tmpNumbers8[j], Time = time, Strain = random.Next(-100, 20), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelLatticeStrains.Add(steelLatticeStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers9.Length; j++)
                {
                    var steelLatticeStrainOriginalvalue = new SteelLatticeStrainTable { PointsNumber = tmpNumbers9[j], Time = time, Strain = random.Next(-100, 20), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade2 };
                    context.SteelLatticeStrains.Add(steelLatticeStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers10.Length; j++)
                {
                    var steelLatticeStrainOriginalvalue = new SteelLatticeStrainTable { PointsNumber = tmpNumbers10[j], Time = time, Strain = random.Next(-100, 20), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade3 };
                    context.SteelLatticeStrains.Add(steelLatticeStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers11.Length; j++)
                {
                    var steelLatticeStrainOriginalvalue = new SteelLatticeStrainTable { PointsNumber = tmpNumbers11[j], Time = time, Strain = random.Next(-100, 20), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelLatticeStrains.Add(steelLatticeStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers12.Length; j++)
                {
                    var steelLatticeStrainOriginalvalue = new SteelLatticeStrainTable { PointsNumber = tmpNumbers12[j], Time = time, Strain = random.Next(-100, 20), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelLatticeStrains.Add(steelLatticeStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers13.Length; j++)
                {
                    var steelLatticeStrainOriginalvalue = new SteelLatticeStrainTable { PointsNumber = tmpNumbers13[j], Time = time, Strain = random.Next(-100, 20), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelLatticeStrains.Add(steelLatticeStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers14.Length; j++)
                {
                    var steelLatticeStrainOriginalvalue = new SteelLatticeStrainTable { PointsNumber = tmpNumbers14[j], Time = time, Strain = random.Next(-100, 20), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelLatticeStrains.Add(steelLatticeStrainOriginalvalue);
                }

                for (int j = 0; j < tmpNumbers15.Length; j++)
                {
                    var steelLatticeStrainOriginalvalue = new SteelLatticeStrainTable { PointsNumber = tmpNumbers15[j], Time = time, Strain = random.Next(-100, 20), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade1 };
                    context.SteelLatticeStrains.Add(steelLatticeStrainOriginalvalue);
                }

                //混凝土应变原始数据初始化
                for (int j = 0; j < tmpNumbers16.Length; j++)
                {
                    var concreteStrain = new ConcreteStrainTable { PointsNumber = tmpNumbers16[j], Time = time, Strain = random.Next(10, 40), Temperature = random.Next(5, 60), ThresholdGrade = ThresholdGrade1 };
                    context.ConcreteStrains.Add(concreteStrain);
                }
                for (int j = 0; j < tmpNumbers17.Length; j++)
                {
                    var concreteStrain = new ConcreteStrainTable { PointsNumber = tmpNumbers17[j], Time = time, Strain = random.Next(10, 40), Temperature = random.Next(5, 60), ThresholdGrade = ThresholdGrade2 };
                    context.ConcreteStrains.Add(concreteStrain);
                }

                //位移初始值初始化
                for (int j = 0; j < tmpNumbers18.Length; j++)
                {
                    var displacementOriginalValue = new DisplacementTable { PointsNumber = tmpNumbers18[j], Time = time, Displacement = random.Next(-20, 40) ,ThresholdGrade = ThresholdGrade1 };
                    context.Displacements.Add(displacementOriginalValue);
                }
                for (int j = 0; j < tmpNumbers19.Length; j++)
                {
                    var displacementOriginalValue = new DisplacementTable { PointsNumber = tmpNumbers19[j], Time = time, Displacement = random.Next(-20, 40) , ThresholdGrade = ThresholdGrade2 };
                    context.Displacements.Add(displacementOriginalValue);
                }
                for (int j = 0; j < tmpNumbers20.Length; j++)
                {
                    var displacementOriginalValue = new DisplacementTable { PointsNumber = tmpNumbers20[j], Time = time, Displacement = random.Next(-20, 40), ThresholdGrade = ThresholdGrade3 };
                    context.Displacements.Add(displacementOriginalValue);
                }
                for (int j = 0; j < tmpNumbers21.Length; j++)
                {
                    var displacementOriginalValue = new DisplacementTable { PointsNumber = tmpNumbers21[j], Time = time, Displacement = random.Next(-20, 40), ThresholdGrade = ThresholdGrade1 };
                    context.Displacements.Add(displacementOriginalValue);
                }

                //索力初始值初始化
                for (int j = 0; j < tmpNumbers26.Length; j++)
                {
                    var cableForceOriginalValue = new CableForceTable { PointsNumber = tmpNumbers26[j], Time = time, CableForce = random.Next(800, 1500), Temperature = random.Next(5, 70) ,ThresholdGrade = ThresholdGrade1 };
                    context.CableForces.Add(cableForceOriginalValue);
                }

                for (int j = 0; j < tmpNumbers27.Length; j++)
                {
                    var cableForceOriginalValue = new CableForceTable { PointsNumber = tmpNumbers27[j], Time = time, CableForce = random.Next(800, 1500), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade2};
                    context.CableForces.Add(cableForceOriginalValue);
                }

                for (int j = 0; j < tmpNumbers28.Length; j++)
                {
                    var cableForceOriginalValue = new CableForceTable { PointsNumber = tmpNumbers28[j], Time = time, CableForce = random.Next(800, 1500), Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade3};
                    context.CableForces.Add(cableForceOriginalValue);
                }

                //温度初始值初始化
                for (int j = 0; j < tmpNumbers22.Length; j++)
                {
                    var temperatureOriginalValue = new TemperatureTable { PointsNumber = tmpNumbers22[j], Time = time, Temperature = random.Next(5, 45), ThresholdGrade = ThresholdGrade1 };
                    context.Temperatures.Add(temperatureOriginalValue);
                }

                for (int j = 0; j < tmpNumbers23.Length; j++)
                {
                    var temperatureOriginalValue = new TemperatureTable { PointsNumber = tmpNumbers23[j], Time = time, Temperature = random.Next(5, 70), ThresholdGrade = ThresholdGrade2 };
                    context.Temperatures.Add(temperatureOriginalValue);
                }

                //湿度初始值初始化
                for (int j = 0; j < tmpNumbers24.Length; j++)
                {
                    var humidityOriginalValue = new HumidityTable { PointsNumber = tmpNumbers24[j], Time = time, Humidity = random.Next(20, 60), ThresholdGrade = ThresholdGrade1 };
                    context.Humiditys.Add(humidityOriginalValue);
                }

                for (int j = 0; j < tmpNumbers25.Length; j++)
                {
                    var humidityOriginalValue = new HumidityTable { PointsNumber = tmpNumbers25[j], Time = time, Humidity = random.Next(20, 60), ThresholdGrade = ThresholdGrade3 };
                    context.Humiditys.Add(humidityOriginalValue);
                }

                //风速初始值
                for (int j = 0; j < tmpNumbers29.Length; j++)
                {
                    var windLoadOriginalValue = new WindLoadTable { PointsNumber = tmpNumbers29[j], Time = time, WindSpeed = random.Next(0, 10), ThresholdGrade = ThresholdGrade3};
                    context.WindLoads.Add(windLoadOriginalValue);
                }

            }
        }
        /// <summary>
        /// 初始化异常阈值
        /// </summary>
        /// <param name="context"></param>
        void CreateAbnormalThresholdValue(BHMSContext context)
        {
            var steelStrainThresholdValue = new AbnormalThresholdValueTable { TypeName = "钢结构应变", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var concreteStrainThresholdValue = new AbnormalThresholdValueTable { TypeName = "混凝土结构应变", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var upperHangerCableForceThresholdValue = new AbnormalThresholdValueTable { TypeName = "上层吊杆索力", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var underHangerCableForceThresholdValue = new AbnormalThresholdValueTable { TypeName = "下层吊杆索力", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var flexibleTiedBarCableForceThresholdValue = new AbnormalThresholdValueTable { TypeName = "柔性系杆", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var tempThresholdValue = new AbnormalThresholdValueTable { TypeName = "温度", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var humThresholdValue = new AbnormalThresholdValueTable { TypeName = "湿度", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var windLoadThresholdValue = new AbnormalThresholdValueTable { TypeName = "风速", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var steelArchXDisThresholdValue = new AbnormalThresholdValueTable { TypeName = "钢拱肋X方向位移", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var steelArchYDisThresholdValue = new AbnormalThresholdValueTable { TypeName = "钢拱肋Y方向位移", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var steelArchZDisThresholdValue = new AbnormalThresholdValueTable { TypeName = "钢拱肋Z方向位移", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var bridgeDeckDisThresholdValue = new AbnormalThresholdValueTable { TypeName = "桥面挠度", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var transitionPierDisThresholdValue = new AbnormalThresholdValueTable { TypeName = "过渡墩变形", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            var expansionDisThresholdValue = new AbnormalThresholdValueTable { TypeName = "伸缩缝变形", MaxLevelThresholdValue = 1000, MinLevelThresholdValue = -1000, };
            context.AbnormalThresholdValue.Add(steelStrainThresholdValue);
            context.AbnormalThresholdValue.Add(concreteStrainThresholdValue);
            context.AbnormalThresholdValue.Add(upperHangerCableForceThresholdValue);
            context.AbnormalThresholdValue.Add(underHangerCableForceThresholdValue);
            context.AbnormalThresholdValue.Add(flexibleTiedBarCableForceThresholdValue);
            context.AbnormalThresholdValue.Add(tempThresholdValue);
            context.AbnormalThresholdValue.Add(humThresholdValue);
            context.AbnormalThresholdValue.Add(windLoadThresholdValue);
            context.AbnormalThresholdValue.Add(steelArchXDisThresholdValue);
            context.AbnormalThresholdValue.Add(steelArchYDisThresholdValue);
            context.AbnormalThresholdValue.Add(steelArchZDisThresholdValue);
            context.AbnormalThresholdValue.Add(bridgeDeckDisThresholdValue);
            context.AbnormalThresholdValue.Add(transitionPierDisThresholdValue);
            context.AbnormalThresholdValue.Add(expansionDisThresholdValue);

        }


        void CreateAdminUser(BHMSContext context)
        {
            var encryptedPassword = EncryptContextFactory.GetContext().Encrypt(AppConstants.DefaultPlainTextPassword);
            var admin = new User { UserName = "admin", Password = encryptedPassword, State = _normalUserState };
            context.Users.Add(admin);
        }

        void CreateNormalUsers(BHMSContext context)
        {
            InitUser(InitNormalUserStartNumber, InitNormalUserNumber, _normalUserState, context);
        }

        void CreateSuspendedUsers(BHMSContext context)
        {
            InitUser(InitSuspendedUserStartNumber, InitTotalUserNumber, _SuspendedUserState, context);
        }

        UserState _normalUserState;
        UserState _SuspendedUserState;
        void InitUserStates(BHMSContext context)
        {
            _normalUserState = new UserState { StateName = AppConstants.NormalState, Description = AppConstants.NormalStateDescription };
            _SuspendedUserState = new UserState { StateName = AppConstants.UnNormalState, Description = AppConstants.UnNormalStateDescription };
            context.UserStates.Add(_normalUserState);
            context.UserStates.Add(_SuspendedUserState);
        }

        void InitUser(int startNum, int endNumber, UserState state, BHMSContext context)
        {
            var encryptedPassword = EncryptContextFactory.GetContext().Encrypt(AppConstants.DefaultPlainTextPassword);
            for (int i = startNum; i <= endNumber; i++)
            {
                var user = new User { UserName = UserName.GetUser(i), Password = encryptedPassword, State = state };
                context.Users.Add(user);
            }
        }

        void CreateMonitoringTestType(BHMSContext context)
        {
            var monitoringTestTypesDict = new Dictionary<string, MonitoringTestType>();
            monitoringTestTypesDict.Add(nameof(steelArchStrainType), steelArchStrainType);
            monitoringTestTypesDict.Add(nameof(steelLatticeStrainType), steelLatticeStrainType);
            monitoringTestTypesDict.Add(nameof(concreteStrainType), concreteStrainType);
            monitoringTestTypesDict.Add(nameof(displacementType), displacementType);
            monitoringTestTypesDict.Add(nameof(cableForceType), cableForceType);
            monitoringTestTypesDict.Add(nameof(windSpeedType), windSpeedType);
            monitoringTestTypesDict.Add(nameof(temperatureType), temperatureType);
            monitoringTestTypesDict.Add(nameof(humidityType), humidityType);


            MonitoringTestType[] monitoringTestTypes = new MonitoringTestType[monitoringTestTypesDict.Count];
            monitoringTestTypesDict.Values.CopyTo(monitoringTestTypes, 0);
            context.MonitoringTestTypes.AddRange(monitoringTestTypes);

            CreateMonitoringPointsPositionsForTestType(context, monitoringTestTypesDict);
        }

        MonitoringPointsNumber[] tmpNumbers1;
        MonitoringPointsNumber[] tmpNumbers2;
        MonitoringPointsNumber[] tmpNumbers3;
        MonitoringPointsNumber[] tmpNumbers4;
        MonitoringPointsNumber[] tmpNumbers5;
        MonitoringPointsNumber[] tmpNumbers6;
        MonitoringPointsNumber[] tmpNumbers7;
        MonitoringPointsNumber[] tmpNumbers8;
        MonitoringPointsNumber[] tmpNumbers9;
        MonitoringPointsNumber[] tmpNumbers10;
        MonitoringPointsNumber[] tmpNumbers11;
        MonitoringPointsNumber[] tmpNumbers12;
        MonitoringPointsNumber[] tmpNumbers13;
        MonitoringPointsNumber[] tmpNumbers14;
        MonitoringPointsNumber[] tmpNumbers15;
        MonitoringPointsNumber[] tmpNumbers16;
        MonitoringPointsNumber[] tmpNumbers17;
        MonitoringPointsNumber[] tmpNumbers18;
        MonitoringPointsNumber[] tmpNumbers19;
        MonitoringPointsNumber[] tmpNumbers20;
        MonitoringPointsNumber[] tmpNumbers21;
        MonitoringPointsNumber[] tmpNumbers22;
        MonitoringPointsNumber[] tmpNumbers23;
        MonitoringPointsNumber[] tmpNumbers24;
        MonitoringPointsNumber[] tmpNumbers25;
        MonitoringPointsNumber[] tmpNumbers26;
        MonitoringPointsNumber[] tmpNumbers27;
        MonitoringPointsNumber[] tmpNumbers28;
        MonitoringPointsNumber[] tmpNumbers29;

        void CreateMonitoringPointsNumberForPointsPosition(BHMSContext context, Dictionary<string, MonitoringPointsPosition> monitoringPointsPosition)
        {
            tmpNumbers1 = new MonitoringPointsNumber[] { sSAAL1Point, sSAAL2Point, sSAAL3Point, sSAAL4Point, sSAAR1Point, sSAAR2Point, sSAAR3Point, sSAAR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers1, nameof(steelArchStrainSectionA));

            tmpNumbers2 = new MonitoringPointsNumber[] { sSABL1Point, sSABL2Point, sSABL3Point, sSABL4Point, sSABR1Point, sSABR2Point, sSABR3Point, sSABR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers2, nameof(steelArchStrainSectionB));

            tmpNumbers3 = new MonitoringPointsNumber[] { sSACL1Point, sSACL2Point, sSACL3Point, sSACL4Point, sSACR1Point, sSACR2Point, sSACR3Point, sSACR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers3, nameof(steelArchStrainSectionC));

            tmpNumbers4 = new MonitoringPointsNumber[] { sSADL1Point, sSADL2Point, sSADL3Point, sSADL4Point, sSADR1Point, sSADR2Point, sSADR3Point, sSADR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers4, nameof(steelArchStrainSectionD));

            tmpNumbers5 = new MonitoringPointsNumber[] { sSAEL1Point, sSAEL2Point, sSAEL3Point, sSAEL4Point, sSAER1Point, sSAER2Point, sSAER3Point, sSAER4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers5, nameof(steelArchStrainSectionE));

            tmpNumbers6 = new MonitoringPointsNumber[] { sATBA1Point, sATBA2Point, sATBA3Point, sATBA4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers6, nameof(archTransverseBraceStrainSectionA));

            tmpNumbers7 = new MonitoringPointsNumber[] { sATBB1Point, sATBB2Point, sATBB3Point, sATBB4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers7, nameof(archTransverseBraceStrainSectionB));

            tmpNumbers8 = new MonitoringPointsNumber[] { sITBA1Point, sITBA2Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers8, nameof(intercostalTransverseBeamStrainSectionA));

            tmpNumbers9 = new MonitoringPointsNumber[] { sITBB1Point, sITBB2Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers9, nameof(intercostalTransverseBeamStrainSectionB));

            tmpNumbers10 = new MonitoringPointsNumber[] { sUSCBA1Point, sUSCBA2Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers10, nameof(upperSteelCrossBeamStrainSectionA));

            tmpNumbers11 = new MonitoringPointsNumber[] { sUSCBB1Point, sUSCBB2Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers11, nameof(upperSteelCrossBeamStrainSectionB));

            tmpNumbers12 = new MonitoringPointsNumber[] { sUSLBA1Point, sUSLBA2Point, sUSLBA3Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers12, nameof(upperSteelLongitudinalBeamStrainSectionA));

            tmpNumbers13 = new MonitoringPointsNumber[] { sUSLBB1Point, sUSLBB2Point, sUSLBB3Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers13, nameof(upperSteelLongitudinalBeamStrainSectionB));

            tmpNumbers14 = new MonitoringPointsNumber[] { sRTBAL1Point, sRTBAL2Point, sRTBAL3Point, sRTBAL4Point, sRTBAR1Point, sRTBAR2Point, sRTBAR3Point, sRTBAR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers14, nameof(rigidTiedBarStrainSectionA));

            tmpNumbers15 = new MonitoringPointsNumber[] { sRTBBL1Point, sRTBBL2Point, sRTBBL3Point, sRTBBL4Point, sRTBBR1Point, sRTBBR2Point, sRTBBR3Point, sRTBBR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers15, nameof(rigidTiedBarStrainSectionB));

            tmpNumbers16 = new MonitoringPointsNumber[] { sCAAL1Point, sCAAL2Point, sCAAL3Point, sCAAL4Point, sCAAR1Point, sCAAR2Point, sCAAR3Point, sCAAR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers16, nameof(concreteArchStrainSectionA));

            tmpNumbers17 = new MonitoringPointsNumber[] { sCABL1Point, sCABL2Point, sCABL3Point, sCABL4Point, sCABR1Point, sCABR2Point, sCABR3Point, sCABR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers17, nameof(concreteArchStrainSectionB));

            tmpNumbers18 = new MonitoringPointsNumber[] { dSA1xPoint, dSA2xPoint, dSA3xPoint, dSA4xPoint, dSA1yPoint, dSA2yPoint, dSA3yPoint, dSA4yPoint, dSA1zPoint, dSA2zPoint, dSA3zPoint, dSA4zPoint };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers18, nameof(steelArchDis));

            tmpNumbers19 = new MonitoringPointsNumber[] { dBD1Point, dBD2Point, dBD3Point, dBD4Point, dBD5Point, dBD6Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers19, nameof(bridgeDeckDis));

            tmpNumbers20 = new MonitoringPointsNumber[] { dSP1Point, dSP2Point, dSP3Point, dSP4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers20, nameof(transitionPierDis));

            tmpNumbers21 = new MonitoringPointsNumber[] { dE1Point, dE2Point, dE3Point, dE4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers21, nameof(expansionDis));

            tmpNumbers22 = new MonitoringPointsNumber[] { tE1Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers22, nameof(environmentTemp));

            tmpNumbers23 = new MonitoringPointsNumber[] { tSAL1Point, tSAL2Point, tSAL3Point, tSAL4Point, tSAR1Point, tSAR2Point, tSAR3Point, tSAR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers23, nameof(steelArchTemp));

            tmpNumbers24 = new MonitoringPointsNumber[] { hE1Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers24, nameof(environmentHum));

            tmpNumbers25 = new MonitoringPointsNumber[] { hSAL1Point, hSAL2Point, hSAL3Point, hSAL4Point, hSAR1Point, hSAR2Point, hSAR3Point, hSAR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers25, nameof(steelArchHum));

            tmpNumbers26 = new MonitoringPointsNumber[] { cFUPHL1Point, cFUPHL2Point, cFUPHL3Point, cFUPHL4Point, cFUPHL5Point, cFUPHL6Point, cFUPHL7Point, cFUPHL8Point, cFUPHL9Point, cFUPHR1Point, cFUPHR2Point, cFUPHR3Point, cFUPHR4Point, cFUPHR5Point, cFUPHR6Point, cFUPHR7Point, cFUPHR8Point, cFUPHR9Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers26, nameof(upperHangerCableForce));

            tmpNumbers27 = new MonitoringPointsNumber[] { cFUNHL1Point, cFUNHL2Point, cFUNHL3Point, cFUNHL4Point, cFUNHR1Point, cFUNHR2Point, cFUNHR3Point, cFUNHR4Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers27, nameof(underHangerCableForce));

            tmpNumbers28 = new MonitoringPointsNumber[] { cFFTBL1Point, cFFTBL2Point, cFFTBL3Point, cFFTBL4Point, cFFTBL5Point, cFFTBL6Point, cFFTBR1Point, cFFTBR2Point, cFFTBR3Point, cFFTBR4Point, cFFTBR5Point, cFFTBR6Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers28, nameof(flexibleTiedBarCableForce));

            tmpNumbers29 = new MonitoringPointsNumber[] { wL1Point };
            SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(monitoringPointsPosition, tmpNumbers29, nameof(windLoad));

            context.MonitoringPointsNumbers.AddRange(tmpNumbers1);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers2);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers3);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers4);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers5);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers6);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers7);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers8);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers9);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers10);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers11);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers12);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers13);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers14);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers15);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers16);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers17);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers18);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers19);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers20);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers21);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers22);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers23);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers24);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers25);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers26);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers27);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers28);
            context.MonitoringPointsNumbers.AddRange(tmpNumbers29);
        }

        void CreateMonitoringPointsPositionsForTestType(BHMSContext context, Dictionary<string, MonitoringTestType> dict)
        {


            MonitoringPointsPosition[] tmpSections1 = { steelArchStrainSectionA, steelArchStrainSectionB, steelArchStrainSectionC, steelArchStrainSectionD, steelArchStrainSectionE, archTransverseBraceStrainSectionA, archTransverseBraceStrainSectionB };
            SetTestTypeNavPropertyToMonitoringPointsPositionInstance(dict, tmpSections1, nameof(steelArchStrainType));

            MonitoringPointsPosition[] tmpSections2 = { intercostalTransverseBeamStrainSectionA, intercostalTransverseBeamStrainSectionB, upperSteelCrossBeamStrainSectionA, upperSteelCrossBeamStrainSectionB, upperSteelLongitudinalBeamStrainSectionA, upperSteelLongitudinalBeamStrainSectionB, rigidTiedBarStrainSectionA, rigidTiedBarStrainSectionB };
            SetTestTypeNavPropertyToMonitoringPointsPositionInstance(dict, tmpSections2, nameof(steelLatticeStrainType));

            MonitoringPointsPosition[] tmpSections3 = { concreteArchStrainSectionA, concreteArchStrainSectionB };
            SetTestTypeNavPropertyToMonitoringPointsPositionInstance(dict, tmpSections3, nameof(concreteStrainType));

            MonitoringPointsPosition[] tmpSections4 = { steelArchDis, bridgeDeckDis, transitionPierDis, expansionDis };
            SetTestTypeNavPropertyToMonitoringPointsPositionInstance(dict, tmpSections4, nameof(displacementType));

            MonitoringPointsPosition[] tmpSections5 = { upperHangerCableForce, underHangerCableForce, flexibleTiedBarCableForce };
            SetTestTypeNavPropertyToMonitoringPointsPositionInstance(dict, tmpSections5, nameof(cableForceType));

            MonitoringPointsPosition[] tmpSections6 = { environmentHum, steelArchHum };
            SetTestTypeNavPropertyToMonitoringPointsPositionInstance(dict, tmpSections6, nameof(humidityType));

            MonitoringPointsPosition[] tmpSections7 = { environmentTemp, steelArchTemp };
            SetTestTypeNavPropertyToMonitoringPointsPositionInstance(dict, tmpSections7, nameof(temperatureType));

            MonitoringPointsPosition[] tmpSections8 = { windLoad };
            SetTestTypeNavPropertyToMonitoringPointsPositionInstance(dict, tmpSections8, nameof(windSpeedType));

            context.MonitoringPointsPositions.AddRange(tmpSections1);
            context.MonitoringPointsPositions.AddRange(tmpSections2);
            context.MonitoringPointsPositions.AddRange(tmpSections3);
            context.MonitoringPointsPositions.AddRange(tmpSections4);
            context.MonitoringPointsPositions.AddRange(tmpSections5);
            context.MonitoringPointsPositions.AddRange(tmpSections6);
            context.MonitoringPointsPositions.AddRange(tmpSections7);
            context.MonitoringPointsPositions.AddRange(tmpSections8);

            var monitoringPointsPosition = new Dictionary<string, MonitoringPointsPosition>();
            monitoringPointsPosition.Add(nameof(steelArchStrainSectionA), steelArchStrainSectionA);
            monitoringPointsPosition.Add(nameof(steelArchStrainSectionB), steelArchStrainSectionB);
            monitoringPointsPosition.Add(nameof(steelArchStrainSectionC), steelArchStrainSectionC);
            monitoringPointsPosition.Add(nameof(steelArchStrainSectionD), steelArchStrainSectionD);
            monitoringPointsPosition.Add(nameof(steelArchStrainSectionE), steelArchStrainSectionE);
            monitoringPointsPosition.Add(nameof(archTransverseBraceStrainSectionA), archTransverseBraceStrainSectionA);
            monitoringPointsPosition.Add(nameof(archTransverseBraceStrainSectionB), archTransverseBraceStrainSectionB);

            monitoringPointsPosition.Add(nameof(intercostalTransverseBeamStrainSectionA), intercostalTransverseBeamStrainSectionA);
            monitoringPointsPosition.Add(nameof(intercostalTransverseBeamStrainSectionB), intercostalTransverseBeamStrainSectionB);
            monitoringPointsPosition.Add(nameof(upperSteelCrossBeamStrainSectionA), upperSteelCrossBeamStrainSectionA);
            monitoringPointsPosition.Add(nameof(upperSteelCrossBeamStrainSectionB), upperSteelCrossBeamStrainSectionB);
            monitoringPointsPosition.Add(nameof(upperSteelLongitudinalBeamStrainSectionA), upperSteelLongitudinalBeamStrainSectionA);
            monitoringPointsPosition.Add(nameof(upperSteelLongitudinalBeamStrainSectionB), upperSteelLongitudinalBeamStrainSectionB);
            monitoringPointsPosition.Add(nameof(rigidTiedBarStrainSectionA), rigidTiedBarStrainSectionA);
            monitoringPointsPosition.Add(nameof(rigidTiedBarStrainSectionB), rigidTiedBarStrainSectionB);

            monitoringPointsPosition.Add(nameof(concreteArchStrainSectionA), concreteArchStrainSectionA);
            monitoringPointsPosition.Add(nameof(concreteArchStrainSectionB), concreteArchStrainSectionB);
            monitoringPointsPosition.Add(nameof(steelArchDis), steelArchDis);
            monitoringPointsPosition.Add(nameof(bridgeDeckDis), bridgeDeckDis);
            monitoringPointsPosition.Add(nameof(transitionPierDis), transitionPierDis);
            monitoringPointsPosition.Add(nameof(expansionDis), expansionDis);
            monitoringPointsPosition.Add(nameof(upperHangerCableForce), upperHangerCableForce);
            monitoringPointsPosition.Add(nameof(underHangerCableForce), underHangerCableForce);
            monitoringPointsPosition.Add(nameof(flexibleTiedBarCableForce), flexibleTiedBarCableForce);
            monitoringPointsPosition.Add(nameof(environmentHum), environmentHum);
            monitoringPointsPosition.Add(nameof(steelArchHum), steelArchHum);
            monitoringPointsPosition.Add(nameof(environmentTemp), environmentTemp);
            monitoringPointsPosition.Add(nameof(steelArchTemp), steelArchTemp);
            monitoringPointsPosition.Add(nameof(windLoad), windLoad);

            CreateMonitoringPointsNumberForPointsPosition(context, monitoringPointsPosition);
        }

        void SetTestTypeNavPropertyToMonitoringPointsPositionInstance(Dictionary<string, MonitoringTestType> dict, MonitoringPointsPosition[] tmpSections, string keyName)
        {
            foreach (var item in tmpSections)
            {
                item.TestType = dict[keyName];
            }
        }

        void SetPointsPositionNavPropertyToMonitoringPointsNumberInstance(Dictionary<string, MonitoringPointsPosition> tmpSections, MonitoringPointsNumber[] tmpNumbers, string keyName)
        {
            foreach (var item in tmpNumbers)
            {
                item.PointsPosition = tmpSections[keyName];
            }
        }
    }
}
