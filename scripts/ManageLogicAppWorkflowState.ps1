Param
(
    [Parameter (Mandatory= $true)]
    [String] $Subscription,

    [Parameter (Mandatory= $true)]
    [String] $ResourceGroup,

    [Parameter (Mandatory= $true)]
    [String] $LogicApp,

    [Parameter (Mandatory= $true)]
    [String[]] $Workflows,

    [Parameter (Mandatory= $true)]
    [String] $State
)

# Set the preference to stop the job when an error occurs
$ErrorActionPreference = "Stop"

# Login using managed identity
"Logging into Azure using managed identity"
# az login
az login --identity

# Change the active subscription to match input parameter
Write-Output("Setting the subscription to: " + $Subscription)
az account set --subscription $Subscription

# Create the settings paramerter, which consists of a space-separated list of settings tp set the states of the workflows
# Format is: Workflows.[workflow name].FlowState=[state]
$settings = ""
foreach($workflow in $Workflows) {
    $workflow = $workflow.Trim()
    $settings = $settings + " Workflows." + $workflow + ".FlowState=" + $State
}
$settings = $settings.Trim()

# Set the state of the Logic App workflows to $State
"Setting the state of the workflows"
Invoke-Expression "az logicapp config appsettings set --name $LogicApp --resource-group $ResourceGroup --settings $settings"

"Completed"
