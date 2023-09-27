

CREATE TABLE hotel (
    id SERIAL,
    name TEXT NOT NULL,
   	location TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE rooms (
    room_number INT NOT NULL,
    price INT NOT NULL,
    room_type TEXT NOT NULL,
    PRIMARY KEY(room_number)
);

CREATE TABLE guest (
    guest_ID INT NOT NULL,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    PRIMARY KEY(guest_ID)
);

CREATE TABLE reservation (
    reservation_ID INT NOT NULL,
    checkin INT NOT NULL,
    checkout INT NOT NULL,
    PRIMARY KEY(reservation_ID)
);

CREATE TABLE payment (
   	payment_ID INT NOT NULL,
    payment_method TEXT NOT NULL,
    amount INT NOT NULL,
    PRIMARY KEY(payment_ID)
);


ALTER TABLE hotel
ADD CONSTRAINT fk_hotel_rooms
FOREIGN KEY (id) 
REFERENCES rooms (room_number);

ALTER TABLE rooms
ADD CONSTRAINT fk_rooms_guest
FOREIGN KEY (room_number) 
REFERENCES guest (guest_ID);

ALTER TABLE guest
ADD CONSTRAINT fk_guest_payment
FOREIGN KEY (guest_ID) 
REFERENCES payment (payment_ID);