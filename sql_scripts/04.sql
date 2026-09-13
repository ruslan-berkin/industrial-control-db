-- =========================================================
-- СКРИПТ 4: ПРОДВИНУТЫЕ ПОДЗАПРОСЫ И КВАНТОРЫ
-- =========================================================
USE university_db;

-- 1. Квантор ALL: Предметы, где оценки выше, чем ЛЮБАЯ оценка по предмету 105
SELECT DISTINCT s.SUBJ_NAME 
FROM subjects s 
JOIN exam_marks em ON s.SUBJ_ID = em.subjects_SUBJ_ID 
WHERE em.MARK > ALL (
    SELECT MARK FROM exam_marks WHERE subjects_SUBJ_ID = 105
);

-- 2. Квантор ALL с HAVING: Предметы с наименьшим количеством оценок
SELECT subjects_SUBJ_ID, COUNT(*) as mark_count 
FROM exam_marks 
GROUP BY subjects_SUBJ_ID 
HAVING mark_count <= ALL (
    SELECT COUNT(*) FROM exam_marks GROUP BY subjects_SUBJ_ID
);

-- 3. Пары университетов, расположенных в одном городе
SELECT u1.UNIV_NAME AS University1, u2.UNIV_NAME AS University2, u1.CITY 
FROM university u1, university u2 
WHERE u1.CITY = u2.CITY AND u1.UNIV_ID < u2.UNIV_ID;

-- 4. Коррелированный подзапрос: Студенты с максимальной стипендией В СВОЕМ городе
SELECT s1.STUDENT_ID, s1.SURNAME, s1.NAME, s1.CITY, s1.STIPEND 
FROM student s1 
WHERE s1.STIPEND = (
    SELECT MAX(s2.STIPEND) FROM student s2 WHERE s2.CITY = s1.CITY
);

-- 5. Оператор NOT EXISTS: Студенты, проживающие в городе, где нет университетов
SELECT s.SURNAME, s.NAME, s.CITY 
FROM student s 
WHERE NOT EXISTS (
    SELECT * FROM university u WHERE u.CITY = s.CITY
);
