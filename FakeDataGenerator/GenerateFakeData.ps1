# Define the number of records to generate
$recordCount = 10000

# Define the output file path
$outputFilePath = "C:\path\to\your\output\fake_data.csv"

# Ensure the directory exists
$outputDirectory = Split-Path -Path $outputFilePath -Parent
if (-not (Test-Path -Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

# Arrays of sample data for randomization
$firstNames = @("John", "Jane", "Michael", "Emily", "David", "Sarah", "James", "Linda", "Robert", "Karen")
$lastNames = @("Doe", "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez")
$cities = @("New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose")
$states = @("NY", "CA", "IL", "TX", "AZ", "PA", "FL", "OH", "GA", "NC")
$countries = @("USA")
$departments = @("HR", "Finance", "IT", "Marketing", "Sales", "Operations", "Customer Support", "R&D", "Legal", "Administration")

# Function to generate a random phone number
function Get-RandomPhoneNumber {
    $areaCode = Get-Random -Minimum 100 -Maximum 999
    $exchange = Get-Random -Minimum 100 -Maximum 999
    $lineNumber = Get-Random -Minimum 1000 -Maximum 9999
    return "$areaCode-$exchange-$lineNumber"
}

# Function to generate a random email address
function Get-RandomEmail {
    param (
        [string]$FirstName,
        [string]$LastName
    )
    $domains = @("example.com", "test.com", "fake.com", "demo.com")
    $domain = Get-Random -InputObject $domains
    return "$($FirstName.ToLower()).$($LastName.ToLower())@$domain"
}

# Function to generate a random address
function Get-RandomAddress {
    $streetNumbers = Get-Random -Minimum 100 -Maximum 9999
    $streetNames = @("Main St", "Elm St", "Oak St", "Pine St", "Maple Ave", "Cedar Blvd", "Birch Ln", "Spruce Way")
    $streetName = Get-Random -InputObject $streetNames
    return "$streetNumbers $streetName"
}

# Function to generate a random ZIP code
function Get-RandomZipCode {
    return Get-Random -Minimum 10000 -Maximum 99999
}

# Create an array to hold the data
$data = @()

# Generate fake data
for ($i = 1; $i -le $recordCount; $i++) {
    $firstName = Get-Random -InputObject $firstNames
    $lastName = Get-Random -InputObject $lastNames
    $email = Get-RandomEmail -FirstName $firstName -LastName $lastName
    $phoneNumber = Get-RandomPhoneNumber
    $address = Get-RandomAddress
    $city = Get-Random -InputObject $cities
    $state = Get-Random -InputObject $states
    $zipCode = Get-RandomZipCode
    $country = Get-Random -InputObject $countries
    $department = Get-Random -InputObject $departments

    $data += [PSCustomObject]@{
        ID          = $i
        FirstName   = $firstName
        LastName    = $lastName
        Email       = $email
        PhoneNumber = $phoneNumber
        Address     = $address
        City        = $city
        State       = $state
        ZipCode     = $zipCode
        Country     = $country
        Department  = $department
    }
}

# Export the data to a CSV file
$data | Export-Csv -Path $outputFilePath -NoTypeInformation

Write-Host "Fake data generation complete. File saved to $outputFilePath"