
CREATE TABLE USERS (
	ID			VARCHAR(12)	PRIMARY KEY,
	EMAIL		VARCHAR(120),
	FIRST_NAME	VARCHAR(120),
	LAST_NAME	VARCHAR(120),
	DOB			DATE
	--FAVORITE_VILLAS	VILLA_LIST
);

CREATE TABLE MANAGER (
	MANAGER_ID	VARCHAR(12),
	MANAGED_BY	VARCHAR(12),
	PRIMARY KEY(MANAGER_ID),
	CONSTRAINT	fk_MangerID	FOREIGN KEY(MANAGER_ID)
		REFERENCES USERS(ID),
	CONSTRAINT fk_ManagerManagedBy FOREIGN KEY (MANAGED_BY)
		REFERENCES MANAGER(MANAGER_ID)
);

CREATE TABLE OWNER (
	OWNER_ID	VARCHAR(12),
	CONTACT_NUMBER	VARCHAR(12),
	MANAGED_BY	VARCHAR(12),
	PRIMARY KEY(OWNER_ID),
	CONSTRAINT fk_OwnerID	FOREIGN KEY(OWNER_ID)
		REFERENCES USERS(ID),
	CONSTRAINT fk_OwnerManagedBy FOREIGN KEY (MANAGED_BY)
		REFERENCES MANAGER(MANAGER_ID)
);


CREATE TABLE VILLA (
	VILLA_ID			VARCHAR(12),
	NAME				VARCHAR(120),
	--FEATURES			FEATURE_LIST,
	OWNER				VARCHAR(12),
	PRIMARY KEY(VILLA_ID)
	-- ,CONSTRAINT fk_VillaOwner FOREIGN KEY (OWNER) REFERENCES OWNER(OWNER_ID) DEFERRABLE INITIALLY DEFERRED
	-- ADD FOREIGN KEY CONSTRAINT LATER
);

-- CONSTRAINT fk_VillaOwner FOREIGN KEY (OWNER) REFERENCES OWNER(OWNER_ID);
ALTER TABLE VILLA ADD FOREIGN KEY(OWNER) REFERENCES OWNER;

CREATE TABLE FEATURES (
	FEATURE_ID		VARCHAR(12),
	FEATURE_NAME	VARCHAR(80),
	PRIMARY KEY(FEATURE_ID)
);


CREATE TABLE VILLA_FEATURE (
	VILLA_ID	VARCHAR(12),
	FEATURE_ID	VARCHAR(12),
	PRIMARY KEY(VILLA_ID, FEATURE_ID),
	CONSTRAINT	fk_Villa_Feature_ID_V	FOREIGN KEY(VILLA_ID)
		REFERENCES VILLA(VILLA_ID) ON DELETE CASCADE,
	CONSTRAINT	fk_Villa_Feature_ID_F	FOREIGN KEY(FEATURE_ID)
		REFERENCES FEATURES(FEATURE_ID) ON DELETE CASCADE
);

--CREATE OR REPLACE TYPE VILLA_LIST AS VARRAY(200) OF VARCHAR(12);

CREATE TABLE USER_FAVORITEVILLA (
	USER_ID		VARCHAR(12),
	VILLA_ID	VARCHAR(12),
	PRIMARY KEY(USER_ID, VILLA_ID),
	CONSTRAINT	fk_User_Villa_ID_U	FOREIGN KEY(USER_ID)
		REFERENCES USERS(ID) ON DELETE CASCADE,
	CONSTRAINT	fk_User_Villa_ID_V	FOREIGN KEY(VILLA_ID)
		REFERENCES VILLA(VILLA_ID) ON DELETE CASCADE
);



CREATE TABLE RATE (
	RATE_ID		VARCHAR(12)	PRIMARY KEY,
	VILLA_ID	VARCHAR(12)	NOT NULL,
	START_DATE	DATE,
	END_DATE	DATE,
	RATE		NUMBER(10,2),		-- money
	CONSTRAINT	fk_RateID	FOREIGN KEY(VILLA_ID)
		REFERENCES VILLA(VILLA_ID)
);

CREATE TABLE COUPON (
	COUPON_ID			VARCHAR(12)	PRIMARY KEY,
	VILLA_ID			VARCHAR(12),
	START_DATE			DATE,
	END_DATE			DATE,
	DISCOUNT_PERCENT	NUMBER(10,2),		-- money
	CONSTRAINT	fk_CouponID	FOREIGN KEY(VILLA_ID)
		REFERENCES VILLA(VILLA_ID)
);

