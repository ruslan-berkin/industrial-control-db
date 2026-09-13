DROP DATABASE IF EXISTS institute_db;
CREATE DATABASE institute_db;
USE institute_db;

-- 1. Таблица кафедр
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

-- 2. Таблица учебных групп
CREATE TABLE student_groups (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    group_name VARCHAR(20) NOT NULL
);

-- 3. Таблица преподавателей
CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    surname VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 4. Таблица студентов
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    surname VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES student_groups(group_id)
);

-- 5. Таблица дисциплин
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    dept_id INT,
    teacher_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

-- 6. Таблица учебников
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    book_name VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    subject_id INT,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- 7. Связующая таблица (Студенты <-> Предметы)
CREATE TABLE student_subject (
    student_id INT,
    subject_id INT,
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- НАПОЛНЕНИЕ ДАННЫМИ
INSERT INTO departments (dept_name) VALUES ('Математика'), ('Информатика');
INSERT INTO student_groups (group_name) VALUES ('ИВТ-1'), ('КС-2');
INSERT INTO teachers (surname, name, dept_id) VALUES ('Иванов','Алексей', 1), ('Петров','Олег', 2);
INSERT INTO students (surname, name, group_id) VALUES ('Сидоров','Иван', 1), ('Кузнецов','Пётр', 2);
INSERT INTO subjects (subject_name, dept_id, teacher_id) VALUES ('Алгебра', 1, 1), ('Программирование', 2, 2);
INSERT INTO books (book_name, author, subject_id) VALUES ('Алгебра: основы', 'А. Автор', 1), ('Введение в программирование', 'Б. Автор', 2);
INSERT INTO student_subject (student_id, subject_id) VALUES (1, 1), (1, 2), (2, 2);