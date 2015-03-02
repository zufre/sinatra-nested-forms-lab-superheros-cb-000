# Super Forms Review Rubric

## Navigate First

- Read `README.md` for instructions
- Both the `super_hero.erb` and `team.erb` ERB templates are empty
- `app.rb` doesn't contain any routing information

## RSpec Tests
- Run the RSpec tests, reconcile with the expectations in the `README`
- Failing tests reference status codes, expectations of generated HTML

### `GET '/'`

- First error should be: `sends a 200 status code (FAILED - 1)`

```ruby
    Failure/Error: expect(last_response.status).to eq(200)

       expected: 200
            got: 404
```

- Second error should be: `renders super hero form (FAILED - 2)`

```ruby
    Failure/Error: expect(last_response.body).to include("Create a Team and Heroes!")
       expected "<!DOCTYPE html>\n<html>\n<head>\n  <style type=\"text/css\">\n  body { text-align:center;font-family:helvetica,arial;font-size:22px;\n    color:#888;margin:20px}\n  #c {margin:0 auto;width:500px;text-align:left}\n  </style>\n</head>\n<body>\n  <h2>Sinatra doesn&rsquo;t know this ditty.</h2>\n  <img src='http://example.org/__sinatra__/404.png'>\n  <div id=\"c\">\n    Try this:\n    <pre># in app.rb\nclass App\n  get '/' do\n    \"Hello World\"\n  end\nend\n</pre>\n  </div>\n</body>\n</html>\n" to include "Create a Team and Heroes!"
```

### `POST '/teams'`

- Third error should be: `sends a 200 status code (FAILED - 3)`

```ruby
    Failure/Error: expect(last_response.status).to eq(200)

       expected: 200
            got: 404
```

- Fourth and final error should be: `displays the team info upon submission (FAILED - 4)`

```ruby
    Failure/Error: expect(last_response.body).to include("We love Ruby!")
           expected "<!DOCTYPE html>\n<html>\n<head>\n  <style type=\"text/css\">\n  body { text-align:center;font-family:helvetica,arial;font-size:22px;\n    color:#888;margin:20px}\n  #c {margin:0 auto;width:500px;text-align:left}\n  </style>\n</head>\n<body>\n  <h2>Sinatra doesn&rsquo;t know this ditty.</h2>\n  <img src='http://example.org/__sinatra__/404.png'>\n  <div id=\"c\">\n    Try this:\n    <pre># in app.rb\nclass App\n  post '/teams' do\n    \"Hello World\"\n  end\nend\n</pre>\n  </div>\n</body>\n</html>\n" to include "We love Ruby!"
```

## Fixing the First Error

- This error is a result of a route not existing for the root path. Let's go ahead and make this in `app.rb`.

```ruby
# app.rb
class App < Sinatra::Base
  get '/' do
  end
end
```

- Now the first test should be passing, since `GET '/'` will be returning a 200 status code.

## Fixing the Second Error

- Let's go ahead and have the `GET '/'` method point to our `super_hero.erb` view.

```ruby
# app.rb
class App < Sinatra::Base
  get '/' do
    erb :"super_hero"
  end
end
```

- Currently, we do not have a form for the super heroes set up in our `views/super_hero.erb` template. Let's go ahead and set up the form.
- The test is expecting two things: the response should include both `"Create a Team and Heroes!"`, and the `<form>` tag.

```ruby
# views/super_hero.erb
<h1>Create a Team and Heroes!</h1>

<form action="/teams" method="post">
...
</form>
```

- Once the form is properly set up as shown above, then the test will pass. But the form is not yet complete. Let's complete it below:

```ruby
<h1>Create a Team and Heroes!</h1>

<form action='/team' method="POST">

  <p>
    <label>Team Name:</label>
    <input type="text" name="team[name]" >
    <br>
    <label>Team Motto:</label>
    <input type="text" name="team[motto]" >
  </p>

  <p>
    <h2>Hero 1</h2>
    <label>Hero's Name</label>
    <input type="text" name="team[members][0][name]" >
    <br>
    <label>Hero's Power</label>
    <input type="text" name="team[members][0][power]" >
    <br>
    <label>Hero's Biography</label>
    <input type="text" name="team[members][0][bio]" >
  </p>

  <p>
    <h2>Hero 2</h2>
    <label>Hero's Name</label>
    <input type="text" name="team[members][1][name]" >
    <br>
    <label>Hero's Power</label>
    <input type="text" name="team[members][1][power]" >
    <br>
    <label>Hero's Biography</label>
    <input type="text" name="team[members][1][bio]" >
  </p>

  <p>
    <h2>Hero 3</h2>
    <label>Hero's Name</label>
    <input type="text" name="team[members][2][name]" >
    <br>
    <label>Hero's Power</label>
    <input type="text" name="team[members][2][power]" >
    <br>
    <label>Hero's Biography</label>
    <input type="text" name="team[members][2][bio]" >
  </p>

<button type="submit" name="submit">Submit</button>
</form>
```

## Fixing the Third Error

- The third error is a result of there being no controller verb taking in a post request for the `/teams` URL. Let's go ahead and resolve this in `app.rb`.

```ruby
class App < Sinatra::Base
  ...

  post '/teams' do
    @team = params[:team]
    erb :"team"
  end
end
```

- Now let's move on to the final error.

## Fixing the Fourth and Final Error

- This requires that the submitted data be correctly rendered on the `team.erb` template.
- Let's start building out the `team.erb` template.

```ruby
# views/team.erb
<h1>Team Name: <%= @team[:name] %></h1>

<h3>Team Motto: <%= @team[:motto] %></h3>

<h3>Team Members</h3>
<% @team[:members].each do |member, member_attributes| %>
  <h5><%= member_attributes[:name] %></h5>
  <p><strong>Power</strong>: <%= member_attributes[:power] %></p>
  <p><strong>Bio</strong>: <%= member_attributes[:bio] %></p>
<% end %>
```

That should be enough to make all the tests pass.
