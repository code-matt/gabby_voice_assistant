# Gabby - iOS voice assistant | v0.1

<p>Interesting parts so far are:</p>
<ul>
<li>gabby_ios_rubymotion_client/app/models/apiAIvoiceController.rb</li>
<li>gabby_ios_rubymotion_client/app/screens/home_screen.rb</li>
<li>gabby_ios_rubymotion_client/app/stylesheets/home_screen_stylesheet.rb</li>
</ul>

<p>Gabby uses an api.ai agent to process voice requests and then if there
are parameters for further action, she contacts her rails server to
find out what to do with them</p>

<p>I have plans to expand this with IBM watson image recognition as well
as knowledge. The idea is that a user logs in and over time as they as questions
and tell gabby things, it builds a database that is personalized to them. Also
started experimenting with personalized actions.. right now Gabby can click
a mouse lol.</p>
