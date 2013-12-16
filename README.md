GitHub-Time-Tracking
===========================

Ruby app that analyzes GitHub Issue Comments, Milestones, and Code Commit Messages for Time Tracking and Budget Tracking information 


## Usage Patterns

### Logging Time for an Issue

Logging time for a specific issue should be done in its own comment.  The comment should not include any data other than the time tracking information.


#### Examples

1. `:clock1: 2h` # => :clock1: 2h

2. `:clock1: 2h | 3pm` # => :clock1: 2h | 3pm

3. `:clock1: 2h | 3:20pm` # => :clock1: 2h | 3:20pm

4. `:clock1: 2h | Feb 26, 2014` # => :clock1: 2h | Feb 26, 2014

5. `:clock1: 2h | Feb 26, 2014 3pm` # => :clock1: 2h | Feb 26, 2014 3pm

6. `:clock1: 2h | Feb 26, 2014 3:20pm` # => :clock1: 2h | Feb 26, 2014 3:20pm

7. `:clock1: 2h | Installed security patch and restarted the server.` # => :clock1: 2h | Installed security patch and restarted the server.

8. `:clock1: 2h | 3pm | Installed security patch and restarted the server.` # => :clock1: 2h | 3pm | Installed security patch and restarted the server.

9. `:clock1: 2h | 3:20pm | Installed security patch and restarted the server.` # => :clock1: 2h | 3:20pm | Installed security patch and restarted the server.

10. `:clock1: 2h | Feb 26, 2014 | Installed security patch and restarted the server.` # => :clock1: 2h | Feb 26, 2014 | Installed security patch and restarted the server.

11. `:clock1: 2h | Feb 26, 2014 3pm | Installed security patch and restarted the server.` # => :clock1: 2h | Feb 26, 2014 3pm | Installed security patch and restarted the server.

12. `:clock1: 2h | Feb 26, 2014 3:20pm | Installed security patch and restarted the server.` # => :clock1: 2h | Feb 26, 2014 3:20pm | Installed security patch and restarted the server.


- Dates and times can be provided in various formats, but the above formats are recommended for plain text readability.

- Any GitHub.com support `clock` Emoji is supported:
":clock130:", ":clock11:", ":clock1230:", ":clock3:", ":clock430:", ":clock6:", ":clock730:", ":clock9:", ":clock10:", ":clock1130:", ":clock2:", ":clock330:", ":clock5:", ":clock630:", ":clock8:", ":clock930:", ":clock1:", ":clock1030:", ":clock12:", ":clock230:", ":clock4:", ":clock530:", ":clock7:", ":clock830:"

