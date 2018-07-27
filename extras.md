# Extra Exercises

Since you're already doing well, in this part we wont give you detailed instructions on how to solve these exercises.

## Delete Posts

The users should be able to delete their posts. Create a new link on the post page with the text "Delete". Clicking on this button should delete the post and redirect to the post listing page.

## Add comments

Users should be able to comment every post. To achieve this, you have to

- Create a new model named `Comment`
    - The `Comment` model `belongs_to` the `Post`, this is called a relation
- Update the `config/routes.rb` to handle comments
- Create a new Controller for the comments
- Create/update the required views
