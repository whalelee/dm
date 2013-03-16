SET @capacity_queried = 72; -- one query

SELECT  drivenBuses.plate_No, drivenBuses.model, COUNT(juldecbabies.staff_id) AS `Number of Drivers`
FROM 

(SELECT DISTINCT b.plate_No, b.Model, t.staff_id, b.capacity
FROM trip t INNER JOIN bus b
ON t.plate_no = b.plate_no) drivenBuses


LEFT JOIN

(SELECT s.staff_id, s.dob
FROM staff s 
WHERE dob LIKE '%-07-%' OR dob LIKE '%-08-%' OR dob LIKE '%-09-%' OR dob LIKE '%-10-%' OR dob LIKE '%-11-%' OR dob LIKE '%-12-%') julDecBabies

ON drivenBuses.staff_id = julDecBabies.staff_id

WHERE drivenBuses.capacity = @capacity_queried -- either 72 or 46
GROUP BY ( drivenBuses.plate_no) ;