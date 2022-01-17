A Rack-Only Learning Project App

The goal is to code a minimalist Ruby app without using a framework that can track and interpret Covid Cases. The intention is to learn the fundamentals that modern frameworks obscure, i.e. how to script a server, its ports, etc. from scratch.

In theory, this app can:
- retrieve updated Covid data for Ontario
- render pie chart of cities (AMcharts)
- render heatmap on cities with active cases (GoogleMaps API)
- do all renderings asynchronously

In practice:

I discovered that the data I was working with did not provide location data
so I've taken out the heatmap portion and now it's simply an amChart. Moving on! 
