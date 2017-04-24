﻿<#	
	.NOTES
	===========================================================================
	 Created with: 	VSCode
	 Created on:   	4/23/2017 1:42 PM
     Editied on:    4/23/2017
	 Created by:   	Mark Kraus
	 Organization: 	
	 Filename:     	Get-RedditOAuthScope.ps1
	===========================================================================
	.DESCRIPTION
		Get-RedditOAuthScope Function
#>
Using module '..\..\Classes\RedditScope.psm1'
<#
    .SYNOPSIS
        Retireve valid Reddit OAuth Scopes.
    
    .DESCRIPTION
        Retrive valid OAuth scope IDs, Names, and Descriptions from Reddit.
    
    .PARAMETER ScopeURL
        Optional. URL for the Reddit App Scope definitions.
        Default:

        https://www.reddit.com/api/v1/scopes
    
    .EXAMPLE
        PS C:\> $RedditScopes = Get-RedditOAuthScope
    
    .NOTES
        For more information about registering Reddit Apps, Reddit's API, or Reddit OAuth see:
            https://github.com/reddit/reddit/wiki/API
            https://github.com/reddit/reddit/wiki/OAuth2
            https://www.reddit.com/prefs/apps
            https://www.reddit.com/wiki/api
    
    .OUTPUTS
        RedditScope
    
    .LINK
        https://psraw.readthedocs.io/en/latest/functions/Get-RedditOAuthScope

    .LINK
        https://github.com/reddit/reddit/wiki/API
    
    .LINK
        https://github.com/reddit/reddit/wiki/OAuth2

    .LINK
        https://www.reddit.com/prefs/apps

    .LINK
        https://www.reddit.com/wiki/api
#>
function Get-RedditOAuthScope {
    [CmdletBinding(ConfirmImpact = 'None',
                   HelpUri = 'https://psraw.readthedocs.io/en/latest/functions/Get-RedditOAuthScope')]
    [OutputType([RedditScope])]
    param
    (
        [Parameter(Mandatory = $false)]
        [ValidateScript({
                [system.uri]::IsWellFormedUriString(
                    $_, [System.UriKind]::Absolute
                )
            })]
        [string]$ScopeURL = 'https://www.reddit.com/api/v1/scopes'
    )
    
    Write-Verbose "Retrieving Scopes from '$ScopeURL'"
    $ScopesObj = Invoke-WebRequest -Uri $ScopeURL |
        Select-Object -ExpandProperty Content |
        ConvertFrom-Json

    Write-Verbose "Looping through each scope and return ID, Name, and Description properties."
    foreach ($Property in $ScopesObj.psobject.Properties.Name) {
        Write-Verbose "Processing '$Property'"
        [RedditScope]::New(
            <# Scope:       #> $Property,
            <# Id:          #> $ScopesObj.$Property.id,
            <# Name:        #> $ScopesObj.$Property.Name,
            <# Decsription: #> $ScopesObj.$Property.Description
        )
    }
}