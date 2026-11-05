if(($null -eq $TestName) -or ($TestName -contains 'Get-AzResiliencyUnifiedResilienceItem'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Get-AzResiliencyUnifiedResilienceItem.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Get-AzResiliencyUnifiedResilienceItem' {
    BeforeAll {
        $serviceGroupIdentity = @{ ServiceGroupName = $env.serviceGroupName }
        function Assert-UnifiedResilienceItem([object]$Item) {
            $Item.Name | Should -Be $env.unifiedResilienceItemName
            $Item.Id | Should -Match "/serviceGroups/$($env.serviceGroupName)/"
        }
    }

    # Skipped: unifiedResilienceItems GET returns 401 'The AAD authentication failed - unauthorized' from the RP for the test identity (correlation 70b8ebe9-ad22-49ac-a370-e8995e160038).
    It 'List' -skip {
        $items = @(Invoke-ResiliencyWithRetry { Get-AzResiliencyUnifiedResilienceItem -ServiceGroupName $env.serviceGroupName })
        $items.Name | Should -Contain $env.unifiedResilienceItemName
    }

    # Skipped: unifiedResilienceItems GET returns 401 'The AAD authentication failed - unauthorized' from the RP for the test identity (correlation 70b8ebe9-ad22-49ac-a370-e8995e160038).
    It 'GetViaIdentityServiceGroup' -skip {
        $item = Invoke-ResiliencyWithRetry { Get-AzResiliencyUnifiedResilienceItem -ServiceGroupInputObject $serviceGroupIdentity -Name $env.unifiedResilienceItemName }
        Assert-UnifiedResilienceItem $item
    }

    # Skipped: unifiedResilienceItems GET returns 401 'The AAD authentication failed - unauthorized' from the RP for the test identity (correlation 70b8ebe9-ad22-49ac-a370-e8995e160038).
    It 'Get' -skip {
        $item = Invoke-ResiliencyWithRetry { Get-AzResiliencyUnifiedResilienceItem -ServiceGroupName $env.serviceGroupName -Name $env.unifiedResilienceItemName }
        Assert-UnifiedResilienceItem $item
    }

    # Skipped: unifiedResilienceItems GET returns 401 'The AAD authentication failed - unauthorized' from the RP for the test identity (correlation 70b8ebe9-ad22-49ac-a370-e8995e160038).
    It 'GetViaIdentity' -skip {
        $identity = $serviceGroupIdentity + @{ UnifiedResilienceItemName = $env.unifiedResilienceItemName }
        $item = Invoke-ResiliencyWithRetry { Get-AzResiliencyUnifiedResilienceItem -InputObject $identity }
        Assert-UnifiedResilienceItem $item
    }
}
