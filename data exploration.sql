--select * from CovidDeaths1;
--select * from Covidvaccinations1

--calculation the death percentage of india


--select location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage 
--from CovidDeaths1 where location like 'india'
--order by 1,2;



--looking at total_cases vs population
--shows what percentage of population got affected in india

--select location,date, population, total_cases, (total_cases / population)*100
--as infected from CovidDeaths1
--where location = 'india'
--order by 1,2


use portfolioproject;

--select location,population,max(total_cases)as highest_infected ,max((total_cases/population)) * 100 as highest_total_infected
--from CovidDeaths1 where location= 'australia'
--group by location  , population;


--showing countries with highest death count per population


--select continent, max(total_deaths) as total_death_count 
--from CovidDeaths1 where continent is not null
--group by continent
--order by total_death_count desc;


--showing continents with the highest death count per population

--select continent,max(total_deaths) as highest_death_count
--from CovidDeaths1
--where continent is not null
--group by continent;

--select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths
--from CovidDeaths1
--where continent is not null
--order by 1,2; 


--looking at total vaccinations vs vaccination

--select dea.continent, dea.location, dea.date, vac.new_vaccinations,
--sum(vac.new_vaccinations) over (partition  by dea.location order by dea.date) as rolling_people_vaccinated
--from CovidDeaths1 dea
--join Covidvaccinations1 vac
--on dea.location=vac.location
--and
--dea.date=vac.date
--where dea.continent is not null
--order by 2,3

--with popvsvac as 
--(
--select dea.continent,dea.population,  dea.location, dea.date, vac.new_vaccinations,
--sum(vac.new_vaccinations) over (partition  by dea.location order by dea.date) 
--as rolling_people_vaccinated
--from CovidDeaths1 dea
--join Covidvaccinations1 vac
--on dea.location=vac.location
--and
--dea.date=vac.date
--where dea.continent is not null
--)
--select *, (rolling_people_vaccinated/population)*100
--from popvsvac


--temp table
--drop table if exists #percentpopulationvaccinated
--create table #percentpopulationvaccinated
--(continent nvarchar(225),
--location nvarchar(225),
--population numeric,
--new_vaccinations numeric,
--rolling_people_vaccinated numeric
--)

--insert into #percentpopulationvaccinated
--select dea.continent,  dea.location,convert(numeric,dea.population),try_convert(numeric,vac.new_vaccinations),
--sum(try_convert(numeric,vac.new_vaccinations)) over (partition  by dea.location order by dea.date) 
--as rolling_people_vaccinated
--from CovidDeaths1 dea
--join Covidvaccinations1 vac
--on dea.location=vac.location
--and
--dea.date=vac.date
--where dea.continent is not null
--SELECT COLUMN_NAME, DATA_TYPE 
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE TABLE_NAME IN ('CovidDeaths1', 'Covidvaccinations1')
--AND DATA_TYPE IN ('nvarchar', 'varchar')

--creating view	to store data for later visualization
go
create or alter view percentpopulationvaccinated as
select dea.continent,  dea.location,convert(numeric,dea.population)as pop,try_convert(numeric,vac.new_vaccinations) as new_vacc,
sum(try_convert(numeric,vac.new_vaccinations))  over (partition  by dea.location order by dea.date)
as rolling_people_vaccinated
from CovidDeaths1 dea
join Covidvaccinations1 vac
on dea.location=vac.location
and
dea.date=vac.date
where dea.continent is not null
go
select * from percentpopulationvaccinated;