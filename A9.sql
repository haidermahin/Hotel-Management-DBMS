/*-------------------------PAYMENT TABLES---------------------------------------- */

create table card_info(
    card_no int not null,
    exp_date timestamp,
    Primary key(card_no)
);

create table bill_address(
    b_add_ID int not null,
    street_number int, 
    street_name varchar(50),
    city varchar(50), 
    province varchar(50), 
    country varchar(50), 
    postal_code varchar(7),
    Primary key(b_add_ID)
);

create table payment(
    payment_ID int not null, 
    card_no int not null,
    first_name varchar(50), 
    last_name varchar(50), 
    b_add_ID int not null,
    Primary key (payment_ID),
    Foreign key (b_add_ID) references bill_address(b_add_ID),
    Foreign key (card_no) references card_info(card_no)
);
    
create table invoice(
    payment_ID int not null,
    customer_ID int not null,
    primary key (payment_ID,customer_ID)
);


/*  -----------------------CUSTOMER TABLES----------------------------------------------- */

create table address_info (
    add_ID int not null,
    street_number int, 
    street_name varchar(50), 
    city varchar(50), 
    province varchar(50), 
    country varchar(50), 
    postal_code varchar(7), 
    primary key (add_ID)
);

create table customer (
    customer_ID int not null, 
    first_name varchar(50), 
    last_name varchar(50), 
    phone_number varchar(50),
    email varchar(70),
    driver_license varchar(16),
    add_ID int not null,
    Primary key (customer_ID),
    Foreign key (add_ID) references address_info(add_ID)
); 

/*  ----------------------------RESERVATION TABLES-------------------------------------------------- */


create table reservation (
    reservation_ID int not null, 
    check_in timestamp, 
    check_out timestamp, 
    children int,
    adults int,
    Primary key (reservation_ID)
); 

CREATE table books(
    customer_ID int not null,
    reservation_ID int not null,
    Foreign key (customer_ID) references customer(customer_ID) ,
    Foreign key (reservation_ID) references reservation(reservation_ID) 
);

/*  --------------------------------PARKING--------------------------------------------- */

create table car_info(
    customer_ID int not null, 
    license_plate varchar(8),
    primary key (customer_ID)
);


CREATE TABLE parking(
    customer_ID int not null, 
    parking_ID int not null,
    parking_lvl int,
    parking_avail char(1) not null,
    Primary key (parking_ID),
    Foreign key (customer_ID) references customer(customer_ID),
    Foreign key (customer_ID) references car_info(customer_ID)
);


/*  --------------------------------------------------------------------------------------- */


/* bit:  True = 1 False = 0*/
CREATE TABLE room (
    room_ID int not null,
    reservation_ID int not null, 
    room_service varchar(50),
    tv char(1),
    room_view varchar(100),
    fridge char(1),
    room_cap int not null,
    Primary key (room_ID),
    Foreign key (reservation_ID) references reservation(reservation_ID) 
);


CREATE table has( 
    room_ID int not null ,
    reservation_ID int not null,
    Foreign key (room_ID) references room(room_ID),
    Foreign key (reservation_ID) references reservation(reservation_ID )  
);


create table room_type_detail(
    r_t_ID int not null,
    room_type_name varchar (50) DEFAULT 'Deluxe',
    smoking char(1),
    primary key (r_t_ID)
);


CREATE TABLE room_type ( 
    room_ID int not null,
    room_type_ID int,
    r_t_ID int not null,
    Primary key (room_ID, room_type_ID),
    Foreign key (room_ID) references room(room_ID) ,
    Foreign key (r_t_ID) references room_type_detail(r_t_ID)
);


CREATE TABLE room_status(
    room_ID int not null,
    room_status_ID int,
    room_avail char(1) not null,
    Primary key (room_ID, room_status_ID),
    Foreign key (room_ID) references room(room_ID) 
);

CREATE TABLE room_price(
    room_ID int not null,
    room_type_ID int,
    price int,
    Primary key (room_ID, room_type_ID),
    Foreign key (room_ID) references room(room_ID) 
);


/* =========================INSERT VALUES================================================*/

/* Address_info:
add_ID ,street_number, street_name , city, province, country , postal_code,
*/

