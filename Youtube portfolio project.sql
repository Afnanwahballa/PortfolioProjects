SELECT *
FROM PortfolioProject.dbo.YouTubeInfluencers2022

--Select Data that we are going to be using

SELECT Youtuber,
       country, 
       subscribers_corrected, 
	   Category_2, 
	   avg_views_corrected,
	   avg_likes_corrected,
	   avg_comments_corrected
FROM PortfolioProject.dbo.YouTubeInfluencers2022
ORDER BY Subscribers_corrected DESC

--looking at the youtubers with most subscribers in each country 

SELECT Country, MAX(subscribers_corrected) AS max_subscribers_by_country
FROM PortfolioProject.dbo.YouTubeInfluencers2022
GROUP BY Country
ORDER BY max_subscribers_by_country DESC

--looking at youtubers in united kingdom 
SELECT Youtuber,
       Subscribers_corrected, 
	   avg_views_corrected,
	   avg_likes_corrected,
	   avg_comments_corrected,
	   Category_2
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country like 'United Kingdom'
-----youtubers in the UK
SELECT Youtuber,
       Category_2,
       Subscribers_corrected 
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country like 'United Kingdom'



----
--max subscribers for each category

SELECT Category_2, MAX(subscribers_corrected) AS max_subscribers_by_category
FROM PortfolioProject.dbo.YouTubeInfluencers2022
GROUP BY Category_2
ORDER BY max_subscribers_by_category DESC



--The table showws the top 10 youtubers with the most subscribers and the categories in which they belong to

SELECT DISTINCT Category_2,
         Youtuber,
		 Subscribers_corrected
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE country like 'United States'
AND category_2 IS NOT NULL
ORDER BY Subscribers_corrected DESC


--what category are most famous in India 

SELECT DISTINCT Category_2,
         Youtuber,
		 Subscribers_corrected
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE country like 'India'
AND category_2 IS NOT NULL
ORDER BY Subscribers_corrected DESC


--category of most famous british youtuber

SELECT DISTINCT Category_2,
         Youtuber,
		 Subscribers_corrected
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE country like 'United Kingdom'
AND category_2 IS NOT NULL
ORDER BY Subscribers_corrected DESC

---

SELECT DISTINCT Category_2,
         Youtuber,
		 Subscribers_corrected,
		 country
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE country IS NOT NULL
AND category_2 IS NOT NULL
ORDER BY Subscribers_corrected DESC



----
--looking at max subscribers for each category

SELECT DISTINCT(Category_2),
       MAX(subscribers_corrected) AS max_subscribers_corrected
FROM PortfolioProject.dbo.YouTubeInfluencers2022
GROUP BY Category_2
ORDER BY max_subscribers_corrected  DESC



SELECT DISTINCT Country, Category_2 
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE country IS NOT NULL
AND Category_2 is NOT NULL


--looking at percentage of subscribers that view content

SELECT Youtuber,
       Country,
	   Category_2,
       avg_views_corrected,
	   subscribers_corrected,
      (avg_views_corrected/ Subscribers_corrected) *100 AS PercentageofViewers
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country IS NOT NULL
AND Category_2 IS NOT NULL
ORDER BY PercentageofViewers DESC



--looking at percentage of subscribers that comment 

SELECT Youtuber,
       Country,
	   Category_2,
       avg_views_corrected,
	   subscribers_corrected,
      (avg_comments_corrected/ Subscribers_corrected) *100 AS PercentageofPeoplethatComment
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country IS NOT NULL
AND Category_2 IS NOT NULL
ORDER BY PercentageofPeoplethatComment DESC


---looking at percentage of people that like videos

SELECT Youtuber,
       Country,
	   Category_2,
       avg_likes_corrected,
	   subscribers_corrected,
      (avg_likes_corrected/ Subscribers_corrected) *100 AS PercentageofLikes
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country IS NOT NULL
AND Category_2 IS NOT NULL
ORDER BY PercentageofLikes DESC

--looking at total percentage of people that like videos on youtube is 0.39%

SELECT SUM(avg_likes_corrected)/ SUM(Subscribers_corrected) *100 AS PercentageofLikes
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country IS NOT NULL
AND Category_2 IS NOT NULL
ORDER BY PercentageofLikes DESC


--looking at percentage of people that view UK content

SELECT Youtuber,
       Country,
	   Category_2,
       avg_views_corrected,
	   subscribers_corrected,
      (avg_views_corrected/ Subscribers_corrected) *100 AS PercentageofViewers
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country like 'United Kingdom'
AND Category_2 IS NOT NULL
ORDER BY PercentageofViewers DESC


--looking at percentage of viewers that like UK content 

SELECT Youtuber,
       Country,
	   Category_2,
       avg_likes_corrected,
	   subscribers_corrected,
      ROUND((avg_likes_corrected/ Subscribers_corrected),5) *100 AS PercentageofLikes
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country like 'United Kingdom'
AND Category_2 IS NOT NULL
ORDER BY PercentageofLikes DESC






--percentage of people that view US content 

SELECT Youtuber,
       Country,
	   Category_2,
       avg_views_corrected,
	   subscribers_corrected,
      (avg_views_corrected/ Subscribers_corrected) *100 AS PercentageofViewers
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country like 'United States'
AND Category_2 IS NOT NULL
ORDER BY PercentageofViewers DESC


---Total Percentage of viewers in the united states in relation to subscribers is 8.3%

SELECT SUM(avg_views_corrected) / SUM(subscribers_corrected)*100 AS PercentageofViewers
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country like 'United States'
AND Category_2 IS NOT NULL
ORDER BY PercentageofViewers DESC


