
## "GDP Choropleth Map of the World" Application

This application downloads data from World Bank database via API and shows choroplet map using googleVis.  
Author: Svetlana Aksyuk.  
Developing Data Products course project.   

## Application input   

The interface elements are located in the left panel.

**"Select year" slider:**

Move the slider to select the year 2000 through 2015  

**"Select indicator to plot" radio button:**

Choose one of the four options for  GDP per capita:  

- GDP per capita (current US$)  

- GDP per capita (constant 2000 US$)  

- GDP per capita, PPP (current international $)  

- GDP per capita, PPP (constant 2005 international $)   

## Application output  

The application reports are at the right side of the page. Interactive map is on the top. Below you can see:  

- Summary statistics for chosen indicator   

- Gini coefficient. It measures unequality among countries: coefficient of 1 (or 100%) expresses maximal inequality among values.  

- Top 5 countries by chosen indicator in descending order  

- Low 5 counries by chosen indicator in ascending order  

## Final notes 

Application loads data on the fly, so it takes some time to plot a map.  

Only countries are represented in the data, macroregions are excluded.   

Enjoy!