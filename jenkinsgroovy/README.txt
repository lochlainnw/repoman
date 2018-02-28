pluginlist >> Script for finding list of plugins from jenkins CM

NumPlugins >> Total number of plugins

JobsURL >> Show all jobs and concatenate URL

DisabledJobs >> shows all disabled jobs in a CM with date last run

JenkinsCleanup >> A house keeping script for Jenkins that creates a report for jobs that have not been run in 180 days.  It cleans them up by shelving them, must have shelving plugin installed. It also shelves disabled jobs that are 180 days disabled.  There is an exceptions section where jobs with “dnd” (do not delete) and “important” will not be shelved. The report will be outputted to a housekeeping-jenkinsCM.csv file contained in your workspace if ran from a jenkins slave.
