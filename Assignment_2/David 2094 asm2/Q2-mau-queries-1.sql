/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*Q2-mau-queries.sql*/
/*Student ID: 31509746*/
/*Student Name: Ke Duong*/
/*Tutorial No: 03*/

/* Comments for your marker:




*/


/*
2(i) Query 1
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
SELECT
    artist_code       AS "Artist Code",
    nvl2(artist_gname, artist_gname || ' ', NULL)
    || artist_fname   AS "Artist Name",
    CASE artist_state
        WHEN 'VIC'  THEN
            'Victoria'
        WHEN 'NSW'  THEN
            'New South Wales'
        WHEN 'WA'   THEN
            'Western Australian'
    END               AS "Artist State"
FROM
    artist
WHERE
    artist_gname IS NULL
    OR artist_fname IS NULL
    OR artist_phone IS NULL
ORDER BY
    nvl2(artist_gname, artist_gname || ' ', NULL)
    || artist_fname ASC;

/*
2(ii) Query 2
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
SELECT
    artist_code                                               AS "Artist Code",
    nvl2(artist_gname, artist_gname || ' ', NULL)
    || artist_fname                                           AS "Artist name",
    artwork_no                                                AS "Artwork No.",
    artwork_title                                             AS "Arwork Title",
    to_char(artwork_minpayment, '$9999999999.00')             AS "Artwork Min.Payment",
    round((aws_date_time - artwork_submitdate) - 1, 1)          AS "Number of Days with MAU"
FROM
    aw_status
    LEFT OUTER JOIN aw_display
    USING ( artist_code,
            artwork_no )
    NATURAL JOIN artwork
    NATURAL JOIN artist
WHERE
    aw_display_id IS NULL
    AND aws_action = 'R'
    AND round((aws_date_time - artwork_submitdate) - 1, 1) <= 120
ORDER BY
    artist_code ASC,
    "Number of Days with MAU" DESC;
/*
2(iii) Query 3
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
SELECT
    artist_code                                            AS "Artist Code",
    artwork_no                                             AS "Artwork No.",
    artwork_title                                          AS "Artwork Title",
    gallery_id                                             AS "Gallery ID",
    gallery_name                                           AS "Gallery Name",
    to_char(aw_display_start_date, 'Dy dd Mon  yyyy')      AS " Display Start Date",
    aw_display_end_date - aw_display_start_date            AS "Number of Days in Gallery"
FROM
         aw_display
    NATURAL JOIN gallery
    NATURAL JOIN artwork
WHERE
    aw_display_end_date - aw_display_start_date < 13
ORDER BY
    "Number of Days in Gallery" ASC,
    gallery_id,
    aw_display_start_date;

/*
2(iv) Query 4
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
SELECT
    artist_code           AS "Artist Code",
    artwork_no            AS "Artwork No.",
    artwork_title         AS "Artowrk Title",
    COUNT(aws_action)     AS "Number of Movements"
FROM
         artwork
    NATURAL JOIN aw_status
WHERE
    aws_action = 'T'
GROUP BY
    artist_code,
    artwork_title,
    artwork_no
HAVING
    COUNT(aws_action) < (
        SELECT
            ( COUNT(aws_id) / COUNT(DISTINCT artist_code) ) AS move_avg
        FROM
            aw_status
        WHERE
            aws_action = 'T'
    )
ORDER BY
    "Number of Movements",
    artist_code,
    artwork_no;

/*
2(v) Query 5
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
SELECT
    artist_code,
    artwork_title,
    lpad(to_char(round(artwork_minpayment +(artwork_minpayment * total1) /(1 - total1)),
                 '$9999999999'),
         20)   AS "Min. Sale Price Est. (Gallery 1)",
    lpad(to_char(round(artwork_minpayment +(artwork_minpayment * total2) /(1 - total2)),
                 '$9999999999'),
         20)   AS "Min. Sale Price Est. (Gallery 2)",
    lpad(to_char(round(artwork_minpayment +(artwork_minpayment * total3) /(1 - total3)),
                 '$9999999999'),
         20)   AS "Min. Sale Price Est. (Gallery 3)",
    lpad(to_char(round(artwork_minpayment +(artwork_minpayment * total4) /(1 - total4)),
                 '$9999999999'),
         20)   AS "Min. Sale Price Est. (Gallery 4)",
    lpad(to_char(round(artwork_minpayment +(artwork_minpayment * total5) /(1 - total5)),
                 '$9999999999'),
         20)   AS "Min. Sale Price Est. (Gallery 5)"
FROM
    aw_display
    LEFT OUTER JOIN sale
    USING ( aw_display_id )
    RIGHT OUTER JOIN artwork
    USING ( artist_code,
            artwork_no )
    NATURAL JOIN (
        SELECT
            ( gallery_sale_percent + 20 ) / 100 AS total1
        FROM
            gallery
        WHERE
            gallery_id = 1
    )
    NATURAL JOIN (
        SELECT
            ( gallery_sale_percent + 20 ) / 100 AS total2
        FROM
            gallery
        WHERE
            gallery_id = 2
    )
    NATURAL JOIN (
        SELECT
            ( gallery_sale_percent + 20 ) / 100 AS total3
        FROM
            gallery
        WHERE
            gallery_id = 3
    )
    NATURAL JOIN (
        SELECT
            ( gallery_sale_percent + 20 ) / 100 AS total4
        FROM
            gallery
        WHERE
            gallery_id = 4
    )
    NATURAL JOIN (
        SELECT
            ( gallery_sale_percent + 20 ) / 100 AS total5
        FROM
            gallery
        WHERE
            gallery_id = 5
    )
WHERE
    sale_id IS NULL
ORDER BY
    artist_code,
    artwork_title;


/*
2(vi) Query 6
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/


WITH all_related_table_combine AS (select * from sale NATURAL JOIN aw_display NATURAL JOIN artwork NATURAL JOIN gallery NATURAL JOIN artist)
select 
lpad(to_char(artist_code), 18)               as "Artist Code", 
nvl2(artist_gname, artist_gname || ' ', NULL) || artist_fname   AS "Artist Full Name", 
to_char(artwork_title)                      as "Artwork Title", 
lpad(to_char(gallery_id),16,' ')            as "Gallery ID",
lpad(to_char('$'||sale_price), 16, ' ')          as "Sale Price",
  lpad(
  to_char(
  (sale_price /(artwork_minpayment +(artwork_minpayment *(gallery_sale_percent + 20) / 100)) - 1) * 100
  ,'999999.0')|| '%'
  ,16) AS "% Sold Above Min. Sell Price"

from (
select * from all_related_table_combine
) 
    
union all

select nvl(null, '------------------'),
 nvl(null, '------------------'), nvl(null, '----------------------'), nvl(null, '----------------'), lpad(nvl(null, 'AVERAGE:'),16,' '),
lpad(to_char(avg((sale_price /(artwork_minpayment +(artwork_minpayment *(gallery_sale_percent + 20) / 100)) - 1) * 100)
  ,'999999.0')|| '%'
  ,16) AS "% Sold Above Min. Sell Price"

from (
select * from all_related_table_combine

);
