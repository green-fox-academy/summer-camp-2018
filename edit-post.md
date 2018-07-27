# Edit Posts (extra)

If you've finished every previous exercise and have a bit more time, you can continue working on editing posts.

The URL for the edit page is `/posts/:id/edit`, where the id is the unique identifier of the blog post you want to create; therefore, we'll have to create a new action called `edit` in the controller and view.

## Controller

First of all, create the controller for this page.

```ruby
class PostsController < ApplicationController

    ...

    def edit
        @post = Post.find params["id"]
    end
end
```

We're reading the post from the database with the specific `id` and assigns it to the variable named `@post`.

## Presentation

Next, let's create the frontend part of the edit. Create a new file named `edit.html.erb` under `views/posts` with the following content:

```html
<h2>Edit a blog post</h2>
<p>
    <%= form_with model: @post, local: true do |form| %>
        <%= form.label 'Title' %>
        <%= form.text_field 'title' %>
        <%= form.label 'Content' %>
        <%= form.text_area 'content' %>
        
        <%= form.submit 'Save' %>
    <% end %>
</p>
```

The new part here is that we're creating a form with a model, this way the post data will be automatically filled into the form.

## Processing the form data

To process the form we have to implement the `update` action.

```ruby
class PostsController < ApplicationController
    
    ...

    def update
        @post = Post.find params["id"]

        @post.title = params["post"]["title"]
        @post.content = params["post"]["content"]

        @post.save

        redirect_to @post
    end
end
```

So this is a but tricker. First, we read the current version of the post from the database, update the properties based on the user input, then save the post to the database.

Yet again, we redirect to the edited post page.