SELECT USERS.ID, USERS.FIRST_NAME, USERS.LAST_NAME
  FROM (SELECT VILLA_ID, NUM, T13NUMBER
          FROM (SELECT T14.VILLA_ID, T14.NUM, CASE WHEN T13.NUM is NULL THEN 0 ELSE T13.NUM END AS T13NUMBER
                  FROM (SELECT R.VILLA_ID, SUM(LEAST(TO_DATE('2014/09/01', 'yyyy/mm/dd'), END_DATE)
                                            - GREATEST(START_DATE, TO_DATE('2014/01/01', 'yyyy/mm/dd'))) AS NUM
                          FROM RESERVATION R
                          WHERE R.START_DATE<TO_DATE('2014/09/01', 'yyyy/mm/dd')
                            AND R.END_DATE>TO_DATE('2014/01/01', 'yyyy/mm/dd')
                          GROUP BY R.VILLA_ID) T14
                      LEFT OUTER JOIN
                      (SELECT R.VILLA_ID, SUM(LEAST(TO_DATE('2013/09/01', 'yyyy/mm/dd'), END_DATE)
                                            - GREATEST(START_DATE, TO_DATE('2013/01/01', 'yyyy/mm/dd'))) AS NUM
                          FROM RESERVATION R
                          WHERE R.START_DATE<TO_DATE('2013/09/01', 'yyyy/mm/dd')
                            AND R.END_DATE>TO_DATE('2013/01/01', 'yyyy/mm/dd')
                          GROUP BY R.VILLA_ID) T13
                      ON T14.VILLA_ID=T13.VILLA_ID)
          WHERE NUM >= 1.1 * T13NUMBER) FILTERED
        , USERS, VILLA
  WHERE FILTERED.VILLA_ID=VILLA.VILLA_ID
    AND VILLA.OWNER=USERS.ID
  GROUP BY USERS.ID, USERS.FIRST_NAME, USERS.LAST_NAME;
