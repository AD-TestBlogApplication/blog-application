# README

## Blog application(test app)
Blog application where multiple users can create posts, comment on posts, and react to them.

### Requirements for the test app
* Use a MySQL database for storing data.
* Build the schema for the database tables that we need for the Blog application described
above
* Documentation for running application
* Git repository containing application code

### Provided the following functionality:
* Fetch / list all posts made by one user
* Fetch / display a single post
* Create, update, and delete posts
* Fetch / list all comments for a post together with the reactions on these comments
* Create, update and delete comments on one post
* Create and delete reactions for one comment. (Implemented reactions are like, and dislike.)

### Implementation description
4 models were created:
* <b>`User`</b><br /> 
The `User` model includes devise functionality<br /> 
Users have two roles: `admin` and` client`<br /> 
Users with the `admin` role are required to implement the admin panel (<b> #TODO </b>: Implement admin panel)<br /> 
Users have many posts, comments, and emotional reactions with cascading deletion.<br /> 
In addition to the basic devise fields, users have the required fields `first name` and `last name`.

* <b>`Post`</b><br /> 
The `Post` model is bound to the User model through the `user_id` field<br /> 
Posts have many comments, and emotional reactions with cascading deletion.<br /> 
Mandatory content field with a limit of 10,000 characters.

* <b>`Comment`</b><br /> 
The `Comment` model is bound to the User model through the `user_id` field<br /> 
Comments have a `commentable` polymorphic association.<br /> 
This is represented as two fields in the database: `commentable_id` and `commentable_type`, where `commentable_id` is the `primary_key` of the record being commented, and `commentable_type` is the class name of the record being commented.<br />
Comments have many emote reactions with cascading deletions.<br /> 
Mandatory content field with a limit of 1,000 characters.

* <b>`EmoteReaction`</b><br /> 
The `EmoteReaction` model is bound to the User model through the `user_id` field<br /> 
Emote reactions have a `emotionable` polymorphic association.<br /> 
This is represented as two fields in the database: `emotionable_id` and `emotionable_type`, where `emotionable_id` is the `primary_key` of the record being emote reacted, and `emotionable_type` is the class name of the record being emote reacted.<br />
Emote reactions have two kinds: `like` and` dislike`<br />
Validation for the `user_id` in the scopes of `emotionable` and `type`. This prevents the possibility of creating duplicate emote reactions from users.

<hr>

### JSON API
In addition to the client side, the `JSON API` was implemented, which is available in the` API` namespace: <br />
<i>`/api/**/*`</i>

User authentication is done using `JWT`.

List of available endpoint:
* <b>`POST`</b> <i>`/api/users/sign_up`</i>
* <b>`POST`</b> <i>`/api/users/sign_in`</i>
* <b>`GET`</b> <i>`/api/users/:user_id/posts`</i>
* <b>`POST`</b> <i>`/api/posts/:post_id/comments`</i>
* <b>`POST`</b> <i>`/api/posts/:post_id/emote_reactions`</i>
* <b>`GET`</b> <i>`/api/posts`</i>
* <b>`POST`</b> <i>`/api/posts`</i>
* <b>`GET`</b> <i>`/api/posts/:id`</i>
* <b>`PATCH`</b> <i>`/api/posts/:id`</i>
* <b>`PUT`</b> <i>`/api/posts/:id`</i>
* <b>`DELETE`</b> <i>`/api/posts/:id`</i>
* <b>`POST`</b> <i>`/api/comments/:comment_id/emote_reactions`</i>
* <b>`PATCH`</b> <i>`/api/comments/:id`</i>
* <b>`PUT`</b> <i>`/api/comments/:id`</i>
* <b>`DELETE`</b> <i>`/api/comments/:id`</i>

## Ruby version
ruby 3.0.0

## Rails version
Rails 6.1.3.2

## Configuration
* Step 1: Install gems with `bundle install`

## Database initialization
* Setup DB with seeds by `rails db:setup` command

## How to run the test suite
`bundle exec rspec`

## How to run the app
`bin/webpack-dev-server & rails s -p3000 -b 0.0.0.0`
