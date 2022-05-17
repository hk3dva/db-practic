-- 1. Добавить внешние ключи
ALTER TABLE lesson
    ADD FOREIGN KEY (id_teacher) REFERENCES teacher (id_teacher);
ALTER TABLE lesson
    ADD FOREIGN KEY (id_subject) REFERENCES subject (id_subject);
ALTER TABLE lesson
    ADD FOREIGN KEY (id_group) REFERENCES `group` (id_group);
ALTER TABLE mark
    ADD FOREIGN KEY (id_lesson) REFERENCES lesson (id_lesson);
ALTER TABLE mark
    ADD FOREIGN KEY (id_student) REFERENCES student (id_student);
ALTER TABLE student
    ADD FOREIGN KEY (id_group) REFERENCES `group` (id_group);


-- 2. Выдать оценки студентов по информатике если они обучаются данному предмету
--       Оформить выдачу данных с использованием VIEW
CREATE VIEW student_grades AS
    SELECT
           student.name,
           m.mark
    FROM student
        JOIN (
            SELECT
                mark,
                id_student,
                id_lesson
            FROM mark
        ) m on student.id_student = m.id_student
        JOIN (
            SELECT
                id_subject,
                id_lesson
            FROM
                lesson
        ) l on m.id_lesson = l.id_lesson
        JOIN (
            SELECT
                name,
                id_subject
            FROM subject
            WHERE
                name = 'Информатика'
        ) s on l.id_subject = s.id_subject
    ORDER BY
        student.name;


-- 3. Дать информацию о должниках с указанием фамилии студента и названия предмета
--       Должниками считаются студенты, не имеющие оценки по предмету, который ведется в группе
--       Оформить в виде процедуры, на входе идентификатор группы
CREATE PROCEDURE debtors
(
    IN identify_group INT
)
BEGIN
    SELECT
        debsters.name AS debster,
        s.name AS lesson
    FROM `group`
        JOIN (
            SELECT
                id_group,
                id_subject
            FROM lesson
        ) l on `group`.id_group = l.id_group
        JOIN (
            SELECT
                id_subject,
                name
            FROM subject
        ) s on s.id_subject = l.id_subject
        RIGHT JOIN (
            SELECT
                student.name,
                g.id_group
            FROM student
                JOIN (
                    SELECT
                        id_group
                    FROM `group`
                ) g on g.id_group = student.id_group
                LEFT JOIN (
                    SELECT
                        id_student,
                        mark
                    FROM mark
                ) m on student.id_student = m.id_student
            WHERE
                m.mark IS NULL
        ) debsters ON debsters.id_group = `group`.id_group
    WHERE
        `group`.id_group = identify_group
    GROUP BY
        s.name, debsters.name
    ORDER BY debsters.name;
END

-- вызов процедуры
CALL debstors(1);


-- 4. Дать среднюю оценку студентов по каждому предмету для тех предметов,
--       по которым занимается не менее 35 студентов
SELECT
       s2.name,
       AVG(m.mark) AS average_rating
FROM lesson
    JOIN (
        SELECT
            id_lesson,
            id_student,
            mark
        FROM mark
    ) m on lesson.id_lesson = m.id_lesson
    JOIN (
        SELECT
            id_student
        FROM student
    ) s on m.id_student = s.id_student
    JOIN (
        SELECT
            id_subject,
            name
        FROM subject
    ) s2 on lesson.id_subject = s2.id_subject
GROUP BY
    s2.name
HAVING
    COUNT(s.id_student) >= 35;


-- 5. Дать оценки студентов специальности БИ по всем проводимым предметам
--       с указанием группы, фамилии, предмета, даты
--       При отсутствии оценки заполнить значениями NULL поля оценки
SELECT
       s.name,
       m.mark,
       s2.name AS lesson,
       l.date
FROM `group`
    JOIN (
        SELECT
            id_group,
            id_student,
            name
        FROM student
    ) s on `group`.id_group = s.id_group
    LEFT JOIN (
        SELECT
            id_student,
            id_lesson,
            mark
        FROM mark
    ) m on s.id_student = m.id_student
    LEFT JOIN (
        SELECT
            id_lesson,
            id_subject,
            date
        FROM lesson
    ) l on m.id_lesson = l.id_lesson
    LEFT JOIN (
        SELECT
            id_subject,
            name
        FROM subject
    ) s2 on l.id_subject = s2.id_subject
WHERE
    `group`.name = 'БИ';


-- 6. Всем студентам специальности ПС, получившим оценки меньшие 5 по предмету БД до 12.05
--       повысить эти оценки на 1 балл
UPDATE
    mark
    JOIN (
        SELECT
            id_lesson,
            id_group,
            date
        FROM lesson
        WHERE
            lesson.date = '2019-05-12'
    ) l on l.id_lesson = mark.id_lesson
    JOIN (
        SELECT
            id_group,
            name
        FROM `group`
        WHERE
            `group`.name = 'ПС'
    ) g on g.id_group = l.id_group
SET
    mark = mark + 1
WHERE
    mark < 5;


-- 7. Добавить необходимые индексы
CREATE INDEX idx_student$id_group ON student (id_group ASC);

CREATE INDEX idx_mark$id_student ON mark (id_student ASC);
CREATE INDEX idx_mark$id_lesson ON mark (id_lesson ASC);

CREATE INDEX idx_lesson$id_subject ON lesson (id_subject ASC);
CREATE INDEX idx_lesson$id_teacher ON lesson (id_teacher ASC);
CREATE INDEX idx_lesson$id_group ON lesson (id_group ASC);