CREATE TABLE RESERVATION (
	RESERVATION_ID	VARCHAR(12)	PRIMARY KEY,
	USER_ID			VARCHAR(12),
	VILLA_ID		VARCHAR(12),
	START_DATE		DATE	NOT NULL,
	END_DATE		DATE	NOT NULL,
	COUPON_ID		VARCHAR(12),
	DEPOSIT			NUMBER(10,2),		-- money
	CONSTRAINT	fk_ReservationUsers	FOREIGN KEY(USER_ID)
		REFERENCES USERS(ID),
	CONSTRAINT	fk_ReservationVilla	FOREIGN KEY(VILLA_ID)
		REFERENCES VILLA(VILLA_ID),
	CONSTRAINT	fk_ReservationCoupon	FOREIGN KEY(COUPON_ID)
		REFERENCES COUPON(COUPON_ID)
);



CREATE TABLE REVIEW (
	REVIEW_ID	VARCHAR(12)	PRIMARY KEY,
	USER_ID		VARCHAR(12),
	VILLA_ID	VARCHAR(12),
	TEXT		VARCHAR(800),
	RATING		INTEGER,
	CONSTRAINT	fk_ReviewUsers	FOREIGN KEY(USER_ID)
		REFERENCES USERS(ID),
	CONSTRAINT	fk_ReviewVilla	FOREIGN KEY(VILLA_ID)
		REFERENCES VILLA(VILLA_ID)
);

CREATE TABLE LIKEDREVIEW (
	REVIEW_ID	VARCHAR(12),
	USER_ID		VARCHAR(12),
	PRIMARY KEY(REVIEW_ID, USER_ID),
	CONSTRAINT	fk_LinkedReview_R	FOREIGN KEY(REVIEW_ID)
		REFERENCES REVIEW(REVIEW_ID),
	CONSTRAINT	fk_LinkedReview_U	FOREIGN KEY(USER_ID)
		REFERENCES USERS(ID)
);

COMMIT;












-- USERS

INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U1',	'jack_killer@gmail.com',	'Jackie',	'Jones',	TO_DATE('1983/2/28', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U2',	'Hello_macy@yahoo.com',	'Jessie',	'Jackson',	TO_DATE('1986/3/4', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U3',	'john_black@hotmail.com',	'Tommy',	'Trojan',	TO_DATE('1990/4/22', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U4',	'ny_robert@usc.edu',	'Niki',	'Nanjan',	TO_DATE('1980/6/10', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U5',	'cool_andrew@bbc.co.uk',	'Jalli',	'Shadan',	TO_DATE('1984/11/27', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U6',	'coryphillip@voa.gov',	'Houtan',	'Khandan',	TO_DATE('1966/6/6', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U7',	'DaneilJ@msnbc.com',	'Naz',	'Nazi',	TO_DATE('2000/4/20', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U8',	'rohanau@cs.mit.edu',	'Ab',	'Bazi',	TO_DATE('1956/12/12', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U9',	'edmorales@houti.com',	'Ben',	'Ghazi',	TO_DATE('1973/11/10', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U10',	'danamoon@louti.com',	'Carlos',	'Santana',	TO_DATE('1977/7/7', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U11',	'owner1@villa.com',	'Roberto',	'Carlos',	TO_DATE('1955/5/5', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U12',	'owner2@villa.com',	'De',	'Vilardo',	TO_DATE('1944/4/4', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U13',	'owner3@villa.com',	'villa',	'Blanka',	TO_DATE('1974/11/11', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U14',	'ceo@villa.com',	'nino',	'bino',	TO_DATE('1991/1/1', 'yyyy/mm/dd'));
INSERT INTO USERS(ID, EMAIL, FIRST_NAME, LAST_NAME, DOB) VALUES ('U15',	'manager2@villa.com',	'Bookish',	'Morinio',	TO_DATE('1950/4/17', 'yyyy/mm/dd'));

-- alter table users add (FIRST_NAME VARCHAR(120));
-- alter table users add (LAST_NAME VARCHAR(120));
-- 
-- alter table users DROP COLUMN FIRSTNAME;
-- alter table users DROP COLUMN LASTNAME;

-- MANAGER

INSERT INTO MANAGER(MANAGER_ID, MANAGED_BY) VALUES ('U14',	null);
INSERT INTO MANAGER(MANAGER_ID, MANAGED_BY) VALUES ('U15',	'U14');


-- OWNER

INSERT INTO OWNER(OWNER_ID, CONTACT_NUMBER, MANAGED_BY) VALUES ('U11',	'111-111-1111',		'U15');
INSERT INTO OWNER(OWNER_ID, CONTACT_NUMBER, MANAGED_BY) VALUES ('U12',	'222-222-2222',		'U15');
INSERT INTO OWNER(OWNER_ID, CONTACT_NUMBER, MANAGED_BY) VALUES ('U13',	'333-333-3333',		'U15');
INSERT INTO OWNER(OWNER_ID, CONTACT_NUMBER, MANAGED_BY) VALUES ('U14',	'444-444-4444',		null);

-- alter table OWNER ADD (CONTACT_NUMBER VARCHAR(120));
-- alter table OWNER DROP COLUMN CONTACT_NO;

-- VILLA
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil1',	'Fifi',	'U11');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil2',	'Lulu',	'U12');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil3',	'Penny',	'U13');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil4',	'Kiki',	'U11');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil5',	'Vivi',	'U11');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil6',	'Gigi',	'U11');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil7',	'Kitty',	'U12');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil8',	'Ellie',	'U13');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil9',	'Ali',	'U14');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil10',	'Kelley',	'U12');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil11',	'Dori',	'U12');
INSERT INTO VILLA(VILLA_ID, NAME, OWNER) VALUES ('Vil12',	'Houti',	'U13');

