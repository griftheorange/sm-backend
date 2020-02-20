# README
Backend for SeisMix, Rails API server. Ruby Version 2.6.1

After pulling, run bundle to install required gem packages.

Then, run the following terminal commands:

- rails db:create
- rails db:migrate
- rails db:seed
- delete the credentials file at config/credentials.yml.enc
- EDITOR="code --wait" rails credentials:edit
**NOTE: replace 'code' in the line above with your text editor of choice (e.g. atom, vim, etc.)

The last command should open up a credentials.yml file for you to edit. In this file, insert the following code:

hmac:
  secret_key: "my personal secret key"

The string can be replaced with anything you like, but it is the key for your local pull that ecrypts the JWT tokens for Authorization. This will not be saved to github, so remember it, or be prepared to reset it if you ever re-clone.


* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
