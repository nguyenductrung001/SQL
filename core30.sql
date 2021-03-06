-- 1. Li?t k? danh s?ch sinh vi?n s?p x?p theo th? t?:
--      a. id t?ng d?n
select id from student order by id asc
--      b. gi?i t?nh
select student.gender from student order by gender desc
--      c. ng?y sinh T?NG D?N v? h?c b?ng GI?M D?N
select student.birthday,student.scholarship from student order by birthday asc ,scholarship desc

-- 2. M?n h?c c? t?n b?t ??u b?ng ch? 'T'
select * from subject where name LIKE 'T%'
-- 3. Sinh vi?n c? ch? c?i cu?i c?ng trong t?n l? 'i'
select * from student where name LIKE '%i'
-- 4. Nh?ng khoa c? k? t? th? hai c?a t?n khoa c? ch?a ch? 'n'
select * from faculty where name LIKE '_n'
-- 5. Sinh vi?n trong t?n c? t? 'Th?'
select * from student where name LIKE '%Th?%'
-- 6. Sinh vi?n c? k? t? ??u ti?n c?a t?n n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? t?n sinh vi?n
select* from student where name between 'a' and 'm' order by name ASC 
-- 7. Sinh vi?n c? h?c b?ng l?n h?n 100000, s?p x?p theo m? khoa gi?m d?n
select* from student where student.scholarship > 100000 order by student.faculty_id DESC
-- 8. Sinh vi?n c? h?c b?ng t? 150000 tr? l?n v? sinh ? H? N?i
select* from student where student.scholarship >= 150000  and student.hometown like N'H? N?i'
-- 9. Nh?ng sinh vi?n c? ng?y sinh t? ng?y 01/01/1991 ??n ng?y 05/06/1992
select* from student where student.birthday between ' 01/01/1991' and ' 05/06/1992' 
-- 10. Nh?ng sinh vi?n c? h?c b?ng t? 80000 ??n 150000
 select* from student where student.scholarship between ' 80000' and '  150000' 
-- 11. Nh?ng m?n h?c c? s? ti?t l?n h?n 30 v? nh? h?n 45
select * from subject where lesson_quantity between '30' and '45'


-- 1. Cho bi?t th?ng tin v? m?c h?c b?ng c?a c?c sinh vi?n, g?m: M? sinh vi?n, Gi?i t?nh, M? 
		-- khoa, M?c h?c b?ng. Trong ??, m?c h?c b?ng s? hi?n th? l? ?H?c b?ng cao? n?u gi? tr? 
		-- c?a h?c b?ng l?n h?n 500,000 v? ng??c l?i hi?n th? l? ?M?c trung b?nh?.
   select s.id,gender,faculty_id,scholarship,
    case 
	when scholarship >500000 
	THEN N'hoc bong cao'
	else N'M?c trung b?nh'
	end 
	from student s  inner join faculty  on s.faculty_id = faculty.id;
		
-- 2. T?nh t?ng s? sinh vi?n c?a to?n tr??ng
select COUNT(id) as sinhvien from student
-- 3. T?nh t?ng s? sinh vi?n nam v? t?ng s? sinh vi?n n?.
select gender,count(*) from student group by gender
-- 4. T?nh t?ng s? sinh vi?n t?ng khoa (ch?a c?n JOIN)
select faculty_id, faculty.name, COUNT(*) as tongSv from student inner join faculty on student.faculty_id = faculty.id  group by student.faculty_id,  faculty.name
-- 5. T?nh t?ng s? sinh vi?n c?a t?ng m?n h?c
select subject_id , COUNT(student_id) from exam_management group by subject_id
-- 6. T?nh s? l??ng m?n h?c m? sinh vi?n ?? h?c
select  COUNT(subject.id) as tongMonHoc from subject inner join exam_management On  exam_management.subject_id= subject.id
					  inner join student on exam_management.student_id = student.id
					  group by student.name
-- 7. T?ng s? h?c b?ng c?a m?i khoa	
select faculty.id,faculty.name, count (student.scholarship) from faculty left join student on faculty.id = student.faculty_id group by faculty.id , faculty.name
-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
select faculty.id,faculty.name, max (student.scholarship) from faculty left join student on faculty.id = student.faculty_id group by faculty.id , faculty.name
-- 9. Cho bi?t t?ng s? sinh vi?n nam v? t?ng s? sinh vi?n n? c?a m?i khoa
select faculty.id,faculty.name, student.gender,  count (student.id) as total_Student from student left join faculty on  student.faculty_id=faculty.id  group by faculty.id , faculty.name, gender
-- 10. Cho bi?t s? l??ng sinh vi?n theo t?ng ?? tu?i
select YEAR( birthday), COUNT(student.id) from student group by YEAR( birthday)
-- 11. Cho bi?t nh?ng n?i n?o c? h?n 2 sinh vi?n ?ang theo h?c t?i tr??ng
select student.hometown, count(student.id) from student group by hometown having count(student.id)>=2;
-- 12. Cho bi?t nh?ng sinh vi?n thi l?i ?t nh?t 2 l?n
select student.name , COUNT(student.id) from exam_management , student where exam_management.student_id = student.id 
group by exam_management.subject_id , student.name having COUNT(student.id)>=2

