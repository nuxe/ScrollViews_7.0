Vibe.ly
============

tl;dr - Used the Google Places API, the Twitter REST API and set intersection theory to build a live event finding app for iOS 

I made an iPhone app. that helps people figure out what's happening in a city if they're new to it. So what it does is it sends your phone's geolocation to Google; Google returns Points of Interests around your location, and then you send those Points of Interests to Twitter to get back a bunch of tweets about those points of interest. So for instance for location A, I get back 10 tweets from Twitter. So, now I have to select one tweet from those 10 to display to the user. This tweet must convey the maximum amount of information in the given char. limit. 

 I've written an algorithm that uses Set intersections to figure out weights for every tweet, and then display the tweet with the maximum weight.

So what I do is, I create a 2D array <br> 

Tweet | A | B | C | D | Total |
--- | --- | --- | --- | --- | --- 
A | 0 | 5 | 3 | 1 | 9 |
B | 4 | 0 | 3 | 6 | 13 |
C | 2 | 3 | 0 | 2 | 7 |
D | 3 | 4 | 4 | 0 | 11 |


And in Tweet[A][B] I store the value of how many words are common in the tweets A&B(I do this by running a set intersection algorithm on the tweets). So the tweet that eventually gets displayed is the tweet with maximum no. of intersections with the rest of the tweets(max. relevant information) (tweet B in this case).

And then I go on to display the tweet, the user who posted the tweet, a map with your location and where the tweet originated from.

##### PS- All the magic happens in TableViewController.m
