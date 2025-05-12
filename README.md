# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Dev
- run `exec rails s -p 3000` to start server


# Create individuals
john = Individual.create(first_name: "John")
jane = Individual.create(first_name: "Jane")

# Create relationship type
parent_type = RelationshipType.create(name: "parent")

# Create relationship
Relationship.create(individual: john, relative: jane, relationship_type: parent_type)