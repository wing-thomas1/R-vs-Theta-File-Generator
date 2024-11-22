MeasureString = 
    WAI WAITFOR 5 0 0 0 0 0
    MVP MOVE -10.000 0 14 "0.798 Degrees/sec"
    WAI WAITFOR 10 0 0 1 0 0
    MVP MOVE 370.000 0 14 "0.798 Degrees/sec"
    WAI WAITFOR 10 0 0 1 0 0
    MVP MOVE -10.000 0 14 "0.798 Degrees/sec"
    WAI WAITFOR 10 0 0 1 0 0
    MVP MOVE 370.000 0 14 "0.798 Degrees/sec"
    WAI WAITFOR 10 0 0 1 0 0
    LOG 1 ""
    WAI WAITFOR 10 0 0 0 0 0

GeneralInitiate(Field) = 
    MVP MOVE 370.000 0 0 "11.970 Degrees/sec"
    WAI WAITFOR 5 0 0 1 0 0
    BRG BRIDGE 3 1000.000 1000.000 1 1 95.0
    WAI WAITFOR 5 0 0 0 0 0
    TMP TEMP 400.000000 12.000000 0
    FLD FIELD 80000.0 200.0 0 0
    WAI WAITFOR 3600 1 1 0 0 0

    if(Field !== 8):
        FLD FIELD Field 200.0 0 0
        WAI WAITFOR 1800 0 1 0 0 0


InitiateMeasurement(Field, Temp) =
    TMP TEMP 400.000000 12.000000 0
    if(Field === 8):
        WAI WAITFOR 1800 1 0 0 0 0
    else:
        FLD FIELD 80000.0 200.0 0 0
        WAI WAITFOR 1800 1 1 0 0 
    
    if(Temp === 10):
        TMP TEMP 20.000000 12.000000 0
        WAI WAITFOR 1800 1 0 0 0 0

        
    TMP TEMP $(Temp) 12.000000 0
    WAI WAITFOR 3600 1 0 0 0 0

    if (Field !== 8):
        FLD FIELD {$(Field)*10000}.0 200.0 0 0 #Funky eval of field thing
        WAI WAITFOR 1800 0 1 0 0 0

ChainString(ID, Date, Field) =
    CHN C:\Users\hmcph\OneDrive\Desktop\FeRh Summer 2024\R vs Theta\${ID}\Sequences\${Date} FeRh ${ID} - R vs Theta - 100K, 50K, 10K - ${Field}.seq

LogString(ID, Date, Field, Temp) =
    LOG 0 1 0.25 8389583 0 0 0 "C:\Users\hmcph\OneDrive\Desktop\FeRh Summer 2024\R vs Theta\${ID}\Data\${Date} FeRh ${ID} - R vs Theta - ${Temp}K - ${Field}T - fast.dat" "${Date} FeRh ${ID} - R vs Theta - ${Temp}K - ${Field}T - fast" "" ""

Initiate10K(Field) = ## No longer needed
    TMP TEMP 400.000000 12.000000 0
    if (Field === 8):
        WAI WAITFOR 1800 1 0 0 0 0
    else:
        FLD FIELD 80000.0 200.0 0 0
        WAI WAITFOR 1800 1 1 0 0 0
    
    TMP TEMP 20.000000 12.000000 0
    WAI WAITFOR 1800 1 0 0 0 0
    TMP TEMP 10.000000 1.000000 1
    WAI WAITFOR 3600 1 0 0 0 0

    if (Field !== 8):
        FLD FIELD Field 200.0 0 0
        WAI WAITFOR 1800 0 1 0 0 0

ConcludeString =
    TMP TEMP 305.000000 12.000000 0
    WAI WAITFOR 10 1 0 0 0 0
    FLD FIELD 0.0 200.0 0 0
    MVP MOVE 90.000 0 0 "11.970 Degrees/sec"
    WAI WAITFOR 10 0 1 1 0 0

400K, 200K, 150K @generalT:
    GeneralInitiate(Field)
    LogString(ID, Date, Field, 400K)
    MeasureString
    InitiateMeasurement(Field, 200K)
    LogString(ID, Date, Field, 200K)
    MeasureString
    InitiateMeasurement(Field, 150K)
    LogString(ID, Date, Field, 150K)
    MeasureString
    ChainString(ID, Date, Field)


100K, 50K, 10K @generalT:
    InitiateMeasurement(Field, 100K)
    LogString(ID, Date, Field, 100K)
    MeasureString
    InitiateMeasurement(Field, 50K)
    LogString(ID, Date, Field, 50K)
    MeasureString
    Initiate10K(Field)
    LogString(ID, Date, Field, 10K)
    MeasureString
    ConcludeString