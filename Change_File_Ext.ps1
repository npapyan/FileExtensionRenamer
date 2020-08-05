Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Change file extension'
$form.Size = New-Object System.Drawing.Size(300,300)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(50,220)
$okButton.Size = New-Object System.Drawing.Size(125,23)
$okButton.Text = 'Commit Changes'
$okButton.Add_Click({Commit-Changes})
#$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(175,220)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Close'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Provide a folder path here:'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$fromLabel = New-Object System.Windows.Forms.Label
$fromLabel.Location = New-Object System.Drawing.Point(10,100)
$fromLabel.Size = New-Object System.Drawing.Size(75,20)
$fromLabel.Text = 'Original Ext:'
$form.Controls.Add($fromLabel)

$fromTextBox = New-Object System.Windows.Forms.TextBox
$fromTextBox.Location = New-Object System.Drawing.Point(10,120)
$fromTextBox.Size = New-Object System.Drawing.Size(75,20)
$form.Controls.Add($fromTextBox)

$toLabel = New-Object System.Windows.Forms.Label
$toLabel.Location = New-Object System.Drawing.Point(100,100)
$toLabel.Size = New-Object System.Drawing.Size(75,20)
$toLabel.Text = 'New Ext:'
$form.Controls.Add($toLabel)

$toTextBox = New-Object System.Windows.Forms.TextBox
$toTextBox.Location = New-Object System.Drawing.Point(100,120)
$toTextBox.Size = New-Object System.Drawing.Size(75,20)
$form.Controls.Add($toTextBox)

$directoryButton = New-Object System.Windows.Forms.Button
$directoryButton.Location = New-Object System.Drawing.Point(10,70)
$directoryButton.Size = New-Object System.Drawing.Size(75,23)
$directoryButton.Text = 'Browse'
$directoryButton.Add_Click({$textBox.Text = Get-File})
$form.Controls.Add($directoryButton)

$changesButton = New-Object System.Windows.Forms.Button
$changesButton.Location = New-Object System.Drawing.Point(10,150)
$changesButton.Size = New-Object System.Drawing.Size(100,23)
$changesButton.Text = 'Show Changes'
$changesButton.Add_Click({Show-Changes})
$form.Controls.Add($changesButton)

function Get-File($initialDirectory) {   
    [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    $OpenFileDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($initialDirectory) { $OpenFileDialog.initialDirectory = $initialDirectory }
    [void] $OpenFileDialog.ShowDialog()
    return $OpenFileDialog.SelectedPath
}

function Show-Changes() {
    If ($textBox.Text -eq '') {
        [System.Windows.MessageBox]::Show("Please choose a folder path.")
    }
    ElseIf ($fromTextBox.Text -eq '') {
        [System.Windows.MessageBox]::Show("Please type in an Original Extention.")
    }
    ElseIf ($toTextBox.Text -eq '') {
        [System.Windows.MessageBox]::Show("Please type in a New Extention.")
    }
    Else {
        If ( -NOT ($fromTextBox.Text.Contains("."))) {
            $fromTextBox.Text = "." + $fromTextBox.Text
        }
        $filePath = $textBox.Text + '\*' + $fromTextBox.Text
        $outputText1 = "Search in directory: "
        $files = Get-ChildItem -Path $filePath -Force -Recurse
        $counter = $files | Measure-Object
        $counterText = "Files will be changed"
        $outputTextFinal = $([String]::Join(([Convert]::ToChar(10)).ToString(), $outputText1, $filePath, "", $counter.Count ,$counterText))
        [System.Windows.MessageBox]::Show($outputTextFinal)
    }
}

function Commit-Changes() {
    If ($textBox.Text -eq '') {
        [System.Windows.MessageBox]::Show("Please choose a folder path.")
    }
    ElseIf ($fromTextBox.Text -eq '') {
        [System.Windows.MessageBox]::Show("Please type in an Original Extention.")
    }
    ElseIf ($toTextBox.Text -eq '') {
        [System.Windows.MessageBox]::Show("Please type in a New Extention.")
    }
    Else {
        If ( -NOT ($fromTextBox.Text.Contains("."))) {
            $fromTextBox.Text = "." + $fromTextBox.Text
        }
        If ( -NOT ($toTextBox.Text.Contains("."))) {
            $toTextBox.Text = "." + $toTextBox.Text
        }
        $finalPath = $textBox.Text + '\*' + $fromTextBox.Text
        $files = Get-ChildItem -Path $finalPath -Force -Recurse
        $files | Rename-Item -NewName { $_.name -Replace $fromTextBox.Text, $toTextBox.Text}
        [System.Windows.MessageBox]::Show("Changes have been written. File Extentions are now changed.")
    }
}

$form.Topmost = $true
$result = $form.ShowDialog()