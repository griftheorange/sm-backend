# README
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




