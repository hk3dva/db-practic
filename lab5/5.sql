-- 1. Добавить внешние ключи
ALTER TABLE booking ADD FOREIGN KEY (id_client) REFERENCES client (id_client);
ALTER TABLE room ADD FOREIGN KEY (id_hotel) REFERENCES hotel (id_hotel);
ALTER TABLE room ADD FOREIGN KEY (id_room_category) REFERENCES room_category (id_room_category);
ALTER TABLE room_in_booking ADD FOREIGN KEY (id_booking) REFERENCES booking (id_booking);
ALTER TABLE room_in_booking ADD FOREIGN KEY (id_room) REFERENCES room (id_room);


-- 2. Выдать информацию о клиентах гостиницы “Космос”,
--      проживающих в номерах категории “Люкс” на 1 апреля 2019г
SELECT
    client.name AS name,
    client.phone,
    hotel.name AS hotel,
    room_category.name,
    checkout_date,
       checkin_date
FROM hotel.client
    LEFT JOIN booking ON client.id_client = booking.id_client
    LEFT JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking
    LEFT JOIN room ON room_in_booking.id_room = room.id_room
    LEFT JOIN room_category ON room.id_room_category = room_category.id_room_category
    LEFT JOIN hotel ON room.id_hotel = hotel.id_hotel
WHERE
    hotel.name = 'Космос' AND
    room_category.name = 'Люкс' AND
    checkin_date <= '2019-04-01' AND
    checkout_date > '2019-04-01';


-- 3. Дать список свободных номеров всех гостиниц на 22 апреля
SELECT
    hotel.name AS hotel_name,
    number,
    price
FROM room
    LEFT JOIN (
        SELECT
               room.id_room,
               room_in_booking.checkin_date,
               room_in_booking.checkout_date
        FROM room
            LEFT JOIN room_in_booking ON room.id_room = room_in_booking.id_room
        WHERE
            checkin_date <= '2019-04-22' AND
            checkout_date > '2019-04-22'
        ) AS occupied_rooms ON room.id_room = occupied_rooms.id_room
    LEFT JOIN hotel ON room.id_hotel = hotel.id_hotel
WHERE
    occupied_rooms.checkout_date IS NULL AND
    occupied_rooms.checkin_date IS NULL
ORDER BY
    hotel.name,
    room.number;


-- 4. Дать количество проживающих клиентов в гостинице "Космос"
--      на 23 марта по каждой категории номеров
SELECT
    room_category.name AS category_name,
    COUNT(room_in_booking.id_room_in_booking) AS quantity
FROM room_category
    LEFT JOIN room ON room_category.id_room_category = room.id_room_category
    LEFT JOIN room_in_booking ON room.id_room = room_in_booking.id_room
    LEFT JOIN hotel ON hotel.id_hotel = room.id_hotel
WHERE
    checkout_date > '2019-03-21' AND
    checkin_date <= '2019-03-21' AND
    hotel.name = 'Космос'
GROUP BY
    room_category.name;


-- 5. Дать список последних проживающих клиентов по всем комнатам гостиницы "Космос"
--      выехавшим в апреле с указанием даты выезда
SELECT
    room.number AS number_room,
    client.name,
    client.phone,
    MAX(room_in_booking.checkout_date) AS checkout_date
FROM room_category
    LEFT JOIN room ON room_category.id_room_category = room.id_room_category
    LEFT JOIN room_in_booking ON room.id_room = room_in_booking.id_room
    LEFT JOIN hotel ON hotel.id_hotel = room.id_hotel
    LEFT JOIN booking ON room_in_booking.id_booking = booking.id_booking
    LEFT JOIN hotel.client ON booking.id_client = client.id_client
WHERE
    hotel.name = 'Космос'
GROUP BY
    room.number
ORDER BY
    room.number;


-- 6. Продлить на 2 дня дату проживания клиентов в гостиницу "Космос" всем клиентам
--      комнат категории "Бизнес", которые заселились 10 мая
UPDATE
    room_in_booking
    LEFT JOIN room ON room_in_booking.id_room = room.id_room
    LEFT JOIN hotel ON room.id_hotel = hotel.id_hotel
    LEFT JOIN room_category ON room.id_room_category = room_category.id_room_category
SET
    checkout_date = DATE_ADD(checkout_date, INTERVAL 2 DAY)
WHERE
    hotel.name = 'Космос' AND
    room_category.name = 'Бизнес' AND
    room_in_booking.checkin_date = '2019-05-10';


-- 7. Найти все "пересекающиеся" варианты проживания.
SELECT * FROM room_in_booking AS table_1
    INNER JOIN room_in_booking AS table_2 on table_1.id_room = table_2.id_room
WHERE
    table_1.checkin_date  <= table_2.checkin_date AND
    table_1.checkout_date >= table_2.checkout_date  AND
    table_1.id_room_in_booking != table_2.id_room_in_booking;


-- 8. Создать бронирование в транзакции
START TRANSACTION;
    INSERT INTO booking (id_client, booking_date)
        VALUES (25, NOW());
    INSERT INTO room_in_booking (id_booking, id_room, checkin_date, checkout_date)
        VALUES((SELECT id_booking FROM booking ORDER BY id_booking DESC LIMIT 1), 46, '2022-04-01', '2022-05-31');
COMMIT;


-- 9. Добавить необходимые индексы для всех таблиц
CREATE INDEX name_idx ON client (name ASC);
CREATE INDEX name_idx ON hotel (name ASC);
CREATE INDEX name_idx ON room_category (name ASC);
CREATE INDEX check_in_out_idx ON  room_in_booking (checkin_date ASC, checkout_date ASC);