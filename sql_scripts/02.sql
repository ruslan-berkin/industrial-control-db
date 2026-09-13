-- =========================================================
-- ЭТАП 1: DDL И DML ДЛЯ БАЗЫ ДАННЫХ LAB2
-- =========================================================
DROP DATABASE IF EXISTS lab2;
CREATE DATABASE lab2;
USE lab2;

-- Создание таблицы студентов
CREATE TABLE Student (
    idStudent INT AUTO_INCREMENT PRIMARY KEY,
    Surname VARCHAR(45) NOT NULL,
    Name VARCHAR(20),
    Address VARCHAR(100),
    Tel VARCHAR(11)
);

-- Создание таблицы оценок
CREATE TABLE Marks (
    idMarks INT AUTO_INCREMENT PRIMARY KEY,
    Subject VARCHAR(45) NOT NULL,
    Date_mark DATE,
    Mark TINYINT,
    Student_idStudent INT,
    FOREIGN KEY (Student_idStudent) REFERENCES Student(idStudent)
);

-- Наполнение тестовыми данными 
INSERT INTO Student (Surname, Name, Address, Tel) VALUES
('Иванов', 'Алексей', 'ул. Абая, д.78, кв.12', '87025557722'),
('Петров', 'Олег', 'проспект Мира, д.10', NULL),
('Сидоров', 'Александр', 'ул. Ленина, д.78', '87071234567'),
('Абрамова', 'Анна', 'ул. Пушкина, д.5', '87052223344');

INSERT INTO Marks (Subject, Date_mark, Mark, Student_idStudent) VALUES
('Математика', '2025-01-15', 2, 1),
('Математика', '2025-01-20', 4, 3),
('Физика', '2025-01-18', 5, 2),
('Математика', '2025-01-22', 3, 4);

-- =========================================================
-- ЭТАП 2: ВЫПОЛНЕНИЕ ЗАПРОСОВ ИЗ ЛАБ №2
-- =========================================================

-- 1. Вывод всей информации из таблицы студентов
SELECT * FROM Student;

-- 2. Вывод только фамилии и телефона
SELECT Surname, Tel FROM Student;

-- 3. Поиск студентов без указанного телефона 
SELECT * FROM Student WHERE Tel IS NULL;

-- 4. Объединение таблиц: Студент - Предмет - Оценка
SELECT s.Surname, m.Subject, m.Mark 
FROM Student s 
JOIN Marks m ON s.idStudent = m.Student_idStudent;

-- 5. Поиск студентов, получивших двойку по математике
SELECT s.* FROM Student s 
JOIN Marks m ON s.idStudent = m.Student_idStudent 
WHERE m.Subject = 'Математика' AND m.Mark = 2;

-- 6. Строковые функции: конкатенация и поиск по шаблону LIKE (Фамилии на 'a' с буквой 'B')
SELECT CONCAT(Surname, ' ', LEFT(Name, 1)) AS FullName 
FROM Student 
WHERE Surname LIKE 'А%' AND Surname LIKE '%м%'; -- Адаптировано под кириллицу

-- 7. Фильтрация с использованием регулярных выражений (REGEXP)
SELECT Surname, Tel 
FROM Student 
WHERE Tel REGEXP '^[2-5|7]+$';

-- 8. Поиск по подстроке в адресе (проживающие в 78 доме)
SELECT * FROM Student 
WHERE Address LIKE '%д.78%';

-- 9. Выборка студентов по конкретному списку фамилий
SELECT * FROM Student 
WHERE Surname IN ('Иванов', 'Петров', 'Сидоров');

-- 10. Уникальные фамилии студентов с оценкой >= 3 по математике
SELECT DISTINCT s.Surname 
FROM Student s 
JOIN Marks m ON s.idStudent = m.Student_idStudent 
WHERE m.Subject = 'Математика' AND m.Mark >= 3;

-- 11. Математические операции в SELECT: перевод оценки в 100-балльную шкалу
SELECT Mark AS FivePointScale, Mark * 20 AS HundredPointScale 
FROM Marks 
GROUP BY Mark;