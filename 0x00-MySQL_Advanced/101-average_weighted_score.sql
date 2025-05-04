DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    -- Temporary table to store calculated weighted averages
    DROP TEMPORARY TABLE IF EXISTS temp_weighted_averages;
    CREATE TEMPORARY TABLE temp_weighted_averages (
        user_id INT PRIMARY KEY,
        weighted_avg DECIMAL(10,2)
    );
    
    -- Calculate weighted average for each user
    INSERT INTO temp_weighted_averages (user_id, weighted_avg)
    SELECT 
        c.user_id,
        SUM(c.score * p.weight) / SUM(p.weight) AS weighted_average
    FROM 
        corrections c
    JOIN 
        projects p ON c.project_id = p.id
    GROUP BY 
        c.user_id;
    
    -- Update users table with the calculated weighted averages
    UPDATE users u
    JOIN temp_weighted_averages t ON u.id = t.user_id
    SET u.average_score = t.weighted_avg;
    
    -- Clean up
    DROP TEMPORARY TABLE IF EXISTS temp_weighted_averages;
END //
DELIMITER ;
