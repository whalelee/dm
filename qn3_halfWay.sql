

SELECT  drivenBuses.plate_No, drivenBuses.model,  julDecBabies.*  , COUNT(*)
FROM 

(SELECT b.plate_No, b.Model, t.staff_id
FROM trip t INNER JOIN bus b
ON t.plate_no = b.plate_no) drivenBuses

LEFT JOIN

(SELECT s.staff_id, s.dob
FROM staff s 
WHERE dob LIKE '%-07-%' OR dob LIKE '%-08-%' OR dob LIKE '%-09-%' OR dob LIKE '%-10-%' OR dob LIKE '%-11-%' OR dob LIKE '%-12-%') julDecBabies

ON drivenBuses.staff_id = julDecBabies.staff_id

 GROUP BY ( drivenBuses.plate_no)

ORDER BY  drivenBuses.plate_No DESC;