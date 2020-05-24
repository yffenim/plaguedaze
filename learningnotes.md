20/03/20

Starting a new file of learning notes because having them
electronically accessible is better than physical notes for the
purpose of quick searching.

Summary of yesterday:
I wanted to sort through the Covid page separate from the
page loading (because it slows down the initial app) so I created
a separate class for data logic with its own url. But that meant
that I needed to render a separate template for the method call
to happen. It also meant that that separate page had to be loaded
for the data to come through so I don't have access to it via
AJAX on template page (without the separate page load).
So I returned to initial organization of logic in
one Template class and will now have it call upon click.

Today:
Unable to write algorithm to instantiate new method inside of a block:

# over100.each do |k,v|
#   def k
#     v
#   end
# end

- even if this worked, I realize now looking at it critically
that I wouldn't have been able to access the method outside of the
loop's scope.

- time to do some research on what is possible in JS front-end

My options going forward:

1. ditch the Ajax: render the data via method
save it in JS var

2. Use Ajax but figure out how to create a route that is
loaded by clicking a button on template
button triggers covid data retrieval & sorting logic
ajax retrieves the data, renders chart

If I do this ^ (which I think is the better way to do it because
it makes me realize that I'm not clear on how to create routing
that doesn't actually "exist" with a template -- which is what
I did yesterday. I made a route but then I couldn't access
it without rendering it. That is excessively.)

I would also like to learn how to script the server from scratch so
that my app in the end has:

- server
- routes
- module methods for authentication
- controller/model/views
- maybe tie it to a database?

Deciding to spend the day on research.


May 24:

It looks like I will have to create the GeoJson resources as
a POST request (and not a GET)
