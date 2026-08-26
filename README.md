# Welcome to My Users App
***

## Task
In this project, I created a full-stack web application called *My Users App* using Ruby, Sinatra, and SQLite3 following the Model-View-Controller (MVC) architecture. The objective of this project is to build a complete user management system capable of handling user authentication, session control, and full CRUD (Create, Read, Update, Delete) operations.
Each part of the project addresses a specific responsibility:
my_user.rb: implemented the User model class to interact directly with the SQLite database for user operations
app.rb: configured the Sinatra controller, defined RESTful routes, and handled session-based user authentication
views/index.erb: designed the view template to render the user interface dynamically in the browser
my_user_app.sql: created the database schema to store user records
## Description
To solve this task, I organized the application into clean MVC layers. In the model, I wrote custom methods with SQL queries to handle database interactions such as user creation, retrieval, password updates, and record deletion. In the controller, I set up Sinatra routes to process incoming HTTP requests (GET, POST, PUT, DELETE), manage user session cookies for signing in and out, and return appropriate responses. I verified all endpoints using curl commands and confirmed that database state and session cookies functioned properly.
## Installation
To run this project, ensure you have Ruby installed on your machine. Install the required gems by running gem install sinatra sqlite3 in your terminal. No additional database installation is required as SQLite3 operates directly with local database files.
## Usage

To use this project, start the application server by executing ruby app.rb in your terminal. You can access the interface by opening http://localhost:4567 in your web browser. Alternatively, you can test authentication and user management endpoints by sending HTTP requests using curl or Postman.
```
./my_project My_User_App
```

### The Core Team

abdullaz_a
<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
