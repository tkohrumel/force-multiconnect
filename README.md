# Heroku Connect API Reference Architecture

For Salesforce ISVs, Heroku Connect makes it easy for you to build Heroku apps that extend the data and functionality of their Force.com managed packages. Using bi-directional synchronization between Salesforce and Heroku Postgres, Heroku Connect unifies the data in a Postgres database with the customers' contacts, accounts, and other custom objects in the Salesforce database.

This reference architecture demonstrates how a multitenant application on Heroku can be used to extend a distributed Force.com application via the Heroku Connect service. Moreover, it shows how to automate the setup and configuration of the Heroku Connect service per customer, which synchronizes data between that customer’s Salesforce environment and the ISV's centralized, multitenant Postgres database.

<a href="https://githubsfdeploy.herokuapp.com?owner=tkohrumel&repo=force-multiconnect">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a> 

___

# Architecture

## On Force.com

- A simple application containing a post-install script and a few custom fields

*Note: In Salesforce post-installation scripts only operate within managed packages; for the sake of being open source, this project is necessarily an unmanaged package. Although the functionality of the post-install script can be triggered manually, the unmanaged package should ideally be converted into a managed package such that the post-install script is able to run.*

## On Heroku

- Processes
  - Frontend Rails app, which handles the creation of sync operations, via the Heroku Connect API, between customers' Salesforce organizations and a multitenant Heroku Postgres database 
  - Ruby process for background jobs
- Add-ons
  - [Heroku Postgres database](https://devcenter.heroku.com/articles/heroku-postgresql)
  - [Heroku Connect](https://devcenter.heroku.com/articles/herokuconnect), with which select data from customers' Salesforce organizations are synchronized with the Postgres database
  - [Heroku Redis](https://devcenter.heroku.com/articles/heroku-redis) key-value store, which is used by background job process to store all job and operational data
  - [SendGrid](https://devcenter.heroku.com/articles/sendgrid), used for sending emails
  - [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler), used for scheduled processing of relevant social media records
  - [PaperTrail](https://devcenter.heroku.com/articles/papertrail), optional, used for log aggregation and management

See the [sequence diagram](https://github.com/tkohrumel/heroku-multiconnect/wiki/Sequence-Diagram) for a visual overview of how it works.

_____

# Getting Started

For comprehensive setup instructions for both the Heroku and Force.com components, refer to the [Heroku app repository](https://github.com/tkohrumel/heroku-multiconnect#heroku-setup).
