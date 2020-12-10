--****PLEASE ENTER YOUR DETAILS BELOW****
--Q2-mau-queries.sql
--Student ID:
--Student Name:
--Tutorial No:

/* Comments for your marker:




*/
/*
As https://edstem.org/courses/4475/discussion/333039 mentioned, it is allowed to use any SQL features. 
That means I am allowed to use ( with .... as ....)clause to format for code. Such that I can format my code in a programmatic way
*/

/*
2(i) Query 1
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
 

SELECT
    artist_code as "Artist Code" ,
   nvl2(artist_gname, artist_gname || ' ', NULL)
    || 
     trim(both ' 'from artist_fname) as "Artist Name",
    CASE
    --who either live in VIC, NSW, WA
        WHEN artist_state = 'VIC'  THEN
            'Victoria'
        WHEN artist_state = 'NSW'  THEN
            'New South Wales'
        WHEN artist_state = 'WA'   THEN
            'Western Australia'
    END as "Artist State"
FROM 
    artist
WHERE
    --those who either dun have a given name 
    ( artist_gname IS NULL
    -- or a family name
      OR artist_fname IS NULL
    -- or a phone num
      OR artist_phone IS NULL )
    AND ( artist_state = 'VIC'
          OR artist_state = 'WA'
          OR artist_state = 'NSW' )
ORDER BY
    "Artist Name",
     "Artist Code";




/*
2(ii) Query 2
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

--未 sure 係< or <=120 days
WITH artwork_return_less_than_twice AS (
    SELECT
        aws_id
    FROM
             aw_status
        NATURAL JOIN (
            SELECT
                aws_id,
                COUNT(aws_action)
            FROM
                aw_status
            WHERE
                aws_action = 'R'
            GROUP BY
                aws_id
            HAVING
                COUNT(aws_action) < 2
        )
)

SELECT
    artist_code                             AS "Artist Code",
    artist_gname
    || ' '
    || artist_fname                          AS "Artist Name",
    artwork_no                              AS "Artwork No.",
    artwork_title                           AS "Artwork Title",
    artwork_minpayment                      AS "Artwork Min. Payment",
    ( artwork_submitdate - aws_date_time -1)  AS "Number of Days with MAU"
FROM
aw_status NATURAL join (SELECT * from artwork NATURAL JOIN artist )
    
WHERE
    aws_id in ( Select * from artwork_return_less_than_twice)
    AND ( artwork_submitdate - aws_date_time ) <= 120
ORDER BY 
    "Artist Code",  "Number of Days with MAU" DESC;

/*
2(iii) Query 3
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT
    artist_code,
    artwork_no,
    aw.artwork_title                                          AS artwork_title,
    gallery_id                                                AS gallery_id,
    g.gallery_name                                            AS gallery_name,
    to_char(aw_display_start_date, 'Dy')
    || to_char(aw_display_start_date, ' DD MONTH YYYY')       AS display_start_date,
    ( aw_display_end_date - aw_display_start_date )           AS number_of_days_in_gallery
FROM
         aw_display
    NATURAL JOIN gallery  g
    NATURAL JOIN artwork  aw
WHERE
        ( aw_display_end_date - aw_display_start_date ) < 13
    AND aw_display_start_date IS NOT NULL
ORDER BY
    number_of_days_in_gallery,
    gallery_id,
    display_start_date;



/*
2(iv) Query 4
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
SELECT
    artist_code           AS "Artist Code",
    artwork_no            AS "Artwork No.",
    artwork_title         AS "Artwork Title",
    COUNT(aws_action)     AS "Number of Movements"
FROM
         aw_status
    NATURAL JOIN artwork
where AWS_ACTION = 'T'
group by artwork_no,artwork_title,artist_code
having count(AWS_ACTION) < (select count(AWS_ACTION) / count(distinct artwork_no) from aw_status where AWS_ACTION = 'T')
order by "Number of Movements" ,"Artist Code",  "Artwork No."




/*
2(v) Query 5
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
--have not put the unsold condition





SELECT
    artist_code,
    artwork_title,
    to_char(artwork_minpayment +(artwork_minpayment *(gallery1commission + 0.2)) /(1 - gallery1commission - 0.2),
            '$999999999999')   AS "Min. Sale Price Est. (Gallery 1)",
    to_char(artwork_minpayment +(artwork_minpayment *(gallery2commission + 0.2)) /(1 - gallery2commission - 0.2),
            '$999999999999')   AS "Min. Sale Price Est. (Gallery 2)",
    to_char(artwork_minpayment +(artwork_minpayment *(gallery3commission + 0.2)) /(1 - gallery3commission - 0.2),
            '$999999999999')   AS "Min. Sale Price Est. (Gallery 3)",
    to_char(artwork_minpayment +(artwork_minpayment *(gallery4commission + 0.2)) /(1 - gallery4commission - 0.2),
            '$999999999999')   AS "Min. Sale Price Est. (Gallery 4)",
    to_char(artwork_minpayment +(artwork_minpayment *(gallery5commission + 0.2)) /(1 - gallery5commission - 0.2),
            '$999999999999')   AS "Min. Sale Price Est. (Gallery 5)"
FROM
    aw_display
    LEFT OUTER JOIN sale USING ( aw_display_id )
    RIGHT OUTER JOIN artwork USING ( artist_code, artwork_no )
    NATURAL JOIN ( SELECT    ( gallery_sale_percent ) / 100 AS gallery1commission FROM    gallery WHERE    gallery_id = 1   )   
    NATURAL JOIN ( SELECT    ( gallery_sale_percent ) / 100 AS gallery2commission FROM    gallery WHERE    gallery_id = 2   )    
    NATURAL JOIN ( SELECT    ( gallery_sale_percent ) / 100 AS gallery3commission FROM    gallery WHERE    gallery_id = 3   )    
    NATURAL JOIN ( SELECT    ( gallery_sale_percent ) / 100 AS gallery4commission FROM    gallery WHERE    gallery_id = 4   )     
    NATURAL JOIN ( SELECT    ( gallery_sale_percent ) / 100 AS gallery5commission FROM    gallery WHERE    gallery_id = 5   )
WHERE
    sale_id IS NULL
ORDER BY
    artist_code,
    artwork_title;


/*
2(vi) Query 6
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

--calculating things adn percentage

WITH all_related_table_combine AS (select * from sale NATURAL JOIN aw_display NATURAL JOIN artwork NATURAL JOIN gallery NATURAL JOIN artist)
select to_char(artist_code) as "Artist Code", 
to_char(ARTIST_GNAME || ' '|| ARTIST_FNAME) as "Artist Full Name", 
to_char(artwork_title) as "Artwork Title", 
lpad(to_char(gallery_id),16,' ') as "Gallery ID",
lpad(to_char(sale_price), 16, ' ') AS "Sale Price",
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
 nvl(null, '------------------'), nvl(null, '------------------'), nvl(null, '----------------'), lpad(nvl(null, 'AVERAGE:'),16,' '),
 lpad(to_char(round(avg("% Sold Above Min. Sell Price"),'99999.0')|| '%'),16,' ')
from ( 

select ARTIST_CODE as "Artist Code", ARTIST_GNAME || ' '|| ARTIST_FNAME as "Artist Full Name", artwork_title as "Artwork Title", gallery_id "Gallery ID",
SALE_PRICE as "Sale Price", 
round((SALE_PRICE - ARTWORK_MINPAYMENT) / ARTWORK_MINPAYMENT*100,1) as "% Sold Above Min. Sell Price"

from (
select * from all_related_table_combine
    )
);