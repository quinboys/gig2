/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

/* !FIXME */

CREATE VIEW MontlyGrowthStatistic AS
SELECT *
FROM Finance
GROUP BY Finance.LogID;

