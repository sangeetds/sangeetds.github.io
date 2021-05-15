---
layout: post
title: RESTful APIs with Kotlin and Ktor
date: 2021-05-12 13:32:20 +0300
description: Learn how to use the new Ktor framework to create REST APIs.
img: i-rest.jpg # Add image post (optional)
fig-caption: # Add figcaption (optional)
tags: [Holidays, Hawaii]
comments: true
---

Application Programming Interface or API can be simply
defined as an intermediary which allows two applications to
talk to each other. Over a majority of API are actually
REpresentational State Transfer or REST APIs. You likely
encounter thousands of such APIs in your daily internet
journey, be it searching for videos on YouTube or searching
for someone on Instagram.

REST is an architectural design concept for modelling
and accessing the resource in your application. It's
always advised to follow its rules to run into problems
down the road.

## What are we building
In this tutorial, we will build a simple backend Application
for the pet store. We will expose various endpoints that
will let people get information about the pets in the store,
add a new member to the store or remove them from the store.

## Why Kotlin and Ktor?
Whenever I set out for building out a new
program/application, I look for two things:-

* How hard is the learning curve
* Can it be built with Kotlin?

Kotlin brings all the power of a statically typed language
and provides the sweetest syntax to write the most robust
application. It is designed to be completely interoperable
with Java and shares its tooling with Java. It brings many
advantages over Java, such as type-safety, higher-order
functions, coroutines and much more. Listing all benefits
will make an article in itself.

Ktor is the latest creation from JetBrains, the brains
behind Kotlin. It's an asynchronous web framework that
allows developers to create highly flexible, module and
scalable microservices. Even though it imposes some
conventions, it rests most of the power in the developer's
hands. There are numerous frameworks for Kotlin, but most of
them were actually built for Java. None of their Kotlin
version feels very Kotlin-y or leverages the full power of
Kotlin as much as Ktor does. Being backed by JetBrains, you
can expect excellent support and documentation.

## Setting up the project
Let's begin with setting up the project. I'm using Intellij
IDEA IDE though you can use any IDE of your choice. One
advantage of using Intellij is that it provides many plugins
to quickly set up a project. You can even choose to use [start.ktor.io][ktor-start], Maven or Gradle to set up your project.

## Let's build the server
To run a Ktor application, you need to create a server
first. There's two way to do it:

<!-- ![I and My friends]({{site.baseurl}}/static/img/we-in-rest.jpg) -->

* EmbeddedServer: This is the simplest way to create your server where you can pass different parameters
such as the server type, port, etc., in code and run
the application.
* EngineMain: This provides more flexibility as you
can define the parameters in `application.conf` file in resources, and the server will load the
changes without any recompilation.
* Let's begin with an embeddedServer to create a simple
server. Let's give a look at the `Application.kt`
file in the src directory. It might contain the code for
engineMain if you created the project with the Intellij
plugin. You may replace the code with this code.

<code data-gist-id="60e4bfdf66e7d5e0e32d456eca0f74d3" data-gist-hide-line-numbers="true">/code>

## Let's dissect the code

1. This is the main module of the app. As you can see,
I've not passed `args` as an argument to the
main function. Kotlin provides flexibility over
choosing to pass args as per your requirement.

2. This declares the server using `Netty` which
    will run on port 8080.


3. Routing is a feature which enables us to handle with
    all the incoming requests. Inside this, we can
    define routes.


4. We have defined a route, which will respond to all
    `GET` requests made to. `/`


5. This will treat the HTTP call and respond with a
    text. This tutorial wouldn't do justice if we didn't
    check our server first by replying
    `Hello World!`

6. This would start up the server.

Let's run the application and see whether everything's
working fine or not. Open your browser and go to the
address `localhost:8080` (given you passed 8080 as
the port value). You might see `Hello World!` on your
browser screen. The browser serves as an effective way
to make GET requests but has no mean to make any other
type of requests. Therefore, we will use `cURL` for
making further requests. You can even use Intellij
IDEA's in-built HTTP client or Postman to make requests.
The curl command for making a get request to our current
endpoint will be: `curl localhost:8080`

There are a few changes that we can do our server. Let's
replace the routing endpoints with routing functions
that would match the requests. We will replace our
original route with a `get` function that now only
needs to take the URL and the code to handle the
request.

