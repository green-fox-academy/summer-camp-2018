# Getting started with Rails

Ruby on Rails is a so called framework, which means that it contains commonly used functions so you can focus on building the custom parts of the application.

## Install rails if you don't have it already

Open a terminal and type

```bash
rails -v
```

If you get something similar, you're good to go:

```
Rails 5.2.0
```

If not, you can install rails using the `gem` command:

```bash
gem install rails
```

## Create a new rails project

Most of the time when you start a Rails project you'll use the code generation feature of the framework. Easily type:

```bash
rails new blog
```

This will create a new rails project named `blog` into a new folder called `blog`.

This will take a few seconds. After it's finished check out the `blog` folder: a lot of files and folders are generated for you. Most of the files are empty. The main point is that the structure of the application is generated. Since most Rails apps are created this way every time you start working on a Rails project you'll already know where to find certain files.

Let's fire up the web app!

```bash
cd blog
ruby bin/rails server
```

Rails comes with a built-in webserver so you don't have to worry about setting up your own. The server starts on your computer, and you'll be able to access it from a browser through `http://localhost:3000`. Here `localhost` means your own computer. You should see the default Rails greeting page.

## Look around

Open the `blog` folder in VS Code.

There are quite a few folders here, but you don't have to worry about them, we'll use only some of them:

- The `app` folder contains your applications code, and
- The `config` folder contains configurations for the server

Ignore the other folders for now.

Open the `app` folder, this is where we'll spend most of our time.

The `views` folder contains files related to presentation, mostly HTML and CSS, you are already familiar with these.

The `controllers` folder contains your Controllers which are responsible of handling HTTP requests.

The `models` folder contains the Models which represents the data in your application.

Ignore the other folders for now.

## Home page

So our app is pretty much empty; let's create a simple home page!

First let's create the presentation for the page, which should go under the `views/home` folder; therefore, create a new folder called `home` under `views` and a new file called `index.html.erb`:

```html
<h1>My own blog</h1>
<p>This is the home page</p>
```

We'll add details later.

To handle incoming requests let's create a new file called `home_controller.rb` under `controllers` named `HomeController`.

```ruby
class HomeController < ApplicationController
    def index
    end
end
```

A `class` is basically just a bunch of methods and variables grouped together.

Finally, let's tell Rails that this is our home page. Open `/config/routes.rb` and add the following line to the middle of the file.

```ruby
root 'home#index'
```

This will tell Rails that the root page (which is the home page) is handled by the `HomeController`'s `index` *action*. An action is basically a function of a controller.

Now if you refresh your page in the browser you should see your own content.

## View: HTML with benefits

You probably noticed that the view files have `.html.erb` extension, which is kind of strange at first. These are generally HTML files, as the name suggests, but you can also include Ruby code in them. (`.erb` stands for Embedded Ruby)

Try something like this in `index.html.erb`:

```html
<p>
    <%= 3 + 2 %>
</p>
```

Refreshing the page you'll find 5 printed out. So as you can see, wherever you need Ruby you can add `<%= ruby code %>` and it will be interpreted as Ruby code.

Of course you'll want to minimize the Ruby code in the View layer as it's main purpose is presentation, so usually you won't find calculations in these files.

Instead, you should use the Controller.

Let's change the `HomeController`:

```ruby
def index
    @result = 2 + 3
end
```

And change the view accordingly:

```html
<p>
    <%= @result %>
</p>
```

The at sign (`@`) before the variable `result` means that the variable is accessible outside of the function; therefore, it is accessible from the view as well.

This is the common way of splitting application code: do every calculation in the controller and use variables to pass data to the view.