=begin
Given(/^I have launched the application$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I (can|should) see the Home Screen$/) do | c |
  pending # express the regexp above with the code you wish you had
end
=end
##############################################

#=begin
Given(/^I have launched the application$/) do
  wait_for() {
    element_exists("view")
  }
end

Then(/^I (can|should) see the Home Screen$/) do | c |
  wait_for() {
    element_exists("view marked:'HomeScreen'")
  }

  setCurrentScreen("#{HOME}")
end
#=end