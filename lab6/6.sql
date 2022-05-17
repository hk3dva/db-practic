-- 1. Добавить внешние ключи
ALTER TABLE dealer
    ADD FOREIGN KEY (id_company) REFERENCES company (id_company);
ALTER TABLE `order`
    ADD FOREIGN KEY (id_production) REFERENCES production (id_production);
ALTER TABLE `order`
    ADD FOREIGN KEY (id_dealer) REFERENCES dealer (id_dealer);
ALTER TABLE `order`
    ADD FOREIGN KEY (id_pharmacy) REFERENCES pharmacy (id_pharmacy);
ALTER TABLE production
    ADD FOREIGN KEY (id_company) REFERENCES company (id_company);
ALTER TABLE production
    ADD FOREIGN KEY (id_medicine) REFERENCES medicine (id_medicine);

-- 2. Выдать информацию по всем заказам лекарств "Кордеон" компании "Аргус"
--       с указанием названий аптек, дат, объема заказов
SELECT
       (SELECT name FROM pharmacy WHERE `order`.id_pharmacy = pharmacy.id_pharmacy),
       c.name,
       m.name,
       date,
       quantity
FROM `order`
    JOIN (
        SELECT id_production,
               id_medicine,
               id_company
        FROM production
    ) p ON `order`.id_production = p.id_production
    JOIN (
        SELECT
            name,
            id_company
        FROM company
        WHERE
            company.name = 'Аргус'
    ) c ON c.id_company = p.id_company
    JOIN (
        SELECT
            name,
            id_medicine
        FROM medicine
        WHERE
            medicine.name = 'Кордеон'
    ) m ON p.id_medicine = m.id_medicine;


-- 3. Дать список лекарств компании "Фарма", на которые не были сделаны заказы до 25 января
SELECT
    m.name
FROM
     production
    JOIN (
        SELECT
            name,
            id_medicine
        FROM medicine
    ) m ON production.id_medicine = m.id_medicine
    JOIN (
        SELECT
            name,
            id_company
        FROM company
        WHERE
            company.name = 'Фарма'
    ) c ON production.id_company = c.id_company
    JOIN (
        SELECT
            id_production
        FROM `order`
        WHERE
            date > '2019-01-25' OR date IS NULL
    ) o ON production.id_production = o.id_production
GROUP BY
    m.name;

-- 4. Дать минимальный и максимальный баллы лекарств каждой фирмы, которая оформила не менее 120 заказов
--==============================
-- Запрос начинался с order
--==============================
SELECT
       name,
       MAX(p.rating) AS max_score,
       MIN(p.rating) AS min_score
FROM
    company
    JOIN (
        SELECT id_production,
               id_company,
               rating
        FROM production
    )  p ON company.id_company = p.id_company
    JOIN (
        SELECT
            id_production
        FROM
            `order`
    ) o ON o.id_production = p.id_production
GROUP BY
    name
HAVING
    COUNT(*) >= 120;


-- 5. Дать списки сделавших заказы аптек по всем дилерам компании компании "AstraZeneca"
--       Если у дилера нет заказов, в названии аптеки проставить NULL
SELECT
       dealer.name,
       dealer.phone,
       o.name
FROM dealer
    LEFT JOIN (
        SELECT
               id_order,
               id_dealer,
               date,
               quantity,
               p.name
        FROM `order`
        JOIN (
            SELECT
                name,
                id_pharmacy
            FROM pharmacy
        ) p on `order`.id_pharmacy = p.id_pharmacy
    ) o on dealer.id_dealer = o.id_dealer
    JOIN (
        SELECT
            id_company,
            name
        FROM company
        WHERE
            company.name = 'AstraZeneca'
    ) c on dealer.id_company = c.id_company;


-- 6. Уменьшить на 20% стоимость всех лекарств, если она превышает 3000,
--       а длительность лечения не более 7 дней
UPDATE
    production
    JOIN (
        SELECT
               id_medicine,
               cure_duration
        FROM medicine
        WHERE
            medicine.cure_duration <= 7
    ) m on production.id_medicine = m.id_medicine
SET
    price = price * 0.8
WHERE
    price > 3000;


-- 7. Добавить необходимые индексы
CREATE INDEX idx_order$id_production ON `order` (id_production ASC);
CREATE INDEX idx_order$id_pharmacy ON `order` (id_pharmacy ASC);
CREATE INDEX idx_order$id_dealer ON `order` (id_dealer ASC);

CREATE INDEX idx_production$id_medicine ON production (id_medicine ASC);
CREATE INDEX idx_production$id_company ON production (id_company ASC);

CREATE INDEX idx_dealer$id_company ON dealer (id_company ASC);