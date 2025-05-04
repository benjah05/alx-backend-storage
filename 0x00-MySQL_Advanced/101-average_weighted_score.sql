-- average weigthed score for all
-- calculate the average weighted score for all student
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUser()
BEGIN
	UPDATE users AS U,
	(SELECT U.id, SUM(score * weight) / SUM(weight) AS w_avg
		FROM users AS U
		JOIN corrections as C ON U.id=C.user_id
		JOIN projects AS P ON C.project_id=P.id
		GROUP BY U.id) AS WA
	SET U.average_score = WA.w_avg
	WHERE U.id=WA.id;
END $$
DELIMITER ;
