=begin
Then(/^I (can|should) see the Dead Drop Mini Map$/) do | c |
  pending # express the regexp above with the code you wish you had
end

Then(/^I (can|should) see the Dead Drop List Screen$/) do | c |
  pending # express the regexp above with the code you wish you had
end

Then(/^I (can|should) see the Dead Drop List$/) do | c |
  pending # express the regexp above with the code you wish you had
end
=end

##############################################

#=begin
Then(/^I (can|should) see the Dead Drop Mini Map$/) do | c |
  wait_for() {
    element_exists("all view marked:'DeadDropMiniMap'")
  }
end

Then(/^I (can|should) see the Dead Drop List Screen$/) do | c |
    if c == "can"
        goToListScreen
        sleep(0.5)
    else
        wait_for() {
            element_exists("view marked:'DeadDropListScreen'")
        }
    end

  setCurrentScreen("#{LIST}")
end

Then(/^I (can|should) see the Dead Drop List$/) do | c |
  wait_for() {
    element_exists("view marked:'DeadDropList'")
  }
end
#=end