SELECT FIRST_NAME, LAST_NAME FROM USERS, RESERVATION, COUPON
  WHERE USERS.ID=RESERVATION.USER_ID AND RESERVATION.COUPON_ID=COUPON.COUPON_ID AND COUPON.DISCOUNT_PERCENT > 10
  GROUP BY USERS.ID, FIRST_NAME, LAST_NAME;
