# Pet-Manager

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Meet your pets needs through this app! Owners (and friends) can join a workspace where they can keep updated on their favorite pets life! You can set notifications to set reminders to feed them, walk them, etc., share pictures, and takes notes of any health related things!

### App Evaluation

- **Category:** Productivity
- **Mobile:** Convenient for tracking pet stuff
- **Story:** Creates a team between pet, parent and friends. 
- **Market:** Any pet parent who wants their friends to be involved and also to help keep track of what their pet is up to. 
- **Habit:** Pet parents and friends can constantly check to see how their pet is doing so they can live worry-free. 
- **Scope:** A pretty wide focus because this is focusing on the whole pet lifestyle. Pet owners and pet lovers :)) 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User can create an account
- [x] User can login
- [x] User can logout
- [x] User can add pets
- [x] User can post notes about their pets
- [] User can view a feed of these posts 
- [] Co-owners can share the same workspace for their pets

**Optional Nice-to-have Stories**

- [] Other users who care not owners of your pet can join your workspace
- [] User can add other remarks to their post about their pets' walks (and also for the other ones like playing, feeding, cleaning up, etc.)
- [] User can track when they play with their pets
- [] User can set up a reminders to play with their pets

## Video Walkthrough

Here's a walkthrough of implemented user stories:

# Sprint 1
<img src='http://g.recordit.co/JXKz0O2705.gif' title='Sprint 1 walkthrough' width='' alt='Sprint 1 walkthrough' />

# Sprint 2
<img src='http://g.recordit.co/Af5ZQYJzm6.gif' title='Sprint 2 walkthrough' width='' alt='Sprint 2 walkthrough' />


### 2. Screen Archetypes

* Login
    * User can login
* Registration Screen
    * User can create an account and add their pets
* Home Feed
    * User can view updates about their pets (not health)
    * User can check to see if their pet has been walked/fed/etc.
* Creation
    * User can post/write updates about their pets
    * User can quickly say whether they have fed/walked their pets
* Health Feed
    * User can view updates about their pets health
* Add more pets
    * User can add pets if they need to

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Feed
* Health Feed
* Add more pets

**Flow Navigation** (Screen to Screen)

* Login Screen
    * => Home Feed
* Registation Screen
    * => Home Feed
* Home Feed
    * => Creation
* Health Feed
    * => Creation

## Wireframes
<img src="https://github.com/Pet-Manager/Pet-Manager/blob/main/wireframe.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

# Schema

### Models

#### Post

| Property     |  Type          | Descrption |
| --------     | --------       | --------   |
| objectId     | String         | unique id for the user post      |
| author       | pointer to User| display author's name |
| image        | File           | image that user posts |
| caption/text | String         | caption of author |
| createdAt    | DateTime       | date when post is created |
| isHealth     | boolean        | marks posts as health related |
| pet          | pointer to Pet | displays pet name |

#### Pet

| Property |  Type    | Descrption |
| -------- | -------- | --------   |
| objectID | String   | unique id for the user's pet       |
| name     | String   | name of the pet |
| image    | File     | profile image of pet |


#### User 

| Property |  Type                 | Descrption |
| -------- | --------              | --------   |
| objectID | String                | unique id for the user |
| name     | String                | name of user |
| image    | File                  | image of user
| username | String                | username of user|
| password | String                | password of user
| pets     | Array? pointer to Pet | user's pet(s)
| posts    | Array?                | array of posts by user

### Networking

#### Lists of network requests by screen

* Login/Sign Up 
    * (Create)
    * (Read/GET) Fetch user information if they click login to make sure they are valid 
        ``` swift
        let query = PFQuery(className:"User")
        query.whereKey("username", equalTo: username)
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
           if let error = error { 
              print(error.localizedDescription)
           } else if let user = user {
              print("Successfully retrieved \(posts.count) posts.")
          // TODO: Do something with posts...
           }
        }
        ```
    * (Update)
    * (Delete)
* Sign Up
    * (Create/POST) Create new user

        ``` swift
        let user = PFObject(className:"User")
        user["name"] = "Yihui"
        user["image"] = something.png
        user["username"] = "yihuiliao"
        user["password"] = "password"
        user.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }

        ```
        
* Home
    * (Create)
    * (Read/GET) Fetch user's posts for feed
        ``` swift
        let query = PFQuery(className:"Post")
        query.whereKey("author", equalTo: currentUser)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
           if let error = error { 
              print(error.localizedDescription)
           } else if let posts = posts {
              print("Successfully retrieved \(posts.count) posts.")
          // TODO: Do something with posts...
           }
        }
        ```
    * (Read/GET) User's pet(s) images
        ```swift
        let query = PFQuery(className:"Pet")
        query.whereKey("petName", equalTo:"Sean Plott")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    print(object.objectId as Any)
                }
            }
        }
        
        //we want to get all the user's pets 
        //need a for loop? and iterate through each pet and 
        //get their image and put them on top of the screen
        ```
        
    * (Update) Update feed with user's posts
        ```swift
        let query = PFQuery(className:"User")
        query.getObjectInBackground(withId: user.objectID) { (Pet: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let post = post {
                //update feed
                post.saveInBackground()
            }
        }
        ```
    * (Delete)
* Health
    * (Create)
    * (Read/GET) Fetch user's posts that are marked as health for feed
        ``` swift
        let query = PFQuery(className:"Post")
        query.whereKey("author", equalTo: currentUser)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
           if let error = error { 
              print(error.localizedDescription)
           } else if let posts = posts {
              print("Successfully retrieved \(posts.count) posts.")
          // TODO: Do something with posts...
           }
        }
        ```
    * (Update) Update feed with user's posts 
        ```swift
        let query = PFQuery(className:"User")
        query.getObjectInBackground(withId: user.objectID) { (Pet: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let post = post {
                //update feed
                post.saveInBackground()
            }
        }
        ```
    * (Delete)
* Post
    * (Create/POST) Create new post object
        ```swift
        let post = PFObject(className:"Post")
        post["author"] = userPointer
        post["caption"] = "I love my cat"
        post["image"] = something.png
        post["isHealth"] = false
        post["createdAt"] = 10:11:12
        post["pet"] = petPointer
        post.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
        ```
    * (Read)
    * (Update)
    * (Delete)
* Add Pets
    * (Create/POST) Create new pet 
        ``` swift 
        let pet = PFObject(className:"Pet")
        pet["name"] = "Sneakers"
        pet["image"] = pet.png
        pet.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
        ```
    * (Read)
    * (Update) Update user's pet 
        ``` swift
        let query = PFQuery(className:"Pet")
        query.getObjectInBackground(withId: user.objectID) { (Pet: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user {
                user["pets"].add(pet) //add pet pointer to pet array
                pet.saveInBackground()
            }
        }
        ```
    * (Delete)

