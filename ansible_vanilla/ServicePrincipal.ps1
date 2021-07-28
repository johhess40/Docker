Import-Module -Name Az.Resources #Imports the PSADPasswordCredential object

$pw01 = ConvertTo-SecureString -AsPlainText -Force -String "<yoursecrethere>"

$user = "<azure@azureuserhere>"

$creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pw01

Connect-AzAccount -Credential $creds

$password = "P@ssW0rd1234!@"

$creds = New-Object Microsoft.Azure.Commands.ActiveDirectory.PSADPasswordCredential -Property @{
    StartDate = Get-Date; EndDate = Get-Date -Year 2024; Password = $password
};

$spSplat = @{
    DisplayName        = "ansible"
    PasswordCredential = $creds
}

New-AzADServicePrincipal @spSplat

$subId = (Get-AzContext).Subscription.Id 

$appId = (Get-AzADServicePrincipal -DisplayName "ansible")

$roleAssignSplat = @{
    ApplicationId = $appId.ApplicationId;
    RoleDefinitionName = 'Contributor';
    Scope = "/subscriptions/$subId"
}
Start-Sleep -Seconds 5

New-AzRoleAssignment @roleAssignSplat 

Start-Sleep -Seconds 5