-- câu 1: tạo view view_studentbasic
create or replace view view_studentbasic as
select s.studentid,
       s.fullname,
       d.deptname
from student s
         join department d on s.deptid = d.deptid;
select *
from view_studentbasic;
-- câu 2: tạo regular index cho cột fullname
create index idx_student_fullname
    on student (fullname);
-- câu 3:  Viết Stored Procedure GetStudentsIT
delimiter //
create procedure getstudentsit()
begin
    select s.studentid,
           s.fullname,
           s.gender,
           s.birthdate,
           d.deptname
    from student s
             join department d on s.deptid = d.deptid
    where d.deptname = 'information technology';
end //
delimiter ;
call getstudentsit();
-- câu 4
-- a:
create or replace view view_studentcountbydept as
select d.deptname,
       count(s.studentid) as totalstudents
from department d
         left join student s on d.deptid = s.deptid
group by d.deptname;
-- b:
select *
from view_studentcountbydept
order by totalstudents desc
limit 1;
-- câu 5:
-- a:
delimiter //
create procedure gettopscorestudent(
    in p_courseid char(6)
)
begin
    select s.studentid,
           s.fullname,
           c.coursename,
           e.score
    from enrollment e
             join student s on e.studentid = s.studentid
             join course c on e.courseid = c.courseid
    where e.courseid = p_courseid
      and e.score = (select max(score)
                     from enrollment
                     where courseid = p_courseid);
end //
delimiter ;
-- b:
call gettopscorestudent('c00001');
