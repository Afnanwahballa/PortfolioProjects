SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4 

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

--Select Data that we are going to be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
WHERE continent IS NOT NULL
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2 

--Looking at Total Cases vs Total Deaths
--Shows the likelihood of dying if you contract covid in your country
SELECT Location, date, total_cases, total_deaths, (total_deaths/ total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location like 'United Kingdom'
AND continent IS NOT NULL
ORDER BY 1,2 


--looking at the total cases vs Population
--Shows what percentage of population got Covid
SELECT Location, date, population, total_cases, (total_cases/ population)*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--Where location like 'United Kingdom'
ORDER BY 1,2


--Looking at countries with Highest Infection Rate compared to Population

SELECT Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/ population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--Where location like 'United Kingdom'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--Showing Countries with the Highest Death Count per Population 

SELECT Location, MAX(cast(Total_Deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where location like 'United Kingdom'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

--LETS'S BREAK THINGS DOWN BY LOCATION WHERE CONTINENT IS NULL



SELECT location, MAX(cast(Total_Deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where location like 'United Kingdom'
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


--LETS BREAK IT DOWN BY CONTINENT WHERE CONTINENT IS NOT NULL 


--Showing the continents with the Highest death count per population 

SELECT continent, MAX(cast(Total_Deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where location like 'United Kingdom'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC



-- GLOBAL NUMBERS

--Total cases, total deaths and DeathPercentage grouped by Date 

SELECT
date,
SUM(new_cases) as total_cases, 
SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int)) /  SUM(new_cases) *100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location like 'United Kingdom'
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2 

--TOTAL NUMBER OF CASES 

SELECT  
SUM(new_cases) as total_cases, 
SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int)) /  SUM(new_cases) *100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location like 'United Kingdom'
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2 



--Looking at total population vs vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
     ON dea.location = vac.location 
	 AND dea.date= vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

--Looking at total population vs vaccination

SELECT dea.continent, 
dea.location, 
dea.date, 
dea.population, 
vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, 
dea.date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
     ON dea.location = vac.location 
	 AND dea.date= vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


--Use CTE

With Popvsvac (Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, 
dea.location, 
dea.date, 
dea.population, 
vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, 
dea.date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
     ON dea.location = vac.location 
	 AND dea.date= vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (RollingPeopleVaccinated/population) *100
FROM Popvsvac;


--TEMP TABLE

DROP TABLE  if exists  #PercentPopulationVaccination
Create Table #PercentPopulationVaccination
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccination
SELECT dea.continent, 
dea.location, 
dea.date, 
dea.population, 
vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, 
dea.date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
     ON dea.location = vac.location 
	 AND dea.date= vac.date
--WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/population) *100
FROM #PercentPopulationVaccination;



--Creating View to store data for later visualisations

CREATE VIEW PercentPopulationVaccination AS
SELECT dea.continent, 
dea.location, 
dea.date, 
dea.population, 
vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, 
dea.date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
     ON dea.location = vac.location 
	 AND dea.date= vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT *
FROM PercentPopulationVaccination