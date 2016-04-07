# Gabby - iOS voice assistant
### RedPotion(RubyMotion) - Rails | v0.1

<p>Interesting parts so far are:</p>
<ul>
<li>gabby_ios_rubymotion_client/app/models/apiAIvoiceController.rb</li>
<li>gabby_ios_rubymotion_client/app/screens/home_screen.rb</li>
<li>gabby_ios_rubymotion_client/app/stylesheets/home_screen_stylesheet.rb</li>
</ul>

<p>Gabby uses an api.ai agent to process voice requests and then if there
are parameters for further action, she contacts her rails server to
find out what to do with them</p>

<p>Gabby's RubyMotion side is using a variety of Objective-C cocoa pods:</p>
<ul>
<li>pod 'AFSoundManager'</li>
<li>pod 'ApiAI', '~> 0.4'</li>
<li>pod 'MVSpeechSynthesizer'</li>
<li>pod 'CircleProgressBar', '~> 0.3'</li>
</ul>
This is the first conversion of ApiAI from its Objective-C to Rubymotion(RMQ/Redpotion really) from
what I can tell. I crash trying to use VAD(voice auto detect) for commit so
that needs some help.

<p>My idea is to expand this and use IBM watson image recognition as well
as knowledge,walfram alpha etc etc... The idea is that a user logs
in and over time as they ask questions and tell gabby things, grows and builds
connections personalized to that user. Also started experimenting with
personalized actions.. right now Gabby can click a mouse lol.</p>