/* Customer:
customer_ID , first_name, last_name, phone_number , email ,driver_license , add_ID
*/

INSERT INTO address_info VALUES (
1,123,'Jane St','Toronto','Ontario','Canada','M5B1B0');
INSERT INTO customer VALUES (
00001, 'John','Smith','416-979-5000','johnsmith@gmail.com','U51463711809374', 1);


INSERT INTO address_info VALUES (2,456,'Keele St West','Toronto','Ontario','Canada','M2N1B6');
INSERT INTO customer VALUES (
00002, 'Jenny','Long','416-679-4000','jenny@gmail.com','JL1463711809374',2);

INSERT INTO address_info VALUES (
3,1000,'Burnaby','Vancouver','British Columbia','Canada','M7K1B3');
INSERT INTO customer VALUES (
00003, 'Jeffrey','Star','416-222-1000','jstar@gmail.com','809374JS',3);


INSERT INTO address_info VALUES (
4,100,'Pineapple Bottom','Etobicoke','Ontario','Canada','M0J9B3');
INSERT INTO customer VALUES (
00004, 'Spongebob','Squarepant','416-100-1234','spongebob@gmail.com','SB1234',4);

INSERT INTO address_info VALUES (
5,90,'Hollywood','Markham','Ontario','Canada','M9K9C3');
INSERT INTO customer VALUES (
00005, 'Arianna','Grande','416-900-6789','ag@gmail.com','ag1234',5);

/*------------------------------------------------------------------------------------------------------------- */
/* reservation_id, check_in,check_out,adults,children*/

INSERT INTO reservation VALUES(
001,'2021-09-12 14:00','2021-09-16 12:00',1,2);

INSERT INTO reservation VALUES(
002,'2021-10-05 10:00','2021-10-10 12:00',2,0);

INSERT INTO reservation VALUES(
003,'2021-12-12 19:00','2021-12-26 13:00',3,1);

INSERT INTO reservation VALUES(
004,'2021-10-11 12:00','2021-12-06 13:00',2,6);

INSERT INTO reservation VALUES(
005,'2022-01-01 12:00','2022-01-10 12:00',2,0);


/*------------------------------------------------------------------------------------------------------------- */

/* 
card info:
card_no, exp_date

bill address:
b_add_ID,street_number,street_name, city,province,country,postal_code 

payment:
payment_id,card_no, first_name,last_name,b_add_ID

invoice:
payment_ID, customer_ID
*/


INSERT INTO card_info VALUES( 50030012, '2021-01-01');
INSERT INTO bill_address VALUES(1, 123,'Jane St','Toronto','Ontario','Canada','M5B1B0');
INSERT INTO payment VALUES (00001,50030012, 'John','Smith',1);
INSERT INTO invoice VALUES (1,1);

INSERT INTO card_info VALUES( 123456,'2022-06-01');
INSERT INTO bill_address VALUES(2, 123,'Jane St','Toronto','Ontario','Canada','M5B1B0');
INSERT INTO payment VALUES(00002,123456, 'Jenny','Long',2);
INSERT INTO invoice VALUES (2,2);

INSERT INTO card_info VALUES( 10000023,'2030-01-01');
INSERT INTO bill_address VALUES(3, 123,'Jstar','Casper','Wyoming','USA','M5B1B0');
INSERT INTO payment VALUES(00003,10000023, 'Jeffrey','Star',3);
INSERT INTO invoice VALUES (3,3);

INSERT INTO card_info VALUES(1000003,'2001-01-09');
INSERT INTO bill_address VALUES(4, 1,'Rock','Toronto','Ontario','Canada','M0B1J0');
INSERT INTO payment VALUES(00004,1000003, 'Patrick','Star',4); 
INSERT INTO invoice VALUES (4,4);
-- patrick pays for spongebob


INSERT INTO card_info VALUES( 98765,'2023-01-09');
INSERT INTO bill_address VALUES(5,90,'Hollywood','Markham','Ontario','Canada','M9K9C3');
INSERT INTO payment VALUES(00005,98765, 'Arianna','Grande',5); 
INSERT INTO invoice VALUES (5,5);


/*------------------------------------------------------------------------------------------------------------- */
/* 
car info:
customer_ID, license_plate

Parking:
customer_id, parking_id, parking_lvl, parking_avail
*/