--Total percentage of viewers in the united kingdom in relation to subscribers is 12.1%

SELECT SUM(avg_views_corrected) / SUM(subscribers_corrected)*100 AS PercentageofViewers
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country like 'United Kingdom'
AND Category_2 IS NOT NULL
ORDER BY PercentageofViewers DESC


--subscribers vs categories

SELECT DISTINCT category_2,
                MAX(subscribers_corrected) AS max_subscribers,
                COUNT(category_2) AS Distributionofcategories
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Category_2 IS NOT NULL
GROUP BY Category_2
ORDER BY Distributionofcategories DESC


--categories vs view
SELECT DISTINCT Category_2,
                MAX(avg_views_corrected) AS max_views,
				COUNT(category_2) AS Distributionofcategories
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Category_2 IS NOT NULL
GROUP BY Category_2
ORDER BY Distributionofcategories DESC

--USE CTE

With Catvsview (Category_2, max_views, Distributionofcategories)
AS
(
SELECT DISTINCT Category_2,
                MAX(avg_views_corrected) AS max_views,
				COUNT(category_2) AS Distributionofcategories
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Category_2 IS NOT NULL
GROUP BY Category_2
--ORDER BY Distributionofcategories DESC
)
SELECT DISTINCT Category_2, Distributionofcategories
FROM CatvsView
ORDER BY Distributionofcategories DESC;



--looking at how many subscribers are in each category

SELECT DISTINCT category_2,
                SUM(subscribers_corrected) AS sum_subscribers,
                COUNT(category_2) AS NumberofInfluencersWithinEachCategory
FROM PortfolioProject.dbo.YouTubeInfluencers2022
--WHERE Category_2 IS NOT NULL
GROUP BY Category_2
ORDER BY NumberofInfluencersWithinEachCategory DESC


--looking at average subscribers per influencer in each category

SELECT DISTINCT TOP 5 category_2,
                ROUND(AVG(subscribers_corrected),0) avg_subscribers,
                COUNT(category_2) NumberofInfluencersWithinEachCategory
FROM PortfolioProject.dbo.YouTubeInfluencers2022
--WHERE Category_2 IS NOT NULL
GROUP BY Category_2
ORDER BY avg_subscribers DESC

--looking at average views for each category 
--Top 5 categories with most views are Animals and pets, Video games, Health and Self help,
--music and dance, humor

--Distribution of views per category per inflencer

SELECT DISTINCT category_2,
                ROUND(AVG(avg_views_corrected),0) AS avg_views,
                COUNT(category_2) AS NumberofInfluencersWithinEachCategory
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Category_2 IS NOT NULL
GROUP BY Category_2
ORDER BY avg_views DESC

--Distribution of views for each category 

SELECT DISTINCT category_2,
                ROUND(SUM(avg_views_corrected),0) AS Sumofavg_views,
                COUNT(category_2) AS NumberofInfluencersWithinEachCategory
FROM PortfolioProject.dbo.YouTubeInfluencers2022
--WHERE Category_2 IS NOT NULL
GROUP BY Category_2
ORDER BY Sumofavg_views DESC

--lets look at Average views for each influencer whos category Health and Self Help

SELECT DISTINCT category_2,
                ROUND(AVG(avg_views_corrected),0) AS avg_views,
                COUNT(category_2) AS NumberofInfluencersWithinEachCategory
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Category_2 like 'Health & Self Help'
GROUP BY Category_2
ORDER BY avg_views DESC


SELECT DISTINCT category_2,
                ROUND(AVG(avg_views_corrected),0) AS avg_views_per_influencer,
                COUNT(category_2) AS NumberofInfluencersWithinEachCategory
FROM PortfolioProject.dbo.YouTubeInfluencers2022
--WHERE Category_2 IS NOT NULL
GROUP BY Category_2
ORDER BY avg_views_per_influencer DESC


--average subscribers per influencer in the 'Health & Self Help' category
SELECT ROUND(AVG(Subscribers_corrected),0)
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Category_2 like 'Health & Self Help'





  



SELECT Youtuber, 
       Category_2,
	   Subscribers_corrected,
	   avg_views_corrected
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Category_2 IS NULL

SELECT Subscribers_corrected,
	   avg_views_corrected
FROM PortfolioProject.dbo.YouTubeInfluencers2022
ORDER BY Subscribers_corrected DESC

SELECT avg_views_corrected
FROM PortfolioProject.dbo.YouTubeInfluencers2022

--------



-----creating view for percentage of subcribers that view UK content 

CREATE TABLE #PercentageSubscribersthatViewUKContent
(
Youtuber nvarchar (255),
Country nvarchar (255),
Category_2 nvarchar (255),
avg_views_corrected numeric,
subscribers_corrected numeric,
PercentageofViewers numeric
)

INSERT INTO #PercentageSubscribersthatViewUKContent
SELECT Youtuber,
       Country,
	   Category_2,
       avg_views_corrected,
	   subscribers_corrected,
      (avg_views_corrected/ Subscribers_corrected) *100 AS PercentageofViewers
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country like 'United Kingdom'
AND Category_2 IS NOT NULL
ORDER BY PercentageofViewers DESC

CREATE VIEW PercentageSubscribersthatViewUKContent AS
SELECT Youtuber,
       Country,
	   Category_2,
       avg_views_corrected,
	   subscribers_corrected,
      (avg_views_corrected/ Subscribers_corrected) *100 AS PercentageofViewers
FROM PortfolioProject.dbo.YouTubeInfluencers2022
WHERE Country like 'United Kingdom'
AND Category_2 IS NOT NULL

SELECT *
FROM PercentageSubscribersthatViewUKContent

