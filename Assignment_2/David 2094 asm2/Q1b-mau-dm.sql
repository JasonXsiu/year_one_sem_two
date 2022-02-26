/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*Q1b-mau-dm.sql*/
/*Student ID: 31509746*/
/*Student Name: Ke Duong*/
/*Tutorial No:*/

/* Comments for your marker:
All queries were made based on the assumptions that:
    -No other artwork has been added by artist 17 after the "Saint Catherine of Siena"
    -No other artwork has been dispalyed after the "Saint Catherine of Siena"



*/


/*
1b(i) Create a sequence 
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE*/
DROP SEQUENCE aw_status_seq;

DROP SEQUENCE aw_display_seq;

DROP SEQUENCE sale_seq;
/*sequence in aw_status*/

CREATE SEQUENCE aw_status_seq START WITH 300 INCREMENT BY 1
NOCACHE NOCYCLE;

/*sequence in aw_display*/
CREATE SEQUENCE aw_display_seq START WITH 300 INCREMENT BY 1 NOCACHE
NOCYCLE;

/*sequence in sale*/
CREATE SEQUENCE sale_seq START WITH 300 INCREMENT BY 1 NOCACHE NOCYCLE;

COMMIT;
/*
1b(ii) Take the necessary steps in the database to record data.
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE*/

/*as we CANNOT manually lookup the value --> subquery is used to find how many artworks the artist currently has*/
INSERT INTO artwork VALUES (
    17,
    (
        SELECT
            nvl(MAX(artwork_no), 0) + 1
        FROM
            artwork
        WHERE
            artist_code = 17
    ),
    'Saint Catherine of Siena',
    500000,
    TO_DATE('22/10/2020', 'dd/mm/yyyy')
);

INSERT INTO aw_status VALUES (
    aw_status_seq.NEXTVAL,
    17,
    (
        select max(artwork_no) from artwork where artist_code = 17
    ),
    TO_DATE('22/10/2020 10:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

COMMIT;


/*
1b(iii) Take the necessary steps in the database to record changes. 
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE*/
/* (a)*/
/*Assumption: no other artworks have been added by this artist*/
/*select gallery_id from gallery where gallery_name = 'Karma Art'; --getting the gallery_id*/
/*select artwork_no from artwork where artist_code = 17 and artwork_title = 'Saint Catherine of Siena'; --getting the artwork_no*/

--newly arrival  using the assumption
INSERT INTO aw_status VALUES (
    aw_status_seq.NEXTVAL,
    17,
    (
        select max(artwork_no) from artwork where artist_code = 17
    ),
    TO_DATE('22/10/2020 11:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    (
        SELECT
            gallery_id
        FROM
            gallery
        WHERE
            gallery_name = 'Karma Art'
    )
);

COMMIT;
/* (b)*/
/*select to_char(to_date('22/10/2020 11:00','dd/mm/yyyy hh24:mi')+(1/24)*(3+ 15 / 60),'dd/mm/yyyy hh24:mi') from dual;*/
/*select max(to_char(aws_date_time,'dd/mm/yyyy hh24:mi')) from aw_status join artwork using (artist_code, artwork_no) where artwork_title = 'Saint Catherine of Siena' and artist_code = 17; -- find the current datetime (it will be larger than the earlier datetime*/

INSERT INTO aw_status VALUES (
    aw_status_seq.NEXTVAL,
    17,
    (
        select max(artwork_no) from artwork where artist_code = 17
    ),
    (
        SELECT
            MAX(aws_date_time)   + ( 1 / 24 ) * ( 3 + 15 / 60 )
        FROM
                 aw_status
            JOIN artwork
            USING ( artist_code,
                    artwork_no )
        WHERE
            artist_code = 17 and aws_action = 'T' and artwork_no = (select max(artwork_no) from artwork where artist_code = 17)),
    'G',
    (
        SELECT
            gallery_id
        FROM
            gallery
        WHERE
            gallery_name = 'Karma Art'
    )
);

COMMIT;

/* (c)*/
INSERT INTO aw_display VALUES (
    aw_display_seq.NEXTVAL,
    17,
    (
        select max(artwork_no) from artwork where artist_code = 17
    ),
    (
        SELECT
            MAX(aws_date_time)   + 1
        FROM
                 aw_status
            JOIN artwork
            USING ( artist_code,
                    artwork_no )
        WHERE
            artist_code = 17 and aws_action = 'G' and artwork_no = (select max(artwork_no) from artwork where artist_code = 17)),
    (
        SELECT
            MAX(aws_date_time)   + 11
        FROM
                 aw_status
            JOIN artwork
            USING ( artist_code,
                    artwork_no )
        WHERE
            artist_code = 17 and aws_action = 'G' and artwork_no = (select max(artwork_no) from artwork where artist_code = 17)),
    (
        SELECT
            gallery_id
        FROM
            gallery
        WHERE
            gallery_name = 'Karma Art'
    )
);

COMMIT;

/*
1b(iv) Take the necessary steps in the database to record changes. 
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE*/
/*note: it is the latest artwork out on display*/
/*update the display ending day*/
UPDATE aw_display
SET
    aw_display_end_date = aw_display_start_date + 5
WHERE
    aw_display_id = (
        SELECT
            MAX(aw_display_id)
        FROM
            aw_display
    );


/*update the aw status*/
/*select to_char (to_date((select max(aw_display_start_date) from aw_display where artist_code = 17),'dd/mm/yyy hh24:mi')+5+(1/24 * (14 +  30/60))  ,'dd/mm/yyyy hh24:mi') from dual;*/
INSERT INTO aw_status VALUES (
    aw_status_seq.NEXTVAL,
    17,
    (
        select max(artwork_no) from artwork where artist_code = 17
    ),
    to_date((
        SELECT
            MAX(aw_display_start_date)
        FROM
            aw_display
    ),
            'dd/mm/yyy hh24:mi') + 5 + ( 1 / 24 * ( 14 + 30 / 60 ) ),
    'S',
    NULL
);

/*update the sale table*/
/*select aws_date_time from aw_status where aws_action = 'S' and artist_code = 17 and artwork_no = (select artwork_no from artwork where artist_code = 17 and artwork_title = 'Saint Catherine of Siena');*/
/*select max(aw_display_id) from aw_display where artist_code = 17;*/
INSERT INTO sale VALUES (
    sale_seq.NEXTVAL,
    (
        SELECT
            aws_date_time
        FROM
            aw_status
        WHERE
                aws_action = 'S'
            AND artist_code = 17
            AND artwork_no = (select max(artwork_no) from artwork where artist_code = 17)
    ),
    850000,
    1,
    (
        SELECT
            MAX(aw_display_id)
        FROM
            aw_display
        WHERE
            artist_code = 17
    )
);

COMMIT;