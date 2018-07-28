class PostsController < ApplicationController
    def new
    end

    def index
        @posts = Post.all
    end

    def show
        @post = Post.find params["id"]
    end

    def create
        post = Post.new

        post.title = params["title"]
        post.content = params["content"]

        post.save

        redirect_to post
    end
end
