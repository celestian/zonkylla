#Feature: Zonkylla database
#
#
## zonkylla init
#
#  Scenario: Zonkylla init on non-existend database
#    Given we have zonkylla installed
#    And there is no <db_file> here
#    When we run "zonkylla init"
#    Then file <db_file> is created
#    And there is proper database structure
#    And zonkylla says that database is prepared with given version
#    And zonkylla says we should run "zonkylla update"
#
#  Scenario: Zonkylla init on existing file (without structure)
#    Given we have zonkylla installed
#    And there is <db_file> without structure here
#    When we run "zonkylla init"
#    Then zonkylla says file is without structure
#    And zonkylla says we should run "zonkylla --force init"
#
#  Scenario: Zonkylla init on existing file (with old structure)
#    Given we have zonkylla installed
#    And there is <db_file> with old structure
#    When we run "zonkylla init"
#    Then zonkylla says file is with old structure
#    And zonkylla says we should run "zonkylla --force init"
#
#  Scenario: Zonkylla init on empty file with proper structure
#    Given we have zonkylla installed
#    And there is empty <db_file> with proper structure
#    When we run "zonkylla init"
#    Then zonkylla says database is already prepared with given version
#    And zonkylla says <db_file> is empty
#    And zonkylla says we should run "zonkylla update"
#
#  Scenario: Zonkylla init on outdated existing file with proper structure
#    Given we have zonkylla installed
#    And there is outdated <db_file> with proper structure
#    When we run "zonkylla init"
#    Then zonkylla says database is already prepared with given version
#    And zonkylla says <db_file> is outdated
#    And zonkylla says we should run "zonkylla update"
#
#  Scenario: Zonkylla init on updated existing file with proper structure
#    Given we have zonkylla installed
#    And there is updated <db_file> with proper structure
#    When we run "zonkylla init"
#    Then zonkylla says database is already prepared with given version
#    And zonkylla says <db_file> is update
#
#
## zonkylla --force init
#
#  Scenario: Zonkylla force init on non-existend database
#    Given we have zonkylla installed
#    And there is no <db_file> here
#    When we run "zonkylla --force init"
#    Then file <db_file> is created
#    And there is proper database structure
#    And zonkylla says that database is prepared with given version
#    And zonkylla says we should run "zonkylla update"
#
#  Scenario: Zonkylla force init on existing file (without structure)
#    Given we have zonkylla installed
#    And there is <db_file> without structure here
#    When we run "zonkylla --force init"
#    Then zonkylla remove current <db_file>
#    And new file <db_file> is created
#    And there is proper database structure
#    And zonkylla says that database is prepared with given version
#    And zonkylla says we should run "zonkylla update"
#
#  Scenario: Zonkylla force init on existing file (with old structure)
#    Given we have zonkylla installed
#    And there is <db_file> with old structure
#    When we run "zonkylla --force init"
#    Then zonkylla remove current <db_file>
#    And new file <db_file> is created
#    And there is proper database structure
#    And zonkylla says that database is prepared with given version
#    And zonkylla says we should run "zonkylla update"
#
#  Scenario: Zonkylla force init on empty file with proper structure
#    Given we have zonkylla installed
#    And there is empty <db_file> with proper structure
#    When we run "zonkylla --force init"
#    Then zonkylla says database is already prepared with given version
#    And zonkylla says <db_file> is empty
#    And zonkylla says we should run "zonkylla update"
#
#  Scenario: Zonkylla force init on outdated existing file with proper structure
#    Given we have zonkylla installed
#    And there is outdated <db_file> with proper structure
#    When we run "zonkylla --force init"
#    Then zonkylla says database is already prepared with given version
#    And zonkylla says <db_file> is outdated
#    And zonkylla says we should run "zonkylla update"
#
#  Scenario: Zonkylla force init on updated existing file with proper structure
#    Given we have zonkylla installed
#    And there is updated <db_file> with proper structure
#    When we run "zonkylla --force init"
#    Then zonkylla says database is already prepared with given version
#    And zonkylla says <db_file> is update
#
#
## zonkylla update
#
#  Scenario: Zonkylla update on non-existend database
#    Given we have zonkylla installed
#    And there is no <db_file> here
#    When we run "zonkylla update"
#    Then zonkylla says file <db_file> is missing
#    And zonkylla says we should run "zonkylla init"
#
#  Scenario: Zonkylla update on existing file (without structure)
#    Given we have zonkylla installed
#    And there is <db_file> without structure here
#    When we run "zonkylla update"
#    Then zonkylla says file is without structure
#    And zonkylla says we should run "zonkylla --force init"
#
#  Scenario: Zonkylla update on existing file (with old structure)
#    Given we have zonkylla installed
#    And there is <db_file> with old structure
#    When we run "zonkylla update"
#    Then zonkylla says file is with old structure
#    And zonkylla says we should run "zonkylla --force init"
#
#  Scenario: Zonkylla update on empty file with proper structure
#    Given we have zonkylla installed
#    And there is empty <db_file> with proper structure
#    When we run "zonkylla update"
#    Then zonkylla update data in <db_file>
#    And zonkylla says update on <db_file> is completed
#
#  Scenario: Zonkylla update on outdated existing file with proper structure
#    Given we have zonkylla installed
#    And there is outdated <db_file> with proper structure
#    When we run "zonkylla update"
#    Then zonkylla update data in <db_file>
#    And zonkylla says update on <db_file> is completed
#
#  Scenario: Zonkylla update on updated existing file with proper structure
#    Given we have zonkylla installed
#    And there is updated <db_file> with proper structure
#    When we run "zonkylla update"
#    Then zonkylla update data in <db_file>
#    And zonkylla says update on <db_file> is completed
#
#
## zonkylla status (or any other command of such kind)
#
#  Scenario: Zonkylla status on non-existend database
#    Given we have zonkylla installed
#    And there is no <db_file> here
#    When we run "zonkylla status"
#    Then zonkylla says file <db_file> is missing
#    And zonkylla says we should run "zonkylla init"
#
#  Scenario: Zonkylla status on existing file (without structure)
#    Given we have zonkylla installed
#    And there is <db_file> without structure here
#    When we run "zonkylla status"
#    Then zonkylla says file is without structure
#    And zonkylla says we should run "zonkylla --force init"
#
#  Scenario: Zonkylla status on existing file (with old structure)
#    Given we have zonkylla installed
#    And there is <db_file> with old structure
#    When we run "zonkylla status"
#    Then zonkylla says file is with old structure
#    And zonkylla says we should run "zonkylla --force init"
#
#  Scenario: Zonkylla status on empty file with proper structure
#    Given we have zonkylla installed
#    And there is empty <db_file> with proper structure
#    When we run "zonkylla status"
#    Then zonkylla says <db_file> is empty
#    And zonkylla shows status
#
#  Scenario: Zonkylla status on outdated existing file with proper structure
#    Given we have zonkylla installed
#    And there is outdated <db_file> with proper structure
#    When we run "zonkylla status"
#    Then zonkylla says <db_file> is outdated
#    And zonkylla says we should run "zonkylla update"
#    And zonkylla shows status
#
#  Scenario: Zonkylla status on updated existing file with proper structure
#    Given we have zonkylla installed
#    And there is updated <db_file> with proper structure
#    When we run "zonkylla status"
#    Then zonkylla shows status