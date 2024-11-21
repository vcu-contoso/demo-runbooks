Param
(
    [Parameter (Mandatory= $true)]
    [String] $Subscription,

    [Parameter (Mandatory= $true)]
    [String] $ResourceGroup,

    [Parameter (Mandatory= $true)]
    [String] $LogicApp,

    [Parameter (Mandatory= $true)]
    [String] $Workflows,

    [Parameter (Mandatory= $true)]
    [String] $State
)

# Set the preference to stop the job when an error occurs
$ErrorActionPreference = "Stop"

# split comma delimited string into array
$WorkflowsArray = $Workflows.Split(",")
# Create the settings paramerter, which consists of a space-separated list of settings tp set the states of the workflows
# Format is: Workflows.[workflow name].FlowState=[state]
$settings = ""
foreach($workflow in $WorkflowsArray) {
    $settings = $settings + " Workflows." + $workflow + ".FlowState=" + $State
}
$settings = $settings.Trim()

Write-Output "Subscription: $Subscription"
Write-Output "ResourceGroup: $ResourceGroup"
Write-Output "LogicApp: $LogicApp"
Write-Output "Workflows: $Workflows"
Write-Output "Settings: $settings"
Write-Output "State: $State"

"Completed"
