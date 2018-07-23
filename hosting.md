# Hosting

So far you've run the web app on your own computer. To enable others to access your blog you'll have to set up a hosting provider which will serve your website to the public.

In this exercise we're going to use Heroku as a hosting provider, which is fairly easy to set up and use.

## Heroku CLI

First of all, let's check if heroku cli is properly installed, open up a terminal window and type

```bash
heroku --version
```

If you get something similar to this, everything's ok:

```
heroku/7.0.0 (darwin-x64) node-v8.0.0
```

If not, don't worry, we'll help you.

## Sign up for Heroku

Go to [the Heroku website](https://www.heroku.com/), click on Sign up in the upper right corner and follow the instructions. After you signed up and confirmed your email address you'll end up on the Heroku dashboard.

Here you'll see the "Create New App" button on the middle of the page, click on it.
s
![](assets/heroku-new-app.png)

Use a unique app name, e.g. your name + my_blog. Choose Europe for the region. Click on the "Create new pipeline" button, and leave the default values. Finally click on the "Create app" button. Remember the name of the app; you'll need it later.

## Set up the database

Heroku supports PostgreSQL by default so we'll use that for this exercise.

First go to the Resources tab in Heroku in your app, and start typing `postgres` in the Add-ons search field. After the result shows up, click on it, then choose "Provision" in the pop-up.

![](assets/heroku-postgresql.png)

After the database created go back to the terminal window and type the following command:

```bash
heroku config
```

Find the line which starts with `DATABASE_URL:`. That's the address of your database, copy it.

The URL must be copied to the `config/database.yaml` file. Find the line which starts with `development:`, and replace it with the following:

```yaml
development:
  <<: *default
  url: <DATABASE_URL>
```

So the file should look something similar:

```yaml
# SQLite version 3.x
#   gem install sqlite3
#
#   Ensure the SQLite 3 gem is defined in your Gemfile
#   gem 'sqlite3'
#
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  <<: *default
  url: postgres://svfawfohwfroqf:80eb434d22a1a43db079cf7267306bf8d58f48cb5e3bbf7b7613e8fe949d0223@ec2-54-228-251-254.eu-west-1.compute.amazonaws.com:5432/d1acbdvgg7v1e0

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: db/test.sqlite3

production:
  <<: *default
  database: db/production.sqlite3
```

Edit the file named `Gemfile`, and replace the following line:

```ruby
gem 'sqlite3'
```

With this:

```ruby
gem 'pg'
```

Then run

```bash
bundle install
```

Migrate the database to the new place:

```bash
ruby bin/rails db:migrate
```

If this runs without an error, you have set up your database in Heroku correctly.

## Deploy your app

Great, now you have an app and a database on Heroku. Now it's time to deploy your blog to Heroku.

Open a terminal in the folder of your Rails application and run the following commands.

First you have to sign in, use your credentials:

```bash
heroku login
```

Then, you'll have to set up Heroku as a git remote:

```bash
heroku git:remote -a <your app name>
```

Finally, you can deploy the application:

```bash
git push heroku master
```

This will take a while, but after it's finished, you'll be able to access your own blog at `https://<your app name>.herokuapp.com/`

Enjoy!
