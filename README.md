# Airbnb Bookings & Listings Analysis

## Project Overview
This project explores Airbnb listings and booking trends using data from Maven Analytics. The objective was to answer key business questions through data transformation, visualization, and statistical analysis. The final dashboard, built in Tableau, helps identify market patterns, city-level listing behaviors, and seasonal guest activity.

## Business Goal
To uncover meaningful insights from Airbnb data such as:

Which cities dominate in listings and pricing?

How do amenities like parking relate to listing popularity?

When do guest bookings peak by season?

Are host behaviors (like accept rates) correlated with review scores?

## Tools & Technologies
Excel: Initial data exploration, cleaning, and distribution checks

Microsoft SQL Server: Data modeling, aggregation, conditional logic (e.g., IF/ELSE), statistical querying

Tableau: Dashboard creation, KPI visuals, city comparisons, seasonal booking trends

## Data Processing
CSV files were preprocessed in Excel to inspect distributions and fix date formats

The cleaned dataset was loaded into SQL Server for further transformation

Data modeling included creating time-based logic and segmenting data by city, season, and amenity type

Final outputs were loaded into Tableau for visualization

## Dashboard Insights
Key performance indicators (KPIs) include:

- 6.87M total listings

- $608.79 average total listing price

- 93.41 average review score

- 0.87 average host response rate

- 0.83 average host accept rate

- 180,024 active hosts with Superhosts making up 17% of the total

**City-Level Insights**
- Sydney leads in total listings with over 2.6M

- Cape Town and Bangkok have the highest average listing prices

- New York shows the highest instance of paid parking, while Sydney leads in unpaid parking availability

**Seasonal Trends**
Booking activity peaked in Autumn 2019 and Winter 2020, suggesting shifting travel behavior potentially impacted by global events

Spring and Summer consistently saw higher bookings until 2020

**Correlation Findings**
A statistically significant but weak negative correlation was found between host accept rate and review location score (p-value < 0.05)

Other host metrics showed minimal linear relationship with review scores

## Recommendations
Optimize Listings in High-Performing Cities: Sydney, New York, and Paris dominate in volume and visibility. Capitalize on Peak Seasons: Autumn and Winter appear as key booking periods for marketing campaigns. Improve Parking Options: Listings with unpaid parking saw broader availability—hosts can highlight this as a perk Furthermore, study Weak Correlations, Although weak, the relationship between host behavior and review quality may benefit from deeper exploration with additional data.

