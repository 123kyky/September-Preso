=begin
Then(/^I (can|should) see the Dead Drop Map Screen$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I (can|should) see the Dead Drop Map$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)" as the Screen Title$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I tap the Back button$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I touch the map pin$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the "(.*?)" map pin label$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
=end

##############################################
#=begin
Then(/^I (can|should) see the Dead Drop Map Screen$/) do | c |
  wait_for() {
    element_exists("view marked:'DeadDropMapScreen'")
  }

  setCurrentScreen("#{MAP}")
end

Then(/^I (can|should) see the Dead Drop Map$/) do | c |
  wait_for() {
    element_exists("view:'MKMapView' marked:'DeadDropMap'")
  }

  setCurrentScreen("#{MAP}")
end

Then(/^I should see "(.*?)" as the Screen Title$/) do |title|
    wait_for() {
        element_exists("all label marked:'#{title}'")
    }
end

Then(/^I tap the Back button$/) do
  goBack
  setCurrentScreen("#{LIST}")
end

Then(/^I touch the map pin$/) do
  wait_for() {
    element_exists("view:'MKAnnotationView'")
  }

  touch("view:'MKAnnotationView'")
end

Then(/^I should see the "(.*?)" map pin label$/) do |pinLabel|
  wait_for() {
    element_exists("label marked:'#{pinLabel}'")
  }
end
#=end