require_relative 'time_tracker/issues'
require_relative 'time_tracker/github_data'
require_relative 'time_tracker/mongo'
require_relative 'time_tracker/milestones'
require_relative 'time_tracker/issue_comment_tasks'

class Time_Tracking_Controller

	def controller(repo, username, password, clearCollections = false)
		GitHub_Data.gh_authenticate(username, password)

		# MongoDb connection: DB URL, Port, DB Name, Collection Name
		Mongo_Connection.mongo_Connect("localhost", 27017, "GitHub-TimeTracking", "TimeTrackingCommits")
		
		# Clears the DB collections if clearCollections var in controller argument is true
		if clearCollections == true
			Mongo_Connection.clear_mongo_collections
		end

		#======Start of Issues=======
		issues = GitHub_Data.get_Issues(repo)
		
		# goes through each issue returned from get_Issues method
		issues.each do |i|

			# Gets the comments for the specific issue
			issueComments = GitHub_Data.get_Issue_Comments(repo, i.attrs[:number])

			# Parses the specific issue for time tracking information
			processedIssues = Gh_Issue.process_issue(repo, i, issueComments)

			# if data is returned from the parsing attempt, the data is passed into MongoDb
			if processedIssues.empty? == false
				Mongo_Connection.putIntoMongoCollTimeTrackingCommits(processedIssues)
			end
		end
		#======End of Issues=======

		#======Start of Milestone=======
		milestones = GitHub_Data.get_Milestones(repo)

		milestones.each do |m|

			processedMilestones = Gh_Milestone.process_milestone(repo, m)

			if processedMilestones.empty? == false
				Mongo_Connection.putIntoMongoCollTimeTrackingCommits(processedMilestones)
			end
		end
		#======End of Milestone=======
	end
end

start = Time_Tracking_Controller.new

# GitHubUsername/RepoName, GitHubUsername, GitHubPassword, ClearCollectionsTFValue
start.controller("StephenOTT/Test1", "USERNAME", "PASSWORD", true)

