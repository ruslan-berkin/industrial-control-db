-- 1. ВГУ рейтингіне тең немесе одан жоғары рейтингі бар университеттер 
-- мен олар орналасқан қалалардың атаулары туралы деректерді алуға
-- мүмкіндік беретін сұранысты жазыңыз.

SELECT UNIV_NAME, CITY, RATING
FROM university
WHERE RATING > (
	SELECT RATING FROM university WHERE UNIV_NAME = "ВГУ"
);

-- 2. Идентификаторы бар пән бойынша жалпы орташа баллдан 101 балл
-- жоғары барлық студенттердің аты-жөні туралы деректерді шығаратын
-- сұрауды жазыңыз.

SELECT s.NAME, s.SURNAME, em.MARK, s.STUDENT_ID, em.subjects_SUBJ_ID 
FROM student s 
JOIN exam_marks em ON s.STUDENT_ID = em.student_STUDENT_ID 
WHERE em.subjects_SUBJ_ID = 101
	AND em.MARK > (SELECT AVG(MARK) FROM exam_marks em2);

-- 3. Идентификаторы 102 курсында жалпы баллынан төмен ұпай
-- жинаған барлық студенттердің атын шығаратын сұрауды жазыңыз.

SELECT s.NAME, s.SURNAME, em.MARK, em.subjects_SUBJ_ID as subj_id
FROM student s 
JOIN exam_marks em ON s.STUDENT_ID = em.student_STUDENT_ID 
WHERE em.subjects_SUBJ_ID = 102
	AND em.MARK < (SELECT AVG(MARK) FROM exam_marks);

-- 4. 20-дан астам пәнді қабылдаған әрбір студент емтихан тапсырған пәндер
-- санын көрсететін сұранысты жазыңыз.

SELECT student_STUDENT_ID, COUNT(DISTINCT subjects_SUBJ_ID) as subj_count
FROM exam_marks
GROUP BY student_STUDENT_ID
HAVING COUNT(DISTINCT subjects_SUBJ_ID) > 20;

-- 5. Университеті орналасқан қалада тұрмайтыны белгілі студенттердің аты-
-- жөні мен идентификаторларын көрсетуге мүмкіндік беретін екі сұрауды
-- жазыңыз. Бір сұрау біріктіруді, екіншісі қатысты ішкі сұрауды
-- пайдаланады.

SELECT s.STUDENT_ID, s.NAME, s.SURNAME, s.CITY AS student_city, u.CITY AS univ_city
FROM student s
JOIN university u ON s.university_UNIV_ID = u.UNIV_ID
WHERE s.CITY != u.CITY;







