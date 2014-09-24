if Meteor.isServer
    Meteor.publish "userData", ->
      #null  unless @userId
      Meteor.users.find {},
        fields:
          emails: 1

if Meteor.isClient
    Deps.autorun ->
        Meteor.subscribe "userData"
