# My First Blog

By now you know enough about Rails to start creating your own blog.

## Set up routing

Routing binds the path of the HTTP request with the Controller, e.g. it tells that the path `/posts/new` route should be handled by the `new` function of the `PostsController`.

Open up `config/routes.rb` and add the following line before `end`:

```ruby
resources 'posts'
```

So the whole file should look similar to this:

```ruby
Rails.application.routes.draw do
    resources 'posts'
    root 'home#index'
end
```

This will set up a few routes for you, among others:

| Verb | URI             | Controller#Action | Purpose                        |
|:-----|:----------------|:------------------|:-------------------------------|
| GET  | /posts          | posts#index       | List all posts                 |
| GET  | /posts/:id      | posts#show        | Show an existing post          |
| POST | /posts          | posts#create      | Save a new blog post           |
| GET  | /posts/new      | posts#new         | Input form for the post        |
| GET  | /posts/:id/edit | posts#edit        | Edit form for an existing post |

## Creating a new blog post

The first page we'll create is the new blog post page, which is handled by `posts#new` as mentioned above.

Create a new file called `posts_controller.rb` and add:

```ruby
class PostsController < ApplicationController
    def new
    end
end
```

After that let's create the view for the page. Add a new folder under `views` named `posts`, and create a new file named `new.html.erb`.

```html
<h2>Create a new blog post</h2>
<p>
    <form action="/posts" method="post">
        <label for="Title">Title</label>
        <input type="text" name="title" id="title">
        <label for="Content">Content</label>
        <textarea name="content" id="content"></textarea>
        
        <button type="submit">Save</button>
        <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">
    </form>
</p>
```

The `authenticity_token` hidden field is there to protect the website against CSRF attacks. It's fine if you don't understand this part of the exercise, there is already a lot to cover, and you can come back later and learn more about web security.

You can also use Rails helper functions to create your form:

```html
<h2>Create a new blog post</h2>
<p>
    <%= form_with url: '/posts', local: true do |form| %>
        <%= form.label 'Title' %>
        <%= form.text_field 'title' %>
        <%= form.label 'Content' %>
        <%= form.text_area 'content' %>
        
        <%= form.submit 'Save' %>
    <% end %>
</p>
```

Open up the `/posts/new` page and see what we just created.

Check out the result using the Chrome Developer tools using `Control+Shift+I` on Windows or `Command+Option+I` on Mac. You'll see that Rails created a `<form>` for you with a `<input>` and a `<textarea>` for you. Pretty handy!

The result is really ugly so far, but don't worry, you'll have time to make it prettier later today.

### Handle the user input in the Controller

Now that we have a form, we need to handle the user input. We'll use the `create` function of our controller.

In the controller we have the `params` Hash which contains every input param submitted by the user:

```ruby
class PostsController < ApplicationController
    def new
    end

    def create
        render plain: params["title"] + " " + params["content"]
    end
end
```

The `render plain:` means to skip the view layer and send back `params["title"] + " " + params["content"]` as plain text.

Go ahead and try to save a new blog post using the `/posts/new` page, you should see the title and content printed out in plain text.

### Save the data

The only remaining task is to save `params["title"]` and `params["content"]` to the database. To achieve this we're introducing our first **Model**.

This time, to make things easier we'll be using Rails' command line to generate the Model for us. It'll also set up the database automatically, so we don't have to worry about that at all.

Go to the terminal and type the following command:

```bash
ruby bin/rails generate model Post title:string content:text
```

It created a few new files, e.g. the Model in `app/models/post.rb` and the so called migration required to create the database automatically. To apply the migration and create the database, use the following command:

```bash
ruby bin/rails db:migrate
```

Our database is created and now we can use the Model to save the Post. We're changing the `create` function:

```ruby
    def create
        post = Post.new
        post.title = params["title"]
        post.content = params["content"]

        post.save

        redirect_to post
    end
```

We're creating a new `Post`, setting the `title` and `content`, then we're saving it. Everything else is handled by Rails in the background.

I've also added a `redirect_to` function call at the end of the `create` function to redirect the user to the `show` page after saving the Post. But we don't have that page just yet; we have to create it first.

### Showing a saved blog post

We've finished the saving part of the app, now we have to show one of the saved posts. To do that we have to write the `show` function of the Controller:

```ruby
class PostsController < ApplicationController
    def new
    end
    
    def create
        ...
    end

    def show
        @post = Post.find params["id"]
    end
end
```

We're using the `find` function of our model which will read the post from the database based on it's identifier (`id`). Note that we haven't told Rails anything about an `id`, it was generated automatically by the framework for convenience. It's an Integer which is unique for every post we create.

We have the post read from the database and it's assigned to the `@post` variable.

To present the post we have to create the view for this page, so create a new file named `show.html.erb` under `views/posts`.

Add the following content:

```html
<h2>
    <%= @post.title %>
</h2>
<p>
    <%= @post.content %>
</p>
```

Now if you open up e.g. `/posts/1` in the browser you'll see your first blog post. It's very ugly, no worries, you'll fix that later.

## List every blog post

The only thing left is to list every blog post saved so far. To do this we'll have to create a new function in our Controller called `index`:

```ruby
class PostsController < ApplicationController
    def index
        @posts = Post.all
    end

    ...
end
```

Here we're using the `all` function of the model to read every post from the database. `@posts` is an Array here, and as you may remember we can use the `each` function to present every post.

To show the posts to the user we'll have to create the view for this page. Create a new file named `index.html.erb` under `views/posts`:

```html
<h2>Every blog post</h2>
<% @posts.each do |post| %>
    <p>
        <h3>
            <%= post.title %>
        </h3>
        <p>
            <%= post.content %>
        </p>
    </p>
<% end %>
```

After creating this file you can open up your site at `/posts` and you should see every blog post you created so far.

Go ahead and create a few more using `/posts/new` page and come back to the `/posts` page to see the newly created blog posts.

## Wrapping up

We've created the `/posts/new`, `/posts/:id` and the `/posts` page, now we have to link them together for the user.

First open up the `index.html.erb` and add links to the create pages:

```html
<%= link_to "Create a new blog post", action: "new", controller: "posts" %>
```

And for every post add a new link to it's own show page:


```html
<%= link_to "Show post", action: "show", controller: "posts", id: post.id %>
```

Now open `show.html.erb` and `new.html.erb` and create links to the other pages on your own.

## Summary

We have a terribly ugly, but functioning blog. Next up is to pimp up the blog in your own style.