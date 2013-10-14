HOME = "home"
LIST = "list"
MAP = "map"

module WorldExtension
    def determineCurrentScreen
        if element_exists("view marked:'HomeScreen'")
            @currentScreen = "#{HOME}"
        elsif element_exists("view marked:'DeadDropListScreen'")
            @currentScreen = "#{LIST}"
        elsif element_exists("view marked:'DeadDropMapScreen'")
            @currentScreen = "#{MAP}"
        end
    end

    def setCurrentScreen(screen)
        @currentScreen = screen
    end

    def goBack
        if @currentScreen == "#{MAP}"
            wait_for() {
                element_exists("button marked:'NavigateBackButton'")
            }
            touch("button marked:'NavigateBackButton'")
        end
    end

    def goToListScreen
        if @currentScreen == "#{MAP}"
            goBack
        elsif @currentScreen == "#{HOME}"
            swipe("down")
        end

        wait_for() {
            element_exists("view marked:'DeadDropListScreen'")
        }

        setCurrentScreen("#{LIST}")
    end
end

World(WorldExtension)