-- FEATURES

INSERT INTO FEATURES(FEATURE_ID, FEATURE_NAME) VALUES ('Fea1',	'swimming pool');
INSERT INTO FEATURES(FEATURE_ID, FEATURE_NAME) VALUES ('Fea2',	'Jacuzzi');
INSERT INTO FEATURES(FEATURE_ID, FEATURE_NAME) VALUES ('Fea3',	'billiard table');
INSERT INTO FEATURES(FEATURE_ID, FEATURE_NAME) VALUES ('Fea4',	'Xbox 360');
INSERT INTO FEATURES(FEATURE_ID, FEATURE_NAME) VALUES ('Fea5',	'board games');
INSERT INTO FEATURES(FEATURE_ID, FEATURE_NAME) VALUES ('Fea6',	'pets allowed');


-- VILLA_FEATURE


INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil1',	'Fea1');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil1',	'Fea2');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil2',	'Fea1');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil3',	'Fea1');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil3',	'Fea4');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil3',	'Fea5');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil4',	'Fea2');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil5',	'Fea4');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil6',	'Fea6');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil7',	'Fea3');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil7',	'Fea4');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil7',	'Fea5');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil7',	'Fea6');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil8',	'Fea6');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil9',	'Fea5');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil10',	'Fea5');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil11',	'Fea2');
INSERT INTO VILLA_FEATURE(VILLA_ID, FEATURE_ID) VALUES ('Vil12',	'Fea2');



-- USER_FAVORITEVILLA

INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U1',	'Vil2');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U1',	'Vil4');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U2',	'Vil8');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U3',	'Vil10');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U3',	'Vil3');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U3',	'Vil7');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U4',	'Vil10');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U4',	'Vil4');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U5',	'Vil1');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U6',	'Vil3');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U7',	'Vil2');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U7',	'Vil4');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U7',	'Vil12');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U8',	'Vil1');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U8',	'Vil9');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U9',	'Vil6');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U10',	'Vil11');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U10',	'Vil12');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U13',	'Vil1');
INSERT INTO USER_FAVORITEVILLA(USER_ID, VILLA_ID) VALUES ('U14',	'Vil2');



-- RATE

INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat1',	'Vil1',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	150);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat2',	'Vil2',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	100);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat3',	'Vil3',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	200);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat4',	'Vil4',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	130);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat5',	'Vil5',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	120);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat6',	'Vil6',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	140);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat7',	'Vil7',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	180);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat8',	'Vil8',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	300);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat9',	'Vil9',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	80);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat10',	'Vil10',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	250);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat11',	'Vil11',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	170);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat12',	'Vil12',	TO_DATE('2013/1/1', 'yyyy/mm/dd'),	TO_DATE('2013/8/31', 'yyyy/mm/dd'),	110);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat13',	'Vil1',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	120);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat14',	'Vil2',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	75);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat15',	'Vil3',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	160);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat16',	'Vil4',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	90);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat17',	'Vil5',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	80);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat18',	'Vil6',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	100);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat19',	'Vil7',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	150);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat20',	'Vil8',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	200);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat21',	'Vil9',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	50);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat22',	'Vil10',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	200);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat23',	'Vil11',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	120);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat24',	'Vil12',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	90);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat25',	'Vil1',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	180);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat26',	'Vil2',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	120);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat27',	'Vil3',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	240);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat28',	'Vil4',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	150);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat29',	'Vil5',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	150);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat30',	'Vil6',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	180);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat31',	'Vil7',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	250);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat32',	'Vil8',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	400);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat33',	'Vil9',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	110);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat34',	'Vil10',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	320);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat35',	'Vil11',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	210);
INSERT INTO RATE(RATE_ID, VILLA_ID, START_DATE, END_DATE, RATE) VALUES ('Rat36',	'Vil12',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	140);

-- ALTER TABLE RATE DROP CONSTRAINT fk_RateID;
-- ALTER TABLE RATE ADD FOREIGN KEY(VILLA_ID) REFERENCES VILLA(VILLA_ID);


-- COUPON

