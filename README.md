# Gabby - iOS voice assistant
### RedPotion(RubyMotion) - Rails | v0.1

<p>Interesting parts so far are:</p>
<ul>
<li>gabby_ios_rubymotion_client/app/models/apiAIvoiceController.rb</li>
<li>gabby_ios_rubymotion_client/app/screens/home_screen.rb</li>
</ul>

<p>Gabby uses an api.ai agent to process voice requests and then if there
are parameters for further action in the response, she contacts her rails server to
find out what to do with them. Sending back customized speech most the time.</p>

<p>Gabby's RubyMotion side is using a variety of Objective-C cocoa pods:</p>
<ul>
<li>pod 'AFSoundManager'</li>
<li>pod 'ApiAI', '~> 0.4'</li>
<li>pod 'MVSpeechSynthesizer'</li>
<li>pod 'CircleProgressBar', '~> 0.3'</li>
</ul>
This is the first conversion of the ApiAI Objective-C pod to RubyMotion(RMQ/Redpotion) from
what I can tell. I crash trying to use VAD(voice auto detect) for commit so
that needs some help. As well as it needs helper methods for contexts and
lots of other things that she currently does not use.

<p>My idea is to expand this and use IBM Cognitive Cloud image recognition as well
as knowledge,Wolfram Alpha etc etc... The idea is that a user logs
in and over time as they ask questions and tell Gabby things, their database grows and builds
connections personalized to that user. Also started experimenting with
personalized actions.. right now Gabby can click a mouse lol.</p>

<p>I would like to switch rails to using MongoDB/Mongoid for the dynamicness
allowed by NoSQL. Gabby needs to be able to learn new tables on the fly.</p>