#### Sample
![screen shot 2013-12-15 at 8 41 35 pm](https://f.cloud.github.com/assets/1994838/1751599/b03deba6-65f3-11e3-9a4a-6e30ca750fd6.png)



### Logging Time for a Code Commit

When logging time in a Code Commit, the code commit message should follow the usage pattern.  The commit message that you would normally submit as part of the code commit comes after the time tracking information.  See example 7 below for a typical usage pattern.  Code Commit time logging can be done as part of the overall Git Commit Message, individual GitHub Commit Comment or Line Comment.

#### Examples

1. `:clock1: 2h` # => :clock1: 2h

2. `:clock1: 2h | 3pm` # => :clock1: 2h | 3pm

3. `:clock1: 2h | 3:20pm` # => :clock1: 2h | 3:20pm

4. `:clock1: 2h | Feb 26, 2014` # => :clock1: 2h | Feb 26, 2014

5. `:clock1: 2h | Feb 26, 2014 3pm` # => :clock1: 2h | Feb 26, 2014 3pm

6. `:clock1: 2h | Feb 26, 2014 3:20pm` # => :clock1: 2h | Feb 26, 2014 3:20pm

7. `:clock1: 2h | Installed security patch and restarted the server.` # => :clock1: 2h | Installed security patch and restarted the server.

8. `:clock1: 2h | 3pm | Installed security patch and restarted the server.` # => :clock1: 2h | 3pm | Installed security patch and restarted the server.

9. `:clock1: 2h | 3:20pm | Installed security patch and restarted the server.` # => :clock1: 2h | 3:20pm | Installed security patch and restarted the server.

10. `:clock1: 2h | Feb 26, 2014 | Installed security patch and restarted the server.` # => :clock1: 2h | Feb 26, 2014 | Installed security patch and restarted the server.

11. `:clock1: 2h | Feb 26, 2014 3pm | Installed security patch and restarted the server.` # => :clock1: 2h | Feb 26, 2014 3pm | Installed security patch and restarted the server.

12. `:clock1: 2h | Feb 26, 2014 3:20pm | Installed security patch and restarted the server.` # => :clock1: 2h | Feb 26, 2014 3:20pm | Installed security patch and restarted the server.


- Dates and times can be provided in various formats, but the above formats are recommended for plain text readability.

- Any GitHub.com support `clock` Emoji is supported:
":clock130:", ":clock11:", ":clock1230:", ":clock3:", ":clock430:", ":clock6:", ":clock730:", ":clock9:", ":clock10:", ":clock1130:", ":clock2:", ":clock330:", ":clock5:", ":clock630:", ":clock8:", ":clock930:", ":clock1:", ":clock1030:", ":clock12:", ":clock230:", ":clock4:", ":clock530:", ":clock7:", ":clock830:"

#### Sample
##### Code Commit Message:
![screen shot 2013-12-15 at 8 42 55 pm](https://f.cloud.github.com/assets/1994838/1751603/ca03597c-65f3-11e3-82a8-0fa293f69d84.png)
![screen shot 2013-12-15 at 8 42 43 pm](https://f.cloud.github.com/assets/1994838/1751604/ca044274-65f3-11e3-9b60-4a912959c19b.png)

##### Code Commit Comment:
![screen shot 2013-12-16 at 10 20 22 am](https://f.cloud.github.com/assets/1994838/1757115/00735ccc-667c-11e3-8656-57caaae42e04.png)

##### Code Commit Line Comment:
![screen shot 2013-12-16 at 10 19 55 am](https://f.cloud.github.com/assets/1994838/1757116/00741680-667c-11e3-9a2f-ba9128a60515.png)


### Logging Budgets for an Issue

Logging a budget for a specific issue should be done in its own comment.  The comment should not include any data other than the budget tracking information.

#### Examples

1. `:dart: 5d` # => :dart: 5d

2. `:dart: 5d | We cannot go over this time at all!` # => :dart: 5d | We cannot go over this time at all! 

#### Sample
![screen shot 2013-12-15 at 8 46 33 pm](https://f.cloud.github.com/assets/1994838/1751609/24b45bbe-65f4-11e3-8a5e-86b0cfb12a74.png)


### Logging Budgets for a Milestone

Logging a budget for a milestone should be done at the beginning of the milestone description.  The typical milestone description information comes after the budget information.  See example 2 below for a typical usage pattern.

#### Examples

1. `:dart: 5d` # => :dart: 5d

2. `:dart: 5d | We cannot go over this time at all!` # => :dart: 5d | We cannot go over this time at all! 

#### Sample
![screen shot 2013-12-15 at 8 42 04 pm](https://f.cloud.github.com/assets/1994838/1751601/bb73ed86-65f3-11e3-9abb-4c47eabbc608.png)
![screen shot 2013-12-15 at 8 41 55 pm](https://f.cloud.github.com/assets/1994838/1751602/bb757d9a-65f3-11e3-9ac5-86dba26bc037.png)


## Sample Data Structure for Reporting

### Time Logging
![screen shot 2013-12-13 at 1 38 58 am](https://f.cloud.github.com/assets/1994838/1740302/e4281c18-63c1-11e3-8674-fda74e89f628.png)


### Budget Logging
![screen shot 2013-12-13 at 5 48 52 pm](https://f.cloud.github.com/assets/1994838/1746777/c65ec7d6-6448-11e3-9e66-161bb3b05739.png)

### Code Commit Time Loggin
![screen shot 2013-12-15 at 7 23 19 pm](https://f.cloud.github.com/assets/1994838/1751625/3e967ac0-65f5-11e3-9ade-00f9358b967b.png)


## Future Features

1. Tracking of Billable and non-billable hours
2. Breakdown by Milestones
3. Breakdown by User
4. Breakdown by Labels
5. Printable View
6. Import from CSV
7. Export to CSV
8. ~~Budget Tracking (What is the allocated budget of a issue, milestone, label, etc)~~ Done
9. ~~Code Commit Time Tracking~~ Done


## Process Overview

![github time tracking process overview](https://f.cloud.github.com/assets/1994838/1757137/409bf8e0-667c-11e3-9576-14400457c2c1.png)
