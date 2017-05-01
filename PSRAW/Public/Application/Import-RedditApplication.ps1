<#	
    .NOTES
    ===========================================================================
     Created with:  VSCode
     Created on:    5/01/2017 4:39 AM
     Edited on:     5/01/2017
     Created by:    Mark Kraus
     Organization: 	
     Filename:      Import-RedditApplication.ps1
    ===========================================================================
    .DESCRIPTION
        Import-RedditApplication Function
#>
Using Module '..\..\Enums\RedditApplicationType.psm1'
Using Module '..\..\Classes\RedditScope.psm1'
Using Module '..\..\Classes\RedditApplication.psm1'

function Import-RedditApplication {
    [CmdletBinding(DefaultParameterSetName = 'Path',
                   ConfirmImpact = 'Low',
                   HelpUri = 'https://psraw.readthedocs.io/en/latest/Module/Import-RedditApplication',
                   SupportsShouldProcess = $true)]
    [OutputType([RedditApplication])]
    param
    (
        [Parameter(ParameterSetName = 'Path',
                   Mandatory = $true,
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Path,
        
        [Parameter(ParameterSetName = 'LiteralPath',
                   Mandatory = $true,
                   ValueFromRemainingArguments = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]$LiteralPath
    )
    
    Process {
        Switch ($PsCmdlet.ParameterSetName) {
            'Path' {
                $ImportFiles = $Path
                $ImportParam = 'Path'
                Break
            }
            'LiteralPath' {
                $ImportFiles = $LiteralPath
                $ImportParam = 'LiteralPath'
                Break
            }
        }
        foreach ($ImportFile in $ImportFiles) {
            if (-not $pscmdlet.ShouldProcess($ImportFile)) {
                Continue
            }
            $Params = @{
                "$ImportParam" = $ImportFile
            }
            $InObject = Import-Clixml @Params
            [RedditApplication]$InObject
        } #End Foreach
    } #End Process
} #End Function