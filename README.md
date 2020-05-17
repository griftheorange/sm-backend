# SeisMix Backend - README

## Settup
Backend for SeisMix, Rails API server. Ruby Version 2.6.1

After pulling, run bundle to install required gem packages.

Then, run the following terminal commands:

- $=> rails db:create
- $=> rails db:migrate
- $=> rails db:seed
- $=> EDITOR="code --wait" rails credentials:edit
**NOTE: replace 'code' in the line above with your text editor of choice (e.g. atom, vim, etc.)

The last command should open up a credentials.yml file for you to edit. In this file, insert the following code:

hmac:  
    secret_key: "my personal secret key"

The string can be replaced with anything you like, but it is the key for your local pull that ecrypts the JWT tokens for Authorization. This will not be saved to github, so remember it, or be prepared to reset it if you ever re-clone.

Once all this is done you should be set to authorize and run with cloudinary, run "rails s" to boot your server up on localhost:3000. Go to http://localhost:3000/users to check if your files seeded properly. You should see: 


    [
    {
        "id": 1,
        "username": "g",
        "address": null,
        "image_url": null,
        "radius_concern": null,
        "bookmarks": [],
        "comments": []
    }
    ]

The password for this profile is "g" if you want to test the login, or you can make a new account


## Models
The model tree for the backend is as follows: 

Users -< Bookmarks


Users -< Comments >- CommentedQuakes


### Users:

The users model has many comments, and many bookmarks. The user keeps track of the following attributes: 

  - Username
  - BCrypt digested password
  - Address (default nil)
  - Radius Concern (default nil)
  - Profile Image URL (default nil)
  - Public Image ID (default nil)
  
Currently, users are permitted to update everything except their password. Of note is the image URL and the public image id. They are always changed together. When a user uploads an image, it is sent to a Cloudinary server to host which returns a URL to access the image, and a public id to manipulate the image on the DB. If a user changes their profile pic, the backend uses the id to delete the old from the server, then updates the URL and id with the new values returned by Cloudinary.

### Bookmarks: 

Bookmarks belongs to a User exclusively. Bookmarks store the following attributes:

- Quake USGS Database ID
- Location (place)
- Time of Occurrence (dateAndTime)
- Magnitude
- User's ID
- Latitude
- Longitude

Many of these values could be accessed through the quake USGS id by fetching for that quake at any given time, yet these attributes are persisted for rendering lists of bookmarks to avoid excessive number of fetches on the frontend. Data that will be rendered on detail cards in a list is persisted to the backend for efficiency purposes. The db_id allows for a bookmark card to link to it's associated event, and the user_id associates it with a given user.

### Comments: 

Comments belong to a user and a commented_quake object. Their attributes are: 

- User ID
- Commented Quake ID
- Date of Posting
- Content
- Quake Name
- Quake Mag

Again, much of this data is persisted to aid in rendering lists of comments with their relavent information to avoid excessive fetches on the frontend. The ID attributes associate the comment with its user of origin and the event it refers to.

### Commented Quakes:

Commented quake objects exist to avoid persisting objects on the backend for every event present on the USGS database. Their attributes are only: 

- Quake Database ID

A seismic event will only have a corresponding CQ object if it is commented on. When a comment for an event is created, the backend first searches for a corresponding CQ. If none exist it creates a new one, then associates a new comment with it. If it finds a matching CQ, it is able to associate the new comment with the found quake. This implementation reduces DB bloat on the backend and improves resposne times of quake comment fetches as the app scales up.
