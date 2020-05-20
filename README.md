# Pet Adoption Site

### Shelters

Within this project, Users are able to create, update, and delete shelters. These shelters can have pets which can also be created, updated and destroyed. Users can see a list of all shelters, as well as seeing a shelter's details on its show page. from this show page users can update/destroy a shelter and leave a review with an optional photo for the shelter. Reviews must include a title, a rating, and the content of the review. After being created, reviews can be edited or deleted from links in the shelter's show page. From this page users can find a link to view all the adoptable pets at the shelter. The show page also includes statistics for the shelter such as average review rating, number of pets, and number of applications for pets. When a shelter is deleted, all of its pets and reviews are deleted as well.

### Pets

Pets can be viewed in an index page of all pets, in an index page that shows all pets for a particular shelter, or in a show page which has all of an individual pet's details. Pets can be favorited from a pet's show page, or removed from favorites if they are already in favorites. An indicator in the navigation bar will indicate how many pets are currently in favorites. User's can access the favorites page by clicking on this favorites indicator. From the favorites page, users can see the pets they have favorited, as well as a list of all pets with applications. Pets can also be removed from favorites from the favorites page.  Users will see a link for 'New Application' on this page. Clicking this link brings users to a form where they can apply to adopt one or more of their favorited pets. 

### Applications

When an application is successfully submitted, all the pets included in the application are removed from favorites and the application is saved. The pets will be added to the list of pets with applications if they are not already included in this list. Clicking a pet's name from this list takes you to the pet's show page. There is a link on this page to view all names of applications that include this pet. Clicking on a name on this list brings you to the application where the application's details are shown. 

### Application Approval
The page will also have names of all pets that the application is for, and each pet has a link to approve the pet for this application. When an application is approved for a pet, this pet cannot be approved for any other applications. If I view other applications for this pet, I will see a message indicating that the pet is pending adoption by another applicant. When I visit the show page for a pet that has been approved for adoption, I will see the pet's adoption status listed as Pending, and I will see a message saying that the pet is on hold for the name associated with the approved application. (i.e. On hold for Kyle if Kyle was the name on the application) If a pet has any approved applications it cannot be deleted, it will show an error message to a user if they try to delete it. Likewise, if a shelter has any pets with approved applications, that shelter will not be able to be deleted either and will show an error message to the user letting them know that the shelter has approved applications. 

## Getting Started

* Click "Fork" in the upper right hand corner of the page
* Follow instructions below: 
```sh
git clone git@github.com:YOUR_USER_NAME_HERE/adopt_dont_shop_2003_production.git
cd adopt_dont_shop_2003_production
  - `bundle install`
  - `bundle update`
  - `rake db:{create,migrate,seed}`
```

### Check your Ruby version

```
ruby -v
```
The output should start with something like `ruby 2.5.3`

If not, install the right version using rbenv

```
rbenv install 2.5.3
```


## Running the tests

Run `bundle exec rspec` to run all tests


## Built With

* Ruby
* Rails


## Authors

* **Rostam Mahabadi**
* **Kyle Iverson**
