﻿SELECT  C.COMPANY_CODE,
        FOUNDER,
        COUNT(DISTINCT(EMP.LEAD_MANAGER_CODE)) AS NUMBER_OF_LM,
        COUNT(DISTINCT(EMP.SENIOR_MANAGER_CODE)) AS NUMBER_OF_SM,
        COUNT(DISTINCT(EMP.MANAGER_CODE)) AS NUMBER_OF_M,
        COUNT(DISTINCT(EMP.EMPLOYEE_CODE)) AS NUMBER_OF_EMP
FROM COMPANY AS C
INNER JOIN EMPLOYEE AS EMP ON C.COMPANY_CODE = EMP.COMPANY_CODE
GROUP BY C.COMPANY_CODE, FOUNDER
ORDER BY 1