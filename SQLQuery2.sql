use SQL
go

-- faculty
create table faculty (
	id int primary key,
	name nvarchar(30) not null
);

-- subject
create table subject(
	id int primary key,
	name nvarchar(100) not null,
	lesson_quantity Decimal(2,0) not null
);

-- student
create table student (
	id int primary key,
	name nvarchar(30) not null,
	gender nvarchar(10) not null,
	birthday date not null,
	hometown nvarchar(100) not null,
	scholarship int,
	faculty_id int not null constraint faculty_id references faculty(id)
);

-- exam management

create table exam_management(
	id int primary key,
	student_id int not null constraint student_id references student(id),
	subject_id int not null constraint subject_id references subject(id),
	number_of_exam_taking int not null,
	mark Decimal(4,2) not null
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, 'Cơ sở dữ liệu', 45);
insert into subject values (2, N'Trí tuệ nhân tạo', 45);
insert into subject values (3, N'Truyền tin', 45);
insert into subject values (4, N'Đồ họa', 60);
insert into subject values (5, N'Văn phạm', 45);


-- faculty
insert into faculty values (1, N'Anh - Văn');
insert into faculty values (2, N'Tin học');
insert into faculty values (3, N'Triết học');
insert into faculty values (4, N'Vật lý');


-- student
insert into student values (1, N'Nguyễn Thị Hải', N'Nữ','1990-01-01', N'Hà Nội', 130000, 2);
insert into student values (2, N'Trần Văn Chính', N'Nam','1992-12-24', N'Bình Định', 150000, 4);
insert into student values (3, N'Lê Thu Yến', N'Nữ', '1990-02-21', N'TP HCM', 150000, 2);
insert into student values (4, N'Lê Thu Yến', N'Nữ', '1990-02-21', N'TP HCM', 170000, 2);
insert into student values (5, N'Trần Anh Tuấn', N'Nam', '1990-12-20', N'Hà Nội', 180000, 1);
insert into student values (6, N'Trần Thanh Mai', N'Nữ','1991-08-12', N'Hải Phòng', null, 3);
insert into student values (7, N'Trần Thị Thu Thủy', N'Nữ','1991-01-02', N'Hải Phòng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);

-- 1. Liệt kê danh sách sinh viên sắp xếp theo thứ tự:
--      a. id tăng dần
select id from student order by id asc
--      b. giới tính
select student.gender from student order by gender desc
--      c. ngày sinh TĂNG DẦN và học bổng GIẢM DẦN
select student.birthday,student.scholarship from student order by birthday asc ,scholarship desc

-- 2. Môn học có tên bắt đầu bằng chữ 'T'
select * from subject where name LIKE 'T%'
-- 3. Sinh viên có chữ cái cuối cùng trong tên là 'i'
select * from student where name LIKE '%i'
-- 4. Những khoa có ký tự thứ hai của tên khoa có chứa chữ 'n'
select * from faculty where name LIKE '_n'
-- 5. Sinh viên trong tên có từ 'Thị'
select * from student where name LIKE '%Thị%'
-- 6. Sinh viên có ký tự đầu tiên của tên nằm trong khoảng từ 'a' đến 'm', sắp xếp theo họ tên sinh viên
select* from student where name between 'a' and 'm' order by name ASC 
-- 7. Sinh viên có học bổng lớn hơn 100000, sắp xếp theo mã khoa giảm dần
select* from student where student.scholarship > 100000 order by student.faculty_id DESC
-- 8. Sinh viên có học bổng từ 150000 trở lên và sinh ở Hà Nội
select* from student where student.scholarship >= 150000  and student.hometown like N'Hà Nội'
-- 9. Những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày 05/06/1992
select* from student where student.birthday between ' 01/01/1991' and ' 05/06/1992' 
-- 10. Những sinh viên có học bổng từ 80000 đến 150000
 select* from student where student.scholarship between ' 80000' and '  150000' 
-- 11. Những môn học có số tiết lớn hơn 30 và nhỏ hơn 45
select * from subject where lesson_quantity between '30' and '45'


-- 1. Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, Giới tính, Mã 
		-- khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao” nếu giá trị 
		-- của học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức trung bình”.
   select s.id,gender,faculty_id,scholarship,
    case 
	when scholarship >500000 
	THEN N'hoc bong cao'
	else N'M?c trung bình'
	end 
	from student s  inner join faculty  on s.faculty_id = faculty.id;
		
-- 2. Tính tổng số sinh viên của toàn trường
select COUNT(id) as sinhvien from student
-- 3. Tính tổng số sinh viên nam và tổng số sinh viên nữ.
select gender,count(*) from student group by gender
-- 4. Tính tổng số sinh viên từng khoa (chưa cần JOIN)
select faculty_id, faculty.name, COUNT(*) as tongSv from student inner join faculty on student.faculty_id = faculty.id  group by student.faculty_id,  faculty.name
-- 5. Tính tổng số sinh viên của từng môn học
select subject_id , COUNT(student_id) from exam_management group by subject_id
-- 6. Tính số lượng môn học mà sinh viên đã học
select  COUNT(subject.id) as tongMonHoc from subject inner join exam_management On  exam_management.subject_id= subject.id
					  inner join student on exam_management.student_id = student.id
					  group by student.name
-- 7. Tổng số học bổng của mỗi khoa	
select faculty.id,faculty.name, count (student.scholarship) from faculty left join student on faculty.id = student.faculty_id group by faculty.id , faculty.name
-- 8. Cho biết học bổng cao nhất của mỗi khoa
select faculty.id,faculty.name, max (student.scholarship) from faculty left join student on faculty.id = student.faculty_id group by faculty.id , faculty.name
-- 9. Cho biết tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa
select faculty.id,faculty.name, student.gender,  count (student.id) as total_Student from student left join faculty on  student.faculty_id=faculty.id  group by faculty.id , faculty.name, gender
-- 10. Cho biết số lượng sinh viên theo từng độ tuổi
select YEAR( birthday), COUNT(student.id) from student group by YEAR( birthday)
-- 11. Cho biết những nơi nào có hơn 2 sinh viên đang theo học tại trường
select student.hometown, count(student.id) from student group by hometown having count(student.id)>=2;
-- 12. Cho biết những sinh viên thi lại ít nhất 2 lần
select student.name , COUNT(student.id) from exam_management , student where exam_management.student_id = student.id 
group by exam_management.subject_id , student.name having COUNT(student.id)>=2

-- 13. Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0 

-- 14. Cho biết danh sách các sinh viên rớt trên 2 môn ở lần thi 1 (rớt môn là điểm thi của môn không quá 4 điểm)

-- 15. Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam (chưa cần JOIN)

-- 16. Cho biết những khoa có 2 sinh viên đạt học bổng từ 200000 đến 300000

-- 17. Cho biết sinh viên nào có học bổng cao nhất
select  student.id, student.name,  student.scholarship from student
group by student.id , student.name, student.scholarship
having scholarship >= (select max(scholarship) from student)

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02
select * from student where student.hometown like N'Hà Nội' and to_char(birthday,'MM')='02';

-- 2. Sinh viên có tuổi lớn hơn 20
select * 
from student where (YEAR(NOW()) - YEAR(birthday))>20;
3. Sinh viên sinh vào mùa xuân năm 1990
select * from student where EXTRACT(YEAR from birthday) = 1990 and EXTRACT(MONTH from birthday) BETWEEN 1 and 3