createMarker = (user, element) ->

  #Creat the HTML that will show the Presence User Marker
  marker = Blaze.toHTML(Blaze.With(
    user: user
    element: element
  , ->
    Template.userMarker
  ))

  #Append the Marker after the input where the user is located
  $("[name='" + element + "']").after marker


### Function userMark ###
# receives a presence id, and fields that changed (input form)
# creates the marker for the user in such input

userMark = (id, fields) ->
  # we use Memoization in the function to store the markers.
  # initialize markers cache as empty object if is undefined.
  userMark.markers = {}  if typeof userMark.markers is "undefined"

  #if there is not a track of presence yet, i.e. is undefined, return false.
  return false  if typeof  fields.state.caretRange is "undefined" or typeof fields.state is "undefined"

  #otherwise, lets create the marker.
  userId = Presences.findOne(_id: id).userId
  user = Meteor.users.findOne(_id: userId)

  userName = user.emails #should be the name in the future, stored in user.profile

  userColor = user.profile.color or "black"

  console.log "user: ", userName
  console.log "in: ", fields.state.caretRange.name

  #element is the input where the presence has changed
  element = fields.state.caretRange.name

  #lets remove existing markers for this user, i.e. other inputs.
  $(".userMarker[data-user = '" + user._id + "']").remove()

  #lets create the new marker for this user in the element
  createMarker user, element


### AutoRun ###
Meteor.startup ->
  Deps.autorun ->
    userMark.markers = {} #initialize memoization cache empty

    #Are we talking about the same route were we are?
    Presences.find("state.route": Router.current() and Router.current().path).observeChanges
      added: (id, fields) ->

        #lets create the marker for the user in the respective DOM element
        console.log " new"
        userMark id, fields

      changed: (id, fields) ->
        console.log "changed"
        userMark id, fields

      removed: (id) ->
        #missing removing not needed probably.
