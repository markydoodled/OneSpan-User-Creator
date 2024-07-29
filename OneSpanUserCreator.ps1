Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to create user using OneSpan API
function CreateUser {
    param (
        [string]$email,
        [string]$firstName,
        [string]$lastName,
        [string]$company,
        [string]$title
    )

    # Define the OneSpan API endpoint and the API key (replace with your actual API key)
    $apiUrl = "https://api.onespan.com/api/account/senders"
    $apiKey = "YOUR_API_KEY"

    # Prepare the user data in JSON format
    $userData = @{
        email = $email
        firstName = $firstName
        lastName = $lastName
        company = $company
        title = $title
    } | ConvertTo-Json

    # Make the API call to create the user
    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Body $userData -ContentType "application/json" -Headers @{ "Authorization" = "Bearer $apiKey" }

    # Check the response and display a message
    if ($response) {
        [System.Windows.Forms.MessageBox]::Show("User Created Successfully!")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Failed To Create User.")
    }
}

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "OneSpan User Creation"
$form.Size = New-Object System.Drawing.Size(300, 300)

# Create the labels and textboxes for the input fields
$fields = @("Email", "First Name", "Last Name", "Company", "Title")
$controls = @{}

$fields | ForEach-Object {
    $label = New-Object System.Windows.Forms.Label
    $label.Text = "$_:"
    $label.Location = New-Object System.Drawing.Point(10, 20 + ($fields.IndexOf($_) * 30))
    $form.Controls.Add($label)

    $textbox = New-Object System.Windows.Forms.TextBox
    $textbox.Location = New-Object System.Drawing.Point(100, 20 + ($fields.IndexOf($_) * 30))
    $textbox.Size = New-Object System.Drawing.Size(150, 20)
    $form.Controls.Add($textbox)

    $controls[$_] = $textbox
}

# Create the submit button
$submitButton = New-Object System.Windows.Forms.Button
$submitButton.Text = "Submit"
$submitButton.Location = New-Object System.Drawing.Point(100, 200)
$submitButton.Add_Click({
    $email = $controls["Email"].Text
    $firstName = $controls["First Name"].Text
    $lastName = $controls["Last Name"].Text
    $company = $controls["Company"].Text
    $title = $controls["Title"].Text
    CreateUser -email $email -firstName $firstName -lastName $lastName -company $company -title $title
})
$form.Controls.Add($submitButton)

# Show the form
[void]$form.ShowDialog()
