Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to create user and invite them using OneSpan API
function CreateUserAndInvite {
    param (
        [string]$email
    )

    # Define the OneSpan API endpoint and the API key (replace with your actual API key)
    $apiUrl = "https://apps.esignlive.eu/api/packages/"
    $apiKey = "YOUR_API_KEY"

    # Prepare the user data in JSON format
    $userData = @{
        email = $email
        status = "ACTIVE"
    } | ConvertTo-Json

    # Make the API call to create the user
    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Body $userData -ContentType "application/json" -Headers @{ "Authorization" = "Bearer $apiKey" }

    # Check the response and display a message
    if ($response) {
        [System.Windows.Forms.MessageBox]::Show("User Created And Invited Successfully!")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Failed To Create User.")
    }
}

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "OneSpan User Creation"
$form.Size = New-Object System.Drawing.Size(300, 200)

# Create the email label and textbox
$emailLabel = New-Object System.Windows.Forms.Label
$emailLabel.Text = "Email:"
$emailLabel.Location = New-Object System.Drawing.Point(10, 20)
$form.Controls.Add($emailLabel)

$emailTextbox = New-Object System.Windows.Forms.TextBox
$emailTextbox.Location = New-Object System.Drawing.Point(60, 20)
$emailTextbox.Size = New-Object System.Drawing.Size(200, 20)
$form.Controls.Add($emailTextbox)

# Create the submit button
$submitButton = New-Object System.Windows.Forms.Button
$submitButton.Text = "Submit"
$submitButton.Location = New-Object System.Drawing.Point(100, 60)
$submitButton.Add_Click({
    $email = $emailTextbox.Text
    CreateUserAndInvite -email $email
})
$form.Controls.Add($submitButton)

# Show the form
[void]$form.ShowDialog()