INSERT INTO COUPON(COUPON_ID, VILLA_ID, START_DATE, END_DATE, DISCOUNT_PERCENT) VALUES ('Coup1',	'Vil1',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2014/1/31', 'yyyy/mm/dd'),	20);
INSERT INTO COUPON(COUPON_ID, VILLA_ID, START_DATE, END_DATE, DISCOUNT_PERCENT) VALUES ('Coup2',	'Vil2',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	15);
INSERT INTO COUPON(COUPON_ID, VILLA_ID, START_DATE, END_DATE, DISCOUNT_PERCENT) VALUES ('Coup3',	'Vil3',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	25);
INSERT INTO COUPON(COUPON_ID, VILLA_ID, START_DATE, END_DATE, DISCOUNT_PERCENT) VALUES ('Coup4',	'Vil4',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/31', 'yyyy/mm/dd'),	10);
INSERT INTO COUPON(COUPON_ID, VILLA_ID, START_DATE, END_DATE, DISCOUNT_PERCENT) VALUES ('Coup5',	'Vil1',	TO_DATE('2014/1/1', 'yyyy/mm/dd'),	TO_DATE('2014/8/31', 'yyyy/mm/dd'),	15);

-- ALTER TABLE COUPON DROP CONSTRAINT fk_CouponID;
-- ALTER TABLE COUPON ADD FOREIGN KEY(VILLA_ID) REFERENCES VILLA(VILLA_ID);


-- RESERVATION


INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res1',	'U1',	'Vil1',	TO_DATE('2013/1/2', 'yyyy/mm/dd'),	TO_DATE('2013/1/4', 'yyyy/mm/dd'),	null,	50);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res2',	'U7',	'Vil2',	TO_DATE('2013/1/5', 'yyyy/mm/dd'),	TO_DATE('2013/1/6', 'yyyy/mm/dd'),	null,	30);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res3',	'U2',	'Vil3',	TO_DATE('2013/2/3', 'yyyy/mm/dd'),	TO_DATE('2013/2/7', 'yyyy/mm/dd'),	null,	60);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res4',	'U4',	'Vil4',	TO_DATE('2013/2/4', 'yyyy/mm/dd'),	TO_DATE('2013/2/5', 'yyyy/mm/dd'),	null,	39);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res5',	'U4',	'Vil5',	TO_DATE('2013/3/6', 'yyyy/mm/dd'),	TO_DATE('2013/3/12', 'yyyy/mm/dd'),	null,	40);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res6',	'U4',	'Vil6',	TO_DATE('2013/4/23', 'yyyy/mm/dd'),	TO_DATE('2013/4/25', 'yyyy/mm/dd'),	null,	42);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res7',	'U6',	'Vil7',	TO_DATE('2013/5/29', 'yyyy/mm/dd'),	TO_DATE('2013/6/1', 'yyyy/mm/dd'),	null,	60);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res8',	'U10',	'Vil8',	TO_DATE('2013/7/30', 'yyyy/mm/dd'),	TO_DATE('2013/8/2', 'yyyy/mm/dd'),	null,	100);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res9',	'U3',	'Vil9',	TO_DATE('2013/8/11', 'yyyy/mm/dd'),	TO_DATE('2013/8/12', 'yyyy/mm/dd'),	null,	24);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res10',	'U2',	'Vil10',	TO_DATE('2013/8/19', 'yyyy/mm/dd'),	TO_DATE('2013/8/21', 'yyyy/mm/dd'),	null,	75);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res11',	'U5',	'Vil11',	TO_DATE('2013/8/15', 'yyyy/mm/dd'),	TO_DATE('2013/8/17', 'yyyy/mm/dd'),	null,	51);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res12',	'U6',	'Vil12',	TO_DATE('2013/8/27', 'yyyy/mm/dd'),	TO_DATE('2013/8/28', 'yyyy/mm/dd'),	null,	33);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res13',	'U2',	'Vil1',	TO_DATE('2013/9/1', 'yyyy/mm/dd'),	TO_DATE('2013/9/3', 'yyyy/mm/dd'),	null,	40);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res14',	'U5',	'Vil2',	TO_DATE('2013/9/2', 'yyyy/mm/dd'),	TO_DATE('2013/9/3', 'yyyy/mm/dd'),	null,	25);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res15',	'U9',	'Vil3',	TO_DATE('2013/9/15', 'yyyy/mm/dd'),	TO_DATE('2013/9/20', 'yyyy/mm/dd'),	'Coup3',	36);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res16',	'U5',	'Vil4',	TO_DATE('2013/10/1', 'yyyy/mm/dd'),	TO_DATE('2013/10/3', 'yyyy/mm/dd'),	'Coup4',	27);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res17',	'U4',	'Vil5',	TO_DATE('2013/10/15', 'yyyy/mm/dd'),	TO_DATE('2013/10/16', 'yyyy/mm/dd'),	null,	24);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res18',	'U5',	'Vil6',	TO_DATE('2013/11/2', 'yyyy/mm/dd'),	TO_DATE('2013/11/4', 'yyyy/mm/dd'),	null,	30);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res19',	'U10',	'Vil7',	TO_DATE('2013/11/6', 'yyyy/mm/dd'),	TO_DATE('2013/11/7', 'yyyy/mm/dd'),	null,	50);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res20',	'U9',	'Vil8',	TO_DATE('2013/11/6', 'yyyy/mm/dd'),	TO_DATE('2013/11/10', 'yyyy/mm/dd'),	null,	60);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res21',	'U4',	'Vil9',	TO_DATE('2013/11/10', 'yyyy/mm/dd'),	TO_DATE('2013/11/13', 'yyyy/mm/dd'),	null,	15);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res22',	'U4',	'Vil10',	TO_DATE('2013/11/11', 'yyyy/mm/dd'),	TO_DATE('2013/11/13', 'yyyy/mm/dd'),	null,	60);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res23',	'U6',	'Vil11',	TO_DATE('2013/12/1', 'yyyy/mm/dd'),	TO_DATE('2013/12/4', 'yyyy/mm/dd'),	null,	40);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res24',	'U5',	'Vil12',	TO_DATE('2013/12/23', 'yyyy/mm/dd'),	TO_DATE('2013/12/26', 'yyyy/mm/dd'),	null,	30);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res25',	'U7',	'Vil1',	TO_DATE('2014/1/12', 'yyyy/mm/dd'),	TO_DATE('2014/1/15', 'yyyy/mm/dd'),	'Coup1',	48);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res26',	'U9',	'Vil2',	TO_DATE('2014/1/6', 'yyyy/mm/dd'),	TO_DATE('2014/1/7', 'yyyy/mm/dd'),	'Coup2',	34);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res27',	'U6',	'Vil2',	TO_DATE('2014/2/5', 'yyyy/mm/dd'),	TO_DATE('2014/2/9', 'yyyy/mm/dd'),	null,	40);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res28',	'U5',	'Vil5',	TO_DATE('2014/2/9', 'yyyy/mm/dd'),	TO_DATE('2014/2/15', 'yyyy/mm/dd'),	null,	50);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res29',	'U4',	'Vil8',	TO_DATE('2014/3/18', 'yyyy/mm/dd'),	TO_DATE('2014/3/19', 'yyyy/mm/dd'),	null,	120);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res30',	'U2',	'Vil4',	TO_DATE('2014/4/27', 'yyyy/mm/dd'),	TO_DATE('2014/4/30', 'yyyy/mm/dd'),	null,	50);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res31',	'U4',	'Vil10',	TO_DATE('2014/5/29', 'yyyy/mm/dd'),	TO_DATE('2014/6/1', 'yyyy/mm/dd'),	null,	96);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res32',	'U9',	'Vil12',	TO_DATE('2014/7/28', 'yyyy/mm/dd'),	TO_DATE('2014/8/2', 'yyyy/mm/dd'),	null,	42);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res33',	'U9',	'Vil7',	TO_DATE('2014/8/11', 'yyyy/mm/dd'),	TO_DATE('2014/8/12', 'yyyy/mm/dd'),	null,	75);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res34',	'U7',	'Vil4',	TO_DATE('2014/8/15', 'yyyy/mm/dd'),	TO_DATE('2014/8/21', 'yyyy/mm/dd'),	null,	50);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res35',	'U8',	'Vil8',	TO_DATE('2014/8/13', 'yyyy/mm/dd'),	TO_DATE('2014/8/17', 'yyyy/mm/dd'),	null,	120);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res36',	'U3',	'Vil2',	TO_DATE('2014/8/27', 'yyyy/mm/dd'),	TO_DATE('2014/8/28', 'yyyy/mm/dd'),	null,	40);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res37',	'U2',	'Vil11',	TO_DATE('2014/6/20', 'yyyy/mm/dd'),	TO_DATE('2014/6/23', 'yyyy/mm/dd'),	null,	70);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res38',	'U1',	'Vil2',	TO_DATE('2014/8/28', 'yyyy/mm/dd'),	TO_DATE('2014/8/30', 'yyyy/mm/dd'),	null,	40);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res39',	'U9',	'Vil1',	TO_DATE('2014/4/10', 'yyyy/mm/dd'),	TO_DATE('2014/4/15', 'yyyy/mm/dd'),	null,	60);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res40',	'U9',	'Vil7',	TO_DATE('2014/2/5', 'yyyy/mm/dd'),	TO_DATE('2014/2/9', 'yyyy/mm/dd'),	null,	75);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res41',	'U8',	'Vil7',	TO_DATE('2014/2/9', 'yyyy/mm/dd'),	TO_DATE('2014/2/15', 'yyyy/mm/dd'),	null,	75);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res42',	'U5',	'Vil7',	TO_DATE('2014/3/18', 'yyyy/mm/dd'),	TO_DATE('2014/3/19', 'yyyy/mm/dd'),	null,	75);
INSERT INTO RESERVATION(RESERVATION_ID, USER_ID, VILLA_ID, START_DATE, END_DATE, COUPON_ID, DEPOSIT) VALUES ('Res43',	'U6',	'Vil1',	TO_DATE('2014/5/12', 'yyyy/mm/dd'),	TO_DATE('2014/5/13', 'yyyy/mm/dd'),	'Coup5',	51);