<code data-gist-id="98264c5624979c580e325ecf5f5c2afd" data-gist-hide-line-numbers="true">/code>

## Let's create our store

Let's have some pets for our store. For that, we will create a
data class in `Pet.kt`. Data class is yet another feature
of Kotlin, which are used for classes that stores data. The
compiler automatically derives field accessors, `hashCode()`,
`equals()`, `toString()`, as well as the useful `copy()` and
`componentN()` functions which reduces a lot of boilerplate code.
Creating a simple Pet class becomes as simple as:

<code data-gist-id="14d45d510d93a1ae718add24e3f5dff5" data-gist-hide-line-numbers="true">/code>

We have introduced an `id` attribute which serves
as a bit of hack to get unique object identifiers. This
isn't the best approach, but it will do work for now.

We can now add pets to our store by initialising a list
of pets in our `Application.kt` file.

<code data-gist-id="8d1c4308641ecaa01cc3b066fe061836" data-gist-hide-line-numbers="true">/code>

## Updating our endpoints

Now for any GET requests, we can try returning the pets that
we have in our store. Update your `get` function to
return the list instead of the text.

<code data-gist-id="11bedc62984605ed090f22f731051fd0" data-gist-hide-line-numbers="true">/code>

Let's rerun our server and check the results in a browser.
Open any browser and go to `localhost:8080`. What do
you see? No need to refresh your browser; you wouldn't see
anything there.

Why do we see nothing on our screen? If you go back to your
IDE/console you will see that ktor has thrown an exception
starting like this:

`java.lang.IllegalArgumentException:`
`Response pipeline couldn't transform 'class
java.util.ArrayList' to the OutgoingContent`

Ktor is just trying to say that it has no way to send our
`petList` in a format that the browser can read. Client
and server mainly interact with texts or JSON, and we need
to tell Ktor how to convert our `petList` or any object into such
format. We will have to do two things. First, we need to
install a feature, namely `ContentNegotiation`, to
negotiate the types between the client and the server and
serialize/deserialize the contents. For
serialization/deserialization, we can use either the
`kotlinx. serialization` library or maybe Gson,
Jackson, etc. We will go with the in-built one.

<code data-gist-id="2341d890661deffd4f3135d0f8564fb7" data-gist-hide-line-numbers="true">/code>

We will install ContentNegotiation inside our server and
call the `json()` method. You might face some imports
or unresolved reference error, in that case update your
<b>pom.xml</b> or `build.gradle` file to include the
`ktor-serialization` dependency. For our second step,
we will also add the serialization plugin. Finally, we will
add the `@Serializable` annotation to our `Pet`
data class to generate the serializer function.

<code data-gist-id="e95f0844f19b2ff0fb054155400371ac" data-gist-hide-line-numbers="true">/code>

If you open your browser and go to `localhost:8080`,
you will see an array of Pet JSONs. We can now even add more
routings. We can have another GET route to get pets by their
id. We can pass pet-id in our url (we put id in curly braces
in our path to denote that it's a variable) and get
information about a particular pet. We can add a `post`
function that will help us add another pet to our pet store
and even a `delete`  function to allow people to adopt
a pet.

<code data-gist-id="64624bf4689319399d6a78d8eb75e45c" data-gist-hide-line-numbers="true">/code>

Our application here contains four routes, but the number
can grow over time. This routing tree may become challenging
to manage. We can club the routes according to their
functionalities in different modules. According to their
features, these modules can be shifted to separate files and
can be even managed in other packages.

<code data-gist-id="4724cfc70e85b2368afd460ebb414001" data-gist-hide-line-numbers="true">/code>


## What's next?

We can add persistence to our application. We were
hardcoding objects for our application which would get lost
as soon as our server stops. We can prevent this by using
any database of our choices such as MySQL, PostgreSQL, etc.
or even NoSQL options such as MongoDB. We can build a UI
such as a web app (Kotlin now also targets JS and can help
create seamless web apps) or an Android app to help display
our data better.

##  Wrapping Up

That's it! We have built our pet store very quickly. There a
lot of other features that Ktor offers that we could discuss
in another article. Do let me know your thoughts in the
comments down below!

[ktor-start]: https://ktor.io/quickstart/generator.html#
