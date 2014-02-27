require_relative './mongo'
# require 'mongo'

module Time_Analyzer
	# include Mongo


	def self.controller

		Mongo_Connection.mongo_Connect("localhost", 27017, "GitHub-TimeTracking", "TimeTrackingCommits")

	end


	def self.analyze_issue_spent_hours
		# totalIssueSpentHoursBreakdown = @collTimeTrackingCommits.aggregate([
		totalIssueSpentHoursBreakdown = Mongo_Connection.aggregate_test([
			{"$project" => {type: 1, 
							issue_number: 1, 
							_id: 1, 
							repo: 1,
							milestone_number: 1, 
							issue_state: 1, 
							issue_title: 1, 
							time_tracking_commits:{ duration: 1, 
													type: 1, 
													comment_id: 1 }}},			
			{ "$match" => { type: "Issue" }},
			{ "$unwind" => "$time_tracking_commits" },
			{ "$match" => { "time_tracking_commits.type" => { "$in" => ["Issue Time"] }}},
			{ "$group" => { _id: {
							repo_name: "$repo",
							milestone_number: "$milestone_number",
							issue_number: "$issue_number",
							issue_state: "$issue_state", },
							time_duration_sum: { "$sum" => "$time_tracking_commits.duration" },
							time_comment_count: { "$sum" => 1 }
							}}])
		output = []
		totalIssueSpentHoursBreakdown.each do |x|
			x["_id"]["time_duration_sum"] = x["time_duration_sum"]
			x["_id"]["time_comment_count"] = x["time_comment_count"]
			output << x["_id"]
		end
		return output
	end

	def self.analyze_issue_budget_hours
		totalIssueSpentHoursBreakdown = Mongo_Connection.aggregate_test([
			{"$project" => {type: 1, 
							issue_number: 1, 
							_id: 1, 
							repo: 1,
							milestone_number: 1, 
							issue_state: 1, 
							issue_title: 1, 
							time_tracking_commits:{ duration: 1, 
													type: 1, 
													comment_id: 1 }}},			
			{ "$match" => { type: "Issue" }},
			{ "$unwind" => "$time_tracking_commits" },
			{ "$match" => { "time_tracking_commits.type" => { "$in" => ["Issue Budget"] }}},
			{ "$group" => { _id: {
							repo_name: "$repo",
							milestone_number: "$milestone_number",
							issue_number: "$issue_number",
							issue_state: "$issue_state", },
							budget_duration_sum: { "$sum" => "$time_tracking_commits.duration" },
							budget_comment_count: { "$sum" => 1 }
							}}])
		output = []
		totalIssueSpentHoursBreakdown.each do |x|
			x["_id"]["budget_duration_sum"] = x["budget_duration_sum"]
			x["_id"]["budget_comment_count"] = x["budget_comment_count"]
			output << x["_id"]
		end
		return output
	end


	def self.merge_issue_time_and_budget(issuesTime, issuesBudget)

		issuesTime.each do |t|

			issuesBudget.each do |b|

				if b["issue_number"] == t["issue_number"]
					t["budget_duration_sum"] = b["budget_duration_sum"]
					t["budget_comment_count"] = b["budget_comment_count"]
					break
				end					
			end
			if t.has_key?("budget_duration_sum") == false and t.has_key?("budget_comment_count") == false
				t["budget_duration_sum"] = nil
				t["budget_comment_count"] = nil
			end
		end

		return issuesTime
	end
end

# start = Time_Analyzer.new

# start.mongo_Connect("localhost", 27017, "GitHub-TimeTracking", "TimeTrackingCommits")
# issuesTime = start.analyze_issue_spent_hours
# puts issuesTime
# puts "======"
# issuesBudget = start.analyze_issue_budget_hours
# puts issuesBudget
# puts "======"
# puts start.merge_issue_time_and_budget(issuesTime,issuesBudget)

