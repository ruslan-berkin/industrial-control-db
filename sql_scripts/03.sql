-- =========================================================
-- ЭТАП 1: DDL И DML ДЛЯ БАЗЫ ДАННЫХ UNIVERSITY_DB
-- =========================================================
DROP DATABASE IF EXISTS university_db;
CREATE DATABASE university_db;
USE university_db;

-- Таблица университетов
CREATE TABLE university (
    UNIV_ID INT PRIMARY KEY,
    UNIV_NAME VARCHAR(50),
    RATING INT,
    CITY VARCHAR(50)
);

-- Таблица студентов
CREATE TABLE student (
    STUDENT_ID INT PRIMARY KEY,
    SURNAME VARCHAR(50),
    NAME VARCHAR(50),
    STIPEND DECIMAL(8,2),
    CITY VARCHAR(50),
    university_UNIV_ID INT,
    FOREIGN KEY (university_UNIV_ID) REFERENCES university(UNIV_ID)
);

-- Таблица предметов
CREATE TABLE subjects (
    SUBJ_ID INT PRIMARY KEY,
    SUBJ_NAME VARCHAR(50)
);

-- Таблица оценок
CREATE TABLE exam_marks (
    MARK_ID INT AUTO_INCREMENT PRIMARY KEY,
    MARK INT,
    student_STUDENT_ID INT,
    subjects_SUBJ_ID INT,
    FOREIGN KEY (student_STUDENT_ID) REFERENCES student(STUDENT_ID),
    FOREIGN KEY (subjects_SUBJ_ID) REFERENCES subjects(SUBJ_ID)
);

-- Наполнение тестовыми данными 
INSERT INTO university VALUES 
(1, 'ВГУ', 600, 'Воронеж'),
(2, 'ВГТУ', 550, 'Воронеж'),
(3, 'МГУ', 800, 'Москва');

INSERT INTO student VALUES 
(1, 'Иванов', 'Иван', 1500.00, 'Воронеж', 1),
(2, 'Петров', 'Петр', 2000.00, 'Москва', 3),
(3, 'Сидоров', 'Олег', 1500.00, 'Воронеж', 1),
(4, 'Баранова', 'Анна', 2500.00, 'Новосибирск', 2),
(5, 'Зайцев', 'Илья', 1200.00, 'Курск', NULL),
(6, 'Абрамова', 'Елена', 1800.00, 'Воронеж', 1),
(7, 'Кузнецов', 'Алексей', 2000.00, 'Москва', 3);

INSERT INTO subjects VALUES 
(101, 'Математика'), (102, 'Физика'), (103, 'Информатика'), (105, 'История');

INSERT INTO exam_marks (MARK, student_STUDENT_ID, subjects_SUBJ_ID) VALUES 
(5, 1, 101), (4, 1, 102), (5, 2, 103), (3, 3, 101),
(4, 4, 101), (5, 4, 102), (3, 6, 105);

-- =========================================================
-- ЭТАП 2: ЗАПРОСЫ ИЗ ЛАБ №3 (ГРУППИРОВКА И АГРЕГАЦИЯ)
-- =========================================================

-- 1. Подсчет общего количества студентов
SELECT COUNT(*) AS total_students FROM student;

-- 2. Подсчет количества оценок по каждому предмету
SELECT subjects_SUBJ_ID, COUNT(*) AS mark_count 
FROM exam_marks GROUP BY subjects_SUBJ_ID;

-- 3. Вычисление среднего балла по предметам
SELECT subjects_SUBJ_ID, AVG(MARK) AS average_mark 
FROM exam_marks GROUP BY subjects_SUBJ_ID;

-- 4. Поиск максимального балла среди всех экзаменов
SELECT MAX(MARK) AS max_mark FROM exam_marks;

-- 5. Подсчет студентов, чья фамилия удовлетворяет шаблону
SELECT COUNT(*) FROM student WHERE SURNAME LIKE '%а%а';

-- 6. Вывод студентов и ID предметов, которые они сдавали
SELECT s.SURNAME, em.subjects_SUBJ_ID 
FROM student s 
JOIN exam_marks em ON s.STUDENT_ID = em.student_STUDENT_ID;

-- 7. LEFT JOIN: Студенты и рейтинг их университета (включая тех, кто без университета)
SELECT s.SURNAME, u.RATING 
FROM student s 
LEFT JOIN university u ON s.university_UNIV_ID = u.UNIV_ID 
ORDER BY s.SURNAME;

-- 8. Многотабличный JOIN: Хорошисты и отличники с названиями предметов
SELECT s.SURNAME, sub.SUBJ_NAME, em.MARK 
FROM exam_marks em 
JOIN student s ON em.student_STUDENT_ID = s.STUDENT_ID 
JOIN subjects sub ON em.subjects_SUBJ_ID = sub.SUBJ_ID 
WHERE em.MARK IN (4, 5);

-- 9. Декартово произведение: Уникальные пары студентов из одного города
SELECT s1.SURNAME AS Student1, s2.SURNAME AS Student2, s1.CITY 
FROM student s1, student s2 
WHERE s1.CITY = s2.CITY AND s1.STUDENT_ID < s2.STUDENT_ID;