--parking for John Smith
INSERT INTO car_info VALUES(00001,'ARTV434');
INSERT INTO parking VALUES(00001,1,2,1);

-- Jeffrey star parking
INSERT INTO car_info VALUES(00003,'STAR101');
INSERT INTO parking VALUES(00003,2,3,1);

/*------------------------------------------------------------------------------------------------------------- */
/* MUST DO RESERVATION FIRST */
/* room: room_id, reservation_id, room_service,tv, room_view, fridge, room_cap*/

INSERT INTO room VALUES(
    101,00001,'None',0,'Falls',1,4
);

INSERT INTO room VALUES(
    102,00002,'None',1,'City',1,2
);

INSERT INTO room VALUES(
    103,00003,'Star Package',1,'Falls',1,6
);

INSERT INTO room VALUES(
    400,00004,'All you can eat Buffet',0,'City',1,2
);

INSERT INTO room VALUES(
    500,00005,'Star Package',0,'Falls',1,2
); -- arianna Special couple package

/*------------------------------------------------------------------------------------------------------------- */

/* has: ROOM_ID reservation_id */
INSERT INTO has VALUES(101,001);

INSERT INTO has VALUES(102,002);

INSERT INTO has VALUES(103,003);

INSERT INTO has VALUES(400,004);

INSERT INTO has VALUES(500,005);

/*------------------------------------------------------------------------------------------------------------- */
/* Room type:
room_id,room_type_id,r_t_ID 

room type detail:
r_t_ID,room_type_name,smoking*/

--john 
INSERT INTO room_type VALUES(101,1,1);
INSERT INTO room_type_detail VALUES (1,'Suite',0);

--jenny 
INSERT INTO room_type VALUES(102,2,2);
INSERT INTO room_type_detail VALUES (2,'Suite',0);

--jeffree 
INSERT INTO room_type VALUES(103,3,3);
INSERT INTO room_type_detail VALUES (3,'Presidential Suite',0);

--Spongebob
INSERT INTO room_type VALUES(400,4,4);
INSERT INTO room_type_detail VALUES (4,'Single',1);

--Arianna grande
INSERT INTO room_type VALUES(500,5,5);
INSERT INTO room_type_detail VALUES (5,'Penthouse Suite',1);




/*------------------------------------------------------------------------------------------------------------- */
/*  Room status: 
room_id, room_status_id, room_avail */

INSERT INTO room_status VALUES(101,1,1); -- John

INSERT INTO room_status VALUES(102,1,1); -- Jenny

INSERT INTO room_status VALUES(103,1,1); --jeffrey

INSERT INTO room_status VALUES(400,1,1); --spongebob

INSERT INTO room_status VALUES(500,1,0); --arianna grande


/*------------------------------------------------------------------------------------------------------------- */
/* room price:
room_id ,room_type_id,price */

INSERT INTO room_price VALUES(101,1,300);--john

INSERT INTO room_price VALUES(102,2,100); --jenny

INSERT INTO room_price VALUES(103,3, 1000); -- jeffrey

INSERT INTO room_price VALUES(400,4, 90); -- spongebob

INSERT INTO room_price VALUES(500,5, 1500); -- arianna grande

/*------------------------------------------------------------------------------------------------------------- */
/* Books: 
customer_id reservation_id */
INSERT INTO books VALUES(00001,001);--john

INSERT INTO books VALUES(00002,002); --jenny 

INSERT INTO books VALUES(00003,003); --jeffrey

INSERT INTO books VALUES(00004,004); --spongebob 

INSERT INTO books VALUES(00005,005); --arianna grande



/* =================================================select statements ========================================== */
SELECT * FROM reservation;


SELECT * FROM payment;
SELECT * FROM invoice;
SELECT * FROM card_info;
SELECT * FROM bill_address;


SELECT * FROM parking;
SELECT * FROM car_info; 

SELECT * FROM customer;
SELECT * FROM address_info;

SELECT * FROM has;
SELECT * FROM books;

SELECT * FROM room;
SELECT * FROM room_price;
SELECT * FROM room_status;
SELECT * FROM room_type;
SELECT * FROM room_type_detail

