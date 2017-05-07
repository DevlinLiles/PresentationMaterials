properties {
  $testMessage = 'Executed Test!'
  $compileMessage = 'Executed Compile!'
  $cleanMessage = 'Executed Clean!'
  $base_dir = Resolve-Path .
  $sln_file = "$base_dir" + "\CodeMigrations\CodeMigrations.csproj";
}



task default -depends Compile


task Compile -depends Clean { 
	msbuild $sln_file
  $compileMessage
}

task Clean { 
  $cleanMessage
}



task ? -Description "Helper to display task info" {
	Write-Documentation
}