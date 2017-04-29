﻿<#	
    .NOTES
    ===========================================================================
     Created with: 	VSCode
     Created on:   	4/23/2017 1:42 PM
     Editied on:    4/25/2017
     Created by:   	Mark Kraus
     Organization: 	
     Filename:     	Get-RedditOAuthScope.ps1
    ===========================================================================
    .DESCRIPTION
        Get-RedditOAuthScope Function
#>

#Import RedditScope Class
Using module '..\..\Classes\RedditScope.psm1'

function Get-RedditOAuthScope {
    [CmdletBinding(ConfirmImpact = 'None',
                   HelpUri = 'https://psraw.readthedocs.io/en/latest/functions/Get-RedditOAuthScope')]
    [OutputType([RedditScope])]
    param
    (
        [Parameter(Mandatory = $false)]
        [string]$ApiEndpointUri = [RedditScope]::GetApiEndpointUri()
    )
    
    Write-Verbose "Retrieving Scopes from '$ApiEndpointUri'"
    $ResultObj = Invoke-RestMethod -Uri $ApiEndpointUri

    Write-Verbose "Looping through each scope and creating [RedditScope] Objects"
    foreach ($Property in $ResultObj.psobject.Properties.Name) {
        Write-Verbose "Processing '$Property'"
        [RedditScope]@{
            Scope = $Property
            Id = $ResultObj.$Property.id
            Name = $ResultObj.$Property.Name
            Description = $ResultObj.$Property.Description
        }
    }
}