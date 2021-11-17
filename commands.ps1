# login to Azure
Login-AzAccount

#create variable with sub GUID
$subid = "enter your subscription GUID id here"

# select correct subscription
Set-AzContext -Subscription $subid

# deploy the policy definition template to the subscription
New-AzSubscriptionDeployment -Location "eastus" -TemplateUri "https://server.com/path/to/policy.tag-billingidentifier.azuredeploy.json"

# retrieve the policy that was just created
$policy = Get-AzPolicyDefinition -Name "require-tag-billingidentifier"

# create hashtable of allowed billid values
$ids = @('AQQHHA','AQQHHB','AQQHHZ')
$allowed = @{ billid = $ids }

# assign the new policy at subscription scope, with allowed billid values
New-AzPolicyAssignment -Name 'BillingIDPolicyAssignment'  -PolicyDefinition $policy -PolicyParameter $allowed -Scope "/subscriptions/$subid"