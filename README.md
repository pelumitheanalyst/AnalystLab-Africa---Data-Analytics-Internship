##### **Weather ETL Pipeline Using OpenWeatherMap API**



###### **Project Overview**

This project demonstrates the implementation of a simple ETL (Extract, Transform, Load) pipeline using real-time weather data from the OpenWeatherMap API. The objective was to collect weather information for multiple cities, transform the raw API response into a structured and analysis-ready dataset, store the processed data, and generate basic weather insights.



###### **Data Source**

Source: OpenWeatherMap API

The OpenWeatherMap Current Weather API was used to retrieve real-time weather information for five Nigerian cities:

Port Harcourt

Lagos

Abuja

Ilesa

Uyo



The API returned weather measurements, atmospheric conditions, wind information, cloud coverage, visibility, sunrise and sunset times, and other location metadata in JSON format.



###### **ETL Process**



1\. Extract

Connected to the OpenWeatherMap API using an API key.

Retrieved weather data for a single city to explore the API structure.

Examined the JSON response and identified available fields.

Explored nested objects, including weather measurements, wind information, and system metadata.

Extracted 15 relevant weather attributes for five cities and stored them in a structured list of dictionaries.



2\. Transform

Converted the extracted data into a Pandas DataFrame.

Inspected the dataset structure and verified data types.

Performed data quality checks by identifying missing values.

Converted Unix timestamps into readable datetime values.



Engineered features:

DayLength\_Hours: Duration between sunrise and sunset.

Temp\_Difference: Difference between feels-like temperature and actual temperature.

Produced a clean and analysis-ready dataset containing 17 columns.



3\. Load

Exported the transformed dataset to a CSV file.

Verified that the exported file was successfully created and could be reloaded for future analysis.



Tools Used



Python

Requests

Pandas

JSON Library

OpenWeatherMap API

CSV File Storage



###### **Steps Taken**

1\. Connected to the OpenWeatherMap API.

2\. Retrieved and explored raw JSON weather data.

3\. Identified available API fields and nested structures.

4\. Selected relevant weather attributes for analysis.

5\. Extracted weather data for five Nigerian cities.

6\. Converted the extracted data into a Pandas DataFrame.

7\. Validated dataset structure and checked for missing values.

8\. Converted Unix timestamps into readable datetime format.

9\. Created additional analytical features.

10\. Exported the transformed dataset as a CSV file.

11\. Performed exploratory weather analysis.



###### **Key Findings**

* Abuja recorded the highest temperature at 32.35°C among the selected cities.
* Uyo recorded the highest humidity level at 79%.
* All five cities experienced overcast cloud conditions during data collection.
* Lagos recorded the highest wind speed at 4.06 m/s and the highest wind gust at 4.40 m/s.
* Temperature rankings ranged from 26.78°C in Uyo to 2.35°C in Abuja.
* Abuja recorded the longest daylight duration at approximately 12.65 hours.
* The feels-like temperature exceeded the actual temperature in every city.
* Lagos recorded the largest difference between actual and feels-like temperature at 3.81°C, indicating that conditions felt significantly warmer than the measured air temperature.



###### **Conclusion**

This project successfully demonstrates a complete ETL workflow using a real-time API data source. By extracting, transforming, loading, and analyzing weather data, the project showcases practical skills in API integration, data preparation, feature engineering, and exploratory analysis using Python and Pandas.



