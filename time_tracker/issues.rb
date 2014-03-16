require_relative 'labels_processor'
require_relative 'helpers'
require_relative 'issue_budget'
require_relative 'issue_time'
require_relative '../gh_issue_task_aggregator'
require 'pp'

module Gh_Issue

	def self.process_issue(repo, issueDetails, issueComments, githubAuthInfo)
		
		githubUserName = githubAuthInfo[:username]
		githubUserID = githubAuthInfo[:userID]
		issueState = issueDetails.attrs[:state]
		issueTitle = issueDetails.attrs[:title]
		issueNumber = issueDetails.attrs[:number]
		issueCreatedAt = issueDetails.attrs[:created_at]
		issueClosedAt = issueDetails.attrs[:closed_at]
		issueLastUpdatedAt = issueDetails.attrs[:updated_at]
		recordCreationDate = Time.now.utc
		
		# gets the milestone number assigned to a issue.  Is not milestone assigned then returns nil
		milestoneNumber = Helpers.get_issue_milestone_number(issueDetails.attrs[:milestone])
		
		# gets labels data for issue and returns array of label strings
		labelNames = Labels_Processor.get_label_names(issueDetails.attrs[:labels])
		
		# runs the label names through a parser to create Label categories.  
		# used for advanced label grouping
		labels = Labels_Processor.process_issue_labels(labelNames)

		commentsTime = []

		# Part of the Task Listing code
		gotIssueDetails = {}
		commentsArray = []
		# end of part of the task listing code

		# cycles through each comment and returns time tracking 
		issueComments.each do |x|
			# checks to see if there is a time comment in the body field
			isTimeComment = Helpers.time_comment?(x.attrs[:body])
			isBudgetComment = Helpers.budget_comment?(x.attrs[:body])
			if isTimeComment == true
				# if true, the body field is parsed for time comment details
				parsedTime = Gh_Issue_Time.process_issue_comment_for_time(x)
				if parsedTime != nil
					# assuming results are returned from the parse (aka the parse was preceived 
					# by the code to be sucessful, the parsed time comment details array is put into
					# the commentsTime array)
					commentsTime << parsedTime
				end
			elsif isBudgetComment == true
				parsedBudget = Gh_Issue_Budget.process_issue_comment_for_budget(x)
				if parsedBudget != nil
					commentsTime << parsedBudget
				end
			end

			parsedTasks = Gh_Issue_Comment_Tasks.process_issue_comment_for_task_time(x)
			if parsedTasks["tasks"].empty? == false
				commentsTime << parsedTasks
			end

			# Beta Code======== Tests for Tasks Listing - Provides a lists of tasks for each issue
			commentBody1 = GH_Issue_Task_Aggregator.get_comment_body(x)
			commentHasTasksTF = GH_Issue_Task_Aggregator.comment_has_tasks?(commentBody1)
			if commentHasTasksTF == true
				gotTasks = GH_Issue_Task_Aggregator.get_tasks_from_comment(commentBody1)
				gotCommentDetails = GH_Issue_Task_Aggregator.get_comment_details(x)
				
				mergedDetails = GH_Issue_Task_Aggregator.merge_details_and_tasks(gotCommentDetails, gotTasks)
				commentsArray << mergedDetails
			end
				
		end # do not delete this 'end'.  it is part of issueComments do block
		
		if commentsArray.empty? == false
			gotIssueDetails = GH_Issue_Task_Aggregator.get_issue_details(repo, issueDetails)
			gotIssueDetails["comments_with_tasks"] = commentsArray
			# pp gotIssueDetails
		end
		#====== End of Tests for Task Listings

		if commentsTime.empty? == false
			return output = {	"downloaded_by_username" => githubUserName,
								"downloaded_by_userID" => githubUserID,
								"repo" => repo,
								"type" => "Issue",
								"issue_state" => issueState,
								"issue_title" => issueTitle,
								"issue_number" => issueNumber,
								"milestone_number" => milestoneNumber,
								"labels" => labels,
								"issue_created_at" => issueCreatedAt,
								"issue_closed_at" => issueClosedAt,
								"issue_last_updated_at" => issueLastUpdatedAt,
								"record_creation_date" => recordCreationDate,
								"time_tracking_commits" => commentsTime, }
		elsif commentsTime.empty? == true
			return output = {}
		end
	end
end