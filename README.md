# Routing for Tourists in Vienna
This repository shows the SQL requests for conducting an AirBNB to POI routing in Vienna. Also it contains a jupyter Notebook for Visualisation.

The background of this repository is the university course Geodatabases by Lukas Wilfinger for the Master Cartography and Geoinformation at the University of Vienna.

Our group decided to do a project the postGIS and pgRouting extentions for PostgreSQL. In the project we are a "travel agency" that plans three days in Vienna for three different target groups. A family with kid and grandparent, a group of young people coming for a nightlife weekend and two YUPPIES (young urban professionals) with lots of disposibale income.

A database was created and sql requests were conducted to answer the questions for routing. The resulting database was accessed via the psycopg2 for python.

Three different plans were designt using the travelling salesman problem, getting routes using the GIP (street network of Vienna) for taxi rides, estimating the costs and visualizing the routes using a python jupyter notebook.

Since the course is in german, der comments and explanations in jupyter are in german.

### Data Sources
The POI dataset can be found [ogd platform austria](https://www.data.gv.at/katalog/dataset/stadt-wien_toplocationsinwien#resources) as well as the [street network](https://www.data.gv.at/katalog/dataset/1039ed7e-97fb-435f-b6cc-f6a105ba5e09#resources). AirBNB data was downloaded from [insideairbnb](http://insideairbnb.com/).