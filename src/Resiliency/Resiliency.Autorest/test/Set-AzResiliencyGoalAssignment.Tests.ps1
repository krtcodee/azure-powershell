if(($null -eq $TestName) -or ($TestName -contains 'Set-AzResiliencyGoalAssignment'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Set-AzResiliencyGoalAssignment.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Set-AzResiliencyGoalAssignment' {
    # Service allows one goal assignment per service group and treats PUT as create; update must use PATCH (Update-AzResiliencyGoalAssignment).
    It 'UpdateExpanded' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    # Service allows one goal assignment per service group and treats PUT as create; update must use PATCH (Update-AzResiliencyGoalAssignment).
    It 'Update' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    # Service allows one goal assignment per service group and treats PUT as create; update must use PATCH (Update-AzResiliencyGoalAssignment).
    It 'UpdateViaJsonFilePath' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    # Service allows one goal assignment per service group and treats PUT as create; update must use PATCH (Update-AzResiliencyGoalAssignment).
    It 'UpdateViaJsonString' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }
}