-- 13. Cho bi?t nh?ng sinh vi?n nam c? ?i?m trung b?nh l?n 1 tr?n 7.0 
   select student_id , avg(mark)
    from exam_management, student
    where exam_management.student_id = student.id and number_of_exam_taking = 1 and gender = 'Nam'
    group by student_id
    having avg(mark) > 7;
-- 14. Cho bi?t danh s?ch c?c sinh vi?n r?t tr?n 2 m?n ? l?n thi 1 (r?t m?n l? ?i?m thi c?a m?n kh?ng qu? 4 ?i?m)

-- 15. Cho bi?t danh s?ch nh?ng khoa c? nhi?u h?n 2 sinh vi?n nam (ch?a c?n JOIN)
   select faculty_id, count(id)
    from student
    where gender = 'Nam'
    group by faculty_id
    having count(id) >= 2;
-- 16. Cho bi?t nh?ng khoa c? 2 sinh vi?n ??t h?c b?ng t? 200000 ??n 300000
 select faculty_id, count(id)
    from student
    where scholarship  between 200000 and 300000
    group by faculty_id
    having count(id) >= 2;
-- 17. Cho bi?t sinh vi?n n?o c? h?c b?ng cao nh?t
select  student.id, student.name,  student.scholarship from student
group by student.id , student.name, student.scholarship
having scholarship >= (select max(scholarship) from student)

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh vi?n c? n?i sinh ? H? N?i v? sinh v?o th?ng 02
select * from student where student.hometown like N'H? N?i' and to_char(birthday,'MM')='02';
-- 2. Sinh vi?n c? tu?i l?n h?n 20
select student.name, current_year - to_number(to_char(student.birthday, 'YYYY')) age
from student, (select to_number(to_char(sysdate, 'YYYY')) current_year from dual)
where current_year - to_number(to_char(student.birthday, 'YYYY')) > 20;
3. Sinh vi?n sinh v?o m?a xu?n n?m 1990
select * from student where EXTRACT(YEAR from birthday) = 1990 and EXTRACT(MONTH from birthday) BETWEEN 1 and 3;





-- 1. Danh s?ch c?c sinh vi?n c?a khoa ANH V?N v? khoa V?T L?
select *
 from student s inner join faculty f on s.faculty_id = f.id where f.id in (1,2)
-- 2. Nh?ng sinh vi?n nam c?a khoa ANH V?N v? khoa TIN H?C
select student.name, faculty.name from student,faculty
where student.faculty_id = faculty.id and (faculty.name = 'Anh - V?n' or faculty.name = 'Tin h?c') and student.gender = 'Nam';
 
 
 -- 3. Cho bi?t sinh vi?n n?o c? ?i?m thi l?n 1 m?n c? s? d? li?u cao nh?t
select * from student s inner join exam_management
-- 4. Cho bi?t sinh vi?n khoa anh v?n c? tu?i l?n nh?t.
select * from  student 
where months_between(sysdate, birthday) / 12 =
         (select  max(months_between(sysdate, birthday) / 12) 
       from  student where faculty_id = 1 );
-- 5. Cho bi?t khoa n?o c? ??ng sinh vi?n nh?t
select subject.id, subject.name, count(exam_management.student_id) as total from subject 
LEFT JOIN exam_management on subject.id = exam_management.subject_id
GROUP by subject.id,  subject.name
order by subject.id asc;
-- 6. Cho bi?t khoa n?o c? ??ng  n? nh?t
select faculty.name, gender, count(gender) from faculty,student
where faculty.id = student.faculty_id and gender = 'N?'
group by faculty.name, gender having count(student.faculty_id)>= all(select count(gender) from student where gender ='N?' group by student.faculty_id);
-- 7. Cho bi?t nh?ng sinh vi?n ??t ?i?m cao nh?t trong t?ng m?n

-- 8. Cho bi?t nh?ng khoa kh?ng c? sinh vi?n h?c
select f.id, f.name, max(s.scholarship)   
from faculty f
LEFT JOIN student s ON f.id = s.faculty_id
where s.scholarship is not null
-- 9. Cho bi?t sinh vi?n ch?a thi m?n c? s? d? li?u
select f.id, f.name,s.gender, count(s.id) as total_Student
from faculty f
LEFT JOIN student s ON f.id = s.faculty_id
GROUP by  f.id, f.name ,s.gender
order by f.id;
-- 10. Cho bi?t sinh vi?n n?o kh?ng thi l?n 1 m? c? d? thi l?n 2
select student.name, number_of_exam_taking from exam_management
join student on student.id = exam_management.student_id
where number_of_exam_taking = 2 and not exists (select id , student_id, subject_id, exam_management.number_of_exam_taking , mark
from exam_management where number_of_exam_taking = 1 and student.id = exam_management.student_id);