@{
    RootModule        = 'ModuleData.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = '8b50d190-76d2-4b1f-9b58-af923047ba74'
    Author            = 'Mark Kraus'
    Copyright         = '2017'
    Description       = 'Provides data about Modules'
    FunctionsToExport = @(
        'Get-ModulePrivateFunction'
        'Get-ModuleClass'
    )
}
