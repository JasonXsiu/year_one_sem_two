/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*Q1a-mau-insert.sql*/
/*Student ID: 31509746*/
/*Student Name: Ke Duong*/
/*Tutorial No:*/

/* Comments for your marker:
the sections are the coloured cells in the task1a.xlsx --> use it as reference
1st section: yellow
2nd section: green
3rd section: red



*/


/*
1(a) Load selected tables with your own additional test data
*/


/*insert data into artwork table-----------------*/
/*format: at_code, aw_no, aw_title, aw_min, aw_subdate*/

/*1st section*/
INSERT INTO artwork VALUES (
    1,
    1,
    'Kangaroo Beauty',
    15000,
    TO_DATE('2/2/2019', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    20,
    1,
    'Wondering Number',
    34500,
    TO_DATE('3/3/2019', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    3,
    1,
    'Sleepless Night',
    75000,
    TO_DATE('4/4/2019', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    20,
    2,
    'Sleepy Night',
    123454,
    TO_DATE('5/5/2019', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    10,
    1,
    'Magic Difference',
    23000,
    TO_DATE('25/5/2019', 'dd/mm/yyyy')
);

/*2nd section*/
INSERT INTO artwork VALUES (
    9,
    1,
    'The Love I Want',
    90000,
    TO_DATE('30/8/2019', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    8,
    1,
    'Sleep and Sound',
    191919,
    TO_DATE('23/9/2019', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    19,
    1,
    'A New Beginning',
    23999,
    TO_DATE('6/10/2019', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    3,
    2,
    'Jokes are Over',
    25000,
    TO_DATE('7/10/2019', 'dd/mm/yyyy')
);

/*3rd section*/
INSERT INTO artwork VALUES (
    7,
    1,
    'Magical Evening',
    12300,
    TO_DATE('1/1/2020', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    19,
    2,
    'Peace and Chaos',
    10000,
    TO_DATE('14/2/2020', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    19,
    3,
    'The Peace I Need',
    25000,
    TO_DATE('28/2/2019', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    3,
    3,
    'The Beauty of Twenty',
    20000,
    TO_DATE('3/3/2019', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    2,
    1,
    'Just One Thing',
    232234,
    TO_DATE('14/3/2019', 'dd/mm/yyyy')
);

INSERT INTO artwork VALUES (
    4,
    1,
    'The Wooden Home',
    34790,
    TO_DATE('15/3/2019', 'dd/mm/yyyy')
);

/*insert data into aw_display table----------------*/
/*data format: aws_dis_id, at_code, aw_no, aw_dis_start_date, aw_dis_end_date, gallery id*/

/*1st section */
INSERT INTO aw_display VALUES (
    1,
    20,
    1,
    TO_DATE('30/5/2019', 'dd/mm/yyyy'),
    TO_DATE('15/6/2019', 'dd/mm/yyyy'),
    3
);

INSERT INTO aw_display VALUES (
    2,
    3,
    1,
    TO_DATE('30/5/2019', 'dd/mm/yyyy'),
    TO_DATE('15/6/2019', 'dd/mm/yyyy'),
    3
);

INSERT INTO aw_display VALUES (
    3,
    10,
    1,
    TO_DATE('30/5/2019', 'dd/mm/yyyy'),
    TO_DATE('15/6/2019', 'dd/mm/yyyy'),
    3
);

/*2nd section*/
INSERT INTO aw_display VALUES (
    4,
    9,
    1,
    TO_DATE('10/10/2019', 'dd/mm/yyyy'),
    TO_DATE('15/10/2019', 'dd/mm/yyyy'),
    2
);

INSERT INTO aw_display VALUES (
    5,
    8,
    1,
    TO_DATE('10/10/2019', 'dd/mm/yyyy'),
    TO_DATE('20/10/2019', 'dd/mm/yyyy'),
    2
);

INSERT INTO aw_display VALUES (
    6,
    19,
    1,
    TO_DATE('10/10/2019', 'dd/mm/yyyy'),
    TO_DATE('19/10/2019', 'dd/mm/yyyy'),
    2
);

INSERT INTO aw_display VALUES (
    7,
    3,
    2,
    TO_DATE('10/10/2019', 'dd/mm/yyyy'),
    TO_DATE('20/10/2019', 'dd/mm/yyyy'),
    2
);

/*3rd section*/
INSERT INTO aw_display VALUES (
    8,
    19,
    2,
    TO_DATE('10/3/2020', 'dd/mm/yyyy'),
    TO_DATE('15/3/2020', 'dd/mm/yyyy'),
    1
);

INSERT INTO aw_display VALUES (
    9,
    19,
    3,
    TO_DATE('10/3/2020', 'dd/mm/yyyy'),
    TO_DATE('20/3/2020', 'dd/mm/yyyy'),
    1
);

INSERT INTO aw_display VALUES (
    10,
    3,
    3,
    TO_DATE('10/3/2020', 'dd/mm/yyyy'),
    TO_DATE('19/3/2020', 'dd/mm/yyyy'),
    1
);

/*insert data into aw_status table-----------------*/
/*data format: aws_id, at_code, aw_no, aw_datetime, aws_action, gallery ID*/
/*1st section*/
/*w stage*/
INSERT INTO aw_status VALUES (
    1,
    1,
    1,
    TO_DATE('2/2/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    2,
    20,
    1,
    TO_DATE('3/3/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    3,
    3,
    1,
    TO_DATE('4/4/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    4,
    20,
    2,
    TO_DATE('5/5/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    5,
    10,
    1,
    TO_DATE('25/5/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

/*t stage*/
INSERT INTO aw_status VALUES (
    6,
    20,
    1,
    TO_DATE('27/5/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    3
);

INSERT INTO aw_status VALUES (
    7,
    3,
    1,
    TO_DATE('27/5/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    3
);

INSERT INTO aw_status VALUES (
    8,
    10,
    1,
    TO_DATE('27/5/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    3
);

/*g&s stage*/
INSERT INTO aw_status VALUES (
    9,
    20,
    1,
    TO_DATE('27/5/2019 11:00', 'dd/mm/yyyy hh24:mi'),
    'G',
    3
);

INSERT INTO aw_status VALUES (
    10,
    3,
    1,
    TO_DATE('27/5/2019 11:00', 'dd/mm/yyyy hh24:mi'),
    'G',
    3
);

INSERT INTO aw_status VALUES (
    11,
    10,
    1,
    TO_DATE('27/5/2019 11:00', 'dd/mm/yyyy hh24:mi'),
    'G',
    3
);

INSERT INTO aw_status VALUES (
    12,
    3,
    1,
    TO_DATE('10/6/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'S',
    NULL
);
/*t stage*/
INSERT INTO aw_status VALUES (
    13,
    20,
    1,
    TO_DATE('16/6/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    3
);

INSERT INTO aw_status VALUES (
    14,
    10,
    1,
    TO_DATE('16/6/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    3
);

/*w&r stage*/
INSERT INTO aw_status VALUES (
    15,
    20,
    1,
    TO_DATE('20/6/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    16,
    10,
    1,
    TO_DATE('20/6/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    17,
    1,
    1,
    TO_DATE('1/8/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'R',
    NULL
);

INSERT INTO aw_status VALUES (
    18,
    20,
    2,
    TO_DATE('1/8/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'R',
    NULL
);

/*2nd section*/
/*w stage*/
INSERT INTO aw_status VALUES (
    19,
    9,
    1,
    TO_DATE('30/8/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    20,
    8,
    1,
    TO_DATE('23/9/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    21,
    19,
    1,
    TO_DATE('6/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    22,
    3,
    2,
    TO_DATE('7/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

/*t stage*/
INSERT INTO aw_status VALUES (
    23,
    9,
    1,
    TO_DATE('8/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    2
);

INSERT INTO aw_status VALUES (
    24,
    8,
    1,
    TO_DATE('8/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    2
);

INSERT INTO aw_status VALUES (
    25,
    19,
    1,
    TO_DATE('8/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    2
);

INSERT INTO aw_status VALUES (
    26,
    3,
    2,
    TO_DATE('8/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    2
);

/*g&s stage*/
INSERT INTO aw_status VALUES (
    27,
    9,
    1,
    TO_DATE('9/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'G',
    2
);

INSERT INTO aw_status VALUES (
    28,
    8,
    1,
    TO_DATE('9/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'G',
    2
);

INSERT INTO aw_status VALUES (
    29,
    19,
    1,
    TO_DATE('9/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'G',
    2
);

INSERT INTO aw_status VALUES (
    30,
    3,
    2,
    TO_DATE('9/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'G',
    2
);

INSERT INTO aw_status VALUES (
    31,
    9,
    1,
    TO_DATE('15/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'S',
    NULL
);

INSERT INTO aw_status VALUES (
    32,
    19,
    1,
    TO_DATE('19/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'S',
    NULL
);

/*t stage*/
INSERT INTO aw_status VALUES (
    33,
    8,
    1,
    TO_DATE('21/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    2
);

INSERT INTO aw_status VALUES (
    34,
    3,
    2,
    TO_DATE('21/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    2
);

/*w&r stage*/
INSERT INTO aw_status VALUES (
    35,
    8,
    1,
    TO_DATE('23/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    2
);

INSERT INTO aw_status VALUES (
    36,
    3,
    2,
    TO_DATE('23/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    2
);

INSERT INTO aw_status VALUES (
    37,
    3,
    2,
    TO_DATE('25/10/2019 9:00', 'dd/mm/yyyy hh24:mi'),
    'R',
    NULL
);

/*3rd section*/
/*w stage*/
INSERT INTO aw_status VALUES (
    38,
    7,
    1,
    TO_DATE('1/1/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    39,
    19,
    2,
    TO_DATE('14/2/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    40,
    19,
    3,
    TO_DATE('28/2/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    41,
    3,
    3,
    TO_DATE('3/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

/*t stage*/
INSERT INTO aw_status VALUES (
    42,
    19,
    2,
    TO_DATE('7/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    1
);

INSERT INTO aw_status VALUES (
    43,
    19,
    3,
    TO_DATE('7/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    1
);

INSERT INTO aw_status VALUES (
    44,
    3,
    3,
    TO_DATE('7/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    1
);

/*g&s stage & new arts coming in(w)*/
INSERT INTO aw_status VALUES (
    45,
    19,
    2,
    TO_DATE('8/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'G',
    1
);

INSERT INTO aw_status VALUES (
    46,
    19,
    3,
    TO_DATE('8/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'G',
    1
);

INSERT INTO aw_status VALUES (
    47,
    3,
    3,
    TO_DATE('8/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'G',
    1
);

INSERT INTO aw_status VALUES (
    48,
    2,
    1,
    TO_DATE('14/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    49,
    19,
    2,
    TO_DATE('15/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'S',
    NULL
);

INSERT INTO aw_status VALUES (
    50,
    4,
    1,
    TO_DATE('15/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    51,
    3,
    3,
    TO_DATE('19/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'S',
    NULL
);

/*t stage*/
INSERT INTO aw_status VALUES (
    52,
    19,
    3,
    TO_DATE('21/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'T',
    1
);

/*w&r stage*/
INSERT INTO aw_status VALUES (
    53,
    19,
    3,
    TO_DATE('22/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'W',
    NULL
);

INSERT INTO aw_status VALUES (
    54,
    19,
    3,
    TO_DATE('25/3/2020 9:00', 'dd/mm/yyyy hh24:mi'),
    'R',
    NULL
);

/*insert data into sale table----------------------*/
/*data format: sale_id, sale_date, sale_price, custoemr_id, aw_dis_id*/
INSERT INTO sale VALUES (
    1,
    TO_DATE('10/6/2019', 'dd/mm/yyyy'),
    100000,
    1,
    2
);

INSERT INTO sale VALUES (
    2,
    TO_DATE('15/10/2019', 'dd/mm/yyyy'),
    150000,
    4,
    4
);

INSERT INTO sale VALUES (
    3,
    TO_DATE('19/10/2019', 'dd/mm/yyyy'),
    50000,
    2,
    6
);

INSERT INTO sale VALUES (
    4,
    TO_DATE('15/3/2020', 'dd/mm/yyyy'),
    50000,
    3,
    8
);

INSERT INTO sale VALUES (
    5,
    TO_DATE('19/3/2020', 'dd/mm/yyyy'),
    35000,
    7,
    10
);

COMMIT;