SELECT V.VILLA_ID, V.NAME
  FROM RESERVATION R, VILLA V
  WHERE R.VILLA_ID=V.VILLA_ID
    AND R.START_DATE<TO_DATE('2015/01/01', 'yyyy/mm/dd')
    AND R.END_DATE>TO_DATE('2014/01/01', 'yyyy/mm/dd')
  GROUP BY V.VILLA_ID, V.NAME
  HAVING SUM(LEAST(TO_DATE('2015/01/01', 'yyyy/mm/dd'), END_DATE)
              - GREATEST(START_DATE, TO_DATE('2014/01/01', 'yyyy/mm/dd')))
          >= 
          (SELECT NUM
                FROM (SELECT SUM(LEAST(TO_DATE('2015/01/01', 'yyyy/mm/dd'), END_DATE)
                                  - GREATEST(START_DATE, TO_DATE('2014/01/01', 'yyyy/mm/dd'))) AS NUM
                          FROM RESERVATION R
                          WHERE R.START_DATE<TO_DATE('2015/01/01', 'yyyy/mm/dd')
                            AND R.END_DATE>TO_DATE('2014/01/01', 'yyyy/mm/dd')
                          GROUP BY R.VILLA_ID
                          ORDER BY NUM DESC)
                WHERE ROWNUM<=1);
