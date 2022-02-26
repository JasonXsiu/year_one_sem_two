/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*Q3-mau-mods.sql*/
/*Student ID: 31509746*/
/*Student Name: Ke Duong*/
/*Tutorial No:*/

/* Comments for your marker:




*/


/*
3(i) Changes to live database 1
*/
/*PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE*/
ALTER TABLE customer DROP COLUMN customer_no_aw_bought;

ALTER TABLE customer ADD customer_no_aw_bought NUMBER(3, 0) DEFAULT 0 NOT NULL;

COMMENT ON COLUMN customer.customer_no_aw_bought IS
    'Number of artworks has been bought by a customer';

MERGE INTO customer c
USING (
          SELECT
              customer_id,
              COUNT(sale_id) AS no_artwork
          FROM
                   customer
              NATURAL JOIN sale
          GROUP BY
              customer_id
      )
calculated ON ( c.customer_id = calculated.customer_id )
WHEN MATCHED THEN UPDATE
SET c.customer_no_aw_bought = calculated.no_artwork;

COMMIT;
/*
3(ii) Changes to live database 2
*/
/*PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE*/
ALTER TABLE sale DROP ( sale_mau_comission,
                        sale_gallery_comission,
                        sale_artist_payment );

ALTER TABLE sale ADD (
    sale_mau_comission      NUMBER(9, 2) DEFAULT 0 NOT NULL,
    sale_gallery_comission  NUMBER(9, 2) DEFAULT 0 NOT NULL,
    sale_artist_payment     NUMBER(9, 2) DEFAULT 0 NOT NULL
);

COMMENT ON COLUMN sale.sale_mau_comission IS
    'The comission in dollars that should be paid to MAU';

COMMENT ON COLUMN sale.sale_gallery_comission IS
    'The comission in dollars that should be paid to the gallery';

COMMENT ON COLUMN sale.sale_artist_payment IS
    'The payment in dollars that should be paid to the artist';

MERGE INTO sale s
USING (
          SELECT
              sale_id,
              0.2 * sale_price                                          AS mc,
              sale_price * ( gallery_sale_percent / 100 )               AS gc,
              sale_price * ( 1 - ( gallery_sale_percent + 20 ) / 100 )  AS ac
          FROM
                   sale
              NATURAL JOIN aw_display
              NATURAL JOIN gallery
      )
calculated ON ( s.sale_id = calculated.sale_id )
WHEN MATCHED THEN UPDATE
SET s.sale_mau_comission = calculated.mc,
    s.sale_gallery_comission = calculated.gc,
    s.sale_artist_payment = calculated.ac;

COMMIT;
/*
3(iii) Changes to live database 3
*/
/*PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE*/
DROP TABLE exhibition CASCADE CONSTRAINTS;

CREATE TABLE exhibition (
    exhibition_code        NUMBER(3, 0) NOT NULL,
    exhibition_name        VARCHAR2(100) NOT NULL,
    exhibition_theme       CHAR(1) NOT NULL,
    exhibition_start_date  DATE NOT NULL,
    exhibition_end_date    DATE NOT NULL,
    gallery_id             NUMBER(3, 0) NOT NULL,
    exhibition_no_artwork  NUMBER(5, 0) NOT NULL,
    artist_code            NUMBER(4, 0) NOT NULL,
    artwork_no             NUMBER NOT NULL,
    artwork_title          VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN exhibition.exhibition_code IS
    'Identifier for the exhibition';

COMMENT ON COLUMN exhibition.exhibition_name IS
    'Name of teh exhibition';

COMMENT ON COLUMN exhibition.exhibition_theme IS
    'Theme of the exhibition
A: Artist
M: Media
O: Other

';

COMMENT ON COLUMN exhibition.exhibition_start_date IS
    'The start date of the exhibition';

COMMENT ON COLUMN exhibition.exhibition_end_date IS
    'The end date of the exhibition';

COMMENT ON COLUMN exhibition.exhibition_no_artwork IS
    'The total number of artworks in an exhibition';

COMMENT ON COLUMN exhibition.artist_code IS
    'Code/Identifier for artist';

COMMENT ON COLUMN exhibition.artwork_no IS
    'Identifier for artwork within this artist';

ALTER TABLE exhibition
    ADD CONSTRAINT exhibition_uq UNIQUE ( exhibition_code,
                                          artist_code,
                                          artwork_no );

ALTER TABLE exhibition
    ADD CONSTRAINT chk_exhibition CHECK ( exhibition_theme IN ( 'A', 'M', 'O' ) );

ALTER TABLE exhibition ADD CONSTRAINT chk_no_artwork CHECK ( exhibition_no_artwork >=
1 );

ALTER TABLE exhibition
    ADD CONSTRAINT aw_display_exhibition FOREIGN KEY ( exhibition_start_date,
                                                       artist_code,
                                                       artwork_no )
        REFERENCES aw_display ( aw_display_start_date,
                                artist_code,
                                artwork_no );

ALTER TABLE exhibition
    ADD CONSTRAINT gallery_exhibition FOREIGN KEY ( gallery_id )
        REFERENCES gallery ( gallery_id );

DROP SEQUENCE exhibition_seq;

CREATE SEQUENCE exhibition_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

INSERT INTO exhibition
    SELECT
        exhibition_seq.NEXTVAL,
        'The End of An Era',
        'O',
        TO_DATE('10/03/2020', 'dd/mm/yyyy'),
        TO_DATE('20/03/2020', 'dd/mm/yyyy'),
        1,
        (
            SELECT
                COUNT(*)
            FROM
                aw_display
            WHERE
                aw_display_start_date = TO_DATE('10/03/2020', 'dd/mm/yyyy')
            GROUP BY
                aw_display_start_date
        ) AS no_artwork,
        artist_code,
        artwork_no,
        artwork_title
    FROM
             artwork
        NATURAL JOIN aw_display
    WHERE
        aw_display_start_date = TO_DATE('10/03/2020', 'dd/mm/yyyy');

COMMIT;