-- REVIEW


INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev1',	'U1',	'Vil1',	'Poor maintainance considering the price.',	2);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev2',	'U2',	'Vil3',	'Boring and Dull',	1);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev3',	'U4',	'Vil6',	'Love it!',	4);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev4',	'U2',	'Vil1',	'Best vila error',	2);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev5',	'U7',	'Vil1',	'Though not clean, has fantastic scenery around it',	3);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev6',	'U5',	'Vil2',	'not recommended',	1);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev7',	'U6',	'Vil1',	'Good one',	4);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev8',	'U4',	'Vil4',	'I gonna rent again and again',	5);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev9',	'U9',	'Vil3',	'Good work',	5);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev10',	'U3',	'Vil9',	'A must visit villa',	5);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev11',	'U10',	'Vil8',	'Nice',	1);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev13',	'U6',	'Vil7',	'poor one',	1);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev14',	'U1',	'Vil7',	'popular one',	4);
INSERT INTO REVIEW(REVIEW_ID, USER_ID, VILLA_ID, TEXT, RATING) VALUES ('Rev15',	'U7',	'Vil3',	'wanna go back!',	5);





-- LIKEDREVIEW



INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev1',	'U4');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev1',	'U2');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev1',	'U3');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev2',	'U7');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev2',	'U4');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev3',	'U8');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev4',	'U9');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev5',	'U2');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev5',	'U4');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev14',	'U2');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev14',	'U4');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev14',	'U6');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev15',	'U3');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev15',	'U6');
INSERT INTO LIKEDREVIEW(REVIEW_ID, USER_ID) VALUES ('Rev15',	'U7');

COMMIT;





