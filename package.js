Package.describe({
  summary: "Add User Presence Markers to input fields in forms"
});

Package.on_use(function (api) {
  api.use(['accounts-base','coffeescript']);
  api.use(['iron:router','jquery', 'presence','templating','deps'], 'client');


  //publications should be removed if data of user is in profile.
  api.add_files(['lib/lib.coffee', 'lib/lib.html','lib/lib.css'],'client');
  api.add_files(['lib/publications.coffee'],['client','server'])

  //api.export('userMark', 'client');
});
