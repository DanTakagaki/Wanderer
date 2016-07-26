# Wanderer

The application is divided into two main flows:

- The World: where users can see the latest post of interest in Flickr .
- My Favorites: where users can group up those volatiles post (based on Flickr API) and save them for later enjoyment.

In the first flow. A user can add search between the collection of articles by scrolling or by using the search
bar on the top. This will find in an iterative way, articles by name or description. 
Also, the user can add or remove articles from their favorite seccion by clicking on the top right part of the cell.

At the second flow. The user can se a zoomed image of the article and also see more detailed information provided via FLickr API. This flow persist data saved between sessions.
And the user can remove an article from his favorites by clicking on the top right button.


Architecture

The app is founded in a MVC structural pattern.

The MODEL part consists fetching articles from Flikr API, hidratating the models and DTO´s (data transfer objects) through the different views. Also, making capable to interact with Core Data object allowing the data persistency layer to save articles.
For the data persistency we are using Core Data witch is managed trough a Singleton class. Which is the one that mantain the favorite section in sync and saved. 

The VIEW is conformed by a storyboard that explicitly shows the app flow. It only hold the visual part and layouting for Universal devices setting of the program.

---TabBar(list of objects)->Detail view of Object---

The CONTROLLER part, formed by a group de controllers (one per each view) work together to manage and coordinate view changes triggered by  the view events and mantain the Model part on sync with its view representation of data


NOTE: The use of  third party libraries and facilitators has been added using a dependency manager called Cocoapods, to reduce development time and give  abetter end wuality of the app UX.





