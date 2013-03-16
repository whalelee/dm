SELECT 
ba.stop_no AS `Stop Number`, 
ba.location_desp AS `Location`, 
ba.boarders_count AS `Number of Boarders`, 
ba.alighters_count AS `Number of Alighters`, 
uc.card_count AS `Unique Cards Tapped`

FROM

	(
	SELECT boarders.stop_no, boarders.location_desp, boarders.Boarders_count, alighters.Alighters_Count
	FROM 

		(
		SELECT  s.stop_no , s.location_desp , COUNT(t.start_stop_no) AS `Boarders_count`
		FROM `stop` s
		LEFT JOIN `transaction` t 
		ON t.start_stop_no = s.stop_no
		GROUP BY s.stop_no
		) boarders

	INNER JOIN 

		(
		SELECT  s.stop_no , s.location_desp , COUNT(t.end_stop_no) AS `Alighters_Count`
		FROM `stop` s
		LEFT JOIN `transaction` t 
		ON t.end_stop_no = s.stop_no
		GROUP BY s.stop_no
		) alighters

	ON boarders.stop_no = alighters.stop_no
	) ba

INNER JOIN 

	(
	SELECT COUNT(card_id) AS `card_count`, stop_no,location_desp
	FROM 
		(
		SELECT  DISTINCT t.card_id, s.stop_no , s.location_desp
		FROM `stop` s
		LEFT JOIN `transaction` t 
		ON t.start_stop_no = s.stop_no

		UNION

		SELECT  DISTINCT t.card_id, s.stop_no , s.location_desp
		FROM `stop` s
		LEFT JOIN `transaction` t 
		ON t.end_stop_no = s.stop_no
		) `unique`

	GROUP BY unique.stop_no
	) uc

ON ba.stop_no = uc.stop_no
ORDER BY uc.stop_no;