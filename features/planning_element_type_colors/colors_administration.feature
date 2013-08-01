#-- copyright
# OpenProject is a project management system.
#
# Copyright (C) 2012-2013 the OpenProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

Feature: Color Adminstration
  As a ChiliProject Admin
  I want to configure which colors are available
  So that I can support my teams with useful settings while still controlling
  the total number of available colors

  Background:
    Given there are the following colors:
          | Name   | Hexcode |
          | Blue   | #336699 |
          | Grey   | #999999 |
          | Yellow | #FFCC33 |

      And I am already admin

  Scenario: The admin may see all colors within the admin UI
     When I go to the admin page
      And I follow "Colors"
     Then I should see that "Blue" is a color
      And I should see that "Grey" is a color
      And I should see that "Yellow" is a color

  Scenario: The admin may create a color
     When I go to the admin page
      And I follow "Colors"
      And I follow "New color"
      And I fill in "White" for "Name"
      And I fill in "#000000" for "Hex code"
      And I press "Save"
     Then I should see a notice flash stating "Successful creation."
      And I should see that "White" is a color
      And "White" should be the last element in the list

  Scenario: Nice error messages help fixing them
     When I go to the admin page
      And I follow "Colors"
      And I follow "New color"
      And I fill in "" for "Name"
      And I press "Save"
     Then I should see an error explanation stating "Name can't be blank"

  Scenario: The admin may edit a color
     When I go to the admin page
      And I follow "Colors"
      And I click "Yellow" for the color "Yellow"
      And I fill in "New Yellow" for "Name"
      And I press "Save"
     Then I should see a notice flash stating "Successful update."
      And I should see that "New Yellow" is a color

  Scenario: The admin may delete a color
     When I go to the admin page
      And I follow "Colors"
      And I follow "Delete Yellow"
      And I press "Delete"
     Then I should see a notice flash stating "Successful deletion."
      And I should not see the "Yellow" color

  Scenario: The admin may reorder colors
     When I go to the admin page
      And I follow "Colors"
      And I move "Yellow" to the top
     Then "Yellow" should be the first element in the list

     When I move "Yellow" down by one
     Then "Blue" should be the first element in the list
